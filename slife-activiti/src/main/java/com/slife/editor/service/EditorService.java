package com.slife.editor.service;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

import static org.activiti.editor.constants.ModelDataJsonConstants.*;

/**
 * @author: felixu.
 * @createTime: 2017/11/26.
 */
@Service
public class EditorService {

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private ObjectMapper objectMapper;

    public Object getStencilset() {
        InputStream stencilsetStream = this.getClass().getClassLoader().getResourceAsStream("stencilset.json");
        try {
            String s= IOUtils.toString(stencilsetStream, "utf-8");
           return JSON.parse(s);
        } catch (Exception e) {
            throw new ActivitiException("Error while loading stencil set", e);
        }
    }

    public Object getEditorJson(String modelId) {
        ObjectNode modelNode = null;
        Model model = repositoryService.getModel(modelId);
        if (model != null) {
            try {
                if (StringUtils.isNotEmpty(model.getMetaInfo())) {
                    modelNode = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
                } else {
                    modelNode = objectMapper.createObjectNode();
                    modelNode.put(MODEL_NAME, model.getName());
                }
                byte[] source = repositoryService.getModelEditorSource(model.getId());
                modelNode.put(MODEL_ID, model.getId());
                ObjectNode editorJsonNode = (ObjectNode) objectMapper.readTree(new String(source, "utf-8"));
                modelNode.put("model", editorJsonNode);
                return JSON.parse(modelNode.toString());
            } catch (Exception e) {
                throw new ActivitiException("Error creating model JSON", e);
            }
        }
        return null;
    }

    public void saveModel(String modelId, String name, String description,
                          String json_xml, String svg_xml) {
        try {
            Model model = repositoryService.getModel(modelId);
            ObjectNode modelJson = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
            modelJson.put(MODEL_NAME, name);
            modelJson.put(MODEL_DESCRIPTION, description);
            model.setMetaInfo(modelJson.toString());
            model.setName(name);
            repositoryService.saveModel(model);
            repositoryService.addModelEditorSource(model.getId(), json_xml.getBytes("utf-8"));
            InputStream svgStream = new ByteArrayInputStream(svg_xml.getBytes("utf-8"));
            TranscoderInput input = new TranscoderInput(svgStream);

            // Setup output
            ByteArrayOutputStream outStream = new ByteArrayOutputStream();
            TranscoderOutput output = new TranscoderOutput(outStream);
//            PNGTranscoder transcoder = new PNGTranscoder();
            // Do the transformation
//            transcoder.transcode(input, output);
            final byte[] result = outStream.toByteArray();
            repositoryService.addModelEditorSourceExtra(model.getId(), result);
            outStream.close();
        } catch (Exception e) {
            throw new ActivitiException("Error saving model", e);
        }
    }
}

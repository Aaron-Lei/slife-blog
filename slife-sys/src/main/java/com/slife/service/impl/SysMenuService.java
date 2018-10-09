package com.slife.service.impl;


import com.baomidou.mybatisplus.enums.SqlLike;
import com.baomidou.mybatisplus.mapper.Condition;
import com.slife.base.service.impl.BaseService;
import com.slife.base.vo.JsTree;
import com.slife.constant.Global;
import com.slife.dao.SysMenuDao;
import com.slife.entity.SysMenu;
import com.slife.enums.HttpCodeEnum;
import com.slife.exception.SlifeException;
import com.slife.service.ISysMenuService;
import com.slife.service.ISysRoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author chen
 * @date 2017/4/24
 * <p>
 * Email 122741482@qq.com
 * <p>
 * Describe: sys 菜单 servive
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SysMenuService extends BaseService<SysMenuDao, SysMenu> implements ISysMenuService {

    @Autowired
    private ISysRoleMenuService sysRoleMenuService;

    /**
     * 把菜单设置为失效
     *
     * @param id
     */
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void disableMenu(Long id) {
        SysMenu sysMenu = selectById(id);
        Optional.ofNullable(sysMenu).orElseThrow(() -> new SlifeException(HttpCodeEnum.NOT_FOUND));

        List<SysMenu> delList = selectList(Condition.create().like("path", sysMenu.getPath(), SqlLike.RIGHT));
        delList.stream().parallel().forEach(menu -> menu.setShowFlag(Global.NO));
        updateBatchById(delList);
        //TODO 判断是否有角色，有角色要清理角色与资源关系

    }

    /**
     * 删除菜单和子菜单
     *
     * @param id
     * @return
     */
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public Boolean deleteMenu(Long id) {
        SysMenu sysMenu = selectById(id);
        Optional.ofNullable(sysMenu).orElseThrow(() -> new SlifeException(HttpCodeEnum.NOT_FOUND));

        List<SysMenu> delList = selectList(Condition.create().like("path", sysMenu.getPath(), SqlLike.RIGHT));
        List<Long> ids = delList.stream().parallel().map(menu -> menu.getId()).collect(Collectors.toList());
        deleteBatchIds(ids);
        //删除对应的角色关联
        sysRoleMenuService.delete(Condition.create().in("sys_menu_id", ids));
        return true;
    }

    /**
     * 新增菜单
     *
     * @param sysMenu
     */
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void add(SysMenu sysMenu) {

        insert(sysMenu);
        if (Global.TOP_TREE_NODE.equals(sysMenu.getParentId())) {
            sysMenu.setPath(sysMenu.getId() + ".");
        } else {

            sysMenu.setPath(sysMenu.getPath() + sysMenu.getId() + ".");
        }
        updateById(sysMenu);
    }

    /**
     * 更新菜单
     *
     * @param sysMenu
     */
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void update(SysMenu sysMenu) {

        updateById(sysMenu);
    }


    /**
     * 根据用户的id 或者该用户具有的菜单列表
     *
     * @param userId
     * @return
     */
    @Override
    public List<SysMenu> selectMenusByUserId(Long userId) {
        return this.baseMapper.selectMenusByUserId(userId);
    }

    /**
     * 查询系统用户 侧边栏菜单
     *
     * @param userId
     * @return
     */

//    @Cacheable(cacheNames="menu", key="#userId")
    @Override
    public List<SysMenu> CaseMenu(Long userId) {
        Map<Long, List<SysMenu>> map = new HashMap();

        List<SysMenu> sysMenus = this.baseMapper.selectMenusByUserId(userId);

        for (SysMenu sysMenu : sysMenus) {
            List<SysMenu> parentMenu = map.get(sysMenu.getParentId());
            if (parentMenu == null) {
                parentMenu = new ArrayList();
            }
            parentMenu.add(sysMenu);
            map.put(sysMenu.getParentId(), parentMenu);
        }
        List<SysMenu> retList = MakeMenu(map, 0L);
        Collections.sort(retList);
        return retList;
    }


    public List<SysMenu> MakeMenu(Map<Long, List<SysMenu>> map, Long supId) {
        List<SysMenu> sysMenus = new ArrayList();
        List<SysMenu> menuList = map.get(supId);
        if (menuList != null) {
            for (SysMenu me : menuList) {
                me.setChildren(MakeMenu(map, me.getId()));
                sysMenus.add(me);
            }
        }
        return sysMenus;
    }

    /**
     * 菜单管理 菜单树
     *
     * @return
     */
    @Override
    public List<JsTree> getMenuTree() {

        List<SysMenu> sysMenus = selectList(Condition.create().orderBy("sort", true));
        return makeTree(sysMenus);
    }


}

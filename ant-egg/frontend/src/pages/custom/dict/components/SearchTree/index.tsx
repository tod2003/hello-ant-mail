import { Tree, Input } from 'antd';
import React, { Component } from 'react';

const { TreeNode } = Tree;
const { Search } = Input;

const getParentKey = (key, tree) => {
  let parentKey;
  for (let i = 0; i < tree.length; i++) {
    const node = tree[i];
    if (node.children) {
      if (node.children.some(item => item.key === key)) {
        parentKey = node.key;
      } else if (getParentKey(key, node.children)) {
        parentKey = getParentKey(key, node.children);
      }
    }
  }
  return parentKey;
};

class SearchTree extends Component<UpdateFormProps, UpdateFormState>  {
    state = {
      expandedKeys: [],
      searchValue: '',
      autoExpandParent: true,
      dataset: [{
        key: '0',
        title: '类型',
        children: [],
      }],
      selectedKeys: ['0'],
    };
  
    componentDidMount() {
      this.props.onRef(this);
    }

    onExpand = expandedKeys => {
      this.setState({
        expandedKeys,
        autoExpandParent: false,
      });
    };
  
    onChange = e => {
      /*
      const { value } = e.target;
      const expandedKeys = dataset
       .map(item => {
          if (item.title.indexOf(value) > -1) {
            return getParentKey(item.key, gData);
          }
          return null;
        })
        .filter((item, i, self) => item && self.indexOf(item) === i);
      this.setState({
        expandedKeys,
        searchValue: value,
        autoExpandParent: true,
      });*/
    };
  
    onSelect = (keys, event) => {
      //console.log('Trigger Select', keys, event);
      this.setState({
        selectedKeys: keys,
      })
      if (keys.length > 0) {
        this.props.onSelect(keys[0]);
      }
    };

    getMaxId(key, node) {
      let idxMax = -1;
      node.children.forEach((item)=>{
        const fields = item.key.split('-');
        const idx = parseInt(fields[fields.length - 1]);
        if ( idx > idxMax) {
          idxMax = idx;
        }
      })
      idxMax += 1;
      return key + '-' + idxMax.toString();
    }

    getNode(key, node) {
      if (node.key === key) {
        return node;
      }

     // node.children.forEach((item) => {
     //   return this.getKey(key, item);
     // })

      for (let item of node.children) {
        let rtn = this.getNode(key, item);
        if (rtn) {
          return rtn;
        }
      }

      return null;
    }

    removeNode = (key, node) => {
      for (let id in node.children) {
        let item = node.children[id];
        if (item.key === key) {
          this.removeNode(key, item)
          node.children.splice(id, 1);
          this.props.onSelect(node.key);
        }
      }
    }

    delNode = (_key) => {
      const { dataset } = this.state;
      this.removeNode(_key, dataset[0]);
      this.setState({
        dataset,
      })
    }

    addNode = (_key, title) => {
      const { dataset } = this.state;
      let node = this.getNode(_key, dataset[0]);
      if (!node) return;
      let key = this.getMaxId(_key, node);
      if (!key) return;
      node.children.push({
        key,
        title,
        children: [],
      });
      this.props.onSelect(key);
      const expandedKeys = [key];
      const selectedKeys = [key];
      this.setState({
        selectedKeys,
        expandedKeys,
        dataset,
      });
    }

    render() {
      const { selectedKeys, searchValue, expandedKeys, autoExpandParent, dataset } = this.state;
      const loop = data =>
        data.map(item => {
          const index = item.title.indexOf(searchValue);
          const beforeStr = item.title.substr(0, index);
          const afterStr = item.title.substr(index + searchValue.length);
          const title =
            index > -1 ? (
              <span>
                {beforeStr}
                <span style={{ color: '#f50' }}>{searchValue}</span>
                {afterStr}
              </span>
            ) : (
              <span>{item.title}</span>
            );
          if (item.children) {
            return (
              <TreeNode key={item.key} title={title}>
                {loop(item.children)}
              </TreeNode>
            );
          }
          return <TreeNode key={item.key} title={title} />;
        });
      return (
        <div>
          <Search style={{ marginBottom: 8 }} placeholder="Search" onChange={this.onChange} />
          <Tree
            selectedKeys={selectedKeys}
            onExpand={this.onExpand}
            expandedKeys={expandedKeys}
            autoExpandParent={autoExpandParent}
            onSelect={this.onSelect}
          >
            {loop(dataset)}
          </Tree>
        </div>
      );
    }
  }

  export default SearchTree;
  
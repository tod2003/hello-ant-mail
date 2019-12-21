import {
  Badge,
  Button,
  Card,
  Col,
  DatePicker,
  Divider,
  Dropdown,
  Form,
  Icon,
  Input,
  InputNumber,
  Menu,
  Row,
  Select,
  message,
  Tabs,
  Table,
} from 'antd';

const { TabPane } = Tabs;

import React, { Component, Fragment } from 'react';

import { Dispatch } from 'redux';
import { FormComponentProps } from 'antd/es/form';
import { PageHeaderWrapper } from '@ant-design/pro-layout';
import { SorterResult } from 'antd/es/table';
import { connect } from 'dva';
import moment from 'moment';
import { StateType } from './model';
import CreateForm from './components/CreateForm';
import StandardTable, { StandardTableColumnProps } from './components/StandardTable';
import UpdateForm, { FormValsType } from './components/UpdateForm';
import { TableListItem, TableListPagination, TableListParams } from './data';
import SearchTree from './components/SearchTree';

import styles from './style.less';

const FormItem = Form.Item;
const { Option } = Select;
const getValue = (obj: { [x: string]: string[] }) =>
  Object.keys(obj)
    .map(key => obj[key])
    .join(',');

type IStatusMapType = 'default' | 'processing' | 'success' | 'error';
const statusMap = ['default', 'processing', 'success', 'error'];
const status = ['地板', '涂料', '辅料', '耗材'];

interface TableListProps extends FormComponentProps {
  dispatch: Dispatch<any>;
  loading: boolean;
  listTableList: StateType;
}

interface TableListState {
  modalVisible: boolean;
  updateModalVisible: boolean;
  expandForm: boolean;
  selectedRows: TableListItem[];
  formValues: { [key: string]: string };
  stepFormValues: Partial<TableListItem>;
}

/* eslint react/no-multi-comp:0 */
@connect(
  ({
    listTableList,
    loading,
  }: {
    listTableList: StateType;
    loading: {
      models: {
        [key: string]: boolean;
      };
    };
  }) => ({
    listTableList,
    loading: loading.models.rule,
  }),
)
class TableList extends Component<TableListProps, TableListState> {
  state: TableListState = {
    modalVisible: false,
    updateModalVisible: false,
    expandForm: false,
    selectedRows: [],
    formValues: {},
    stepFormValues: {},
    titleTree: '',
    levelTree: 1,
    keyTree: '',
  };

  componentDidMount() {
    const { dispatch } = this.props;
    dispatch({
      type: 'listTableList/fetch',
    });
  }

  handleModalVisible = (flag?: boolean) => {
    this.setState({
      modalVisible: !!flag,
    });
  };

  handleAdd = (key, fields: { desc: any }) => {
    //console.log(fields.desc)
    console.log(key)
    this.mytree.addNode(key, fields.desc);

    /*
    const { dispatch } = this.props;
    dispatch({
      type: 'listTableList/add',
      payload: {
        desc: fields.desc,
      },
    });
    */
    message.success('添加成功');
    this.handleModalVisible();
  };

  handleDelNode = (value) => {
    const { keyTree }  = this.state;
    this.mytree.delNode(keyTree);
  }

  handleAddNode = (value) => {
    const { keyTree }  = this.state;
    if (!keyTree) return;
    if (keyTree.length === 0) return;
    const len = keyTree.split('-').length;
    if ( len === 1) {
      this.setState({
        titleTree: '新建大类',
        keyTree,
      });
      this.handleModalVisible(true)
    } else if (len === 2) {
      this.setState({
        titleTree: '新建小类',
        keyTree,
      });
      this.handleModalVisible(true)
    } else if (len === 3) {
      this.setState({
        titleTree: '新建商品码',
        keyTree,
      });
      this.handleModalVisible(true)
    }

    
  }

onRef = (ref) => {
  this.mytree = ref;
  /*this.props.dispatch({
    type: 'updateState',
    payload: {
      childTree: ref
    }
  });*/
}

onSelect = (value) => {
  value = (value === undefined)?'':value;
  this.setState({
    keyTree: value,
  });
}

  render() {
    const {
      listTableList: { data },
      loading,
    } = this.props;

    const { selectedRows, modalVisible, updateModalVisible, stepFormValues, keyTree, titleTree } = this.state;
    const menu = (
      <Menu onClick={this.handleMenuClick} selectedKeys={[]}>
        <Menu.Item key="remove">删除</Menu.Item>
        <Menu.Item key="approval">批量审批</Menu.Item>
      </Menu>
    );

    const parentMethods = {
      handleAdd: this.handleAdd,
      handleModalVisible: this.handleModalVisible,
    };
    const updateMethods = {
      handleUpdateModalVisible: this.handleUpdateModalVisible,
      handleUpdate: this.handleUpdate,
    };

    return (
      <PageHeaderWrapper>
        <Card bordered={false}>
          <div style={{ marginBottom: 24 }}>
            <Button icon="plus" style={{ marginLeft: 8 }} type="primary" onClick={() => this.handleAddNode(1)}>
              新建
              </Button>
            <Button icon="plus" style={{ marginLeft: 8 }} type="primary" onClick={() => this.handleDelNode()}>
              删除
              </Button>
          </div>
          <div>
            <Row gutter={{ md: 8, lg: 24, xl: 48 }}>
              <Col md={12} sm={24}>
                <SearchTree
                  onRef={this.onRef}
                  onSelect={this.onSelect}
                />
              </Col>
              <Col md={12} sm={24} style={{ margin: 5, backgroundColor: 0x000000}}>

              </Col>
            </Row>
          </div>
        </Card>
        <CreateForm {...parentMethods} modalVisible={modalVisible} keyTree={keyTree} title={titleTree} />
        {stepFormValues && Object.keys(stepFormValues).length ? (
          <UpdateForm
            {...updateMethods}
            updateModalVisible={updateModalVisible}
            values={stepFormValues}
          />
        ) : null}
      </PageHeaderWrapper>
    );
  }
}

export default Form.create<TableListProps>()(TableList);

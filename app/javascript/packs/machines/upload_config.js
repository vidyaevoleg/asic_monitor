import React, {Component} from 'react';
import API from '../common/api';
import Errors from './errors';

import {
  Modal,
  ModalHeader,
  ModalBody,
  ModalFooter,
  Button,
  Alert
} from 'reactstrap'

class UploadConfig extends Component {

  constructor (props) {
    super(props);
    this.state = {
      uploading: false,
      errors: null
    }
  }

  fileChangeHanlder = (e) => {
    const file = e.target.files[0];
    if (file) {
      this.setState({uploading: true, errors: null})

      const success = () => {
        window.location.reload();
      }
      const error = (res) => {
        this.setState({uploading: false})
        this.setState({errors: res.errors})
      }
      API.machines.uploadConfig({file: file}, success, error);
    }
  }

  tips () {
    const {models} = this.props;
    return (
      <Alert color="info">
        <p>
          Каждая строчка конфигурации роутера должна быть подобной этой:
        </p>
        <code>
          add address=192.168.2.2
          client-id=1:8:96:32:51:56:d2
          comment=1-1-1
          model=S9
          mac-address=08:96:32:51:56:D2
          userid=1
          server=dhcp1
        </code>
        <br/>
        <p>
          <ul>
            <li>
              если какой-то из параметров <code> address, model, userid, comment, mac-address </code> будет отсутствовать, то загрузка будет провалена (изменения не применятся)
            </li>

            <li>
              <code>server=dhcp1</code> обязательно в конце строки!!!
            </li>
            <li>
              <code>ключ=значение</code> - без кавычек
            </li>
          </ul>
        </p>
        <p>
          Требования для поля <b>model</b>:
          <ul>
            <li>
                значение должно быть из списка
                <code>
                  {models.join(', ')}
              </code>
            </li>
            <li>верхний регистр обязателен</li>
            <li>если модели асика нет в списке, то подключать этот асик нельзя</li>
          </ul>
        </p>
      </Alert>
    )
  }

  render () {
    const {uploading, errors} = this.state;
    const {toogle} = this.props;

    return (
      <Modal isOpen={true} size="lg">
        <ModalHeader>
          <h2>
            Загрузка конфигурации роутера
          </h2>
        </ModalHeader>
        <ModalBody>
          <Errors errors={errors} />
          <div className="col-12">
            {this.tips()}
          </div>
          <div className="col-12">
            {
              uploading ?
                <div class="spinner">
                  <div class="double-bounce1"></div>
                  <div class="double-bounce2"></div>
                </div> : <div className="form-group">
                  <label> Файл формата .rsc </label>
                  <input className="form-control" type="file" accept=".rsc" onChange={this.fileChangeHanlder}/>
                </div>
            }

          </div>
        </ModalBody>
        <ModalFooter>
          <Button color="secondary" onClick={toogle}>Отмена</Button>
        </ModalFooter>
      </Modal>
    )
  }
}

export default UploadConfig;

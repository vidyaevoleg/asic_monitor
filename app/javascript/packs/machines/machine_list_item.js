import React, {Component} from 'react'
import MachinePopup from './machine_popup'
import MachineConfigPopup from './machine_config_popup'
import API from '../common/api'

class MachineListItem extends Component {

  deleteMachine = () => {
    const {machine} = this.props;
    if (confirm('Уверен?')) {
      API.machines.delete(machine.id, (res) => {
        window.location.reload();
      })
    }
  }

  render () {
    const {machine, onChoose, chosen, editMachine, editConfig} = this.props;
    let color;
    if (machine.active && machine.success) {
      color = 'table-success'
    } else if (machine.active && !machine.success) {
      color = 'table-warning'
    } else if (!machine.active) {
      color = 'table-danger'
    }
    return (
      <tr className={color}>
        <td>
          <div className="form-group checkbox-lil">
            <input type="checkbox" className="form-control" checked={chosen} onChange={onChoose}/>
          </div>
        </td>
        <td>
          <a href={'http://' + machine.ip} target="_blank">
            {machine.ip}
          </a>
        </td>
        <td>
          {machine.place}
        </td>
        <th>
          {machine.model}
        </th>
        <td>
          <code>
            {machine.template.url1}
          </code>
        </td>
        <th>
          <code>
            {machine.temparatures && machine.temparatures.toLocaleString()}
          </code>
        </th>
        <th>
          {machine.hashrate}
        </th>
        <td>
          {machine.time}
        </td>
        <th>
          <i className="fa fa-pencil fa-lg" onClick={editMachine}></i>
        </th>
        <th>
          <i className="fa fa-cog fa-lg" aria-hidden="true" onClick={editConfig}></i>
        </th>
        <th>
          <i className="fa fa-times text-danger fa-lg" aria-hidden="true" onClick={this.deleteMachine}></i>
        </th>
      </tr>
    )
  }
}

export default MachineListItem;

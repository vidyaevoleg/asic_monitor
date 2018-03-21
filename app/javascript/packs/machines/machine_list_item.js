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
          <a href={'/machines/' + machine.id}>
            {machine.place}
          </a>
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
        <th>
          {machine.blocks_count}
        </th>
        <td>
          {machine.time}
        </td>
        <th>
          <div className="machines-action">
            <i className="fa fa-pencil" onClick={editMachine}></i>

          </div>
          <div className="machines-action">
            <i className="fa fa-cog" aria-hidden="true" onClick={editConfig}></i>

          </div>
          <div className="machines-action">
            <a href={'/machines/' + machine.id}>
              <i className="fa fa-area-chart" aria-hidden="true"></i>
            </a>
          </div>
          <div className="machines-action">
            <i className="fa fa-times text-danger" aria-hidden="true" onClick={this.deleteMachine}></i>
          </div>
        </th>
      </tr>
    )
  }
}

export default MachineListItem;

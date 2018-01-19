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

    return (
      <tr>
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
        <td>
          {machine.model}
        </td>
        <th>
          <code>
            {[machine.template.url1, machine.template.url2, machine.template.url3].join(', ')}
          </code>
        </th>
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

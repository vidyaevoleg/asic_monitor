import React, {Component} from 'react'
import ReactDOM from 'react-dom'
import MachineListItem from './machines/machine_list_item'
import MachineConfigPopup from './machines/machine_config_popup'
import MachinePopup from './machines/machine_popup'
import RebootingProgress from './machines/rebooting_progress'
import dums from './common/dums'

class Machines extends Component {

  constructor (props) {
    super(props);
    gon.pools = [];
    this.state = {
      machines: gon.machines,
      selected: [],
      filter: {
        model: null
      },
      selectedMachines: [],
      rebootedMachines: [],
      selectedTemplate: null,
      selectedMachine: null,
      models: gon.models
    }
  }

  _getJsonFromUrl () {
    const query = window.location.search.substr(1);
    const result = {};
    query.split("&").forEach(function(part) {
      let item = part.split("=");
      result[item[0]] = decodeURIComponent(item[1]);
    });
    return result;
  }

  componentDidMount () {
    const params = this._getJsonFromUrl();
    if (params.model) {
      this.setState({
        filter: {
          model: params.model
        }
      })
    }
  }

  chooseAll = (e) => {
    if (e.target.checked) {
      this.setState({
        selected: this.filterMachines().map(m => m.id)
      });
    } else {
      this.setState({selected: []});
    }
  }

  filterMachines = () => {
    const {filter, machines} = this.state;
    let filtred = machines;
    for (let key in filter) {
      if (filter[key] && key == 'model' && filter[key] != 'all') {
        filtred = filtred.filter(m => m.model == filter[key])
      }
    }
    return filtred;
  }

  chooseItem = (id) => {
    let {selected} = this.state;
    if (selected.includes(id)) {
      this.setState({
        selected: selected.filter(i => i != id)
      })
    } else {
      this.setState({
        selected: selected.concat(id)
      })
    }
  }

  editGroupHandler = () => {
    const {selected} = this.state;
    const machines = this.state.machines.filter(m => selected.includes(m.id));
    if (machines.length) {
      this.setState({selectedMachines: machines});
    }
  }

  newMachineNandler = () => {
    const {machineDum} = dums;
    this.setState({
      selectedMachine: machineDum
    })
  }

  afterSaveMachineHandler = (machine) => {
    this.setState({
      selectedMachine: null,
      machines: [
        ...this.state.machines,
        machine
      ],
      selectedTemplate: machine
    })
  }

  tooglePopup = () => {
    this.setState({
      selectedMachines: [],
      selectedMachine: null,
      selectedTemplate: null,
      rebootedMachines: []
    })
  }

  editConfigHandler = (machine) => {
    this.setState({
      selectedTemplate: machine
    })
  }

  editMachineHandler = (machine) => {
    this.setState({
      selectedMachine: machine
    })
  }

  rebootHandler = () => {
    const {selected} = this.state;
    if (confirm('Уверен?')) {
      this.setState({
        rebootedMachines: selected
      })
    }
  }

  changeSearchHanlder = (e) => {
    const model = e.target.value;
    window.history.pushState({}, '', '?model=' + model)
    this.setState({
      filter: {
        model
      }
    })
  }


  openHandler = () => {
    const {selected, machines} = this.state;
    selected.map(id => {
      let machine = machines.find(s => s.id == id);
      window.open(machine.url);
    })
  }

  render () {
    const {selected, filter, selectedMachines, selectedMachine, selectedTemplate, rebootedMachines, models} = this.state;
    const machines = this.filterMachines();
    return (
      <div className="container-fluid">
        <div className="machines-header">
          <pre>
            <h2>
              тачки
              <span className="machines-header-panel">
                  <div className="col-2">
                    <i className="fa fa-plus-circle text-success fa-lg" onClick={this.newMachineNandler} aria-hidden="true"></i>
                  </div>
              </span>
            </h2>
          </pre>
        </div>
        <div className="row">
          <div className="col-2">
            <div className="form-group">
              <select value={filter.model} className="form-control" onChange={this.changeSearchHanlder}>
                <label>модель</label>
                <option value={null}>all</option>
                 {models.map(m => {
                   return (
                     <option value={m}>{m}</option>
                   )
                 })}
              </select>
            </div>
          </div>
          {selected && selected.length > 0 && <div className="col-2">
            <button className="btn btn-dark" onClick={this.editGroupHandler}>
              редактировать ({selected.length})
            </button>
          </div>}
          {selected && selected.length > 0 && <div className="col-2">
            <button className="btn btn-info" onClick={this.openHandler}>
              открыть ({selected.length})
            </button>
          </div>}
          {selected && selected.length > 0 && <div className="col-2">
            <button className="btn btn-danger" onClick={this.rebootHandler}>
              ребут ({selected.length})
            </button>
          </div>}
        </div>
        <div className="machines-list">
          <table className="table table-considered">
            <thead className="table-info">
              <th width="5%">
                <div className="form-group checkbox-big">
                  <input type="checkbox" className="form-control" checked={selected.length == machines.length} onChange={this.chooseAll}/>
                </div>
              </th>
              <th className="label">
                IP
              </th>
              <th className="label">
                PLACE
              </th>
              <th className="label">
                MODEL
              </th>
              <th className="label">
                MAIN POOL
              </th>
              <th className="label">
                TEMPERATURE
              </th>
              <th className="label">
                HASHRATE
              </th>
              <th className="label">
                BLOCKS
              </th>
              <th className="label">
                LAST SYNC
              </th>
              <th>
              </th>
              <th>
              </th>
              <th>
              </th>
              <th>
              </th>
            </thead>
            <tbody>
              {
                machines.map(m => {
                  const chosen = selected.includes(m.id);
                  return <MachineListItem
                    key={m.id}
                    machine={m}
                    onChoose={() => {this.chooseItem(m.id)}}
                    chosen={chosen}
                    editConfig={() => this.editConfigHandler(m)}
                    editMachine={() => this.editMachineHandler(m)}
                  />
                })
              }
            </tbody>
          </table>
          {selectedMachine &&
            <MachinePopup toogle={this.tooglePopup} machine={selectedMachine}/>
          }
          {selectedTemplate &&
            <MachineConfigPopup toogle={this.tooglePopup} machine={selectedTemplate} />
          }
          {selectedMachines && selectedMachines.length > 0 &&
            <MachineConfigPopup toogle={this.tooglePopup} machines={selectedMachines} />
          }
          {
            rebootedMachines && rebootedMachines.length > 0 &&
            <RebootingProgress toogle={this.tooglePopup} ids={rebootedMachines}/>
          }
        </div>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Machines />,
    document.getElementById('react_machines')
  )
})

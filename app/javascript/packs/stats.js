import React, {Component} from 'react'
import ReactDOM from 'react-dom'

class Stats extends Component {

  constructor (props) {
    super(props);
    gon.pools = [];
    this.state = {
      stats: gon.stats,
      models: gon.models,
      filter: {},
      selected: []
    }
  }

  chooseAll = (e) => {
    if (e.target.checked) {
      this.setState({
        selected: this.filterStats().map(m => m.id)
      });
    } else {
      this.setState({selected: []});
    }
  }

  filterStats = () => {
    const {filter, stats} = this.state;
    let filtred = stats;
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

  openSelected = () => {
    const {selected, stats} = this.state;
    selected.map(id => {
      let stat = stats.find(s => s.id == id);
      window.open(stat.url);
    })
  }

  render () {
    const stats = this.filterStats();
    const {filter, models, selected} = this.state;
    return (
      <div className="container-fluid">
        <div className="stats-header">
          <pre>
            <h2>
              Статистика
            </h2>
          </pre>
        </div>
        <div className="row">
          <div className="col-3">
            <div className="form-group">
              <select value={filter.model} className="form-control" onChange={(e) => {this.setState({filter: {...this.state.filter, model: e.target.value}})}}>
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
          { selected.length > 0 &&
            <div className="col-3">
              <div className="form-group">
                <button className="btn btn-info" onClick={this.openSelected}>
                  открыть {selected.length} тачек
                </button>
              </div>
            </div>
          }
        </div>
        <div className="stats-list">
          <table className="table table-considered">
            <thead>
              <th width="5%">
                <div className="form-group checkbox-big">
                  <input type="checkbox" className="form-control" checked={selected.length == stats.length} onChange={this.chooseAll}/>
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
                temparatures
              </th>
              <th className="label">
                HASHRATE
              </th>
              <th className="label">
                BLOCKS
              </th>
              <th className="label">
                TIME
              </th>
            </thead>
            <tbody>
              {
                stats.map(stat => {
                  let color;
                  if (stat.active && stat.success) {
                    color = 'table-success'
                  } else if (stat.active && !stat.success) {
                    color = 'table-warning'
                  } else if (!stat.active) {
                    color = 'table-danger'
                  }
                  let chosen = selected.includes(stat.id);
                  return (
                    <tr className={color}>
                      <td>
                        <div className="form-group checkbox-lil">
                          <input type="checkbox" className="form-control" checked={chosen} onChange={() => {this.chooseItem(stat.id)} }/>
                        </div>
                      </td>
                      <td>
                        <a href={stat.url} target="_blank">
                          {stat.ip}
                        </a>
                      </td>
                      <th>
                        {stat.place}
                      </th>
                      <th>
                        {stat.model}
                      </th>
                      <td>
                        <code>
                          {stat.temparatures.toLocaleString()}
                        </code>
                      </td>
                      <th>
                        {stat.hashrate}
                      </th>
                      <th>
                        {stat.blocks}
                      </th>
                      <td className="text-info">
                        {stat.time}
                      </td>
                    </tr>
                  )
                })
              }
            </tbody>
          </table>
        </div>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Stats />,
    document.getElementById('react_stats')
  )
})

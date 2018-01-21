import React, {Component} from 'react'
import ReactDOM from 'react-dom'

class Stats extends Component {

  constructor (props) {
    super(props);
    gon.pools = [];
    this.state = {
      stats: gon.stats,
      models: gon.models,
      filter: {}
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

  render () {
    const stats = this.filterStats();
    const {filter, models} = this.state;
    return (
      <div className="container-fluid">
        <div className="stats-header">
          <pre>
            <h2>
              Последние данные по тачкам
              <span className="stats-header-panel">
              </span>
            </h2>
          </pre>
        </div>
        <div className="row">
        <div className="col-4">
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
        </div>
        <div className="stats-list">
          <table className="table table-considered">
            <thead>
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
                  return (
                    <tr className={color}>
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
                          {stat.temparatures}
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

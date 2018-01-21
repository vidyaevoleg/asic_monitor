import React, {Component} from 'react'
import ReactDOM from 'react-dom'

class Stats extends Component {

  constructor (props) {
    super(props);
    gon.pools = [];
    this.state = {
      stats: gon.stats,
    }
  }

  render () {
    const {stats} = this.state;

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
                TEMPERATURES
              </th>
              <th className="label">
                HASHRATE
              </th>
              <th className="label">
                BLOCKS
              </th>
            </thead>
            <tbody>
              {
                stats.map(stat => {
                  let color;
                  if (stat.active && stat.success) {
                    color = 'table-success'
                  } else if (stat.success && !stat.active) {
                    color = 'table-warning'
                  } else if (!stat.success) {
                    color = 'table-danger'
                  }
                  return (
                    <tr className={color}>
                      <td>
                        <a href={stat.url} target="_blank">
                          {stat.ip}
                        </a>
                      </td>
                      <td>
                        {stat.place}
                      </td>
                      <td>
                        {stat.model}
                      </td>
                      <th>
                        <code>
                          {stat.temperatures}
                        </code>
                      </th>
                      <th>
                        {stat.hashrate}
                      </th>
                      <th>
                        {stat.blocks}
                      </th>
                      <th>

                      </th>
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

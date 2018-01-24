import React, {Component} from 'react'
import ReactDOM from 'react-dom'
import {
  VictoryLine,
  VictoryArea,
  VictoryAxis,
  VictoryBar,
  VictoryChart,
  VictoryZoomContainer,
  VictoryBrushContainer,
  VictoryTheme,
  Bar
} from 'victory';

class Stats extends Component {

  constructor (props) {
    super(props);
    const stats = gon.stats;
    const newStats = stats.map(s => {
      return {
        ...s,
        time: new Date(s.time)
      }
    })
    this.state = {
      hashrateStats: newStats.map(s => {
        return {x: s.time, y: parseInt(s.hashrate)}
      })
    }
  }



  render () {
    const {hashrateStats} = this.state;
    return (
      <div className="container-fluid">
        <br/>
        <br/>
        <div className="stats-header">
          <pre>
            <h2>
              Статистика
            </h2>
          </pre>
        </div>
        <div className="stats-list">
          <VictoryChart scale={{ x: "time" }} height={200} width={800} theme={VictoryTheme.material}
            animate={{ duration: 500 }}>
            <VictoryAxis
              style={{
                tickLabels: { fontSize: 10, fontWeight: 'bold' },
              }}
            />

            <VictoryAxis
              style={{
                tickLabels: { fontSize: 8, fontWeight: 'bold' },
                grid: { stroke: '#B3E5FC', strokeWidth: 0.25 }
              }}
              dependentAxis
              tickFormat={(x) => {
                return x + ' GH/s'
              }}
            />
            <VictoryLine
              style={{data: { stroke: "cyan", border: '2px solid cyan'}}}
              data={hashrateStats}
            />
          </VictoryChart>
        </div>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Stats />,
    document.getElementById('react_machine_stats')
  )
})

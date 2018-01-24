import React, {Component} from 'react'
import ReactDOM from 'react-dom'
import {
  VictoryLine,
  VictoryAxis,
  VictoryChart,
  VictoryTheme,
  VictoryLabel
} from 'victory';

class Stats extends Component {

  constructor (props) {
    super(props);
    const stats = gon.stats.map(s => {
      return {
        ...s,
        time: new Date(s.time)
      }
    });
    const hashrateStats = stats.map(s => {
      return {x: s.time, y: parseInt(s.hashrate)}
    });
    const temps = [];
    const chips = gon.chips;
    for (let i=0; i < chips; i++) {
      temps[i] = temps[i] || [];
      for (let j in stats) {
        let stat = stats[j];
        temps[i].push({
          x: stat.time, y: parseInt(stat.temps[i]) || 0
        })
      }
    }
    this.state = {
      hashrateStats: hashrateStats,
      temps: temps
    }
  }



  render () {
    const {hashrateStats, temps} = this.state;
    console.log(temps)
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
          <VictoryChart scale={{ x: "time" }} height={300} width={800} theme={VictoryTheme.material}
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
        <div className="stats-list">
          <VictoryChart scale={{ x: "time" }} height={300} width={800} theme={VictoryTheme.material}
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
                return x + ' ℃'
              }}
            />
            {temps.map( (temp, index) => {
              let color = ['blue', 'deepskyblue', 'violet', 'navy'][index]
              return (
                <VictoryLine
                  style={{data: { stroke: color, border: '2px solid gray'}}}
                  data={temp}
                />
              )
            })}
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

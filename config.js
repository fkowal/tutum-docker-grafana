define(['settings'],
function (Settings) {
  return new Settings({
    //elasticsearch: "http://"+window.location.hostname+":9200",
    datasources: {
      graphite: {
        default: true,
        type: 'graphite',
        url: 'http://${GRAPHITE_HOST}:${GRAPHITE_PORT}'
      }
    },
    default_route: '/dashboard/file/default.json',
    timezoneOffset: null,
    grafana_index: "grafana-dash",
    unsaved_changes_warning: true,
    panel_names: ['text','graphite']
  });
});

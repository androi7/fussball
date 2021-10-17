enum Endpoint {
  teams,
}

/// Erhalte alle Uri's, die aus einem [host] und einem Endpoint bestehen.
/// Alle Endpoints werden in einer Map [_paths] aufgelistet und
/// können mit der [Endpoint] Enumeration ausgewählt werden.
class API {
  static const host = 'public.allaboutapps.at';
// https://public.allaboutapps.at
  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: _paths[endpoint],
      );

  static final Map<Endpoint, String> _paths = {
    Endpoint.teams: 'hiring/clubs.json',
  };
}

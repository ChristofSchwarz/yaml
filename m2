engine:
  acceptEULA: "yes"

global:
  persistence:
    storageClass: localnfs

devMode:
  enabled: true
#mongodb:
#  uri: mongodb://qlik:Qlik1234@mongo-mongodb.default.svc.cluster.local:27017/qsefe

edge-auth:
  oidc:
    redirectUri: https://elastic.example:32443/login/callback

identity-providers:
  secrets:
    idpConfigs:
      - discoveryUrl: "https://qlik.eu.auth0.com/.well-known/openid-configuration"
        clientId: "yshaJXU98iUb8AvSdUzZzHXGatyd9nen"
        clientSecret: "ILUmwYcxQ6aSUVn1zIob1OcEuHLjAGqQmwBeNy2KGD0Fg07GNJ1Xw5AgKXa0S_ad"
        realm: "Auth0"
        hostname: "elastic.example"
        claimsMapping:
          client_id: [ "client_id", "azp" ]
          groups: "/https:~1~1qlik.com~1groups"
          sub: ["/https:~1~1qlik.com~1sub", "sub"]

elastic-infra:
  nginx-ingress:
    controller:
      service:
        type: NodePort
        nodePorts:
          https: 32443
      extraArgs.report-node-internal-ip-address: ""

hub:
  ingress:
    annotations:
      nginx.ingress.kubernetes.io/auth-signin: https://$host:32443/login?returnto=$request_uri

management-console:
  ingress:
    annotations:
      nginx.ingress.kubernetes.io/auth-signin: https://$host:32443/login?returnto=$request_uri

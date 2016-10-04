# roshi Cookbook

This cookbook will install Roshi, along with the associated Redis instance and nginx for proxying the connections on port 80 to roshi

## Requirements

### Platforms

- Ubuntu 14.04

### Chef

- Chef 12.0 or later

### Cookbooks

- `redisio` - used to install Redis
- `tar` - used to download Roshi from the repository and unpack

## Attributes


### roshi::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['roshi']['version']</tt></td>
    <td>String</td>
    <td>What version of the roshi tarball to install from the repo</td>
    <td><tt>1</tt></td>
  </tr>
  <tr>
    <td><tt>['roshi']['redis']['version']</tt></td>
    <td>String</td>
    <td>What version of redis to download and install</td>
    <td><tt>3.2.4</tt></td>
  </tr>
</table>

See redisio cookbook at https://github.com/brianbianco/redisio for Redisio settings.

## Usage

### roshi::default

Just include `roshi` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[roshi]"
  ]
}
```

## License and Authors

Authors: Rob Borek

Assistance from the following
- redisio, apt, and tar cookbooks
- nginx upstart file courtesy of the nginx website

## TODO

- optimize nginx reverse proxy
- determine whether roshi and redis should be blocked from access outside the host
- parameterize the config files to allow for more robust configuration via role/environment file
- make the download source configurable
- optimize redis settings
- add remote logging capabilities for redis/nginx


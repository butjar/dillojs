# dillojs-cookbook

Provisions dilloJS.

## Supported Platforms

- ubuntu-14.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['dillojs']['home']</tt></td>
    <td>String</td>
    <td>DilloJS home directory</td>
    <td><tt>/opt/dillojs</tt></td>
  </tr>
  <tr>
    <td><tt>['dillojs']['api']['home']</tt></td>
    <td>String</td>
    <td>API home directory</td>
    <td><tt>default['dillojs']['home']/api</tt></td>
  </tr>
  <tr>
    <td><tt>['dillojs']['web']['home']</tt></td>
    <td>String</td>
    <td>App home directory</td>
    <td><tt>default['dillojs']['home']/web</tt></td>
  </tr>
  <tr>
    <td><tt>['dillojs']['npm']['packages']['global']</tt></td>
    <td>Array</td>
    <td>Global npm packages</td>
    <td><tt>["bower", "brunch"]</tt></td>
  </tr>
  <tr>
    <td><tt>['dillojs']['nginx']['root_dir']</tt></td>
    <td>String</td>
    <td>Nginx root directory</td>
    <td><tt>/usr/share/nginx/www/</tt></td>
  </tr>
</table>

## Usage

### dillojs::default

Include `dillojs` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[dillojs::default]"
  ]
}
```

## License and Authors

Author:: Martin Fleischer (<martin.fleischer@kreuzwerker.de>)

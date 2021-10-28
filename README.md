Oracle Cookbook
===============
This cookbook makes your Oracle Database.

Requirements
------------
### Platforms
Oracle Linux 5.9~
### Oracle
Oracle Database 19g Release 2 (19.3.0.0.0)

### Deploy the Install Files
Both disk 1 and disk 2 should have been unzipped into the same database directory.
It stores the directory to files/default.

Attributes
----------
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['hostname']</tt></td>
    <td>String</td>
    <td>hostname</td>
    <td><tt>ora-chef.tsubauaaa.com</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['packages']</tt></td>
    <td>Array</td>
    <td>requirement OS packages</td>
    <td><tt>%w{compat-libstdc++-33 libaio-devel unixODBC unixODBC-devel}</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oinstall_gid']</tt></td>
    <td>Integer</td>
    <td>oinstall's group id</td>
    <td><tt>200</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['dba_gid']</tt></td>
    <td>Integer</td>
    <td>dba's group id</td>
    <td><tt>201</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oper_gid']</tt></td>
    <td>Integer</td>
    <td>oper's group id</td>
    <td><tt>202</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oracle_uid']</tt></td>
    <td>Integer</td>
    <td>oracle's user id</td>
    <td><tt>440</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['user_password']</tt></td>
    <td>String</td>
    <td>oracle user's password</td>
    <td><tt>oracle</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oracle_dir']</tt></td>
    <td>Directory Path</td>
    <td>oracle's directory path </td>
    <td><tt>/u01/app</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oracle_base']</tt></td>
    <td>Directory Path</td>
    <td>oracle_base's directory path </td>
    <td><tt>/u01/app/oracle</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oracle_home']</tt></td>
    <td>Directory Path</td>
    <td>oracle_home's directory path </td>
    <td><tt>$ORACLE_BASE/product/19.3.0/dbhome_1</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oracle_data']</tt></td>
    <td>Directory Path</td>
    <td>oracle's data files directory path </td>
    <td><tt>/u01/app/oracle/data</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oracle_inventry']</tt></td>
    <td>Directory Path</td>
    <td>oracle's inventry files directory path </td>
    <td><tt>/u01/app/oracle/oraInventry</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['install_dir']</tt></td>
    <td>Directory Path</td>
    <td>oracle's install files directory path </td>
    <td><tt>/usr/local/src</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['oracle_sid']</tt></td>
    <td>String</td>
    <td>oracle's SID </td>
    <td><tt>orcl</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['db_password']</tt></td>
    <td>String</td>
    <td>oracle system and sys's password</td>
    <td><tt>Oracle11g</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['nls_lang']</tt></td>
    <td>Lang String</td>
    <td>NLS Language</td>
    <td><tt>JAPANESE_JAPAN.UTF8</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['setup']['env']</tt></td>
    <td>Directory Path</td>
    <td>Environment Variable</td>
    <td><tt>ORACLE_HOME,ORACLE_BASE,ORACLE_UNQNAME,PATH</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['em']['dbsnmp_password']</tt></td>
    <td>String</td>
    <td>dbsnmp's password</td>
    <td><tt>Oracle11g</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['em']['sysman_password']</tt></td>
    <td>String</td>
    <td>sysman's password</td>
    <td><tt>Oracle11g</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['em']['email_addr']</tt></td>
    <td>Email Address</td>
    <td>mail address for alert</td>
    <td><tt>tsubasa11@marble.ocn.ne.jp</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['em']['smtp_server']</tt></td>
    <td>String</td>
    <td>SMTP Server Hostname or IP Address</td>
    <td><tt>smtp_server</tt></td>
  </tr>
  <tr>
    <td><tt>default['oracle']['em']['secure']</tt></td>
    <td>Boolean</td>
    <td>Whether Enterprise Manager uses the ssl</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----
#### oracle::default
Just include `oracle` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[oracle::default]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Distributed under the [MIT License][mit].

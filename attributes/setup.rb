default['oracle']['setup']['hostname'] = 'chefclient1'
# default['oracle']['setup']['packages'] = %w{compat-libstdc++-33 libaio-devel unixODBC unixODBC-devel}
default['oracle']['setup']['oinstall_gid'] = '200'
default['oracle']['setup']['dba_gid'] = '201'
default['oracle']['setup']['oper_gid'] = '202'
default['oracle']['setup']['oracle_uid'] = '440'
default['oracle']['setup']['user_password'] = 'oracle'
#解压包目录
default['oracle']['setup']['install_dir'] = '/home/u19'
default['oracle']['setup']['oracle_dir'] = '/opt/app'
default['oracle']['setup']['oracle_base'] = "#{default['oracle']['setup']['oracle_dir']}/oracle"
#创建安装目录
default['oracle']['setup']['oracle_home'] = "#{default['oracle']['setup']['oracle_base']}/product/19.3.0.0/dbhome_1"
#数据文件存放目录
default['oracle']['setup']['oracle_data'] = "#{default['oracle']['setup']['oracle_dir']}/oradata"
#数据库创建及使用过程中的日志目录
default['oracle']['setup']['oracle_inventry'] = "#{default['oracle']['setup']['oracle_dir']}/oraInventory"

default['oracle']['setup']['oracle_sid'] = 'icic'
default['oracle']['setup']['db_password'] = 'Oracle19c'
default['oracle']['setup']['nls_lang'] = 'AL32UTF8'
default['oracle']['setup']['env'] = {'ORACLE_BASE' => node['oracle']['setup']['oracle_base'],
                                     'ORACLE_HOME' => node['oracle']['setup']['oracle_home'],
                                     'ORACLE_UNQNAME' => node['oracle']['setup']['oracle_sid'],
                                     'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node['oracle']['setup']['oracle_base']}/dba/bin:#{node['oracle']['setup']['oracle_home']}/bin:"}

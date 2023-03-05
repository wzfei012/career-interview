# bash

## 官方文档

### **变量声明**

```bash
declare
+/- "-"可用来指定变量的属性，"+"则是取消变量所设的属性。
-f 仅显示函数。
r  将变量设置为只读。
x  指定的变量会成为环境变量,可供shell以外的程序来使用。
i  [设置值]可以是数值，字符串或运算式。

n 表示number
a 表示array
A 表示map

```

### **字符串分割**

```bash
${#parameter}
#Parameter length

${parameter#word}
${parameter##word}
# Remove matching prefix pattern.From the beginning of parameter
${parameter%word}
${parameter%%word}
# Remove matching prefix pattern.From the trailing of parameter

${parameter:offset}
${parameter:offset:length}

${parameter/pattern/string}
# Pattern substitution.Replace pattern with string
## If pattern begins with /, all matches of pattern are replaced with string.  Normally only the first match is replaced.  
## If pattern begins with  #,it  must  match  at  the beginning of the expanded value of parameter.  
## If pattern begins with %, it must match at the end of the expanded value of parameter.  
## If string is null, matches of pattern are deleted and the / following pattern may be omitted.  

## If the nocasematch shell option is enabled, the match is performed without regard  to  the   case of alphabetic characters.  
## If parameter is @ or *, the substitution operation is applied to each positional parameter in turn, and the expansion is the resultant list. 
## If parameter is an array variable subscripted with @ or *, the substitution operation is applied to each member of the array in turn, and the  expansion  is  the  resultant
```

### **字符串转换**

```bash
${parameter^pattern}  # convert first letter matching pattern to uppercase
${parameter^^pattern} # convert letters matching pattern to uppercase
${parameter,pattern}  # convert first letter matching pattern to lowercase
${parameter,,pattern} # convert letters matching pattern to lowercase
# Case conversion

${parameter@operator}
# transformation of the value of parameter or information about parameter itself, depending on the value of operator.
## Each operator is a single letter:
## Q The expansion is a string that is the value of parameter quoted in a format that can be reused as input.
## E The expansion is a string that is the value of parameter with backslash escape sequences expanded as with the $'...' quoting mechansim.
## P The expansion is a string that is the result of expanding the value of parameter as if it were a prompt string (see PROMPTING below).
## A The expansion is a string in the form of an assignment statement or declare command that, if evaluated, will recreate parameter with its attributes and value.
## a The expansion is a string consisting of flag values representing parameter's attributes.
```

### **字符串默认值**

```bash
${parameter:-word}
# If parameter is unset or null, the expansion of word is substituted.  Otherwise, the value of parameter is substituted.
${parameter:=word}
#If parameter is unset or null, the expansion of word is assigned to parameter.  The value of parameter is then substituted.   Positional parameters and special parameters may not be assigned to in this way.
${parameter:?word}
#If parameter is null or unset, the expansion of word (or a message to that effect if word is not present) is written to the standard error and the shell, if it is not interactive, exits.  Otherwise, the value of parameter is substituted.
${parameter:+word}
#Use Alternate Value.  If parameter is null or unset, nothing is substituted, otherwise the expansion of word is substituted.
```

### 实例

```bash
#!/bin/bash

#字符快速处理
a=aaa:bbb:ccc:ddd
echo ${a#*:}  #从左侧开始匹配，去掉第一个:及左边的所有字符 结果为 bbb:ccc:ddd
echo ${a%:*}  #从右侧开始匹配，去掉第一个:及右边的所有字符 结果为 aaa:bbb:ccc
echo ${a##*:} #从左侧开始匹配，去掉最后一个:及左边的所有字符 结果为 ddd
echo ${a%%:*} #从右侧开始匹配，去掉最后一个:及右边的所有字符 结果为 aaa
echo ${a/ccc/333} # ccc替换为333 支持正则（部分支持）

echo ${a^[a-z]}	 # Aaa:bbb:ccc:ddd
echo ${a^^[a-z]} # AAA:BBB:CCC:DDD

a=AAA:BBB:CCC:DDD
echo ${a,[A-Z]}	 # aAA:BBB:CCC:DDD
echo ${a,,[A-Z]} # aaa:bbb:ccc:ddd
echo ${a@Q} # 'AAA:BBB:CCC:DDD'
echo ${a@A} # a='AAA:BBB:CCC:DDD'

${parameter@E} #将字符串中的 '\' 替换为转义字符, \t -> tab  \n -> newline 与$'...'等效 如：$'\t'  $'\n'


${parameter@a} #返回参数的类型, 如: echo ${myMap@a} 结果为 A,echo ${myarray@a} 结果为a
## declare -A myMap=(["my01"]="01" ["my02"]="02") 
## myMap["my03"]="03"
## myMap["my04"]="04"
## declare -a myarray=( "1" "2" )
## myarrary[2]="3"
## myarrary[3]="4"

${parameter@P} # 提示(PROMPTING)

# 当以交互方式执行时,bash在准备好读取命令时显示主提示PS1,在需要更多输入来完成命令时显示辅助提示PS2。Bash在读取命令之后但在执行命令之前显示PS0。Bash允许通过插入多个反斜杠转义的特殊字符来自定义这些提示字符串，这些字符的解码方式如下：

# \a ASCII钟形字符(07)

## \d "工作日-月-日" 格式的日期(例如,"Sun Mar 05")

## \D{format} format被传递给strftime(03),结果被插入到提示字符串中；空格式会打印区域设置的时间。其中`{}' 不可以省略

## \e ASCII转义字符(033)

## \h 主机名截取到第一个`.'之前

## \H 主机名

## \j当前由shell管理的作业数

## \l shell终端设备名称的基本名称

## \n换行符

## \r回车

## \s是shell的名称,基本名称为$0(最后一个斜杠后面的部分)

## \t 24小时HH:MM:SS格式的当前时间

## \以12小时HH:MM:SS格式显示当前时间

## \@当前时间为12小时上午/下午格式

## \A 24小时HH:MM格式的当前时间

## \u当前用户的用户名

## \v bash的版本(例如2.00)

## \V 发布bash,版本+补丁级别(例如2.00.0)

## \w 当前工作目录,$HOME缩写为波浪号(使用PROMPT_DIRTRIM变量的值)

## \W是当前工作目录的基本名称,$HOME缩写为波浪号

## \! 此命令的历史编号

## \#此命令的命令编号

## \$如果有效UID为0,则为#，否则为$

## \nnn与八进制数nnn对应的字符

## \\反斜杠

## \[开始一系列非打印字符，可用于将终端控制序列嵌入提示中

## \]结束非打印字符序列

```

##### declare

```bash
+/- "-"可用来指定变量的属性，"+"则是取消变量所设的属性。
-f 仅显示函数。
r  将变量设置为只读。
x  指定的变量会成为环境变量,可供shell以外的程序来使用。
i  [设置值]可以是数值，字符串或运算式。

$ declare -f a
a () 
{
    echo 1111
}
```

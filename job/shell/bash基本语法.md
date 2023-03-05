## 变量

### **变量声明**

```bash
declare
+/- "-"可用来指定变量的属性，"+"则是取消变量所设的属性。
-f 仅显示函数。
r  将变量设置为只读。
x  指定的变量会成为环境变量,可供shell以外的程序来使用。
i  [设置值]可以是数值，字符串或运算式。

n 表示别名
a 表示array
A 表示map 

declare -n test=a # a是一个变量的名称，test为该变量的别名
declare -a arrary1=( item1 item2 ... itemn )
declare -A map1=(["key01"]="val01" ["key02"]="val" ... ["keyn"]="valn") 
#赋值
arrary[n]=itemn
map1["keyn"]=valn

```

### 变量使用

```
# map
# 1）输出所有的key,若未使用declare声明map，则此处将输出0，与预期输出不符，此处输出语句格式比arry多了一个！
echo ${!myMap[@]}
#2）输出所有value,与array输出格式相同
echo ${myMap[@]}
#3）输出map长度,与array输出格式相同
echo ${#myMap[@]}


```


### 特殊变量

```
$$  #Shell本身的PID（ProcessID）
$!  #Shell最后运行的后台Process的PID
$?  #最后运行的命令的结束代码（返回值）
$-  #使用set命令设定的Flag一览

$@  #参数列表
$*  #参数列表
$#  #参数数量
$0  #command名称
$1,$2....$n #第n个参数

$(command) #执行command
$((command)) #执行command
`command`  #执行command

# Assignment statements may also appear as arguments to the alias, declare,  typeset,  export,  readonly,   
       and  local builtin commands (declaration commands).  When in posix mode, these builtins may appear in a command after one or more instances of the command builtin   
       and retain these assignment statement properties.

```

## 表达式

## 循环

```bash
# for name [ [ in [ word ... ] ] ; ] do list ; don
  for name   in ${arrary[@]}  ;  do echo $name; done
# for (( expr1 ; expr2 ; expr3 )) ; do list ; done
  for ((i=0;i<10;i++));do echo $i;done
#  while list-1; do list-2; done
while [[ $i -lt 10 ]
do 
   let i++
   echo $i
done
```

## 选择

`select name [ in word ] ; do list ; done`

```bash
#!/bin/bash
Hostname=( 'host1' 'host2' 'host3' )
select host in ${Hostname[@]}; do
    if [[ "${Hostname[@]/${host}/}" != "${Hostname[@]}" ]] ; then
        echo "You select host: ${host}";
    else
        echo "The host is not exist! ";
        break;
    fi
done
```

`case word in [ [(] pattern [ | pattern ] ... ) list ;; ] ... esac`

```bash
case expression in  
    pattern_1)  
        statements  
        ;;  
    pattern_2)  
        statements  
        ;;  
    pattern_3|pattern_4|pattern_5)  
        statements  
        ;;  
    pattern-n)  
        statements  
        ;;  
    *)  
        statements  
        ;;  
esac


```

`if list; then list; [ elif list; then list; ] ... [ else list; ] fi`

```bash
# 强烈推荐使用 `[[ ]]' 而不是 `[]' 前者的功能更多 
if [[ expression ]]
then
    command1
elif [[ expression ]]
    command2
else
    command3
fi
```


## 命令

单个命令是一系列可选变量赋值，后跟空格分隔的单词和重定向，并由控制运算符终止。这个

第一个字指定要执行的命令，并作为参数0传递。剩余的单词作为参数传递给调用的命令。

简单命令的返回值是其退出状态，如果命令被信号n终止，则返回128+n。

### 列表

多个命令+操作符

```bash
command1 && command2 #and
command1 || command2 #else
command1 | command2 #pipeline
( command1;command2;... ) # command list in subshell environment
{ command1;command2;... } # command list in current shell

((expression)) #等同于 let expression （如 let a++ ）
[[ expression ]] #条件判断 支持 !前缀 ,支持 == != =~ => <= -eq -ge -le ,支持多个条件运算 && ||
```

## 异步执行

```bash
coproc command1 等效于 comamand1 & 
但是 & 运算符会与子shell建立双向管道，而coproc不会
```

## 函数

```bash
# Shell Function Definitions
## A shell function is an object that is called like a simple command and executes a compound command with a new set of positional parameters.  
## Shell functions are declared as follows:

name () compound-command [redirection]
function name [()] compound-command [redirection]
```

## 转义字符

`$'...'`

```
Words of the form $'string' are treated specially. The word expands to string, with backslash-escaped characters replaced as specified by the  ANSI  C  standard. Backslash escape sequences, if present, are decoded as follows:


\a     alert (bell)
\b     backspace
\e
\E     an escape character
\f     form feed
\n     new line
\r     carriage return
\t     horizontal tab
\v     vertical tab\\     backslash
\\'     single quote
\\"     double quote
\\?     question mark
\nnn        the eight-bit character whose value is the octal value nnn (one to three digits)
\xHH       the eight-bit character whose value is the hexadecimal value HH (one or two hex digits)
\uHHHH  the Unicode (ISO/IEC 10646) character whose value is the hexadecimal value HHHH (one to four hex digits)
\UHHHHHHHH
                the Unicode (ISO/IEC 10646) character whose value is the hexadecimal value HHHHHHHH (one to eight hex digits)
\cx    a control-x character
```

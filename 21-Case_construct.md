Using Case in bash scripts

# Syntax
case '$VAR" in

  "$condition1" )        #if condition1 is true, it runs the commands in the block od code
    command(s)
    ;;

  "$condition2" )        # if condition1 is false, it evaluates next block of code
    command(s)
    ;;

  * )                    # if none of the blocks above match it runs this block of code
    command(s)
    ;;

esac

# Example
case "$(whoami)" in
  "root" )
    echo "You are root"
    ;;
  "Wizard" )
    echo "You are Wizard"
    ;;
  * )
    echo "I don't know you"
    ;;
esac


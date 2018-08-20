#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the Demo-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Demo-1.0.1-Linux subdirectory
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Demo Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
T License (MIT)

Copyright (c) 2013 Joseph Pan(http://hahack.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Demo will be installed in:"
    echo "  \"${toplevel}/Demo-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Demo-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Demo-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

tail $use_new_tail_syntax +162 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the Demo-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� 4u[ �[tGz�]Y��O��$$P����X��7�lDd��.1�ֲ��dI�Vi�sBO��{��K�R.�^齶��wW�>^L|�{�>��qM�ʅ�g�K�q$u�\��+�v�@_[���~�}�����|3�z0�h\��$�-$�ǳ��U��U(��jm�<����6��mnnnmjn�x�$f�乕�b�ͨ�4�J&��(���J��H��	=�� 
B��Z���6�}�,t|�T��2 �r�[5r>�ӥ3�h�ک����]$|��ӥ��KMjյ��K#�@� ��P]���|̀.��z�D��H�f���g)`�}e��O�~�.���r�5��.�t�"��ʧK�rrz�
���������=�~�h�YʞCc<6����4�c�잆=�mm-�L�݄�䢲mڂ�Y?J��u����̮������̓b�s�o�����(�����o����uO]������e���jh9�Vt��+���3��O�8R�4���������^<���?����_>�3Gu��/����n�~���y&�%�KM��&�|�o6)爉|���&�? �A�5������8�J �����nq9�ݚ�{����'8ZIp6^���KW(� �����?i'�W)~	�U�����T~��Ϧ�I�;��J���T��+cp�g�H�����n�I&d�h��䍻��J4�Q�tg<��( w���%M����x2���
�3́vF�	x��⼈<�U3 ��%�!R���B�B#�X�!�LV�%�DW/̎�r6�D`v$����V�"~0�ay�֚J�*�,BI@E)����::�&w��5߯"N�O0���O���'{w�i�c넓<�r�3C���(��I\+�B��ip�׮#�ܦ�}�B��j�~�.��ӓ�u��߱OͶ�Ef�� ^�K}���(���YH��#5��Y��)�&1������q��I��b~/�QS.M@��~W��;������\���:=�f@��)	'�����#(xuȹ.>'��n	6���qsG�S'paî�xe͞w.}a'�4�f,P>�{-x��uA�l��3Y��
Q�T�^'�oS�'ּa��c��5�Vd���� $�|
�Op|�v+P��P����p5��gw\�U�K��LQ�A�r���eώ?����������A�2R�+��q�z\���Ogg��x-�13N��޹Xd|Ҏ�NO?3�8kg ~&���|����\���aq��9��*���
���t�Lw�b�eLn�>؃傹-H��L���
�
p�?�F��뿀uC���j3*e:��;Hl�����\��������	2�.�{��t ;]�-��\���,́FW��f���ڞs���s��s;����o��f�[�r��t����w�?f��8Ԁ҇���}3x�4#�/~{����%ΥO�t����}��1[�Vp|J��{�w�D����������SCn&��	<��Tt�����UIgbɄTq�G*��L(�< ���PF��=)�NM�R%�ߔ�F	���d6-%GROH��k/J��A}T�	��b�>Z	�E��ȷB�>ؘ��t��a���)��W��=S��ј�i;})��z
{7a�KXTm�O6/; �Z�i��< ˩��ǳ�)$�pmp,���?�ݽze��� *�|�a�xM�;\�Κr�Xɏ�����Gp>�E=��	���Āc᳖�C:Tp��k��9Pt���z�������+:R�c!��p�q;�>X������$MP)ESF�I���?IS��b~�>����(���(��Gw�t��/��?�t�I|Y$屵Z���ufh~%�Њ���T	- z�����1;AS6/�/p'M���t��Y���
����'E�g)���2�����E�},G��s=@�/���4�6M_���uv> ��;�{�w��Uj�x[=mM�Ҋ�JD
�T�7x�����t�u�c��w
L��Q�m`��g�Z���11$�mGQ"��
%����2�b��eZA�Rf�8T�Z��ٱ���$Ƭ��߃�u^��m��йK��y���;ġ�9��{T�U���o����z$\GT#v�	�H�vT�8�Fٿ!͗P ��A���!�T�e�@�����B-��#��v���E�����*���W�J���1 ��{��H��W�P+�;�WY���<��:q9��Z!h���P愷]�a�na�]�U�!�t|��q� sʭ��"���*eC[-:�`3o�Pd��
=B
��-c�Z���C֮�]h���0�zlDu>v��+>�C��8�Qəc�h2��1<ڥd�ld�׶˩Px�| @�>w8�"�
��3K�p1*.����_���}q��]���h�lz��t��� @�Ԇl"�B�,��;��d�$�N�s�2/B���?��]��J��F |yH���W��!5��ل�&�$�t,�P:<��CIQ�?�z=�����g�j�D&M�:�:"7��p(}������UIfѮ?���Af8�V�6 ���eN-���*�XJ�n�qzcT���pg�F�� L�4I�����Nw"�*nGW��R.�Ⱥ��x�!�e��;2���TM����u�12�K+��w)�An|�V�=���1��$>�p+��P:4��Ñt�#r(��v�h8�����養/�
)q0��prd��;�f�P9��*��C�|��`Z�͸x,��{�Ғd���s�q1>��-@5��������"=^����������6e�W��=^����x������!^|�H��s;����+n��kA�!>/����y?U�ׁˆ�C���ȟo��;�~�/>g%x��(��.���_l���	��_Z��%��l�ǫq^q�����v�>�Mq��)��k�������!|_��r&�r�����	�v�2����8�T����0)�},_<~�+��ß�;1�Ǹ��wԼ��i�8�>\N�8�����q\bX0>��#���Ϛ�/����`x�D��&�h"o��w���xD����8N�#ەE���.�8��[4�����?���0�-�a@8�Bdh����s����p�,�B�DVG�0
�d�$ˑ��'Cq9�&�9���Z��+�q�5���@��zz�!��*N.�T4��I��a��' 6�G �(z�Pwo��[�ݰ��@����� ���μt$���C�
��F� ¬d����h�6$��i#1EA�)�Ba%�,RX℮�B�)^Z�2�]3:�^|�KƫHL��B+)z%��T���+���ˀ>VU�.��'_��^N���*���G���&�>��L����6v��h gkL���3XASt>'��s�����1}�J�������	���g~�Zz ����}�vr�x�ߦ�����h/ }�?/��T����?�?E�;(���cT��?"�j�gA�[D�}�N$y��9N���T?�ɻ��0����T�;��Kς�9}�����<_��@?���z�Ҹ���;����!���<o�ۜ>�G�Q�:n���'��������6��<�b,N�>�צ�S��?�g~�����'@��/|E����q�/�}��q^�>K����~/5,���g�V���ϛ��������}����>�m#�o�p>>c�߉�ƨ���>�;M�L��U����D�Y��k	�^���Ij-a�`�OҀ�3&�,������;H,a_;�������=������������>�n�W7�c	�)����\�������_��i�|��*y�m�����v�=�s󵕍����p_�Y���*I�h����n���a���KPSS���-�;�XY���khk���"��i�׶�Ij�zZX��W��ʙ�ͧ_>z������	�!����m��&�&9b B�tD�����tL%��٦a:\'>Lw�Cf|�بk�t[�\��5�\��f�� 	���
�܊@ڍ��}݄v�l�l�UҵBQ$"��ې��i�F���h0>zS��ll\!»�R>�tM2;�Ed1Y�-�~���o�p���k������U&x�	�0���0�����C~���i�|�*5���58j�s�Zg�5�����5���J���e�{8��d�I����g(������a���ɳ����柶ߴ_=�]_O��h*c/��J�T��>��w~��]!�?6������ݨ�� ����>Z��l�q����ץ�T��U�1��K��%�������'��~ן�r�~-���GL��;�)a_6���� ��S�xW9N9�QѮr���:����?�ۯ���d��w�{�~;��,�TϨ���� ��g��>N��q�u���G�!C��}�]�1v�\���_�%��lDi'C��{�V�(���\��{Z�Ӊ�Jo����vPcc$�d$uX�R�:�L�H�trw,��4D��u��+�e�DD������w����r�-�M��5����Mr�c�f�k�ٵ	fz*K�m�n=���w�o�k��������������f����m!r!�-�
ʠ���c	5��T�����s4Gs4G���?377q H  
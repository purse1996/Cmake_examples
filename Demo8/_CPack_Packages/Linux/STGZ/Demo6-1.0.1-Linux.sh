#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the Demo6-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Demo6-1.0.1-Linux subdirectory
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
  echo "Demo6 Installer Version: 1.0.1, Copyright (c) Humanity"
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
The MIT License (MIT)

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
    echo "By default the Demo6 will be installed in:"
    echo "  \"${toplevel}/Demo6-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Demo6-1.0.1-Linux?"
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
  toplevel="${toplevel}/Demo6-1.0.1-Linux"
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

tail $use_new_tail_syntax +162 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the Demo6-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� z�[ �mp��I�,;�Bc����1�X��!;ɶ�sj;Ʊ���9���R�����aHHǐ���f(�2��0�B��@A;���ƴe eh:6	�	<����}����$-��s��}����{�nw�<�V�kN��������P�T�,p����7f��qNL8݈��֎H%��8v%N�#����L�0�,�� Qu�8��}���ם�WMn����x��\5��s^K�(|���>_{��`��Ft;"ԡb�D{�?�0��A���.A�Q�r�Q�i0M��L�(�G�Q��^r�P5�
/.C*���#�ڭ2�n�Wa���zFЫ�J��xg�W G��qQ�r-
y]�'����E��[<*���0zw`�"t�`���]�)�t��"��`�P$��itW�����F����:{%yz9�y>�� i�|���ҹ�'/~m�>��ҟ��6���}�پt~���`���!ms�N��J���㩇�-[��ҧ�sj��WO=V3�·oݽe��~~��?���?�؊xA������]�NDg^�����_�÷�������������u�I>݄���*����0��%�B���'$����1kt�:�����V4^"�E��>��,���/����e�	�?!�K�t�G%_���n�f�G��>��&�m�Ţ���:�e�F�S���D�!�OƤ�"!��HR��p���D��w��v�� >m���b\�$�b���y({�C"Ġ?�����018��q�o���HTH%Ġ�#����9�HP��;�n�yȟH�	�Mֵ�555�^F���Ϡ�����WR#%D���6y>��P�\��#��oR�+�ߩ�+��
�Y��GϚ����9�?0�,�HH�?����?S�d*N�_�>#t�4M���P�6���'�%���&C����a�����듏KtӡC�?ׇm�׷����驮��ccd�ǎ��;F���o��'!���xn3`/_E�?:m����X��4B<��}�IC�=,|�d��(E�A��$��[2p�	��S������%��K���J�5�lG��m%���ۋ'�ر��
/s����a�J[�R�g~����>"
���{�9�3�I�>��S㣻O�k�����y��r���K���!٘x�R&"�a[�anxN��D�����%�c��1�����i��١���}g�Ǧ&n�ā޳Xd*�w,|����;>�
���ӄ5B![����Y�ÿ%��e01�9��x��Q2�󶹾����Dl�m�64��4JY0�pv�L�1�E2����}�w/
�΍��-'ޙ��2g��m"��ûٻɛ�x{�=�+�܃UolK_hK��~����?�iⳋ�>�a�s�C�C{����l!3�?z���<���l���y����n�
G����Ga/��1�.�Hp��x"�rAGEЂz�Aq��	�G��;O4�ɁNgl'�S��}����\lg���'������]Ur[�-.��*-�]:�ְȴ��D�޲k?��1�B�8��g0~O�8��7��ƍ��K�{��a�nXTVl>d(�>yֆ��������'���<V{��|��t�y/Z�p���[nF Cb�"��,�Z����s����%�=���p{��}��Nt���gj���cc���A���,h�V����:�������'nm�Z�^ke���rX��j���
>���w����0�izE�9@���&�i�h���d9�/f�?���j�e{����4�!����>\J���!S@|@��`���/ ��K�a��ߴ����K��������c�5�<�7�孀7���u�ͫ��ށT4���ug�;%Q�=.��Y�p9o�����t;W��	_%ZP��|Z�7��&� ������:R��M�/֜'^�&�$�N�|Kv=������/C��u7�ݷW��˯�|�<G���75n�����C�R-��}�����w5�F�i򿡹>Mx7�|B�/��g5??_���y��_��#�� }�a�eR[����g�������������}�E����/6J���������'���˯u��;��uxQj����������ұ��{C޸&%;7!���?�d�;�y��_��>�\?]�3h�6����̻�z��v}���������S:v^��0h׉&u�E�Z��b�v=�4Ү7�4h׉��Dˌ�u�J���k����ԑ�kԮ7�@<�H�B!G 	���n��mc� �\�GHRnI�"OL����`2O��
Ć��I1�h�_Y�-$��<��%��)����aQ���wa%�T��<�ɬZS�@�g	���no�O�u��2��?=WY!��`"&��� �Y�����hkV���պ�^�ǃi���z:���u�����֍��������vFJs���E
tj���������+/�)�qrqP�$G�L��E:�H�N�0N�e�gx`b|;rDcI��mj�J������P�*D�'�����d���-;�]E�-.�� �mJ�.� ɩc0�O����f��I��!�aQ���%��F֠��q��p$��Y�'���ȁ��0^����y�G���C��bF���ː�v�{�#�#_��.F�ƭI`�2�>�.�܁����`���O�(�T�?����Q	��[���lBr.E�i��A�4��^��H΅�>���!�s0�|�s+J���}i�O��K
{4N�>'{�(�~�o���{A�擅���?�r�&	���40�]%`�?����������3�aF��{A��^,�(�O�Ӈ@��LQɮ&ѯ}��@B_�ȳ�
��/�7�@��g���Ͻo��5�<��aF��Cf(@�g<���� /#i="��U[�����M�O������'�O�i��]����<wT?�~\��{q:�T���G��i^7m���)>��g�t��3��4�O�[�]�'�O��>�G�������d�y�.T������U���g� W�t���\�J�����}5H�Υ�?�0c����@���!�:#�_�>�N���N����Zܨ����P[?������k��@�vK5�g޹Sů�
��'%��O*�5T���������T;��z���F�U_���o���c�{�~� ���-��·����^i�\�]$�]h���Q�j|L:wp��S@��k�u��:|m�M(���yґ���4����� F���bFN�W=ξ �Rd9Vd�4'��������w��]��͑���16{} �&9rʏ�hnHc�R��#~11��:����@���껐v��8��bܕH;F{�[���4|"�O�Ga3���=�����iϟGc��(��b�-�φ�c��oK�&�RJ4�׋1�`��3�?���RA��ȗ���:��5������������U��w��Թ��7�����q]`Y$�!�k�f_��[�a"���0b<�c��!����J �w|+�H4�������21��,3w=�@� E����q�������mNW}}C����P��[��� �w�O�۞[^����6��7�m�:��7ts.�ƶN�����0�0_�/��l @  
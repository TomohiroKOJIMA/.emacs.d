##�t�H���_�\��
- auto-install             : auto-install���g���ē��������p�b�P�[�W
- auto-save-list           : autosave�̃o�b�N�A�b�v�t�@�C��
- elpa                     : elpa���g���ē��������p�b�P�[�W
- plugins                  : yatex���̃v���O�C���֘A
- server                   :
- snippets                 : �e����mode��snippet�֘A
- ac-comphist.dat          :
- all.filelist             : anything�p�̃f�[�^�x�[�X
- contrib-make-filelist.rb : all.filelist���ŐV��ԂɍX�V����Ruby�X�N���v�g
- contrib-make-filelist.bat: Windows�̃^�X�N�X�P�W���[�������L�����s���邽�߂̃o�b�`�t�@�C��
- init.el                  : Emacs�̐ݒ�t�@�C��

##Anything�֘A
###Windows�ł̃t�@�C�����X�g�����X�V�ݒ�
1. �R�}���h�v�����v�g�ňȉ��̃R�}���h�����s����Ɩ���0���ɍX�V����D

    schtasks /create /tn "EmacsUpdate" /tr c:\windows\backup.cmd /sc daily /st 00:00:00

2. �ȉ��̃R�}���h�����s���C�ݒ�^�X�N�̒���"EmacsUpdate"���ǉ�����Ă��邱�Ƃ��m�F����D

    schtasks /query

###OSX/Linux�ł̃t�@�C�����X�g�����X�V�ݒ�
.bash_profile�ɏ������ށi�������͂��j�D

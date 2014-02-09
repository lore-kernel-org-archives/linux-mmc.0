From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: [RFC PATCH 1/1] mmc-utils: Support-sending-eMMC-5.0-FFU
Date: Sun, 9 Feb 2014 09:08:00 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE63F4970C7@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:59997
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379AbaBIJIE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 9 Feb 2014 04:08:04 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'cjb@laptop.org'" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Grant Grundler <grundler@chromium.org>

  The mmc-utils was modified to invoke eMMC5.0 Field Firmware Update (F=
=46U) process in mmc driver
  New command was add: "do_emmc50_ffu".
 =20
  This patch depends on patch  mmc: Support-FFU-for-eMMC-v5.0 Committed=
 by Avi Shchislowski <avi.shchislowski@sandisk.com>
 =20
  FFU will be done in two steps. Two new IOCTL codes will be sent to th=
e driver in order to operate FFU code:
    1.  FFU_DWONLOAD_OP (sent in ffu_download_image() function)
	2.  FFU_INSTALL_OP (sent in ffu_install() function)
 =20
 =20
Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

diff --git a/mmc.c b/mmc.c
index 926e92f..a01852d 100644
--- a/mmc.c
+++ b/mmc.c
@@ -36,9 +36,9 @@ struct Command {
                                   if >=3D 0, number of arguments,
                                   if < 0, _minimum_ number of argument=
s */
        char    *verb;          /* verb */
-       char    *help;          /* help lines; from the 2nd line onward=
 they
+       char    *help;          /* help lines; from the 2nd line onward=
 they
                                    are automatically indented */
-        char    *adv_help;      /* advanced help message; from the 2nd=
 line
+        char    *adv_help;      /* advanced help message; from the 2nd=
 line
                                    onward they are automatically inden=
ted */

        /* the following fields are run-time filled by the program */ @=
@ -110,6 +110,11 @@ static struct Command commands[] =3D {
                "Send Sanitize command to the <device>.\nThis will dele=
te the unmapped memory region of the device.",
          NULL
        },
+       { do_emmc50_ffu, -2,
+       "emmc50 ffu", "<image path> <device>\n"
+         "run eMMC 5.0 Field firmware update.\n.",
+         NULL
+       },
        { 0, 0, 0, 0 }
 };

@@ -362,7 +367,7 @@ static int parse_args(int argc, char **argv,
                        matchcmd->verb, matchcmd->nargs);
                        return -2;
        }
-
+
         if (prepare_args( nargs_, args_, prgname, matchcmd )){
                 fprintf(stderr, "ERROR: not enough memory\\n");
                return -20;
diff --git a/mmc.h b/mmc.h
index 9871d62..3be6db0 100644
--- a/mmc.h
+++ b/mmc.h
@@ -80,6 +80,14 @@
 #define BKOPS_ENABLE   (1<<0)

 /*
+ * sector size
+*/
+#define CARD_BLOCK_SIZE        512
+
+#define FFU_DWONLOAD_OP        302
+#define FFU_INSTALL_OP 303
+
+/*
  * EXT_CSD field definitions
  */
 #define EXT_CSD_HPI_SUPP               (1<<0)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b8afa74..24c4a6b 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1163,3 +1163,112 @@ int do_sanitize(int nargs, char **argv)

 }

+static int ffu_download_image(int fw_fd, int mmc_fd) {
+       int ret =3D 0;
+       struct mmc_ioc_cmd mmc_ioc_cmd;
+       char data_buff[MMC_IOC_MAX_BYTES];
+       int file_size;
+       int size;
+       int data_length;
+
+       memset(data_buff, 0, sizeof(data_buff));
+       /* get file size */
+       file_size =3D lseek(fw_fd, 0, SEEK_END);
+       if (file_size < 0) {
+               ret =3D  -1;
+               perror("seek file error \n");
+               goto exit;
+       }
+
+       lseek(fw_fd, 0, SEEK_SET);
+       do {
+               size =3D (file_size > MMC_IOC_MAX_BYTES) ?
+                               MMC_IOC_MAX_BYTES : file_size;
+               /* Read FW data from file */
+               data_length =3D read(fw_fd, data_buff, size);
+               if (data_length =3D=3D -1) {
+                       ret =3D -1;
+                       goto exit;
+               }
+               /* prepare and send ioctl */
+               memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
+               mmc_ioc_cmd.opcode =3D  FFU_DWONLOAD_OP;
+               mmc_ioc_cmd.blksz =3D CARD_BLOCK_SIZE;
+               mmc_ioc_cmd.blocks =3D data_length / mmc_ioc_cmd.blksz;
+               mmc_ioc_cmd.arg =3D  0;
+               mmc_ioc_cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC=
_CMD_ADTC;
+               mmc_ioc_cmd.write_flag =3D 1;
+               mmc_ioc_cmd_set_data(mmc_ioc_cmd, data_buff);
+               ret =3D ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
+               if (ret) {
+                       perror("ioctl FW download");
+                       goto exit;
+               }
+
+               file_size =3D file_size - size;
+               printf("firmware file loading, remaining:   %d\n", file=
_size);
+       } while (file_size > 0);
+
+exit:
+
+       return ret;
+}
+
+static int ffu_install(int mmc_fd)
+{
+       int ret;
+       struct mmc_ioc_cmd mmc_ioc_cmd;
+
+       memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
+       mmc_ioc_cmd.opcode =3D FFU_INSTALL_OP;
+       mmc_ioc_cmd.blksz =3D CARD_BLOCK_SIZE;
+       mmc_ioc_cmd.blocks =3D 0;
+       mmc_ioc_cmd.arg =3D  0;
+       mmc_ioc_cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADT=
C;
+       mmc_ioc_cmd.write_flag =3D 0;
+       ret =3D ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
+       if (ret)
+               perror("ioctl install");
+
+       printf("ffu_install ret %d \n", ret);
+       return ret;
+}
+
+int do_emmc50_ffu(int nargs, char **argv) {
+       int fd, fw_fd, ret;
+       char *device;
+
+       CHECK(nargs !=3D 3, "Usage: ffu <image path> </path/to/mmcblkX>=
 \n",
+                               exit(1));
+
+       device =3D argv[2];
+       fd =3D open(device, O_RDWR);
+       if (fd < 0) {
+               perror("open");
+               exit(1);
+       }
+
+       /* open eMMC5.0 firmware image file */
+       fw_fd =3D open(argv[1], O_RDONLY);
+       if (fw_fd < 0) {
+               perror("open eMMC5.0 firmware file");
+               ret =3D -1;
+               goto exit;
+       }
+
+       ret =3D ffu_download_image(fw_fd, fd);
+       if (ret)
+               goto exit;
+
+       ret =3D ffu_install(fd);
+       if (ret)
+               goto exit;
+
+exit:
+       close(fd);
+       close(fw_fd);
+
+       return ret;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index f06cc10..77a6cb8 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -28,3 +28,5 @@ int do_sanitize(int nargs, char **argv);  int do_stat=
us_get(int nargs, char **argv);  int do_enh_area_set(int nargs, char **=
argv);  int do_write_reliability_set(int nargs, char **argv);
+int do_emmc50_ffu(int nargs, char **argv);
+
--
1.7.5.4


Avi=A0Shchislowski=A0|=A0Staff Software Engineer,=A0MCS Embedded=A0=A0|=
 SanDisk | +972.09.763-2666| www.sandisk.com



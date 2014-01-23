From: Grant Grundler <grundler@chromium.org>
Subject: [PATCH v2] mmc-utils: add eMMC 5.0 FFU support
Date: Thu, 23 Jan 2014 11:44:24 -0800
Message-ID: <1390506264-17107-1-git-send-email-grundler@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38168 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbaAWToo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jan 2014 14:44:44 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so2281011pad.39
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jan 2014 11:44:43 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>

Field Firmware Update feature is new for 5.0 spec.
Code written per JESD84-B50.pdf spec available from:
    http://www.jedec.org/standards-documents/technology-focus-areas/flash-memory-ssds-ufs-emmc/e-mmc

Change-Id: I0a22e9862876421630f53ac27fc0a161a9c70131
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
V2:
Fix compiler borkage in use of strncmp().
Use '\0' instead of 0 in char assignment.

V1:
This patch needs to be reviewed and tested by _ANY_ eMMC 5.0 HW vendor.

If you represent an eMMC 5.0 HW vendor and expect your part will be used
in a ChromeOS device, make sure FFU works with mmc-utils.

mmc-utils is now shipping with ChromeOS (starting with R34 or R35 release):
    https://chromium-review.googlesource.com/#/c/182716/

Please also make sure your FFU implementation works reliably and
is robust (e.g. sign your binaries and check the signature).

Two general trends in eMMC are driving the requirement for FFU support:
1) longer support life time for devices (Chromebooks are > 5 years).
I.e. odds of requiring a bug fix later is higher.
I believe this trend applies to tablets and phones as well.

2) eMMC 5.0 devices are more complex --> testing will not find all the bugs.
e.g. TLC vs MLC vs SLC error handling _and_ implementations which support
a write cache, reliable write, and the plethora of other eMMC features.
More code means more interactions and more bugs. Fact of (SW) Life.
It's no longer a question of whether code will have bugs. It's a question
of how severe and can they be mitigated (FFU is just one way to mitigate).

I've written similar FFU patches for three different eMMC 4.5 products.
Some of those will get published and will conflict with this patch.
I'm happy resolve those conflicts and repost.
Please just make sure I'm CC'd.

I'm also willing to write additional mmc-utils FFU patches for any other
eMMC 4.5 vendor.  Please send technical details to my google.com email
and promise to test and publish the result.

Thanks for reading this far! :)


 Makefile         |   4 +-
 mmc.c            |  31 ++++++--
 mmc.h            |  29 ++++++-
 mmc_cmds-emmc5.c | 129 +++++++++++++++++++++++++++++++
 mmc_cmds.c       | 232 ++++++++++++++++++++++++++++++++++++++++++++-----------
 mmc_cmds.h       |   6 ++
 6 files changed, 378 insertions(+), 53 deletions(-)
 create mode 100644 mmc_cmds-emmc5.c

diff --git a/Makefile b/Makefile
index 91cfc35..1cdd97f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 CC ?= gcc
 AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
 CFLAGS ?= -g -O2
-objects = mmc.o mmc_cmds.o
+objects = mmc.o mmc_cmds.o mmc_cmds-emmc5.o
 
 CHECKFLAGS = -Wall -Werror -Wuninitialized -Wundef
 
@@ -44,7 +44,7 @@ clean:
 	$(MAKE) -C man clean
 
 install: $(progs) install-man
-	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
+	$(INSTALL) -m 755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(progs) $(DESTDIR)$(bindir)
 
 .PHONY: all clean install manpages install-man
diff --git a/mmc.c b/mmc.c
index 926e92f..01a5074 100644
--- a/mmc.c
+++ b/mmc.c
@@ -20,7 +20,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
+#include <linux/types.h>
 
+#include "mmc.h"
 #include "mmc_cmds.h"
 
 #define MMC_VERSION	"0.1"
@@ -37,9 +40,9 @@ struct Command {
 				   if < 0, _minimum_ number of arguments */
 	char	*verb;		/* verb */
 	char	*help;		/* help lines; from the 2nd line onward they 
-                                   are automatically indented */
-        char    *adv_help;      /* advanced help message; from the 2nd line 
-                                   onward they are automatically indented */
+				   are automatically indented */
+	char	*adv_help;	/* advanced help message; from the 2nd line
+				   onward they are automatically indented */
 
 	/* the following fields are run-time filled by the program */
 	char	**cmds;		/* array of subcommands */
@@ -110,9 +113,24 @@ static struct Command commands[] = {
 		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device.",
 	  NULL
 	},
+	{ do_firmware_update, -2,
+	  "firmware upload", "<firmware_file> " "<device>\n"
+		"Upload/Update firmware on <device> using <firmware_file>.\n",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
+const char *manfid_lookup[0x100] = {
+	[MANFID_PANASONIC] = "Panasonic",
+	[MANFID_KINGSTON] = "Kingston",
+	[MANFID_SANDISK] = "Sandisk",
+	[MANFID_SAMSUNG] = "Samsung",
+	[MANFID_TOSHIBA] = "Toshiba",
+	[MANFID_SANDISK_SEM] = "Sandisk_SEM",
+	[MANFID_KINGSTON_MMC] = "Kingston_MMC"
+};
+
 static char *get_prgname(char *programname)
 {
 	char	*np;
@@ -363,11 +381,10 @@ static int parse_args(int argc, char **argv,
 			return -2;
 	}
 	
-        if (prepare_args( nargs_, args_, prgname, matchcmd )){
-                fprintf(stderr, "ERROR: not enough memory\\n");
+	if (prepare_args( nargs_, args_, prgname, matchcmd )){
+		fprintf(stderr, "ERROR: not enough memory\\n");
 		return -20;
-        }
-
+	}
 
 	return 1;
 }
diff --git a/mmc.h b/mmc.h
index 9871d62..61c0303 100644
--- a/mmc.h
+++ b/mmc.h
@@ -24,12 +24,25 @@
 #define MMC_BLOCK_MAJOR			179
 
 /* From kernel linux/mmc/mmc.h */
+#define MMC_GO_IDLE_STATE	0	/* bc                               */
+#define MMC_ALL_SEND_CID	2	/* bcr				R2  */
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
+#define MMC_SELECT_CARD		7	/* ac	[31:16] RCA		R1  */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
-#define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
+#define MMC_SEND_CID		10	/* ac   [31:16] RCA		R2  */
+#define MMC_STOP_TRANSMISSION	12	/* ac				R1b */
+#define MMC_SEND_STATUS		13	/* ac   [31:16] RCA		R1  */
+#define MMC_READ_SINGLE_BLOCK	17	/* adtc [31:0] data addr	R1  */
+#define MMC_READ_MULTIPLE_BLOCK	18	/* adtc [31:0] data addr	R1  */
+#define MMC_WRITE_BLOCK		24	/* adtc [31:0] data addr	R1  */
+#define MMC_WRITE_MULTIPLE_BLOCK 25	/* adtc				R1  */
+
+#define MMC_GEN_CMD		56	/* adtc [0] RD/WR		R1  */
+
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
 
+
 /*
  * EXT_CSD fields
  */
@@ -125,3 +138,17 @@
 
 #define MMC_RSP_R1	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 #define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
+
+
+/* Manufacturer IDs as shown by /sys/block/mmcblk0/device/manfid */
+#define MANFID_PANASONIC	0x000001
+#define MANFID_KINGSTON		0x000002
+#define MANFID_SANDISK		0x000003
+#define MANFID_SAMSUNG		0x000015
+#define MANFID_TOSHIBA		0x00001d
+#define MANFID_SANDISK_SEM	0x000045	/* seen with "SEM16G" */
+#define MANFID_KINGSTON_MMC	0x000070	/* Seen on embedded device */
+
+#if 0
+const char *manfid_lookup[];
+#endif
diff --git a/mmc_cmds-emmc5.c b/mmc_cmds-emmc5.c
new file mode 100644
index 0000000..43fe3f2
--- /dev/null
+++ b/mmc_cmds-emmc5.c
@@ -0,0 +1,129 @@
+/*
+ * eMMC 5.0+ Specific tools
+ *
+ * Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>	/* for memset() */
+#include <errno.h>
+#include <linux/types.h>
+#include <sys/ioctl.h>
+#include <dirent.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <limits.h>
+#include <ctype.h>
+
+#include "mmc.h"
+#include "mmc_cmds.h"
+
+
+
+int do_emmc5_fw_update(int fd, __u8 *cid, __u8 *ext_csd,
+				char *emmc_fw, size_t fwsize)
+{
+	struct mmc_ioc_cmd idata;
+	int retcode = 0;
+	int ret;
+
+	/* 2) Host send CMD6 to set MODE_CONFIG[30] = 0x01 */
+	memset(&idata, 0, sizeof(idata));
+	idata.opcode = MMC_SWITCH;
+        idata.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			(30 << 16) |	/* index */
+			(1 << 8) |	/* value */
+			EXT_CSD_CMD_SET_NORMAL;
+	idata.flags = MMC_RSP_R1B | MMC_CMD_AC;;
+	ret = ioctl(fd, MMC_IOC_CMD, &idata);
+	if (ret) {
+		retcode = ret;
+		printf("ioctl: MMC_SWITCH (eMMC 5.0 FW Update) %m\n");
+		goto abort_update;
+	}
+
+	/* 2) send CMD25 0x0000FFFF */
+	memset(&idata, 0, sizeof(idata));
+	idata.write_flag = 1;
+	idata.data_ptr = (__u64) ((unsigned long) emmc_fw); /* Write this FW */
+	idata.opcode = MMC_WRITE_MULTIPLE_BLOCK;
+	idata.arg = 0x0000FFFF;
+	idata.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;;
+	ret = ioctl(fd, MMC_IOC_CMD, &idata);
+	if (ret) {
+		retcode = ret;
+		printf("ioctl:MMC_WRITE_MULTIPLE_BLOCK (eMMC 5.0 FW Update) %m\n");
+		goto abort_update;
+	}
+
+	/* 3) check FFU_STATUS[26] */
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		retcode = ret;
+		fprintf(stderr, "read_extcsd error (%d): %m\n", ret);
+		goto abort_update;
+	}
+
+	switch(ext_csd[26]) {
+	case 0:  break;
+	case 0x10:
+		fprintf(stderr, "eMMC 5.0 FFU had general error and failed (EIO).\n");
+		retcode = -EIO;
+		break;
+	case 0x11:
+		fprintf(stderr, "eMMC 5.0 FFU did not complete (EAGAIN).\n");
+		retcode = -EAGAIN;
+		break;
+	case 0x12:
+		fprintf(stderr, "eMMC 5.0 FFU download failed: checksum "
+			"mismatch or was interrupted (EINTR).\n");
+		retcode = -EINTR;
+		break;
+	default:
+		fprintf(stderr, "eMMC 5.0 FFU unknown error: %x\n", ext_csd[26]);
+		retcode = -EIO;
+	}
+
+	/* 4) check NUMBER_OF_FW_SECTORS_CORRECTLY_PROGRAMMED[305-302] */
+	ret = ext_csd[302] << 0 | (ext_csd[303] << 8) |
+		(ext_csd[304] << 16) | (ext_csd[305] << 24);
+
+	/* convert that gibberish to bytes */
+	ret *= 512;
+	if (ext_csd[61] == 1)
+		ret *= 8;	/* 4K sectors */
+
+	if (ret != fwsize) {
+		fprintf(stderr, "eMMC 5.0 FFU Failed? (fwsize: %d,"
+			" PROGRAMMED_SECTORS: %d)\n", fwsize, ret);
+	}
+
+abort_update:
+	/* 4) send CMD0
+	 * This should reset the device and force use of the new firmware.
+	 */
+	memset(&idata, 0, sizeof(idata));
+	idata.opcode = MMC_GO_IDLE_STATE;
+	ret = ioctl(fd, MMC_IOC_CMD, &idata);
+	if (ret) {
+		retcode = ret;
+		perror("ioctl:MMC_GO_IDLE_STATE (eMMC 5.0 FFU)");
+	}
+
+	return retcode;
+}
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b8afa74..afbed77 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1,3 +1,4 @@
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public
@@ -17,9 +18,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/ioctl.h>
-#include <sys/types.h>
+#include <errno.h>
 #include <dirent.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -30,23 +32,27 @@
 #include "mmc.h"
 #include "mmc_cmds.h"
 
+#define EXT_CSD_SIZE	512
+#define CID_SIZE 16
+
+
 int read_extcsd(int fd, __u8 *ext_csd)
 {
 	int ret = 0;
 	struct mmc_ioc_cmd idata;
 	memset(&idata, 0, sizeof(idata));
-	memset(ext_csd, 0, sizeof(__u8) * 512);
+	memset(ext_csd, 0, sizeof(__u8) * EXT_CSD_SIZE);
 	idata.write_flag = 0;
 	idata.opcode = MMC_SEND_EXT_CSD;
 	idata.arg = 0;
 	idata.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-	idata.blksz = 512;
+	idata.blksz = EXT_CSD_SIZE;
 	idata.blocks = 1;
 	mmc_ioc_cmd_set_data(idata, ext_csd);
 
 	ret = ioctl(fd, MMC_IOC_CMD, &idata);
 	if (ret)
-		perror("ioctl");
+		perror("ioctl SEND_EXT_CSD");
 
 	return ret;
 }
@@ -67,7 +73,30 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
 
 	ret = ioctl(fd, MMC_IOC_CMD, &idata);
 	if (ret)
-		perror("ioctl");
+		perror("ioctl Write EXT CSD");
+
+	return ret;
+}
+
+int read_cid(int fd, __u8 *cid)
+{
+	int ret = 0;
+	struct mmc_ioc_cmd idata;
+
+	memset(&idata, 0, sizeof(idata));
+	memset(cid, 0, sizeof(__u8) * CID_SIZE);
+
+	idata.write_flag = 0;
+	idata.opcode = MMC_SEND_CID;
+	idata.arg    = 0;
+	idata.flags  = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	idata.blksz  = CID_SIZE;
+	idata.blocks = 1;
+	mmc_ioc_cmd_set_data(idata, cid);
+
+	ret = ioctl(fd, MMC_IOC_CMD, &idata);
+	if (ret)
+		perror("ioctl SEND_CID");
 
 	return ret;
 }
@@ -103,17 +132,11 @@ void print_writeprotect_status(__u8 *ext_csd)
 
 		reg = ext_csd[EXT_CSD_BOOT_WP];
 		printf("Boot Area Write protection [BOOT_WP]: 0x%02x\n", reg);
-		printf(" Power ro locking: ");
-		if (reg & EXT_CSD_BOOT_WP_B_PWR_WP_DIS)
-			printf("not possible\n");
-		else
-			printf("possible\n");
+		printf(" Power ro locking: %spossible\n",
+			(reg & EXT_CSD_BOOT_WP_B_PWR_WP_DIS) ? "not " : "");
 
-		printf(" Permanent ro locking: ");
-		if (reg & EXT_CSD_BOOT_WP_B_PERM_WP_DIS)
-			printf("not possible\n");
-		else
-			printf("possible\n");
+		printf(" Permanent ro locking: %spossible\n",
+			(reg & EXT_CSD_BOOT_WP_B_PERM_WP_DIS) ? "not " : "");
 
 		printf(" ro lock status: ");
 		if (reg & EXT_CSD_BOOT_WP_B_PWR_WP_EN)
@@ -127,7 +150,7 @@ void print_writeprotect_status(__u8 *ext_csd)
 
 int do_writeprotect_get(int nargs, char **argv)
 {
-	__u8 ext_csd[512];
+	__u8 ext_csd[EXT_CSD_SIZE];
 	int fd, ret;
 	char *device;
 
@@ -155,7 +178,7 @@ int do_writeprotect_get(int nargs, char **argv)
 
 int do_writeprotect_set(int nargs, char **argv)
 {
-	__u8 ext_csd[512], value;
+	__u8 ext_csd[EXT_CSD_SIZE], value;
 	int fd, ret;
 	char *device;
 
@@ -191,7 +214,7 @@ int do_writeprotect_set(int nargs, char **argv)
 
 int do_disable_512B_emulation(int nargs, char **argv)
 {
-	__u8 ext_csd[512], native_sector_size, data_sector_size, wr_rel_param;
+	__u8 ext_csd[EXT_CSD_SIZE], native_sector_size, data_sector_size, wr_rel_param;
 	int fd, ret;
 	char *device;
 
@@ -301,7 +324,7 @@ int do_write_boot_en(int nargs, char **argv)
 
 int do_hwreset(int value, int nargs, char **argv)
 {
-	__u8 ext_csd[512];
+	__u8 ext_csd[EXT_CSD_SIZE];
 	int fd, ret;
 	char *device;
 
@@ -360,7 +383,7 @@ int do_hwreset_dis(int nargs, char **argv)
 
 int do_write_bkops_en(int nargs, char **argv)
 {
-	__u8 ext_csd[512], value = 0;
+	__u8 ext_csd[EXT_CSD_SIZE], value = 0;
 	int fd, ret;
 	char *device;
 
@@ -497,7 +520,7 @@ int set_partitioning_setting_completed(int dry_run, const char * const device,
 int do_enh_area_set(int nargs, char **argv)
 {
 	__u8 value;
-	__u8 ext_csd[512];
+	__u8 ext_csd[EXT_CSD_SIZE];
 	int fd, ret;
 	char *device;
 	int dry_run = 1;
@@ -635,7 +658,7 @@ int do_enh_area_set(int nargs, char **argv)
 int do_write_reliability_set(int nargs, char **argv)
 {
 	__u8 value;
-	__u8 ext_csd[512];
+	__u8 ext_csd[EXT_CSD_SIZE];
 	int fd, ret;
 
 	int dry_run = 1;
@@ -696,7 +719,7 @@ int do_write_reliability_set(int nargs, char **argv)
 
 int do_read_extcsd(int nargs, char **argv)
 {
-	__u8 ext_csd[512], ext_csd_rev, reg;
+	__u8 ext_csd[EXT_CSD_SIZE], ext_csd_rev, reg;
 	__u32 regl;
 	int fd, ret;
 	char *device;
@@ -722,24 +745,13 @@ int do_read_extcsd(int nargs, char **argv)
 	ext_csd_rev = ext_csd[192];
 
 	switch (ext_csd_rev) {
-	case 6:
-		str = "4.5";
-		break;
-	case 5:
-		str = "4.41";
-		break;
-	case 3:
-		str = "4.3";
-		break;
-	case 2:
-		str = "4.2";
-		break;
-	case 1:
-		str = "4.1";
-		break;
-	case 0:
-		str = "4.0";
-		break;
+	case 7: str = "5.0"; break;
+	case 6: str = "4.5"; break;
+	case 5: str = "4.41"; break;
+	case 3: str = "4.3"; break;
+	case 2: str = "4.2"; break;
+	case 1: str = "4.1"; break;
+	case 0: str = "4.0"; break;
 	default:
 		goto out_free;
 	}
@@ -1160,6 +1172,140 @@ int do_sanitize(int nargs, char **argv)
 	}
 
 	return ret;
-
 }
 
+int do_firmware_update(int nargs, char **argv)
+{
+	char *emmc_fw;
+	char *device;
+	char *fwfilename;
+	struct stat fwfilestat;
+	size_t fwsize;
+	int ret = 0;
+	int devfd,fwfd;
+	__u8 ext_csd[EXT_CSD_SIZE];
+	__u8 cid[CID_SIZE];
+	__u8 ext_csd_rev;
+
+
+	CHECK(nargs != 4, "Usage: mmc firmware update"
+			" --I_want_to_destroy_my_drive"
+			" </path/to/mmcblkX> </path/to/FW.bin>\n",
+			  exit(1));
+
+
+	/* Lesson from hdparm: user must be aware of the risks
+	 * Key here is the additional command line flag be UNDOCUMENTED.
+	 * User _must_ read and KNOW this is risky at runtime.
+	 */
+	if (strncmp(argv[4], "--I_want_to_destroy_my_drive", 28)) {
+		fprintf(stderr,"ERROR: Please specify --I_want_to_destroy_my_drive"
+		" as first parameter to firmware update.\n");
+
+		exit(1);
+	}
+
+	emmc_fw = malloc(MMC_IOC_MAX_BYTES);
+	if (!emmc_fw)
+		return -ENOMEM;
+
+	device = argv[5];
+
+	devfd = open(device, O_RDWR);
+	if (devfd < 0) {
+		fprintf(stderr,"ERROR: open %s: %m\n", device); /* %m = errno */
+		goto out_free;
+	}
+
+	/* 1) read device version and attributes */
+	ret = read_extcsd(devfd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "ERROR: Read EXT_CSD from %s: %m\n", device);
+		goto out_dev;
+	}
+
+	ext_csd_rev = ext_csd[192];
+
+	if (ext_csd_rev < 7) {
+		fprintf(stderr, "ERROR: Can not update firmware"
+			": %s is pre-emmc 5.0 vintage\n", device);
+		goto out_dev;
+	}
+
+	printf("%s: FW is currently %8s (0x%02x%02x%02x%02x%02x%02x%02x%02x)\n",
+		device, &(ext_csd[254]),
+		ext_csd[254], ext_csd[255], ext_csd[256], ext_csd[257],
+		ext_csd[258], ext_csd[259], ext_csd[260], ext_csd[261]
+		);
+
+	/* 2) confirm SUPPORTED_MODES has FFU bit set */
+	if (!(ext_csd[493] & 1)) {
+		fprintf(stderr, "ERROR: %s is eMMC 5.0 device"
+			"but does not support FFU.\n", device);
+		goto out_dev;
+	}
+
+	/* 3) confirm FW updated is NOT disabled on this device */
+	if (ext_csd[169] & 1) {
+		fprintf(stderr, "ERROR: %s is eMMC 5.0 device"
+			"but FFU is disabled.\n", device);
+		goto out_dev;
+	}
+
+	/* 4) read the device manfid */
+	ret = read_cid(devfd, cid);
+	if (ret) {
+		fprintf(stderr, "ERROR: Read EXT_CSD from %s: %m\n", device);
+		goto out_dev;
+	}
+
+	/* 5) Fetch the FW image */
+	fwfilename = argv[2];
+
+	fwfd = open(fwfilename, O_RDONLY);
+	if (fwfd < 0) {
+		/* %m = errno */
+		fprintf(stderr,"ERROR: open %s: %m", fwfilename);
+		goto out_dev;
+	}
+
+	ret = fstat(fwfd, &fwfilestat);
+	if (ret) {
+		/* %m = errno */
+		fprintf(stderr,"ERROR: fstat %s: %m", fwfilename);
+		goto out_fw;
+	}
+
+	fwsize = fwfilestat.st_size;
+	if (fwsize > MMC_IOC_MAX_BYTES) {
+		fprintf(stderr,"ERROR: %s is > %ld bytes long (max allowed)\n",
+			fwfilename, MMC_IOC_MAX_BYTES);
+		goto out_fw;
+	}
+
+	ret = read(fwfd, emmc_fw, fwsize);
+	if (ret < fwsize) {
+		fprintf(stderr,"ERROR: did not read all %d bytes of %s"
+				"(%d bytes long)\n",
+			fwsize, fwfilename, ret);
+		goto out_fw;
+	}
+
+	do_emmc5_fw_update(devfd, cid, ext_csd, emmc_fw, fwsize);
+
+	cid[13] = '\0';	/* make sure string is NULL terminated */
+
+	printf("%s: FW updated to %8s (0x%2x%2x%2x%2x%2x%2x%2x%2x)\n",
+		device, &(ext_csd[254]),
+		ext_csd[254], ext_csd[255], ext_csd[256], ext_csd[257],
+		ext_csd[258], ext_csd[259], ext_csd[260], ext_csd[261]
+		);
+
+out_fw:
+	close(fwfd);
+out_dev:
+	close(devfd);
+out_free:
+	free(emmc_fw);
+	return ret;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index f06cc10..549b851 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -28,3 +28,9 @@ int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
 int do_write_reliability_set(int nargs, char **argv);
+int do_firmware_update(int nargs, char **argv);
+
+int read_extcsd(int fd, __u8 *ext_csd);
+int write_extcsd_value(int fd, __u8 index, __u8 value);
+
+int do_emmc5_fw_update(int devfd, __u8 *cid, __u8 *ext_csd, char *emmc_fw, size_t fwsize);
-- 
1.8.1.5


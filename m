From: Peter Turczak <peter@turczak.de>
Subject: [PATCH] mmc-utils: Add support for locking/unlocking SD cards by password.
Date: Mon, 1 Jul 2013 16:01:21 +0200
Message-ID: <8BE392D8-E755-4F24-A2FA-251A396988AF@turczak.de>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from netconsequence.de ([85.214.40.104]:46813 "EHLO
	mx.netconsequence.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab3GAOB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jul 2013 10:01:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Add commands for locking and unlocking SD cards by password. This is to be used
in conjunction with a kernel that enumerates locked sd cards and provides an ioctl
for rereading the card after unlocking.
 
Signed-off-by: Peter Turczak <peter@turczak.de>
---
mmc.c      |   24 +++++++++-
mmc.h      |   12 +++++
mmc_cmds.c |  152 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
mmc_cmds.h |    4 ++
4 files changed, 189 insertions(+), 3 deletions(-)

diff --git a/mmc.c b/mmc.c
index 725b842..2f797ea 100644
--- a/mmc.c
+++ b/mmc.c
@@ -36,9 +36,9 @@ struct Command {
				   if >= 0, number of arguments,
				   if < 0, _minimum_ number of arguments */
	char	*verb;		/* verb */
-	char	*help;		/* help lines; from the 2nd line onward they 
+	char	*help;		/* help lines; from the 2nd line onward they
                                   are automatically indented */
-        char    *adv_help;      /* advanced help message; from the 2nd line 
+	char    *adv_help;      /* advanced help message; from the 2nd line
                                   onward they are automatically indented */

	/* the following fields are run-time filled by the program */
@@ -100,6 +100,26 @@ static struct Command commands[] = {
		"Permanently disable the eMMC H/W Reset feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
	  NULL
	},
+	{ do_sd_password_set, -1,
+	  "password set", "<password> <device>\n"
+		"Set password for unlocking the SD card, no not lock until next power up.",
+	  NULL
+	},
+	{ do_sd_password_lock, -1,
+	  "password lock", "<password> <device>\n"
+		"Set password for unlocking the SD card, and lock now.",
+	  NULL
+	},
+	{ do_sd_password_unlock, -1,
+	  "password unlock", "<password> <device>\n"
+		"Unlock the SD card until next power cycling.",
+	  NULL
+	},
+	{ do_sd_password_delete, -1,
+	  "password delete", "<password> <device>\n"
+		"Remove set password from SD.",
+	  NULL
+	},
	{ do_sanitize, -1,
	  "sanitize", "<device>\n"
		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device.",
diff --git a/mmc.h b/mmc.h
index ad07b44..c578ba0 100644
--- a/mmc.h
+++ b/mmc.h
@@ -24,11 +24,15 @@
#define MMC_BLOCK_MAJOR			179

/* From kernel linux/mmc/mmc.h */
+#define MMC_GO_IDLE_STATE	0   /* bc                          */
+#define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
#define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
#define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
#define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
#define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
#define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
+#define MMC_LOCK_UNLOCK		42   /* adtc                    R1b */
+#define MMC_SET_BLOCKLEN	16   /* ac   [31:0] block len   R1  */

/*
 * EXT_CSD fields
@@ -112,6 +116,9 @@

#define MMC_CMD_AC	(0 << 5)
#define MMC_CMD_ADTC	(1 << 5)
+#define MMC_CMD_BC      (2 << 5)
+#define MMC_CMD_BCR     (3 << 5)
+

#define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
#define MMC_RSP_SPI_BUSY (1 << 10)		/* card may send busy */
@@ -121,3 +128,8 @@

#define MMC_RSP_R1	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
#define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
+
+#define MMC_LOCK_UNLOCK_ARG_ERASE	(1 << 3)
+#define MMC_LOCK_UNLOCK_ARG_LOCK	(1 << 2)
+#define MMC_LOCK_UNLOCK_ARG_CLR		(1 << 1)
+#define MMC_LOCK_UNLOCK_ARG_SET		(1 << 0)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index ba4f9cf..f455860 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -26,6 +26,7 @@
#include <libgen.h>
#include <limits.h>
#include <ctype.h>
+#include <assert.h>

#include "mmc.h"
#include "mmc_cmds.h"
@@ -72,6 +73,38 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
	return ret;
}

+int get_rca(int fd)
+{
+char orig_filename[1024];
+char temp[1024];
+char *base;
+char *pos;
+
+	memset(orig_filename, 0, sizeof(orig_filename));
+	memset(temp, 0, sizeof(temp));
+
+	/* Get the block device name of the mmcblock device from the
+	 * file descriptor
+	 */
+	snprintf(temp, sizeof(temp)-1, "/proc/self/fd/%d", fd);
+	if (readlink(temp, orig_filename, sizeof(orig_filename)-1) < 0)
+		return -1;
+
+	/* Fetch the bus device from sysfs */
+	base = basename(orig_filename);
+	snprintf(temp, sizeof(temp)-1, "/sys/class/block/%s/device", base);
+	if (readlink(temp, orig_filename, sizeof(orig_filename)) < 0)
+		return -1;
+
+	/* Extract number from given path, assumed to be something
+	 * like /sys/bus/mmc/mmc0:e624 , where e624 specifies the RCA
+	 * value
+	 */
+	assert(pos = strrchr(orig_filename, ':'));
+	pos++;
+	return strtol(pos, NULL, 16);
+}
+
int send_status(int fd, __u32 *response)
{
	int ret = 0;
@@ -79,7 +112,7 @@ int send_status(int fd, __u32 *response)

	memset(&idata, 0, sizeof(idata));
	idata.opcode = MMC_SEND_STATUS;
-	idata.arg = (1 << 16);
+	idata.arg = (get_rca(fd) << 16);
	idata.flags = MMC_RSP_R1 | MMC_CMD_AC;

	ret = ioctl(fd, MMC_IOC_CMD, &idata);
@@ -1032,6 +1065,123 @@ out_free:
	return ret;
}

+int sd_password_command(int fd, int arg, char *pass)
+{
+	int ret = 0;
+	int len;
+	int blocklen;
+	struct mmc_ioc_cmd idata;
+	__u8 data[512];
+	__u32 status;
+
+	/* Send password request */
+	memset(&data, 0, sizeof(data));
+	len = strlen(pass);
+	if (len > 16)
+		len = 16;
+	data[0] = arg;
+	data[1] = len;
+	memcpy(&data[2], pass, len);
+
+	/* Set block length */
+	blocklen = 18;
+
+	memset(&idata, 0, sizeof(idata));
+	idata.write_flag = 0;
+	idata.opcode = MMC_SET_BLOCKLEN;
+	idata.flags =  MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_BCR;
+	idata.arg = blocklen;
+	idata.blksz = 0;
+	idata.blocks = 0;
+	idata.cmd_timeout_ms = 500;
+
+	ret = ioctl(fd, MMC_IOC_CMD, &idata);
+	if (ret) {
+		perror("ioctl");
+		return ret;
+		}
+
+	memset(&idata, 0, sizeof(idata));
+	idata.write_flag = 1;
+	idata.opcode = MMC_LOCK_UNLOCK;
+	idata.flags =  MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	idata.arg = 0;
+	idata.blocks = 1;
+	idata.blksz = blocklen;
+	idata.cmd_timeout_ms = 500;
+	idata.data_ptr = (__u32)data;
+	ret = ioctl(fd, MMC_IOC_CMD, &idata);
+	if (ret) {
+		perror("ioctl");
+		return ret;
+		}
+
+	ret = send_status(fd, &status);
+	if (ret)
+		return ret;
+	/* Mask out status bits and return them.
+	 * BIT24: CARD_IS_LOCKED
+	 * BIT25: LOCK_UNLOCK_FAILED
+	 */
+	if (ret & (1 << 24))
+		return ret >> 24;
+
+	printf("Unlocking succeeded!\n");
+
+	if (arg == 0) {
+		ret = ioctl(fd, MMC_IOC_RESCAN, NULL);
+		if (ret) {
+			perror("ioctl");
+			return ret;
+			}
+	}
+	return ret;
+}
+
+int do_sd_password(int mmc_cmd, int nargs, char **argv)
+{
+	int fd;
+	char *device;
+	char *pass;
+	int ret;
+
+	CHECK(nargs != 3,
+		"Usage: mmc password set|lock|unlock|delete"
+			  " password </path/to/mmcblkX>\n", exit(1));
+
+	pass = argv[1];
+	device = argv[2];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = (sd_password_command(fd, mmc_cmd, pass));
+	return ret;
+}
+
+int do_sd_password_set(int nargs, char **argv)
+{
+	return do_sd_password(MMC_LOCK_UNLOCK_ARG_SET, nargs, argv);
+}
+
+int do_sd_password_lock(int nargs, char **argv)
+{
+	return do_sd_password(MMC_LOCK_UNLOCK_ARG_LOCK, nargs, argv);
+}
+
+int do_sd_password_unlock(int nargs, char **argv)
+{
+	return do_sd_password(0, nargs, argv);
+}
+
+int do_sd_password_delete(int nargs, char **argv)
+{
+	return do_sd_password(MMC_LOCK_UNLOCK_ARG_CLR, nargs, argv);
+}
+
int do_sanitize(int nargs, char **argv)
{
	int fd, ret;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index fa347f5..adff8b9 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -24,6 +24,10 @@ int do_write_boot_en(int nargs, char **argv);
int do_write_bkops_en(int nargs, char **argv);
int do_hwreset_en(int nargs, char **argv);
int do_hwreset_dis(int nargs, char **argv);
+int do_sd_password_delete(int nargs, char **argv);
+int do_sd_password_lock(int nargs, char **argv);
+int do_sd_password_set(int nargs, char **argv);
+int do_sd_password_unlock(int nargs, char **argv);
int do_sanitize(int nargs, char **argv);
int do_status_get(int nargs, char **argv);
int do_enh_area_set(int nargs, char **argv);
-- 
1.7.0.4


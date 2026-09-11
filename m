Received: from mail-m32115.qiye.163.com (mail-m32115.qiye.163.com [220.197.32.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B8400DF9
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109499; cv=none; b=erPVTwA79FEJRidmt+5uUyzDK0dklQk+/mDpNkfKfsOTpYHGnRrGrLBpmxmEY5cXF8/Db5wnDQzcEJvy70Qo7Y5oALzeNWXS1NcxWOrTIItuqSHVPDh1kCff3LbgS4nqo6xAwvT8BuVo7NdnRWwLW5P46vomGNed9QDzvLT1atM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109499; c=relaxed/simple;
	bh=o+w3QeWExLbRzjMMT4hqRRZjp1MkzvW7M2K5G+ZKe3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mVJNOskhD2qDx7HQ5EzqkA3MXpdwRLvg0pulekAnClyt5b6J9vwVJG3TmuToHSE57oqAWgqrQnPSlC/KM1rGqYe54ZQtzz4jq2bthYC6stttK3MTJuXELwUPR5dBhd0kANRNU9eoSrC7UBucGEzVwBRLBY9tXus79WmIJBjTDgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ahi2DRyr; arc=none smtp.client-ip=220.197.32.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ahi2DRyr"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d64b9704;
	Fri, 11 Sep 2026 14:46:07 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [RFC PATCH 3/4] mmc-utils: Add sdio read/write commands for CMD52 access
Date: Fri, 11 Sep 2026 14:44:55 +0800
Message-Id: <1789109096-196082-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa08f37660803a4kunma7c49b4e5df30a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTU9DVkkZSkMdSEIdHUsfGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ahi2DRyrN7j+xsLk38DwkYF9pFFjlFVEp/fwDanw0Z1RXSK62I5d9CrTYZSms6cFHRRxcqxPmgBhI7YoFPnZnsd8NfKr6yKcMqNXSGEIXBK0KTW+wov9QekD2tjCqVx3xY+uLZy6ZU4gbrCBhEKR62eH6q+9D7Eutq3ziVr2T5o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=XXvkXDGFI09HFN+x2LxJ78TTR9aLWOjxPMmlah+J6Zs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Add 'mmc sdio read/write' commands issuing CMD52 through the
/dev/mmcX:YYYY:FN character device exposed by the kernel
(CONFIG_MMC_SDIO_CDEV), for debugging and factory test tools on
SDIO devices, requires root.

 # mmc sdio read /dev/mmc2:0001:1 0 0x0
 fn 0 addr 0x00000: 0x43 (67)

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---
 docs/HOWTO.rst |  9 ++++++
 lsmmc.c        | 21 ++++++++++---
 man/mmc.1      | 10 +++++-
 mmc.c          | 13 ++++++++
 mmc.h          | 26 ++++++++++++++++
 mmc_cmds.c     | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h     |  2 ++
 7 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index c4709d7..f52034e 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -26,6 +26,15 @@ Running mmc-utils
     ``extcsd write <offset> <value> <device>``
         Write <value> at offset <offset> to <device>'s extcsd.
 
+    ``sdio read <sdio-dev> <fn> <addr>``
+        Read one byte from an SDIO register via CMD52. <sdio-dev> is the
+        character device of the SDIO function (/dev/mmcX:YYYY:FN, requires
+        a kernel with CONFIG_MMC_SDIO_CDEV). fn 0 addresses the card
+        common area (CCCR/FBR). Requires root.
+
+    ``sdio write <sdio-dev> <fn> <addr> <value>``
+        Write one byte to an SDIO register via CMD52. Requires root.
+
     ``writeprotect boot get <device>``
         Print the boot partitions write protect status for <device>.
 
diff --git a/lsmmc.c b/lsmmc.c
index 6ea43d3..3cd1e76 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -375,18 +375,16 @@ static char *read_file_at(const char *dir, const char *name);
 static void print_sdio_functions(const char *devname,
 				 const char *blkdev, const char *cardpath)
 {
-	char devnode[32];
+	char devnode[PATH_MAX + 8];
 	DIR *d;
 	struct dirent *ent;
 
-	snprintf(devnode, sizeof(devnode), "/dev/%s", blkdev ? blkdev : "-");
-
 	d = opendir(cardpath);
 	if (!d)
 		return;
 
 	while ((ent = readdir(d)) != NULL) {
-		char funcdir[PATH_MAX + 256];
+		char funcdir[PATH_MAX + 256], cdevpath[PATH_MAX + 8];
 		char vid[8], did[8], cls[8], clsbuf[24];
 		char *vendor, *device, *class, *revision;
 		char *vname, *dname, *cname, *product = NULL;
@@ -397,6 +395,21 @@ static void print_sdio_functions(const char *devname,
 		    !isdigit((unsigned char)ent->d_name[len + 1]))
 			continue;
 
+		/*
+		 * With the kernel passthrough char device
+		 * (CONFIG_MMC_SDIO_CDEV) each function also gets its own
+		 * /dev/<function name> node - prefer it over the card's
+		 * block device, since it is what the sdio read/write
+		 * commands operate on.
+		 */
+		snprintf(cdevpath, sizeof(cdevpath), "/dev/%s", ent->d_name);
+		if (!access(cdevpath, F_OK))
+			snprintf(devnode, sizeof(devnode), "/dev/%s",
+				 ent->d_name);
+		else
+			snprintf(devnode, sizeof(devnode), "/dev/%s",
+				 blkdev ? blkdev : "-");
+
 		snprintf(funcdir, sizeof(funcdir), "%s/%s",
 			 cardpath, ent->d_name);
 
diff --git a/man/mmc.1 b/man/mmc.1
index b30c5b0..dc4b94c 100644
--- a/man/mmc.1
+++ b/man/mmc.1
@@ -52,12 +52,20 @@ NOTE!  This is a one-time programmable (unreversible) change.
 .TP
 .BR "status get <device>"
 Print the response to STATUS_SEND (CMD13).
-.TP
 .BR "health <device>"
 Print a health summary of the eMMC <device>: the background operations
 status (eMMC >= 4.41), Pre EOL info and device life time estimates
 (eMMC >= 5.0). eMMC only; SD cards do not report health data.
+
+.TP
+.BR "sdio read <sdio-dev> <fn> <addr>"
+Read one byte from an SDIO register via CMD52. <sdio-dev> is the
+character device of the SDIO function (/dev/mmcX:YYYY:FN, requires a
+kernel with CONFIG_MMC_SDIO_CDEV). fn 0 addresses the card common area
+(CCCR/FBR). Requires root.
 .TP
+.BR "sdio write <sdio-dev> <fn> <addr> <value>"
+Write one byte to an SDIO register via CMD52. Requires root..TP
 .BR "bootpart enable <boot_partition> <send_ack> <device>"
 Enable the boot partition for the <device>.
 Disable the boot partition for the <device> with <boot_partition> set to 0.
diff --git a/mmc.c b/mmc.c
index 45fdc8f..91fd12f 100644
--- a/mmc.c
+++ b/mmc.c
@@ -106,6 +106,19 @@ static struct Command commands[] = {
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
 	},
+	{ do_sdio_read, 3,
+	  "sdio read", "<sdio-dev> <fn> <addr>\n"
+		  "Read one byte from an SDIO register via CMD52. <sdio-dev>\n"
+		  "is the character device of the SDIO function\n"
+		  "(/dev/mmcX:YYYY:FN, requires a kernel with\n"
+		  "CONFIG_MMC_SDIO_CDEV). fn 0 addresses the card common\n"
+		  "area (CCCR/FBR). Requires root.",
+	},
+	{ do_sdio_write, 4,
+	  "sdio write", "<sdio-dev> <fn> <addr> <value>\n"
+		  "Write one byte to an SDIO register via CMD52. Requires\n"
+		  "root.",
+	},
 	{ do_health, -1,
 	  "health", "<device>\n"
 	  "Print a health summary of the eMMC <device>: BKOPS status\n"
diff --git a/mmc.h b/mmc.h
index 89862bd..aea8571 100644
--- a/mmc.h
+++ b/mmc.h
@@ -20,6 +20,32 @@
 #include <linux/major.h>
 #include <linux/mmc/ioctl.h>
 
+/* SDIO userspace passthrough: mirror of uapi/linux/mmc/sdio_ioctl.h */
+#ifndef SDIO_IOC_RW
+#define SDIO_IOC_MAGIC		'S'
+#define SDIO_IOC_RW		_IOWR(SDIO_IOC_MAGIC, 0x52, struct sdio_ioc_rw)
+#define SDIO_IOC_RW_EXT		_IOWR(SDIO_IOC_MAGIC, 0x53, struct sdio_ioc_rw_ext)
+
+struct sdio_ioc_rw {
+	__u8 write;		/* 1 = write, 0 = read */
+	__u8 fn;		/* function number, 0..7 */
+	__u8 raw;		/* read back after write */
+	__u8 data;		/* byte to write / value read */
+	__u32 addr;		/* SDIO register address */
+};
+
+struct sdio_ioc_rw_ext {
+	__u8 write;		/* 1 = write, 0 = read */
+	__u8 fn;		/* function number, 1..7 */
+	__u8 incr_addr;		/* 1 = incrementing address, 0 = fixed */
+	__u8 reserved;
+	__u32 addr;		/* SDIO register address */
+	__u16 count;		/* number of bytes, 1..512 */
+	__u16 reserved2;
+	__u8 data[512];		/* data to write / buffer for read */
+};
+#endif
+
 /* From kernel linux/mmc/mmc.h */
 #define MMC_GO_IDLE_STATE         0   /* bc                          */
 #define MMC_GO_IDLE_STATE_ARG		0x0
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 2d9069f..3e93977 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1132,6 +1132,90 @@ int do_health(int nargs, char **argv)
 	return 0;
 }
 
+/*
+ * SDIO userspace passthrough, issued on the /dev/mmcX:YYYY:FN character
+ * device exposed by the kernel (CONFIG_MMC_SDIO_CDEV). fn 0 addresses
+ * the card common area (CCCR/FBR), functions 1-7 the per-function
+ * registers. Requires root.
+ */
+static int sdio_cdev_rw(const char *sdio_dev, int write, int fn,
+			unsigned int addr, __u8 *data)
+{
+	struct sdio_ioc_rw rw = {};
+	int fd, ret;
+
+	fd = open(sdio_dev, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	rw.write = write;
+	rw.fn = fn;
+	rw.addr = addr;
+	rw.data = *data;
+
+	ret = ioctl(fd, SDIO_IOC_RW, &rw);
+	close(fd);
+	if (ret) {
+		perror("ioctl");
+		return ret ? ret : -EIO;
+	}
+
+	*data = rw.data;
+	return 0;
+}
+
+int do_sdio_read(int nargs, char **argv)
+{
+	unsigned int addr, fn;
+	__u8 data = 0;
+	int ret;
+	char *device;
+
+	if (nargs != 4) {
+		print_usage(do_sdio_read);
+		exit(1);
+	}
+
+	device = argv[1];
+	fn = strtol(argv[2], NULL, 0);
+	addr = strtol(argv[3], NULL, 0);
+
+	ret = sdio_cdev_rw(device, 0, fn, addr, &data);
+	if (ret)
+		return 1;
+
+	printf("fn %u addr 0x%05x: 0x%02x (%u)\n", fn, addr, data, data);
+	return 0;
+}
+
+int do_sdio_write(int nargs, char **argv)
+{
+	unsigned int addr, fn, val;
+	__u8 data;
+	int ret;
+	char *device;
+
+	if (nargs != 5) {
+		print_usage(do_sdio_write);
+		exit(1);
+	}
+
+	device = argv[1];
+	fn = strtol(argv[2], NULL, 0);
+	addr = strtol(argv[3], NULL, 0);
+	val = strtol(argv[4], NULL, 0);
+	data = val;
+
+	ret = sdio_cdev_rw(device, 1, fn, addr, &data);
+	if (ret)
+		return 1;
+
+	printf("fn %u addr 0x%05x wrote 0x%02x\n", fn, addr, data);
+	return 0;
+}
+
 static unsigned int get_sector_count(__u8 *ext_csd)
 {
 	return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) |
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 88caf85..dc3b7dc 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -39,6 +39,8 @@ int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
 int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
+int do_sdio_read(int nargs, char **argv);
+int do_sdio_write(int nargs, char **argv);
 int do_health(int nargs, char **argv);
 int do_create_gp_partition(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
-- 
2.25.1


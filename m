Received: from mail-m15574.qiye.163.com (mail-m15574.qiye.163.com [101.71.155.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB637E2E5
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109502; cv=none; b=n8gk8T3xUH6OBrljPoS4fHB3/1x08a3zcjkPEIG7rxCS0EnCr1rFBFzn6daK7+E3B3lLwPkLKUubdcllkjjWaZ35DCI7r5x5d1RuRmZGicxelPk8Gw24Z5loHE+jcHAO1TQKX2TWwD9uRRw68BUYY7dVdY3ufVmVS9jmIiq0OWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109502; c=relaxed/simple;
	bh=zCRsEt6qU42OYH7Gl9mWgjpfuY2afAUj7Ttgty3EVMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mDjovOjQ6I0H7SeWrND5BiUzWnKKMCVXs1OwPLdipeASYMocrwx5VThY5J4OnIO5BPzRuHoEuaXn182pOZBCjEha4rHJcWPO34IKn1ZljnHhtzDg76OMVpzTWU6tBRHOmtr6mtikFB9i0B5oz2OR8UyFB9QK/BFQ3v4o9eV+SU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PVUWUbFb; arc=none smtp.client-ip=101.71.155.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PVUWUbFb"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d64b9717;
	Fri, 11 Sep 2026 14:46:11 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [RFC PATCH 4/4] mmc-utils: Add sdio xread/xwrite commands for CMD53 access
Date: Fri, 11 Sep 2026 14:44:56 +0800
Message-Id: <1789109096-196082-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa08f37734503a4kunma7c49b4e5df330
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEMdVhgfTUIfQ0NOTx1NHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PVUWUbFbekA9m5efokq/PQwoyn0VXb5Gqn8p5jhfLed399ufjrO3tNOh9sJBw95c/TCoQl/yT1d3ZR/fQEEACn1HMnfhUdIvN2GkgDTLQpIbnNxQcrUqjZM9CEFA+2nLj+NBVPfpwAyFhWZCEaRRfsJ1CzdtbU7m6/9eXkV36YA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=VkoqanRnHti7tqxsSHur6ztEtkiRO1YAf/Y0e3bWMDQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Add 'mmc sdio xread/xwrite' commands issuing CMD53 through the
/dev/mmcX:YYYY:FN character device (CONFIG_MMC_SDIO_CDEV), for
multi-byte access to the SDIO register space:

  - sdio xread <sdio-dev> <fn> <addr> <count>: byte-mode CMD53 read
    of 1..512 bytes with hexdump output.
  - sdio xwrite <sdio-dev> <fn> <addr> <byte>... | @file: byte-mode
    CMD53 write of up to 512 bytes given as hex values on the command
    line, or read from a binary file with the @file form.

Complements the existing CMD52 single-byte commands. Function 0 is not
valid for CMD53. Requires root.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---
 docs/HOWTO.rst |  11 ++++
 man/mmc.1      |  14 ++++-
 mmc.c          |  12 ++++
 mmc_cmds.c     | 150 +++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h     |   2 +
 5 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index f52034e..34efb0f 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -35,6 +35,17 @@ Running mmc-utils
     ``sdio write <sdio-dev> <fn> <addr> <value>``
         Write one byte to an SDIO register via CMD52. Requires root.
 
+    ``sdio xread <sdio-dev> <fn> <addr> <count>``
+        Read 1..512 bytes from an SDIO register space via CMD53 (byte mode,
+        incrementing address). <sdio-dev> is the character device of the
+        SDIO function. fn 0 is not valid for CMD53. Requires root.
+
+    ``sdio xwrite <sdio-dev> <fn> <addr> <byte>... | @file``
+        Write up to 512 bytes to an SDIO register space via CMD53 (byte
+        mode, incrementing address). The payload is given as hex bytes on
+        the command line, or read from a binary file with the @file form.
+        Requires root.
+
     ``writeprotect boot get <device>``
         Print the boot partitions write protect status for <device>.
 
diff --git a/man/mmc.1 b/man/mmc.1
index dc4b94c..9e1e3e9 100644
--- a/man/mmc.1
+++ b/man/mmc.1
@@ -52,6 +52,7 @@ NOTE!  This is a one-time programmable (unreversible) change.
 .TP
 .BR "status get <device>"
 Print the response to STATUS_SEND (CMD13).
+.TP
 .BR "health <device>"
 Print a health summary of the eMMC <device>: the background operations
 status (eMMC >= 4.41), Pre EOL info and device life time estimates
@@ -65,7 +66,18 @@ kernel with CONFIG_MMC_SDIO_CDEV). fn 0 addresses the card common area
 (CCCR/FBR). Requires root.
 .TP
 .BR "sdio write <sdio-dev> <fn> <addr> <value>"
-Write one byte to an SDIO register via CMD52. Requires root..TP
+Write one byte to an SDIO register via CMD52. Requires root.
+.TP
+.BR "sdio xread <sdio-dev> <fn> <addr> <count>"
+Read 1..512 bytes from an SDIO register space via CMD53 (byte mode,
+incrementing address). Requires root.
+.TP
+.BR "sdio xwrite <sdio-dev> <fn> <addr> <byte>... | @file"
+Write up to 512 bytes to an SDIO register space via CMD53 (byte mode,
+incrementing address). The payload is given as hex bytes on the command
+line, or read from a binary file with the @file form. Requires root.
+
+.TP
 .BR "bootpart enable <boot_partition> <send_ack> <device>"
 Enable the boot partition for the <device>.
 Disable the boot partition for the <device> with <boot_partition> set to 0.
diff --git a/mmc.c b/mmc.c
index 91fd12f..1f2198f 100644
--- a/mmc.c
+++ b/mmc.c
@@ -119,6 +119,18 @@ static struct Command commands[] = {
 		  "Write one byte to an SDIO register via CMD52. Requires\n"
 		  "root.",
 	},
+	{ do_sdio_readb, 4,
+	  "sdio xread", "<sdio-dev> <fn> <addr> <count>\n"
+		  "Read 1..512 bytes from an SDIO register space via CMD53\n"
+		  "(byte mode, incrementing address). <sdio-dev> is the\n"
+		  "function character device. fn 0 is not valid for CMD53.\n"
+		  "Requires root.",
+	},
+	{ do_sdio_writeb, -1,
+	  "sdio xwrite", "<sdio-dev> <fn> <addr> <byte>... | @file\n"
+		  "Write up to 512 bytes to an SDIO register space via CMD53\n"
+		  "(byte mode, incrementing address). Requires root.",
+	},
 	{ do_health, -1,
 	  "health", "<device>\n"
 	  "Print a health summary of the eMMC <device>: BKOPS status\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3e93977..ed4efa7 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1166,6 +1166,42 @@ static int sdio_cdev_rw(const char *sdio_dev, int write, int fn,
 	return 0;
 }
 
+/*
+ * CMD53 extended access through the /dev/mmcX:YYYY:FN character device
+ * (kernel CONFIG_MMC_SDIO_CDEV). Byte mode, 1..512 bytes per call; fn 0
+ * is not valid for CMD53. Requires root.
+ */
+static int sdio_cdev_rw_ext(const char *sdio_dev, int write, int fn,
+			    unsigned int addr, int incr, __u8 *buf,
+			    __u16 count)
+{
+	struct sdio_ioc_rw_ext rw = {};
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
+	rw.incr_addr = incr;
+	rw.addr = addr;
+	rw.count = count;
+	memcpy(rw.data, buf, count);
+
+	ret = ioctl(fd, SDIO_IOC_RW_EXT, &rw);
+	close(fd);
+	if (ret) {
+		perror("ioctl");
+		return -EIO;
+	}
+
+	memcpy(buf, rw.data, count);
+	return 0;
+}
+
 int do_sdio_read(int nargs, char **argv)
 {
 	unsigned int addr, fn;
@@ -1216,6 +1252,120 @@ int do_sdio_write(int nargs, char **argv)
 	return 0;
 }
 
+int do_sdio_readb(int nargs, char **argv)
+{
+	unsigned int addr, fn, count, i, j;
+	__u8 *data;
+	int ret;
+	char *device;
+
+	if (nargs != 5) {
+		print_usage(do_sdio_readb);
+		exit(1);
+	}
+
+	device = argv[1];
+	fn = strtol(argv[2], NULL, 0);
+	addr = strtol(argv[3], NULL, 0);
+	count = strtol(argv[4], NULL, 0);
+
+	if (fn == 0 || fn > 7 || !count || count > 512) {
+		fprintf(stderr, "fn must be 1..7, count must be 1..512\n");
+		return -EINVAL;
+	}
+
+	data = malloc(count);
+	if (!data)
+		return -ENOMEM;
+
+	ret = sdio_cdev_rw_ext(device, 0, fn, addr, 1, data, count);
+	if (ret) {
+		free(data);
+		return 1;
+	}
+
+	for (i = 0; i < count; i += 16) {
+		unsigned int n = count - i < 16 ? count - i : 16;
+
+		printf("  0x%04x:", addr + i);
+		for (j = 0; j < n; j++)
+			printf(" %02x", data[i + j]);
+		printf("\n");
+	}
+
+	free(data);
+	return 0;
+}
+
+int do_sdio_writeb(int nargs, char **argv)
+{
+	unsigned int addr, fn, i;
+	__u8 data[512];
+	unsigned int count = 0;
+	int ret;
+	char *device;
+
+	/* argv: [0]=prog+verb, [1]=dev, [2]=fn, [3]=addr, [4..]=bytes|@file */
+	if (nargs < 5) {
+		print_usage(do_sdio_writeb);
+		exit(1);
+	}
+
+	device = argv[1];
+	fn = strtol(argv[2], NULL, 0);
+	addr = strtol(argv[3], NULL, 0);
+
+	if (fn == 0 || fn > 7) {
+		fprintf(stderr, "fn must be 1..7\n");
+		return -EINVAL;
+	}
+
+	if (argv[4][0] == '@') {
+		/* Read the binary payload from a file, up to 512 bytes */
+		FILE *f = fopen(argv[4] + 1, "rb");
+
+		if (!f) {
+			perror("fopen");
+			return 1;
+		}
+		count = fread(data, 1, sizeof(data), f);
+		if (ferror(f)) {
+			fprintf(stderr, "Could not read %s\n", argv[4] + 1);
+			fclose(f);
+			return 1;
+		}
+		fclose(f);
+		if (!count) {
+			fprintf(stderr, "Empty file %s\n", argv[4] + 1);
+			return -EINVAL;
+		}
+	} else {
+		if (nargs - 4 > 512) {
+			fprintf(stderr, "Up to 512 bytes\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < (unsigned int)(nargs - 4); i++) {
+			unsigned long v = strtoul(argv[4 + i], NULL, 0);
+
+			if (v > 0xff) {
+				fprintf(stderr, "byte value out of range: %s\n",
+					argv[4 + i]);
+				return -EINVAL;
+			}
+			data[i] = v;
+		}
+		count = nargs - 4;
+	}
+
+	ret = sdio_cdev_rw_ext(device, 1, fn, addr, 1, data, count);
+	if (ret)
+		return 1;
+
+	printf("fn %u addr 0x%05x wrote %u bytes\n", fn, addr, count);
+	return 0;
+}
+
 static unsigned int get_sector_count(__u8 *ext_csd)
 {
 	return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) |
diff --git a/mmc_cmds.h b/mmc_cmds.h
index dc3b7dc..f7493d7 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -41,6 +41,8 @@ int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
 int do_sdio_read(int nargs, char **argv);
 int do_sdio_write(int nargs, char **argv);
+int do_sdio_readb(int nargs, char **argv);
+int do_sdio_writeb(int nargs, char **argv);
 int do_health(int nargs, char **argv);
 int do_create_gp_partition(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
-- 
2.25.1


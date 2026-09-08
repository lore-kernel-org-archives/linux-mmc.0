Received: from mail-m32101.qiye.163.com (mail-m32101.qiye.163.com [220.197.32.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0D70808
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827192; cv=none; b=avlZpKzN2ge5m/6WrTaeqD382Q6GvFzg59Lp4EUstGdDtUZW6E10VhaajQ6e2uEE7tdRLmOjjueloXFsvPKN+2/4kTmZsR0y5Lsjx4BsH23FcLumUqlkesbbp4bV8RMk/MSqKr3ky3OtH9hmPasPP/1Jocy/tGjcNHCFJe9EmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827192; c=relaxed/simple;
	bh=PM5IgmHUReavJvrdNQcCniC0qwY5uRrPeD1dHhJnK5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TA4sNXyh6tKOIxlCSrUIiOEKsrkeR0Sqokhjnn+3VLU84TlSDz6ekq3IXjB6imWfbfwMPd7nODiAqPtsKlFZZi/N2XxC+J+8JnW+3Ckbb/bGz6yAWQKPAiF8SMMKU367ZVMSqsINTGuj54vwhkYGz7QedxY++q3JFwyTNFQCZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SrWrrxU3; arc=none smtp.client-ip=220.197.32.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SrWrrxU3"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ce1549ea;
	Tue, 8 Sep 2026 08:21:08 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v3 2/2] mmc-utils: Add health command for eMMC health reporting
Date: Tue,  8 Sep 2026 08:21:00 +0800
Message-Id: <1788826860-153971-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1788826860-153971-1-git-send-email-shawn.lin@rock-chips.com>
References: <1788826860-153971-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa07e63dcd903a4kunm951c4038385a19
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUgeSFZMGEseQ0oeTx
	4ZSENWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SrWrrxU3mWvScxrh+ljLbb/un00pV+bqRh+AoR7KTdB85Af5SNrLDwR6oYak+2c1AdqGscivBm+xyVQvPzitfHMUCn8jal8vcDOiJhzGP7X4QYoMI6x5lQ6cfUsfESFL3ycL6aye06PnWUIif0/2ITN6eMvqWGFCBRg41YR1RdE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=s8XbnF1eNuej02TejcR4X1/m61N+CzsQLC+zAn21Mtk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Add a "mmc health <device>" command that prints a health summary of an
eMMC device: the background operations status (available since eMMC
4.41) and the Pre EOL info plus device life time estimates (available
since eMMC 5.0), each with a human readable decode of the field. eMMC
only, as SD cards do not report any standardized health data.

Note that devices may additionally expose a vendor proprietary health
report (EXT_CSD [301:270], read via CMD56), which is not covered by
this command.

Execution effect on an eMMC 5.1 device:

  # mmc health /dev/block/mmcblk0
  =============================================
    eMMC Health Report: /dev/block/mmcblk0
  =============================================
  Extended CSD rev: 1.8 (MMC 5.1)
  BKOPS status:     0x00 [No background operation required]
  Pre EOL info:     0x01 [Normal]
  Life time type A: 0x01 [0%-10% of device life time used]
  Life time type B: 0x01 [0%-10% of device life time used]

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---
 docs/HOWTO.rst |  18 +++++++
 man/mmc.1      |   5 ++
 mmc.c          |   6 +++
 mmc.h          |   1 +
 mmc_cmds.c     | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h     |   1 +
 6 files changed, 156 insertions(+)

diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
index 3aba86f..3518b0f 100644
--- a/docs/HOWTO.rst
+++ b/docs/HOWTO.rst
@@ -96,6 +96,24 @@ Running mmc-utils
             sysfs: /sys/devices/platform/fe320000.mmc/mmc_host/mmc1/mmc1:aaaa
             SCR Register: 0235800000000000
 
+    ``health <device>``
+        Print a health summary of the eMMC <device>: the background operations
+        status (eMMC >= 4.41), Pre EOL info and device life time estimates
+        (eMMC >= 5.0), each with a human readable decode of the raw field.
+        eMMC only; SD cards do not report health data.
+
+        Example::
+
+            $ mmc health /dev/mmcblk0
+            =============================================
+              eMMC Health Report: /dev/mmcblk0
+            =============================================
+            Extended CSD rev: 1.8 (MMC 5.1)
+            BKOPS status:     0x00 [No background operation required]
+            Pre EOL info:     0x01 [Normal]
+            Life time type A: 0x01 [0%-10% of device life time used]
+            Life time type B: 0x01 [0%-10% of device life time used]
+
     ``list``
         List all MMC/SD devices present on the system. Output is a table with
         columns: DEVICE (sysfs name), DEV (/dev path), TYPE (MMC or SD),
diff --git a/man/mmc.1 b/man/mmc.1
index 665fe6d..b30c5b0 100644
--- a/man/mmc.1
+++ b/man/mmc.1
@@ -53,6 +53,11 @@ NOTE!  This is a one-time programmable (unreversible) change.
 .BR "status get <device>"
 Print the response to STATUS_SEND (CMD13).
 .TP
+.BR "health <device>"
+Print a health summary of the eMMC <device>: the background operations
+status (eMMC >= 4.41), Pre EOL info and device life time estimates
+(eMMC >= 5.0). eMMC only; SD cards do not report health data.
+.TP
 .BR "bootpart enable <boot_partition> <send_ack> <device>"
 Enable the boot partition for the <device>.
 Disable the boot partition for the <device> with <boot_partition> set to 0.
diff --git a/mmc.c b/mmc.c
index b0f1f9b..45fdc8f 100644
--- a/mmc.c
+++ b/mmc.c
@@ -106,6 +106,12 @@ static struct Command commands[] = {
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
 	},
+	{ do_health, -1,
+	  "health", "<device>\n"
+	  "Print a health summary of the eMMC <device>: BKOPS status\n"
+	  "(eMMC >= 4.41), Pre EOL info and device life time estimates\n"
+	  "(eMMC >= 5.0). eMMC only, SD cards do not report health data.",
+	},
 	{ do_write_boot_en, -3,
 	  "bootpart enable", "<boot_partition> " "<send_ack> " "<device>\n"
 		"Enable the boot partition for the <device>.\nDisable the boot partition for the <device> if <boot_partition> is set to 0.\nTo receive acknowledgment of boot from the card set <send_ack>\nto 1, else set it to 0.",
diff --git a/mmc.h b/mmc.h
index 2bb346b..89862bd 100644
--- a/mmc.h
+++ b/mmc.h
@@ -97,6 +97,7 @@
 #define EXT_CSD_CACHE_SIZE_2		251
 #define EXT_CSD_CACHE_SIZE_1		250
 #define EXT_CSD_CACHE_SIZE_0		249
+#define EXT_CSD_BKOPS_STATUS		246	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231
 #define EXT_CSD_BOOT_INFO		228	/* R/W */
 #define EXT_CSD_BOOT_MULT		226	/* RO */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index c70c337..2d9069f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1007,6 +1007,131 @@ static const char *extcsd_rev_to_string(__u8 rev)
 	}
 }
 
+static const char *pre_eol_info_to_string(__u8 val)
+{
+	switch (val) {
+	case 0x00:
+		return "Not defined";
+	case 0x01:
+		return "Normal";
+	case 0x02:
+		return "Warning: Consumed 80% of reserved block";
+	case 0x03:
+		return "Urgent";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *life_time_est_to_string(__u8 val)
+{
+	static const char * const strs[] = {
+		"Not defined",                                     /* 0x00 */
+		"0%-10% of device life time used",                 /* 0x01 */
+		"10%-20% of device life time used",                /* 0x02 */
+		"20%-30% of device life time used",                /* 0x03 */
+		"30%-40% of device life time used",                /* 0x04 */
+		"40%-50% of device life time used",                /* 0x05 */
+		"50%-60% of device life time used",                /* 0x06 */
+		"60%-70% of device life time used",                /* 0x07 */
+		"70%-80% of device life time used",                /* 0x08 */
+		"80%-90% of device life time used",                /* 0x09 */
+		"90%-100% of device life time used",               /* 0x0A */
+		"Exceeded the maximum estimated device life time", /* 0x0B */
+	};
+
+	if (val > 0x0B)
+		return "Reserved";
+
+	return strs[val];
+}
+
+static const char *bkops_status_to_string(__u8 val)
+{
+	switch (val) {
+	case 0x00:
+		return "No background operation required";
+	case 0x01:
+		return "Level 1: background operation required (non-urgent)";
+	case 0x02:
+		return "Level 2: background operation required (performance impacted)";
+	case 0x03:
+		return "Level 3: background operation required (urgent)";
+	default:
+		return "Reserved";
+	}
+}
+
+/*
+ * Print a health summary of the device. The background operations
+ * status is available since eMMC 4.41, the Pre EOL info and the device
+ * life time estimates since eMMC 5.0. SD cards do not report health
+ * data.
+ */
+int do_health(int nargs, char **argv)
+{
+	__u8 ext_csd[512], ext_csd_rev, pre_eol, life_typ_a, life_typ_b, bkops;
+	int fd, ret;
+	char *device;
+	const char *str;
+
+	if (nargs != 2) {
+		print_usage(do_health);
+		exit(1);
+	}
+
+	device = argv[1];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s, "
+				"not an eMMC device?\n", device);
+		close(fd);
+		exit(1);
+	}
+
+	ext_csd_rev = ext_csd[EXT_CSD_REV];
+
+	printf("=============================================\n");
+	printf("  eMMC Health Report: %s\n", device);
+	printf("=============================================\n");
+	str = extcsd_rev_to_string(ext_csd_rev);
+	printf("Extended CSD rev: 1.%d (MMC %s)\n", ext_csd_rev,
+	       str ? str : "unknown");
+
+	/* The background operations status is available since eMMC 4.41 */
+	if (ext_csd_rev >= EXT_CSD_REV_V4_4_1) {
+		bkops = ext_csd[EXT_CSD_BKOPS_STATUS] & 0x3;
+		printf("BKOPS status:     0x%02x [%s]\n", bkops,
+		       bkops_status_to_string(bkops));
+		if (bkops == 0x03)
+			printf("Note: urgent background operation is pending, "
+			       "do not power off the device right now\n");
+	}
+
+	/* The Pre EOL info and life time estimates are available since eMMC 5.0 */
+	if (ext_csd_rev >= EXT_CSD_REV_V5_0) {
+		pre_eol = ext_csd[EXT_CSD_PRE_EOL_INFO];
+		life_typ_a = ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
+		life_typ_b = ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
+		printf("Pre EOL info:     0x%02x [%s]\n", pre_eol,
+		       pre_eol_info_to_string(pre_eol));
+		printf("Life time type A: 0x%02x [%s]\n", life_typ_a,
+		       life_time_est_to_string(life_typ_a));
+		printf("Life time type B: 0x%02x [%s]\n", life_typ_b,
+		       life_time_est_to_string(life_typ_b));
+	}
+
+	close(fd);
+	return 0;
+}
+
 static unsigned int get_sector_count(__u8 *ext_csd)
 {
 	return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) |
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 033cc09..88caf85 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -39,6 +39,7 @@ int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
 int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
+int do_health(int nargs, char **argv);
 int do_create_gp_partition(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
 int do_write_reliability_set(int nargs, char **argv);
-- 
2.25.1


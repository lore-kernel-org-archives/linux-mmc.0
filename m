Received: from mail-m49222.qiye.163.com (mail-m49222.qiye.163.com [45.254.49.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8853C1966
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763541; cv=none; b=cvGjv0PYpcLplxwx2Le0mrNZ4bzUUno2X0jKOtmSntlxZ/iNeeozDnsek0Tg8y8Faoq5Nf4kzJ16h0bevhpZSAOezvKNKLHet3raqp3FzvZpQb6Y6nmplEsrhqJggtUouh0gEKOnDRIZbuR9otlzFw42KnLe4VfjpnrV6ukm09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763541; c=relaxed/simple;
	bh=h9s5grPBgq875qJSJ7f1iWvnW/bbDXrWzkeqTA41fy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kPPXj1A6TvTZc84OmfiRpfRvVcBU6r4ttzR2muPm/15D9OCgqSyC79VBVgf2H5Udv6cpWZa/uLVW8X5ftk6nYuR4j4PBaKFzZonLiyPHrk7Tj3PuEbSjmlzeLoRLVqmRgbno8TUalF4EEc9t7roZ/a7MRm/D18erw5xBct7rUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Atticm0r; arc=none smtp.client-ip=45.254.49.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Atticm0r"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cb8dbfa6;
	Mon, 7 Sep 2026 09:02:35 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v2 2/2] mmc-utils: Add health command for eMMC health reporting
Date: Mon,  7 Sep 2026 09:02:24 +0800
Message-Id: <1788742944-94637-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1788742944-94637-1-git-send-email-shawn.lin@rock-chips.com>
References: <1788742944-94637-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0796370b303a4kunm8383fd3f2ced29
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGRhJTVZPSx5NSRpNH0
	JDHUNWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Atticm0rqwaw1zNRRmAc4IIu0TgSjDDLsUhDR1fGOF0/2Xh2aYyBTlOZAPAvFajaOMH5cuwHZAl84JfY4gHpsLBUUbWRpjdPpGp6ZuhMzGEqjvFES7SRPnXV3r4KczdMpZcwRAIbkjGed9BrI0Y24bNL2mfozUqje8pjj0Yw4Jw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=WJmLGv6VVZNDaPtNyoP+QG3mv8fbt6zGRfvuzBbGA9s=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Add a "mmc health <device>" command that prints a health summary of an
eMMC device: Pre EOL info, device life time estimates (type A and B)
and BKOPS status, each with a human readable decode of the field and a
final verdict line.

The per-field values and their level semantics come from the eMMC 5.0
spec (JESD84-B50, EXT_CSD fields 267/268/269/246). The aggregated
verdict takes the worst of the three wear related fields and maps it
onto an exit code, so the command can be used directly from production
test scripts and CI:

  0 healthy, 1 command failure, 2 wrong argument count, 3 warning,
  4 urgent, 5 unsupported (eMMC < 5.0), 6 not an eMMC device.

Note that this verdict is an mmc-utils derived indicator: the eMMC
spec does not define such an aggregated health measure. Devices may
additionally expose a vendor proprietary health report (EXT_CSD
[301:270], read via CMD56), which is not covered by this command.

The command is eMMC only: SD cards do not have EXT_CSD and do not
report any standardized health data.

Execution effect on an eMMC 5.1 device:

  # mmc health /dev/block/mmcblk0
  =============================================
    eMMC Health Report: /dev/block/mmcblk0
  =============================================
  Extended CSD rev: 1.8 (MMC 5.1)
  Pre EOL info:     0x01 [Normal]
  Life time type A: 0x01 [0%-10% of device life time used]
  Life time type B: 0x01 [0%-10% of device life time used]
  BKOPS status:     0x00 [No background operation required]
  Result: HEALTHY

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---
 mmc.c      |  11 +++++
 mmc.h      |   1 +
 mmc_cmds.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 154 insertions(+)

diff --git a/mmc.c b/mmc.c
index b0f1f9b..ce8b454 100644
--- a/mmc.c
+++ b/mmc.c
@@ -106,6 +106,17 @@ static struct Command commands[] = {
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
 	},
+	{ do_health, -1,
+	  "health", "<device>\n"
+	  "Print a health summary of the eMMC <device>: Pre EOL info,\n"
+	  "device life time estimates and BKOPS status. eMMC only, SD\n"
+	  "cards do not report health data.\n"
+	  "Note: the verdict is an mmc-utils derived indicator, the\n"
+	  "eMMC spec does not define an aggregated health measure.\n"
+	  "Exit code: 0 healthy, 1 command failure, 2 wrong argument\n"
+	  "count, 3 warning, 4 urgent, 5 unsupported (eMMC < 5.0),\n"
+	  "6 not an eMMC device.",
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
index c70c337..35663f1 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1007,6 +1007,147 @@ static const char *extcsd_rev_to_string(__u8 rev)
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
+ * Print a health summary of the device. Exit codes:
+ *   0 healthy (or no degradation reported)
+ *   1 warning level
+ *   2 urgent level
+ *   3 health data not supported (eMMC < 5.0)
+ *   4 not an eMMC device (EXT_CSD read failed)
+ * Only meaningful for eMMC; SD cards do not report health data.
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
+		exit(6);
+	}
+
+	ext_csd_rev = ext_csd[EXT_CSD_REV];
+	pre_eol = ext_csd[EXT_CSD_PRE_EOL_INFO];
+	life_typ_a = ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
+	life_typ_b = ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
+	bkops = ext_csd[EXT_CSD_BKOPS_STATUS] & 0x3;
+
+	printf("=============================================\n");
+	printf("  eMMC Health Report: %s\n", device);
+	printf("=============================================\n");
+	str = extcsd_rev_to_string(ext_csd_rev);
+	printf("Extended CSD rev: 1.%d (MMC %s)\n", ext_csd_rev,
+	       str ? str : "unknown");
+	printf("Pre EOL info:     0x%02x [%s]\n", pre_eol,
+	       pre_eol_info_to_string(pre_eol));
+	printf("Life time type A: 0x%02x [%s]\n", life_typ_a,
+	       life_time_est_to_string(life_typ_a));
+	printf("Life time type B: 0x%02x [%s]\n", life_typ_b,
+	       life_time_est_to_string(life_typ_b));
+	printf("BKOPS status:     0x%02x [%s]\n", bkops,
+	       bkops_status_to_string(bkops));
+
+	if (ext_csd_rev < EXT_CSD_REV_V5_0) {
+		ret = 5;
+		goto out;
+	}
+
+	if (pre_eol == 0x03 || life_typ_a == 0x0B || life_typ_b == 0x0B) {
+		printf("Result: URGENT\n");
+		ret = 4;
+	} else if (pre_eol == 0x02 || life_typ_a == 0x0A ||
+		   life_typ_b == 0x0A) {
+		printf("Result: WARNING\n");
+		ret = 3;
+	} else if (pre_eol == 0x00 && life_typ_a == 0x00 &&
+		   life_typ_b == 0x00) {
+		printf("Result: UNKNOWN (device does not report health data)\n");
+	} else {
+		printf("Result: HEALTHY\n");
+	}
+
+	if (bkops == 0x03)
+		printf("Note: urgent background operation is pending, "
+		       "do not power off the device right now\n");
+
+out:
+	close(fd);
+	return ret;
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


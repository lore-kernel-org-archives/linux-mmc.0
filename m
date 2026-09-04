Received: from mail-m32108.qiye.163.com (mail-m32108.qiye.163.com [220.197.32.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D648822C
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525553; cv=none; b=R2wHK6KoYtV1YTbW3pDYVp3vzJhPNDOG2NNi4p+4D5X2lvfavGQvcXlHkc2b94IhAXzvgZQ6jSq0UuNq60JfxZEoJd6VpBhd8Yxv0QDQ6Fe2B9nIdAaekbQ9SYkfDboV4MbHQzql50Qt2dx+B7nVs2ezsT4Ni7y7roeSlrHILtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525553; c=relaxed/simple;
	bh=F2OXNhMCPRKIBeWbUzqqe81xVsy0py88XrW4kixCDx8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cpFHi6z18YOBcr8UINdircUD9uE7AFMISaDnthFBInZOzwbKnY5CdipVNcl/JkDQ3K/4tg0trWrcAuuOuGzltR713qaNcA8kU+qLxqTcRYS2MY3hWKw7057a9xWYyjSvdbYrQOnmrs1YV4Hx+KdzAkXYSAKnjiUuXqfULo3+BeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T6oXfB8V; arc=none smtp.client-ip=220.197.32.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T6oXfB8V"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c9331ca9;
	Fri, 4 Sep 2026 20:33:47 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH] mmc-utils: Add health command for eMMC health reporting
Date: Fri,  4 Sep 2026 20:33:34 +0800
Message-Id: <1788525214-40803-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa06c692bc103a4kunmc343671017336b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUwaSlYZSR1DGE8aT0
	1CTk1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=T6oXfB8V0N56tTjuI7aGSwZSdX3PbjYRs+BSqv01170hKIuzcC9vw7KuwUdYtRc/YrHbYJlNiGsdTU8SUQIiogq6QNS5SctJ7pl2i3Z77HGFQNcJzhGqhktpHS1JG9RPSSJgpTqYhypqUFAhw1avcRcRWCg/PtcaRkxrBb7pfys=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=cOnQqZqU1c3Oda2sorxlBdwD9h7S+fhX5OcEkoBp6VE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Add a "mmc health <device>" command that prints a health summary of an
eMMC device: Pre EOL info, device life time estimates (type A and B)
and BKOPS status, each with a human readable decode of the raw field,
plus a final verdict line.

The per-field values and their level semantics come from the eMMC 5.0
spec (JESD84-B50, EXT_CSD fields 267/268/269/33); the aggregated
verdict takes the worst of the three wear related fields and maps it
onto an exit code, so the command can be used directly from production
test scripts and CI:

  0 healthy, 1 warning, 2 urgent, 3 unsupported (eMMC < 5.0),
  4 not an eMMC device (EXT_CSD read failed).

The command is eMMC only: SD cards do not have EXT_CSD and do not
report any standardized health data.

Execution effect on an eMMC 5.1 device:

  # mmc health /dev/block/mmcblk0
  =============================================
    eMMC Health Report: /dev/block/mmcblk0
  =============================================
  eMMC rev:         1.8 (MMC 5.1)
  Pre EOL info:     0x01 [Normal]
  Life time type A: 0x01 [0%-10% of device life time used]
  Life time type B: 0x01 [0%-10% of device life time used]
  BKOPS status:     0x01 [Level 1: background operation required (non-urgent)]
  Result: HEALTHY

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---
 mmc.c      |   8 +++
 mmc.h      |   1 +
 mmc_cmds.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 175 insertions(+)

diff --git a/mmc.c b/mmc.c
index b0f1f9b..e0fc0e8 100644
--- a/mmc.c
+++ b/mmc.c
@@ -106,6 +106,14 @@ static struct Command commands[] = {
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
 	},
+	{ do_health, -1,
+	  "health", "<device>\n"
+	  "Print a health summary of the eMMC <device>: Pre EOL info,\n"
+	  "device life time estimates and BKOPS status. eMMC only, SD\n"
+	  "cards do not report health data.\n"
+	  "Exit code: 0 healthy, 1 warning, 2 urgent, 3 unsupported\n"
+	  "(eMMC < 5.0), 4 not an eMMC device.",
+	},
 	{ do_write_boot_en, -3,
 	  "bootpart enable", "<boot_partition> " "<send_ack> " "<device>\n"
 		"Enable the boot partition for the <device>.\nDisable the boot partition for the <device> if <boot_partition> is set to 0.\nTo receive acknowledgment of boot from the card set <send_ack>\nto 1, else set it to 0.",
diff --git a/mmc.h b/mmc.h
index 2bb346b..af0ad87 100644
--- a/mmc.h
+++ b/mmc.h
@@ -120,6 +120,7 @@
 #define EXT_CSD_WR_REL_SET		167
 #define EXT_CSD_WR_REL_PARAM		166
 #define EXT_CSD_SANITIZE_START		165
+#define EXT_CSD_BKOPS_STATUS		33	/* RO */
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_PARTITIONING_SUPPORT	160	/* RO */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index a7e4784..43dcdcc 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -981,6 +981,171 @@ out_free:
 	return ret;
 }
 
+static const char *extcsd_rev_to_string(__u8 rev)
+{
+	switch (rev) {
+	case 9:
+	case 8:
+		return "5.1";
+	case 7:
+		return "5.0";
+	case 6:
+		return "4.5";
+	case 5:
+		return "4.41";
+	case 3:
+		return "4.3";
+	case 2:
+		return "4.2";
+	case 1:
+		return "4.1";
+	case 0:
+		return "4.0";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *pre_eol_info_to_string(__u8 val)
+{
+	switch (val) {
+	case 0x00:
+		return "Not defined";
+	case 0x01:
+		return "Normal";
+	case 0x02:
+		return "Warning: reserved blocks are consumed";
+	case 0x03:
+		return "Urgent: reserved blocks are exhausted";
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
+		exit(4);
+	}
+
+	ext_csd_rev = ext_csd[EXT_CSD_REV];
+	pre_eol = ext_csd[EXT_CSD_PRE_EOL_INFO];
+	life_typ_a = ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
+	life_typ_b = ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
+	bkops = ext_csd[EXT_CSD_BKOPS_STATUS];
+
+	printf("=============================================\n");
+	printf("  eMMC Health Report: %s\n", device);
+	printf("=============================================\n");
+	printf("eMMC rev:         1.%d (MMC %s)\n", ext_csd_rev,
+	       extcsd_rev_to_string(ext_csd_rev));
+	printf("Pre EOL info:     0x%02x [%s]\n", pre_eol,
+	       pre_eol_info_to_string(pre_eol));
+	printf("Life time type A: 0x%02x [%s]\n", life_typ_a,
+	       life_time_est_to_string(life_typ_a));
+	printf("Life time type B: 0x%02x [%s]\n", life_typ_b,
+	       life_time_est_to_string(life_typ_b));
+	printf("BKOPS status:     0x%02x [%s]\n", bkops,
+	       bkops_status_to_string(bkops));
+
+	if (ext_csd_rev < 7) {
+		printf("Result: UNSUPPORTED (health data requires eMMC 5.0)\n");
+		ret = 3;
+		goto out;
+	}
+
+	if (pre_eol == 0x03 || life_typ_a == 0x0B || life_typ_b == 0x0B) {
+		printf("Result: URGENT\n");
+		ret = 2;
+	} else if (pre_eol == 0x02 || life_typ_a == 0x0A ||
+		   life_typ_b == 0x0A) {
+		printf("Result: WARNING\n");
+		ret = 1;
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


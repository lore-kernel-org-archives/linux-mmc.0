From: Ben Gardiner <ben.l.gardiner@gmail.com>
Subject: [PATCH 3/3] support setting the OTP write reliability settings
Date: Thu, 19 Sep 2013 11:14:29 -0400
Message-ID: <06c38eb8dcbf25bee62d50a6a9b9162c734ce7ad.1379602866.git.ben.l.gardiner@gmail.com>
References: <cover.1379602866.git.ben.l.gardiner@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:57597 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab3ISPOn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2013 11:14:43 -0400
Received: by mail-qc0-f176.google.com with SMTP id t7so5514641qcv.21
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2013 08:14:42 -0700 (PDT)
In-Reply-To: <cover.1379602866.git.ben.l.gardiner@gmail.com>
In-Reply-To: <cover.1379602866.git.ben.l.gardiner@gmail.com>
References: <cover.1379602866.git.ben.l.gardiner@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Signed-off-by: Ben Gardiner <ben.l.gardiner@gmail.com>
---
 mmc.c      |  5 +++++
 mmc_cmds.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 3 files changed, 68 insertions(+)

diff --git a/mmc.c b/mmc.c
index 725b842..926e92f 100644
--- a/mmc.c
+++ b/mmc.c
@@ -75,6 +75,11 @@ static struct Command commands[] = {
 		"Enable the enhanced user area for the <device>.\nDry-run only unless -y is passed.\nNOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
+	{ do_write_reliability_set, -2,
+	  "write_reliability set", "<-y|-n> " "<partition> " "<device>\n"
+		"Enable write reliability per partition for the <device>.\nDry-run only unless -y is passed.\nNOTE!  This is a one-time programmable (unreversible) change.",
+	  NULL
+	},
 	{ do_status_get, -1,
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 7874b23..079f322 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -632,6 +632,68 @@ int do_enh_area_set(int nargs, char **argv)
 	return 0;
 }
 
+int do_write_reliability_set(int nargs, char **argv)
+{
+	__u8 value;
+	__u8 ext_csd[512];
+	int fd, ret;
+
+	int dry_run = 1;
+	int partition;
+	char *device;
+
+	CHECK(nargs != 4, "Usage: mmc write_reliability set <-y|-n> "
+			"<partition> </path/to/mmcblkX>\n", exit(1));
+
+	if (!strcmp("-y", argv[1]))
+		dry_run = 0;
+
+	partition = strtol(argv[2], NULL, 10);
+	device = argv[3];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		exit(1);
+	}
+
+	/* assert not PARTITION_SETTING_COMPLETED */
+	if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED])
+	{
+		printf(" Device is already partitioned\n");
+		exit(1);
+	}
+
+	/* assert HS_CTRL_REL */
+	if (!(ext_csd[EXT_CSD_WR_REL_PARAM] & HS_CTRL_REL)) {
+		printf("Cannot set write reliability parameters, WR_REL_SET is "
+				"read-only\n");
+		exit(1);
+	}
+
+	value = ext_csd[EXT_CSD_WR_REL_SET] | (1<<partition);
+	ret = write_extcsd_value(fd, EXT_CSD_WR_REL_SET, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+				value, EXT_CSD_WR_REL_SET, device);
+		exit(1);
+	}
+
+	printf("Done setting EXT_CSD_WR_REL_SET to 0x%02x on %s\n",
+		value, device);
+
+	if (!set_partitioning_setting_completed(dry_run, device, fd))
+		exit(1);
+
+	return 0;
+}
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index fa347f5..f06cc10 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -27,3 +27,4 @@ int do_hwreset_dis(int nargs, char **argv);
 int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
+int do_write_reliability_set(int nargs, char **argv);
-- 
1.8.1.2


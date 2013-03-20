From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH] Add method for triggering Sanitize command
Date: Wed, 20 Mar 2013 13:58:02 +0200
Message-ID: <1363780682-28440-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ygardi@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch adds a method to trigger Sanitize command to MMC.
The Sanitize command is used for deleting the unmapped memory region
of the MMC device.

Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>

diff --git a/mmc.c b/mmc.c
index a2de863..174d9a4 100644
--- a/mmc.c
+++ b/mmc.c
@@ -90,6 +90,11 @@ static struct Command commands[] = {
 		"Permanently disable the eMMC H/W Reset feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
+	{ do_sanitize, -1,
+	  "sanitize", "<device>\n"
+		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index c863751..5173d34 100644
--- a/mmc.h
+++ b/mmc.h
@@ -38,6 +38,7 @@
 #define EXT_CSD_PART_CONFIG		179
 #define EXT_CSD_BOOT_WP			173
 #define EXT_CSD_WR_REL_PARAM		166
+#define EXT_CSD_SANITIZE_START		165
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b407f65..5473a20 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -767,3 +767,31 @@ int do_read_extcsd(int nargs, char **argv)
 out_free:
 	return ret;
 }
+
+int do_sanitize(int nargs, char **argv)
+{
+	int fd, ret;
+	char *device;
+
+	CHECK(nargs != 2, "Usage: mmc sanitize </path/to/mmcblkX>\n",
+			exit(1));
+
+	device = argv[1];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, EXT_CSD_SANITIZE_START, 1);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			1, EXT_CSD_SANITIZE_START, device);
+		exit(1);
+	}
+
+	return ret;
+
+}
+
diff --git a/mmc_cmds.h b/mmc_cmds.h
index e52d622..ec22eee 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -24,3 +24,4 @@ int do_write_boot_en(int nargs, char **argv);
 int do_write_bkops_en(int nargs, char **argv);
 int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
+int do_sanitize(int nargs, char **argv);
-- 
1.7.6
-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

From: Ben Gardiner <ben.l.gardiner@gmail.com>
Subject: [PATCH 1/3] extract PARTITION_SETTING_COMPLETE function
Date: Thu, 19 Sep 2013 11:14:27 -0400
Message-ID: <c13acd12b1ad70d2ef8f63ec40f6bff112688329.1379602866.git.ben.l.gardiner@gmail.com>
References: <cover.1379602866.git.ben.l.gardiner@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:39619 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab3ISPOj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2013 11:14:39 -0400
Received: by mail-qe0-f53.google.com with SMTP id jy17so5798186qeb.26
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2013 08:14:39 -0700 (PDT)
In-Reply-To: <cover.1379602866.git.ben.l.gardiner@gmail.com>
In-Reply-To: <cover.1379602866.git.ben.l.gardiner@gmail.com>
References: <cover.1379602866.git.ben.l.gardiner@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Extract a function which sets the OTP PARTITION_SETTING_COMPLETE
bit; once this bit is set there are many other parameters in
EXT_CSD which can no longer be set.

Multiple OTP partition settings can be achieved by calling 'set'
commands with '-n' on all except for the last.

Signed-off-by: Ben Gardiner <ben.l.gardiner@gmail.com>
---
 mmc_cmds.c | 77 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index ba4f9cf..5ea19ac 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -449,6 +449,51 @@ unsigned int get_hc_erase_grp_size(__u8 *ext_csd)
 	return ext_csd[224];
 }
 
+int set_partitioning_setting_completed(int dry_run, const char * const device,
+		int fd)
+{
+	int ret;
+
+	if (dry_run) {
+		fprintf(stderr, "NOT setting PARTITION_SETTING_COMPLETED\n");
+		fprintf(stderr, "These changes will not take effect neither "
+			"now nor after a power cycle\n");
+		return 1;
+	}
+
+	fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x1 to "
+			"EXT_CSD[%d] in %s\n",
+			EXT_CSD_PARTITION_SETTING_COMPLETED, device);
+		return 1;
+	}
+
+	__u32 response;
+	ret = send_status(fd, &response);
+	if (ret) {
+		fprintf(stderr, "Could not get response to SEND_STATUS "
+			"from %s\n", device);
+		return 1;
+	}
+
+	if (response & R1_SWITCH_ERROR) {
+		fprintf(stderr, "Setting OTP PARTITION_SETTING_COMPLETED "
+			"failed on %s\n", device);
+		return 1;
+	}
+
+	fprintf(stderr, "Setting OTP PARTITION_SETTING_COMPLETED on "
+		"%s SUCCESS\n", device);
+	fprintf(stderr, "Device power cycle needed for settings to "
+		"take effect.\n"
+		"Confirm that PARTITION_SETTING_COMPLETED bit is set "
+		"using 'extcsd read' after power cycle\n");
+
+	return 0;
+}
+
 int do_enh_area_set(int nargs, char **argv)
 {
 	__u8 value;
@@ -579,38 +624,10 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 
-	if (dry_run)
-	{
-		fprintf(stderr, "NOT setting PARTITION_SETTING_COMPLETED\n");
-		exit(1);
-	}
+	printf("Done setting ENH_USR area on %s\n", device);
 
-	fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
-	ret = write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1);
-	if (ret) {
-		fprintf(stderr, "Could not write 0x1 to "
-			"EXT_CSD[%d] in %s\n",
-			EXT_CSD_PARTITION_SETTING_COMPLETED, device);
+	if (!set_partitioning_setting_completed(dry_run, device, fd))
 		exit(1);
-	}
-
-	__u32 response;
-	ret = send_status(fd, &response);
-	if (ret) {
-		fprintf(stderr, "Could not get response to SEND_STATUS from %s\n", device);
-		exit(1);
-	}
-
-	if (response & R1_SWITCH_ERROR)
-	{
-		fprintf(stderr, "Setting ENH_USR area failed on %s\n", device);
-		exit(1);
-	}
-
-	fprintf(stderr, "Setting ENH_USR area on %s SUCCESS\n", device);
-	fprintf(stderr, "Device power cycle needed for settings to take effect.\n"
-		"Confirm that PARTITION_SETTING_COMPLETED bit is set using 'extcsd read'"
-		"after power cycle\n");
 
 	return 0;
 }
-- 
1.8.1.2


From: Philippe Reynes <philippe.reynes@sagemcom.com>
Subject: [RESEND][PATCH] Add a commande extcsd write <offset> <value> <device>
Date: Tue, 5 Sep 2017 14:28:58 +0200
Message-ID: <15d06e9d-0cf7-448d-88aa-2856a986b690@EXDRUEARSGC008.eq1sgc.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sgc-chev-fe1.sgc.gmessaging.net ([194.51.18.91]:50926 "EHLO
        sgc-chev-fe1.sgc.gmessaging.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751350AbdIEMgd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Sep 2017 08:36:33 -0400
Received: from sgc-chev-fe1.sgc.gmessaging.net (localhost.localdomain [127.0.0.1])
        by localhost.sgc.gmessaging.net (Postfix) with SMTP id 3xmmHG3nPzzqF3G
        for <linux-mmc@vger.kernel.org>; Tue,  5 Sep 2017 14:29:14 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: linux-mmc@vger.kernel.org, Philippe Reynes <philippe.reynes@sagemcom.com>

There was a command to read the extcsd and some command
to enable or configure feature, but not generic write in
the extcsd. Such generic write may be usefull for the
manufacturer registers.

Signed-off-by: Philippe Reynes <philippe.reynes@sagemcom.com>
---
 mmc.c      |    5 +++++
 mmc_cmds.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/mmc.c b/mmc.c
index 50c9c9e..de820eb 100644
--- a/mmc.c
+++ b/mmc.c
@@ -58,6 +58,11 @@ static struct Command commands[] = {
 		"Print extcsd data from <device>.",
 	  NULL
 	},
+	{ do_write_extcsd, -1,
+	  "extcsd write", "<offset> " "<value> " "<device>\n"
+		"Write <value> at offset <offset> to <device> extcsd.",
+	  NULL
+	},
 	{ do_writeprotect_boot_get, -1,
 	  "writeprotect boot get", "<device>\n"
 		"Print the boot partitions write protect status for <device>.",
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 6b86115..ba79ffe 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1750,6 +1750,36 @@ out_free:
 	return ret;
 }
 
+int do_write_extcsd(int nargs, char **argv)
+{
+	int fd, ret;
+	int offset, value;
+	char *device;
+
+	CHECK(nargs != 4, "Usage: mmc extcsd write <offset> <value> </path/to/mmcblkX>\n",
+			  exit(1));
+
+	offset = strtol(argv[1], NULL, 0);
+	value  = strtol(argv[2], NULL, 0);
+	device = argv[3];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, offset, value);
+	if (ret) {
+		fprintf(stderr,
+			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			value, offset, device);
+		exit(1);
+	}
+
+	return ret;
+}
+
 int do_sanitize(int nargs, char **argv)
 {
 	int fd, ret;
-- 
1.7.9.5


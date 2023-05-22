Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E561C77B75
	for <linux-mmc@archiver.kernel.org>; Mon, 22 May 2023 21:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjEVVxc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 17:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjEVVxb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 17:53:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFD1DB
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 14:53:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DT7-0001qn-2j; Mon, 22 May 2023 23:53:29 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DT5-0026B1-Kn; Mon, 22 May 2023 23:53:27 +0200
Received: from ejo by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ejo@pengutronix.de>)
        id 1q1DT5-008YMq-25; Mon, 22 May 2023 23:53:27 +0200
From:   Enrico Jorns <ejo@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, ejo@pengutronix.de
Subject: [PATCH 1/2] mmc-utils: introduce optional --verify argument for 'extcsd write'
Date:   Mon, 22 May 2023 23:53:09 +0200
Message-Id: <20230522215310.2038669-1-ejo@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ejo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Registers can be write-once but ioctl does not necessarily return with
an error. Thus it is a good idea to allow verifying the data written.

Signed-off-by: Enrico Jorns <ejo@pengutronix.de>
---
 mmc.c      |  7 ++++---
 mmc_cmds.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/mmc.c b/mmc.c
index 795b4e3..3f813b4 100644
--- a/mmc.c
+++ b/mmc.c
@@ -56,9 +56,10 @@ static struct Command commands[] = {
 		"Print extcsd data from <device>.",
 	  NULL
 	},
-	{ do_write_extcsd, 3,
-	  "extcsd write", "<offset> <value> <device>\n"
-		  "Write <value> at offset <offset> to <device>'s extcsd.",
+	{ do_write_extcsd, -3,
+	  "extcsd write", "<offset> <value> <device> [--verify]\n"
+		  "Write <value> at offset <offset> to <device>'s extcsd.\n"
+		  "  --verify  Verify data written",
 	  NULL
 	},
 	{ do_writeprotect_boot_get, -1,
diff --git a/mmc_cmds.c b/mmc_cmds.c
index df66986..154020e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1986,9 +1986,10 @@ int do_write_extcsd(int nargs, char **argv)
 	int fd, ret;
 	int offset, value;
 	char *device;
+	int verify = 0;
 
-	if (nargs != 4) {
-		fprintf(stderr, "Usage: mmc extcsd write <offset> <value> </path/to/mmcblkX>\n");
+	if (nargs != 4 && nargs != 5) {
+		fprintf(stderr, "Usage: mmc extcsd write <offset> <value> </path/to/mmcblkX> [--verify]\n");
 		exit(1);
 	}
 
@@ -1996,6 +1997,14 @@ int do_write_extcsd(int nargs, char **argv)
 	value  = strtol(argv[2], NULL, 0);
 	device = argv[3];
 
+	if (nargs == 5) {
+		if (strcmp(argv[4], "--verify") == 0) {
+			verify = 1;
+		} else {
+			fprintf(stderr, "Unknown argument: '%s'\n", argv[4]);
+		}
+	}
+
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
 		perror("open");
@@ -2010,6 +2019,21 @@ int do_write_extcsd(int nargs, char **argv)
 		exit(1);
 	}
 
+	if (verify) {
+		__u8 ext_csd[512];
+
+		ret = read_extcsd(fd, ext_csd);
+		if (ret) {
+			fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+			exit(1);
+		}
+
+		if (ext_csd[offset] != value) {
+			fprintf(stderr, "Verification failed: expected 0x%x, got 0x%x\n", value, ext_csd[offset]);
+			exit(1);
+		}
+	}
+
 	return ret;
 }
 
-- 
2.39.2


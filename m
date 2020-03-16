Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7606C0044D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 20:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9977D205ED
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 20:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BAoJwoZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgCPUWe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:22:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46374 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbgCPUWd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 16:22:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id c19so10566835pfo.13
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2020 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5S3YmyPyNaRJ47XoluhO142q/Y4TYJjQ5nqsLmdGLc=;
        b=BAoJwoZuSFMwPiikZ9xvLuv9IBK/WXzKZlBaKy1xSk80ZnAsYJtHFq4NPQ7AfWlopP
         XYt8GgEkq5FahVwoROCQEi458eyr8Bc7H9glSLlnEXOU1N9ZRJYJRhYPY4E9SdAe67Lo
         QcT1KTzhbpVtIEFMmmQW6PeTApa6kcK9SIt2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5S3YmyPyNaRJ47XoluhO142q/Y4TYJjQ5nqsLmdGLc=;
        b=uZWNViprlIzWO+pixe5MEhzCRE1xuhzERPMSCYangi7HRZ2XlNkMGb2YWI6/zZwXtK
         eKB8G6r0lb+uWGg7V4qS/6GIV7teo/V12YvrAx3lociLAROMSsJFfDTTUjcWwPrWYV0m
         uIu58TP5q5wNx1UWtgq6Nt5zde24kLhNZM5+0Y5OEyTjJ4UFr5IvFhwTD8FL75jLxfca
         p1f+Q9NFJdkBWVh/JPerwZ+uUwlrEcOc5ClKowxWvA8fbvCx/QE6j5lpT6+731U9BKHA
         m650c+Uu7l4HXAWXcd9PDZClY2L4WbQ1FZ5ccUkYSE/ZVesnBFb6ikPEGdCoI8Yg1Ynh
         ycSA==
X-Gm-Message-State: ANhLgQ3hUcTyGiblHyRnHQGZkBH9PxC5dYsgZ7HWmRNZIZboeiKrvXW0
        h5iDmn3RmblUNjBL2OLPUparoQ==
X-Google-Smtp-Source: ADFU+vt6v8gFWItRTr4T3QqIvii8cSXiahWiKsgKO8GiSmwyglJD+WLhaMYlNEBwvKZJrAHFgUE7rA==
X-Received: by 2002:a62:1b12:: with SMTP id b18mr1436129pfb.258.1584390152605;
        Mon, 16 Mar 2020 13:22:32 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:6a:3f83:ada3:6a0f])
        by smtp.gmail.com with ESMTPSA id c190sm709518pfa.66.2020.03.16.13.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 13:22:31 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Chris Ball <chris@printf.net>
Cc:     linux-mmc@vger.kernel.org, gwendal@chromium.org,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH] mmc-utils: Expand 'writeprotect boot'
Date:   Mon, 16 Mar 2020 13:22:21 -0700
Message-Id: <20200316202221.107714-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch updates 'mmc writeprotect boot set' with a few more optional
parameters, so that it can be used to enable permanent write-protection
and so that the two boot partitions can be protected independently. It
also splits protection information output by 'mmc writeprotect boot get'
by partition.

(Note: eMMC boot partitions are named "Area 1" and "Area 2" by the eMMC
spec, but mmcblk0boot0 and mmcblk0boot1 by Linux. To avoid confusion
between the two numbering schemes, this patch uses 0 and 1 throughout,
even when defining EXT_CSD register bits.)

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 mmc.c      | 17 ++++++++++---
 mmc.h      | 11 ++++++++
 mmc_cmds.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/mmc.c b/mmc.c
index 50c9c9e..9e46072 100644
--- a/mmc.c
+++ b/mmc.c
@@ -64,9 +64,20 @@ static struct Command commands[] = {
 	  NULL
 	},
 	{ do_writeprotect_boot_set, -1,
-	  "writeprotect boot set", "<device>\n"
-		"Set the boot partitions write protect status for <device>.\nThis sets the eMMC boot partitions to be write-protected until\nthe next boot.",
-	  NULL
+	  "writeprotect boot set",
+#ifdef DANGEROUS_COMMANDS_ENABLED
+		"[-p] "
+#endif /* DANGEROUS_COMMANDS_ENABLED */
+		"<device> [<number>]\n"
+		"Set the boot partition write protect status for <device>.\n"
+		"If <number> is passed (0 or 1), only protect that particular\n"
+		"eMMC boot partition, otherwise protect both. It will be\n"
+		"write-protected until the next boot.\n"
+#ifdef DANGEROUS_COMMANDS_ENABLED
+		"  -p  Protect partition permanently instead.\n"
+		"      NOTE! -p is a one-time programmable (unreversible) change.\n"
+#endif /* DANGEROUS_COMMANDS_ENABLED */
+	  , NULL
 	},
 	{ do_writeprotect_user_set, -4,
 	  "writeprotect user set", "<type>" "<start block>" "<blocks>" "<device>\n"
diff --git a/mmc.h b/mmc.h
index 648fb26..e3cb621 100644
--- a/mmc.h
+++ b/mmc.h
@@ -74,6 +74,7 @@
 #define EXT_CSD_PART_CONFIG		179
 #define EXT_CSD_BOOT_BUS_CONDITIONS	177
 #define EXT_CSD_ERASE_GROUP_DEF		175
+#define EXT_CSD_BOOT_WP_STATUS		174
 #define EXT_CSD_BOOT_WP			173
 #define EXT_CSD_USER_WP			171
 #define EXT_CSD_FW_CONFIG		169	/* R/W */
@@ -143,9 +144,19 @@
 #define EXT_CSD_HPI_SUPP		(1<<0)
 #define EXT_CSD_HPI_IMPL		(1<<1)
 #define EXT_CSD_CMD_SET_NORMAL		(1<<0)
+/* NOTE: The eMMC spec calls the partitions "Area 1" and "Area 2", but Linux
+ * calls them mmcblk0boot0 and mmcblk0boot1. To avoid confustion between the two
+ * numbering schemes, this tool uses 0 and 1 throughout. */
+#define EXT_CSD_BOOT_WP_S_AREA_1_PERM	(0x08)
+#define EXT_CSD_BOOT_WP_S_AREA_1_PWR	(0x04)
+#define EXT_CSD_BOOT_WP_S_AREA_0_PERM	(0x02)
+#define EXT_CSD_BOOT_WP_S_AREA_0_PWR	(0x01)
+#define EXT_CSD_BOOT_WP_B_SEC_WP_SEL	(0x80)
 #define EXT_CSD_BOOT_WP_B_PWR_WP_DIS	(0x40)
 #define EXT_CSD_BOOT_WP_B_PERM_WP_DIS	(0x10)
+#define EXT_CSD_BOOT_WP_B_PERM_WP_SEC_SEL (0x08)
 #define EXT_CSD_BOOT_WP_B_PERM_WP_EN	(0x04)
+#define EXT_CSD_BOOT_WP_B_PWR_WP_SEC_SEL (0x02)
 #define EXT_CSD_BOOT_WP_B_PWR_WP_EN	(0x01)
 #define EXT_CSD_BOOT_INFO_HS_MODE	(1<<2)
 #define EXT_CSD_BOOT_INFO_DDR_DDR	(1<<1)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..c230127 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -202,11 +202,19 @@ static void print_writeprotect_boot_status(__u8 *ext_csd)
 		else
 			printf("possible\n");
 
-		printf(" ro lock status: ");
-		if (reg & EXT_CSD_BOOT_WP_B_PWR_WP_EN)
+		reg = ext_csd[EXT_CSD_BOOT_WP_STATUS];
+		printf(" partition 0 ro lock status: ");
+		if (reg & EXT_CSD_BOOT_WP_S_AREA_0_PERM)
+			printf("locked permanently\n");
+		else if (reg & EXT_CSD_BOOT_WP_S_AREA_0_PWR)
 			printf("locked until next power on\n");
-		else if (reg & EXT_CSD_BOOT_WP_B_PERM_WP_EN)
+		else
+			printf("not locked\n");
+		printf(" partition 1 ro lock status: ");
+		if (reg & EXT_CSD_BOOT_WP_S_AREA_1_PERM)
 			printf("locked permanently\n");
+		else if (reg & EXT_CSD_BOOT_WP_S_AREA_1_PWR)
+			printf("locked until next power on\n");
 		else
 			printf("not locked\n");
 	}
@@ -260,13 +268,28 @@ int do_writeprotect_boot_set(int nargs, char **argv)
 	__u8 ext_csd[512], value;
 	int fd, ret;
 	char *device;
+	char *end;
+	int argi = 1;
+	int permanent = 0;
+	int partition = -1;
 
-	if (nargs != 2) {
-		fprintf(stderr, "Usage: mmc writeprotect boot set </path/to/mmcblkX>\n");
+#ifdef DANGEROUS_COMMANDS_ENABLED
+	if (!strcmp(argv[argi], "-p")){
+		permanent = 1;
+		argi++;
+	}
+#endif
+
+	if (nargs < 1 + argi ||  nargs > 2 + argi) {
+		fprintf(stderr, "Usage: mmc writeprotect boot set "
+#ifdef DANGEROUS_COMMANDS_ENABLED
+			"[-p] "
+#endif
+			"</path/to/mmcblkX> [0|1]\n");
 		exit(1);
 	}
 
-	device = argv[1];
+	device = argv[argi++];
 
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
@@ -274,14 +297,49 @@ int do_writeprotect_boot_set(int nargs, char **argv)
 		exit(1);
 	}
 
+	if (nargs == 1 + argi) {
+		partition = strtoul(argv[argi], &end, 0);
+		if (*end != '\0' || !(partition == 0 || partition == 1)) {
+			fprintf(stderr, "Invalid partition number (must be 0 or 1): %s\n",
+				argv[argi]);
+			exit(1);
+		}
+	}
+
 	ret = read_extcsd(fd, ext_csd);
 	if (ret) {
 		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
 		exit(1);
 	}
 
-	value = ext_csd[EXT_CSD_BOOT_WP] |
-		EXT_CSD_BOOT_WP_B_PWR_WP_EN;
+	value = ext_csd[EXT_CSD_BOOT_WP];
+	/*
+	 * If permanent protection is already on for one partition and we're
+	 * trying to enable power-reset protection for the other we need to make
+	 * sure the selection bit for permanent protection still points to the
+	 * former or we'll accidentally permanently protect the latter.
+	 */
+	if ((value & EXT_CSD_BOOT_WP_B_PERM_WP_EN) && !permanent) {
+		if (ext_csd[EXT_CSD_BOOT_WP_STATUS] &
+		    EXT_CSD_BOOT_WP_S_AREA_1_PERM) {
+			value |= EXT_CSD_BOOT_WP_B_PERM_WP_SEC_SEL;
+			if (partition != 1)
+				partition = 0;
+		} else {
+			/* PERM_WP_SEC_SEL cleared -> pointing to partition 0 */
+			if (partition != 0)
+				partition = 1;
+		}
+	}
+	if (partition != -1) {
+		value |= EXT_CSD_BOOT_WP_B_SEC_WP_SEL;
+		if (partition == 1)
+			value |= permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_SEC_SEL
+					   : EXT_CSD_BOOT_WP_B_PWR_WP_SEC_SEL;
+	}
+	value |= permanent ? EXT_CSD_BOOT_WP_B_PERM_WP_EN
+			   : EXT_CSD_BOOT_WP_B_PWR_WP_EN;
+
 	ret = write_extcsd_value(fd, EXT_CSD_BOOT_WP, value);
 	if (ret) {
 		fprintf(stderr, "Could not write 0x%02x to "
-- 
2.24.1


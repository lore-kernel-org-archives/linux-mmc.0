Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB383C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AB161A0E
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 16:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbhCXQp7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhCXQpa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 12:45:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AEDC061763;
        Wed, 24 Mar 2021 09:45:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x21so28405152eds.4;
        Wed, 24 Mar 2021 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25OUVuiTG0J8rQw9wxGkkZPwxHQF7p/PB2qLPPS2uA0=;
        b=uh8soqsM4U9j8UWk8aKLYbdf17naDaGvGL62awRPI8EpbFXriK6ien98AVks5DF5sl
         1Fg3fnAevnp+/SLJg6OsLKEpYtmwKhktgrfkDkxAyYdZ0pjvFAvtERhrC03U/YwGWbfO
         kMmKDuKpbxA+SGJuL2PnsoFe2k9l3iU1/OqmEgrX+WW8HltwEEtZH8Wbkdr2FUm1PuHb
         jh9Sk5Bz967c/ag7sTd8ey7hduNJUn8HB++uQ2361oKUyt8SiBp+DnuDUk3anVxbAVz4
         MfnbTkc4OxhFFgnpHAnkQv70qNlngTl/pWm8yJCIgtIrOjzzWv4Si2I0KTVOkq1YrDk2
         HBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25OUVuiTG0J8rQw9wxGkkZPwxHQF7p/PB2qLPPS2uA0=;
        b=DMQ6ONDfXoPwE9CGceRh+Yfof2Lbi19O5bHXSQ21td/iucMKYD3Zd10L3p1wU2m3L0
         YS1yH0S2R1FlSIEXqcdO6PZdyy8P4dtoxrDOZIWbiA1VFnuGGpkAv1sh1C355uj4chrV
         9YQBx05iV5+NOVZlHOgCMXYxBaXXyIMk34zQs3deHsp+0AL7UcAzZhum+iOZW3x+wgbw
         437t/eFyb2CznBGEbV87KXAXgaQmLdNN/RNoduf3FvSNtnu1/UAZMPTPogcJjHVqpXR0
         80lQMpY7VEVDuxLa95JzcZ8+qWbZjal+IrJf1i7qHAxLp7kkijvWVZ79C2gXvN2w8Sro
         f2Ew==
X-Gm-Message-State: AOAM532ma+mLtNvTYMyGbUnJ2iF6U3ScZOX1jdUjfTKQ8fxsZ8iRSUdM
        BIP6o5wbxGDx5um79OcRc7s=
X-Google-Smtp-Source: ABdhPJzvaRNDn9n6WOzSdQSobTj9liGJlJTQVQkrmQSOXukA1ZrZNg4oCTgvbhZC6ZXmPzOUURVVaA==
X-Received: by 2002:a05:6402:1545:: with SMTP id p5mr4356696edx.155.1616604328510;
        Wed, 24 Mar 2021 09:45:28 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.gmail.com with ESMTPSA id r19sm1206759ejr.55.2021.03.24.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 09:45:28 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     beanhuo@micron.com, kenny.gibbons@oracle.com,
        kimito.sakata@oracle.com, rkamdar@micron.com, chris@printf.net,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc-utils: Add eMMC erase command support
Date:   Wed, 24 Mar 2021 17:44:08 +0100
Message-Id: <20210324164408.14722-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Kimito Sakata <kimito.sakata@oracle.com>

we have been using this erase feature for a while, but it is
still not merged into the upstream mmc-utils. Especially, for
the customer, every time when they update the mmc-utils, they
should re-install this patch again, let's try to make this
erase command upstreamed in the mmc-utils.

Co-developed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
---

Hi Ulf,
Please help us review this mmc-utils patch, and if agree, it is
possible to make it merged in the official mmc-utils.

Changelog:

V1--V2:
    1. refactor Kimito's original patch
    2. change to use MMC_IOC_MULTI_CMD
    3. add checkup if eMMC devie supports secure erase/trim

---
 mmc.c      |   8 ++++
 mmc.h      |  13 +++++-
 mmc_cmds.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/mmc.c b/mmc.c
index 50c9c9e..cb29a65 100644
--- a/mmc.c
+++ b/mmc.c
@@ -215,6 +215,14 @@ static struct Command commands[] = {
 		"Run Field Firmware Update with <image name> on <device>.\n",
 	  NULL
 	},
+	{ do_erase, -4,
+	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
+		"Send Erase CMD38 with specific argument to the <device>\n\n"
+		"NOTE!: This will delete all user data in the specified region of the device\n"
+		"<type> must be: legacy | discard | secure-erase | "
+		"secure-trim1 | secure-trim2 | trim \n",
+	NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 648fb26..90b7fb5 100644
--- a/mmc.h
+++ b/mmc.h
@@ -34,7 +34,15 @@
 #define MMC_SET_WRITE_PROT	28    /* ac   [31:0] data addr   R1b */
 #define MMC_CLEAR_WRITE_PROT	29    /* ac   [31:0] data addr   R1b */
 #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
-
+#define MMC_ERASE_GROUP_START	35    /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE_GROUP_END	36    /* ac   [31:0] data addr   R1  */
+#define MMC_ERASE		38    /* ac   [31] Secure request
+					      [30:16] set to 0
+					      [15] Force Garbage Collect request
+					      [14:2] set to 0
+					      [1] Discard Enable
+					      [0] Identify Write Blocks for
+					      Erase (or TRIM Enable)  R1b */
 /*
  * EXT_CSD fields
  */
@@ -61,6 +69,7 @@
 #define EXT_CSD_CACHE_SIZE_2		251
 #define EXT_CSD_CACHE_SIZE_1		250
 #define EXT_CSD_CACHE_SIZE_0		249
+#define EXT_CSD_SEC_FEATURE_SUPPORT	231
 #define EXT_CSD_BOOT_INFO		228	/* R/W */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224
 #define EXT_CSD_HC_WP_GRP_SIZE		221
@@ -177,6 +186,8 @@
 #define EXT_CSD_REV_V4_2		2
 #define EXT_CSD_REV_V4_1		1
 #define EXT_CSD_REV_V4_0		0
+#define EXT_CSD_SEC_GB_CL_EN		(1<<4)
+#define EXT_CSD_SEC_ER_EN		(1<<0)
 
 
 /* From kernel linux/mmc/core.h */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..17986e3 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2435,6 +2435,141 @@ int do_cache_dis(int nargs, char **argv)
 	return do_cache_ctrl(0, nargs, argv);
 }
 
+static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
+{
+#ifndef MMC_IOC_MULTI_CMD
+	fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
+			" support, needed by erase.\n");
+	return -ENOTSUP;
+#else
+	int ret = 0;
+	struct mmc_ioc_multi_cmd *multi_cmd;
+
+	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
+			   3 * sizeof(struct mmc_ioc_cmd));
+	if (!multi_cmd) {
+		perror("Failed to allocate memory");
+		return -ENOMEM;
+	}
+
+	multi_cmd->num_of_cmds = 3;
+	/* Set erase start address */
+	multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
+	multi_cmd->cmds[0].arg = start;
+	multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	multi_cmd->cmds[0].write_flag = 1;
+
+	/* Set erase end address */
+	multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
+	multi_cmd->cmds[1].arg = end;
+	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	multi_cmd->cmds[1].write_flag = 1;
+
+	/* Send Erase Command */
+	multi_cmd->cmds[2].opcode = MMC_ERASE;
+	multi_cmd->cmds[2].arg = argin;
+	multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
+	multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	multi_cmd->cmds[2].write_flag = 1;
+
+	/* send erase cmd with multi-cmd */
+	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+	if (ret)
+		perror("Erase multi-cmd ioctl");
+
+	free(multi_cmd);
+	return ret;
+#endif
+}
+
+int do_erase(int nargs, char **argv)
+{
+	int dev_fd, ret;
+	char *print_str;
+	char **eptr = NULL;
+	__u8 ext_csd[512], checkup_mask = 0;
+	__u32 arg, start, end;
+
+	if (nargs != 5) {
+		fprintf(stderr, "Usage: erase <type> <start addr> <end addr> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
+		start = strtol(argv[2], eptr, 16);
+	else
+		start = strtol(argv[2], eptr, 10);
+
+	if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
+		end = strtol(argv[3], eptr, 16);
+	else
+		end = strtol(argv[3], eptr, 10);
+
+	if (end < start) {
+		fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x]\n",
+			start, end);
+		exit(1);
+	}
+
+	if (strcmp(argv[1], "legacy") == 0) {
+		arg = 0x00000000;
+		print_str = "Legacy Erase";
+	} else if (strcmp(argv[1], "discard") == 0) {
+		arg = 0x00000003;
+		print_str = "Discard";
+	} else if (strcmp(argv[1], "secure-erase") == 0) {
+		print_str = "Secure Erase";
+		checkup_mask = EXT_CSD_SEC_ER_EN;
+		arg = 0x80000000;
+	} else if (strcmp(argv[1], "secure-trim1") == 0) {
+		print_str = "Secure Trim Step 1";
+		checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
+		arg = 0x80000001;
+	} else if (strcmp(argv[1], "secure-trim2") == 0) {
+		print_str = "Secure Trim Step 2";
+		checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
+		arg = 0x80008000;
+	} else if (strcmp(argv[1], "trim") == 0) {
+		print_str = "Trim";
+		checkup_mask = EXT_CSD_SEC_GB_CL_EN;
+		arg = 0x00000001;
+	} else {
+		fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
+		exit(1);
+	}
+
+	dev_fd = open(argv[4], O_RDWR);
+	if (dev_fd < 0) {
+		perror(argv[4]);
+		exit(1);
+	}
+
+	if (checkup_mask) {
+		ret = read_extcsd(dev_fd, ext_csd);
+		if (ret) {
+			fprintf(stderr, "Could not read EXT_CSD from %s\n",
+				argv[4]);
+			goto out;
+		}
+		if ((checkup_mask & ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
+								checkup_mask) {
+			fprintf(stderr, "%s is not supported in %s\n",
+				print_str, argv[4]);
+			ret = -ENOTSUP;
+			goto out;
+		}
+
+	}
+	printf("Executing %s from 0x%08x to 0x%08x\n", print_str, start, end);
+
+	ret = erase(dev_fd, arg, start, end);
+out:
+	printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
+	close(dev_fd);
+	return ret;
+}
+
+
 int do_ffu(int nargs, char **argv)
 {
 #ifndef MMC_IOC_MULTI_CMD
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 9d3246c..8331ab2 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
+int do_erase(int nargs, char **argv);
-- 
2.25.1


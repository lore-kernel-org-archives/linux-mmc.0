Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFA7C433ED
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 23:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DDD610FA
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 23:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhDAXC3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhDAXCZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2021 19:02:25 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000EC0613E6;
        Thu,  1 Apr 2021 16:02:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e186so3768437iof.7;
        Thu, 01 Apr 2021 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v50fLl6MCjS2xgLg5cVnj3QCuPg+VJB5XEPbilVJjdU=;
        b=dq1d2J6fdcaqfU0wkxY2UodlioVzl7Z723QzVJzjid662XtjBMKj/LWaJ0FonJQl5+
         GMz69KRjATtSDEatp+kZzR63M82fR4MLlgXyG7Vmyu0eEwFS9BEeqPJNMJakfWhyqJOF
         ag/EhYd4HlPwM93cjVo+04hpyaR2EY3Moh3+vKU8OjR9Uuy8xxAaoAztKWDD0QRPJDUT
         oskqELCrmXoffRxpqJQD4zyfmWRihiqKVg8QlOo0pRXS5EiuSpDeuoq4M8mquIAmyxFK
         hsIro97abxQpp3ELjSd8EItyxOnT1/UkZDqTBL0i6WUkjRUy5snYYq3gmiJS8FYRa75+
         OGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v50fLl6MCjS2xgLg5cVnj3QCuPg+VJB5XEPbilVJjdU=;
        b=kRzZ2tGMEjaxdukz0IMoPRg/fq5tZB9Q+aKmIQCxgSZRrrTnsR/An46ny6B1XAoMUk
         rOqnMcy9axAoRFpVWxPspt369gSKQ1tBXWEK6yHIHdDC9AQFF7R9AExf5gKwGU+7PBlt
         5U4dAd4/dMy+uU6pDRuZnZgbooIdcNqFTtxSCco05A5JlbL3PNZhGLeOA4tvy3QdhwQ9
         ZMtw0JAxfl5rmpWeAaVvhPvBuj+DUcSk6G2z3w8kKwVN9ACJilOp8GCYwP9SLw84hf8A
         S58tF+engY9+M2gMdjiyoxvhXphX6q7qTDekadhK5JjIte7VqRkxRD5m1xHJg3Asjxnb
         HNmg==
X-Gm-Message-State: AOAM532RO/A+wukfHfNGvMQFsHzz/4A0XqH2zGf8MSGaWDjl2qI9KrD2
        I46R5uEnQNbhlHUmVDza/DY=
X-Google-Smtp-Source: ABdhPJzmXn5tktD+j64uPtuP6kxiCi7QAwu0af7dGRrmXe6Mfd/x9dbJouXcDcPdml2C/i62a1GIpA==
X-Received: by 2002:a5e:a515:: with SMTP id 21mr8627156iog.164.1617318143187;
        Thu, 01 Apr 2021 16:02:23 -0700 (PDT)
Received: from Kimitos-MBP.hsd1.co.comcast.net ([2601:285:8380:2960::46a0])
        by smtp.gmail.com with ESMTPSA id b9sm3366985ioz.49.2021.04.01.16.02.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 16:02:22 -0700 (PDT)
From:   luserhker@gmail.com
To:     beanhuo@micron.com, kenny.gibbons@oracle.com,
        kimito.sakata@oracle.com, rkamdar@micron.com, chris@printf.net,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
Subject: [PATCH v3] Re-submit of the erase command addition plus removal of MMC_IOC_MULTI_CMD ifndef for erase. Author=Kimito Sakata <kimito.sakata@oracle.com>
Date:   Thu,  1 Apr 2021 17:02:21 -0600
Message-Id: <20210401230221.12532-1-luserhker@gmail.com>
X-Mailer: git-send-email 2.24.1 (Apple Git-126)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Kimito Sakata <kimito.sakata@oracle.com>

Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
---
 mmc.c      |   8 ++++
 mmc.h      |  13 +++++-
 mmc_cmds.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/mmc.c b/mmc.c
index f3d724b..eb2638b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -229,6 +229,14 @@ static struct Command commands[] = {
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
index 5754a9d..e9766d7 100644
--- a/mmc.h
+++ b/mmc.h
@@ -35,7 +35,15 @@
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
@@ -62,6 +70,7 @@
 #define EXT_CSD_CACHE_SIZE_2		251
 #define EXT_CSD_CACHE_SIZE_1		250
 #define EXT_CSD_CACHE_SIZE_0		249
+#define EXT_CSD_SEC_FEATURE_SUPPORT	231
 #define EXT_CSD_BOOT_INFO		228	/* R/W */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224
 #define EXT_CSD_HC_WP_GRP_SIZE		221
@@ -190,6 +199,8 @@
 #define EXT_CSD_REV_V4_2		2
 #define EXT_CSD_REV_V4_1		1
 #define EXT_CSD_REV_V4_0		0
+#define EXT_CSD_SEC_GB_CL_EN		(1<<4)
+#define EXT_CSD_SEC_ER_EN		(1<<0)
 
 
 /* From kernel linux/mmc/core.h */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 6c24cea..3e36ff2 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2514,6 +2514,135 @@ int do_cache_dis(int nargs, char **argv)
 	return do_cache_ctrl(0, nargs, argv);
 }
 
+static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
+{
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
2.24.1 (Apple Git-126)


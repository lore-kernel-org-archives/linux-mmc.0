Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B50C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 19:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6999F613B5
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 19:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhEFTLm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhEFTLm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 15:11:42 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31206C061574;
        Thu,  6 May 2021 12:10:44 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j12so5688004ils.4;
        Thu, 06 May 2021 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z2zhxlRJo09b+3nYsUPOPPvMonv9Z+WrzWTt/6DJnLk=;
        b=cKTKMgsg67IWOA2ljXN0JZIakSAh5cI9Ss0nqWPysT43G0Kn+VsaUOItU7S+a83kT5
         J0psrQIggTbv5ASjt6oChR7wQh457Qa27oo7ZzNbFcjc56/dARKPzLJ3LbomAsOqVY7i
         Jyoxa8+EEZjDop5Y5qIxJ1Oceo0pqd/P5kM5Tz5xRyPOD7KOjc1cA3sZB5FZgQrXIjm0
         2Z1SkGwsAP/EDXPZ/9cdK2f9RBaFBt05CkhSRHjhb0TEdcLEUS1jlRQl0Z46OyEGAGmH
         QOEORkRVCmGlkfDx20y9IMIqdlVGRw444zLZzBfXsAgnE7u2ABtibH4HmiXQTMB815Qs
         llHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z2zhxlRJo09b+3nYsUPOPPvMonv9Z+WrzWTt/6DJnLk=;
        b=e6oO51fkXZDgCAdVI3yYI9ZpCa2uRt6r+H4uSFr0AcSI8GMVIMjk7WFs6Ob6i8UmTO
         6ikHR5UH025fyocPnS3ugUvNlD8iUUv3VhKAp4i294GC76FKyeB/9PEtz9FYmF/OrwdB
         +f15mx3CSWWEqPAudjnK/VfENJt1d1H8IFj/3PDTF7qZ7seNJhxLFU0FVQYz4JpJdvXs
         9xuyBnM4vL1OBkMSLUZ00TRBL6hs5AtUPGQe5Q/oSdJCBu2QsAyl1Sc3mUFiv+/SWlOS
         qmed2lFMdeB7YTXTLG6MoAH4ZFmYVMOEZbZzDO/YGueUFVXZqgigubHB3UQnMNdCDOWT
         0AkA==
X-Gm-Message-State: AOAM532LmtTLSxsMFdtVcPBJ2nrulWhm0QoI88ULQzVpdGilrj3bMb+N
        ftXvcGk9H1n+S5I0qT/p/M8=
X-Google-Smtp-Source: ABdhPJwqKzVMZDftiPdsl0hYS0GzwC+VF0w7y+Tb2D9hsWZR3ogDpBh3CBS++2COSbIHtyJo/WoTvA==
X-Received: by 2002:a92:c5a5:: with SMTP id r5mr5984102ilt.122.1620328243656;
        Thu, 06 May 2021 12:10:43 -0700 (PDT)
Received: from KSAKATA-T470.us.oracle.com (c-73-243-79-162.hsd1.co.comcast.net. [73.243.79.162])
        by smtp.gmail.com with ESMTPSA id e12sm1644597ilu.75.2021.05.06.12.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 12:10:43 -0700 (PDT)
From:   oracleks043021@gmail.com
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kimito Sakata <kimito.sakata@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Kenneth Gibbons <kenny.gibbons@oracle.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4] mmc-utils: Add eMMC erase command support
Date:   Thu,  6 May 2021 13:10:41 -0600
Message-Id: <20210506191041.1178-1-oracleks043021@gmail.com>
X-Mailer: git-send-email 2.31.1
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

We need to send 3 MMC commands and it is important that they
stay in sequence. Therefore we are using MMC_IOC_MULTI_CMD.

Co-developed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Changelog:
v3--v4:
    1. Replace unused pointer var with NULL.
    2. Added msg if ERASE_GROUP_DEF enabled for HC.
v2--v3:
    1. Remove redundant ifndef

V1--V2:
    1. refactor Kimito's original patch
    2. change to use MMC_IOC_MULTI_CMD
    3. add checkup if eMMC devie supports secure erase/trim
---
 mmc.c      |   8 +++
 mmc.h      |  13 ++++-
 mmc_cmds.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 165 insertions(+), 1 deletion(-)

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
index 6c24cea..afa85b7 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2514,6 +2514,150 @@ int do_cache_dis(int nargs, char **argv)
 	return do_cache_ctrl(0, nargs, argv);
 }
 
+static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
+{
+	int ret = 0;
+	struct mmc_ioc_multi_cmd *multi_cmd;
+	__u8 ext_csd[512];
+
+
+	ret = read_extcsd(dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD\n");
+		exit(1);
+	}
+	if (ext_csd[EXT_CSD_ERASE_GROUP_DEF] & 0x01) {
+	  fprintf(stderr, "High Capacity Erase Unit Size=%d bytes\n" \
+                          "High Capacity Erase Timeout=%d ms\n" \
+                          "High Capacity Write Protect Group Size=%d bytes\n",
+		           ext_csd[224]*0x80000,
+		           ext_csd[223]*300,
+                           ext_csd[221]*ext_csd[224]*0x80000);
+	}
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
+	__u8 ext_csd[512], checkup_mask = 0;
+	__u32 arg, start, end;
+
+	if (nargs != 5) {
+		fprintf(stderr, "Usage: erase <type> <start addr> <end addr> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
+		start = strtol(argv[2], NULL, 16);
+	else
+		start = strtol(argv[2], NULL, 10);
+
+	if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
+		end = strtol(argv[3], NULL, 16);
+	else
+		end = strtol(argv[3], NULL, 10);
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
2.31.1


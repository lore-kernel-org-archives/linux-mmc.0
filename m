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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5428CC433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271D261405
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhDVQNf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhDVQNe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2021 12:13:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B64DC06174A;
        Thu, 22 Apr 2021 09:12:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s16so40824163iog.9;
        Thu, 22 Apr 2021 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ci+bG/URHd1DEHzthT2LxhFOocTaKT1ulgtCKpVjbss=;
        b=IuaTEHfNbidSGe5mas+1NsWiWLZ4YFXCkagrSyGmO8JDzOCYHgq0XsDvnnUtXQWLmK
         4KgejjaskGWLLUryLAEFJjT5cZLnzPZLZKy5nBbFFVpk6Jh4Mn6ntnIg5yX3JCzdlij7
         DkBxPstjHE53+Rb7KqR0+7NupY5luIp8RrW3FxskXK4MPI/ndAiartkrSxU6ANeRlJRY
         ILltc7MkqAzgRo1xMcEoP1oVm0/IlI988paDL/OAoqVc1TEESklyyGNqTMFskEwzwYP/
         Yj1T4Wox2IDkz1OhltE5k5Qa4U53yVliTleqQLn5DBYB+hnaCXFQVqQQ9QV8UTb2N6T9
         ikyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ci+bG/URHd1DEHzthT2LxhFOocTaKT1ulgtCKpVjbss=;
        b=M/jjhDNLYQPf66P2T4wWaZG5kwIYcrW0lXFG3sxCo2OGpINu4Q9h+M6+7ZEX87Yywc
         g8w6yt6B8F5zn2Dz4oRKhVjMkjWFWMReXt6CbLPAg2a89AZzmlQ8bIvqmyLP0HTwzExT
         tH86epnPKgcqvpyEMRXlK3kZeotR38PA6VjluTYaU0Liew7wq02GFGGwpc6AEYAjA35p
         pdvBMw7x5dtjqvy3h2ohTEQ/vFUgETQ3Jpyt20KATRi/mAg3EDfmy8QGza/O0OqD2B0w
         y3bQIfEqv9wQDVEKaMbGZxEDKeiM7B3xxcPHZa3+ANTeFIbT2BP/5z5WuQP8D+XKypDH
         MP0g==
X-Gm-Message-State: AOAM533R01mZ2Wd8mRopNGzo9ez/DhMlcxD6UGGfzCx+YX9HcmGbodqa
        ePwD6dxZU3l32wpHBMVOWDA=
X-Google-Smtp-Source: ABdhPJz68Vfbji+GRC2lnt05t2oBNyU7ReXZN2ufAO1CC9XOR4k99OA+nfSoOyikjK0P7z9keabSSA==
X-Received: by 2002:a05:6638:3809:: with SMTP id i9mr3841322jav.24.1619107978856;
        Thu, 22 Apr 2021 09:12:58 -0700 (PDT)
Received: from Kimitos-MBP.hsd1.co.comcast.net ([2601:285:8380:2960::46a0])
        by smtp.gmail.com with ESMTPSA id f8sm1319357ilr.20.2021.04.22.09.12.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Apr 2021 09:12:58 -0700 (PDT)
From:   luserhker@gmail.com
To:     beanhuo@micron.com, kenny.gibbons@oracle.com,
        kimito.sakata@oracle.com, rkamdar@micron.com, chris@printf.net,
        ulf.hansson@linaro.org, avri.altman@wdc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>
Subject: [PATCH RESEND v3] mmc-utils: Re-submit of the erase command addition plus remval of MMC_IOC_MULTI_CMD ifndef for erase. Re-committing the change per request by Avir.
Date:   Thu, 22 Apr 2021 10:12:55 -0600
Message-Id: <20210422161255.4610-1-luserhker@gmail.com>
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
 mmc_cmds.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 156 insertions(+), 1 deletion(-)

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
index 6c24cea..9340e3f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2514,6 +2514,141 @@ int do_cache_dis(int nargs, char **argv)
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
2.24.1 (Apple Git-126)


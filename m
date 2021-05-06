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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791EAC433ED
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 03:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D40F610F7
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 03:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhEFDar (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 May 2021 23:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhEFDaq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2021 23:30:46 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A19C061574;
        Wed,  5 May 2021 20:29:49 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v13so3585692ilj.8;
        Wed, 05 May 2021 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PrC4tEx40nBbJRViLS/pt/DUkIvthDYADq4HZdMxFQ=;
        b=qi9HzIFvM8DVfENCuiPDnjCRy9UlFxFFiy2hCpC5r2GI9A3A8QOK1BavRR6MN+O1MP
         9KA35TrTeUI9hEwtBs3yO4pVrDzkptsG5Qqu6WnnAcDFNK4vahkhdbw/rO9V+fV6NzJp
         IUdivryB2gwabkjGeV8gMZN1eBKNuG38HkNbG1dyKLMSqO1GGfhdMr1ZG3uFvKiGWNsG
         hWIkRLi90apvNRD/BtV3m0cUgbSVeb+MfRMMq1Au3RlmzN8hzNU5Kmhivm+Shd5bGSvM
         U6emyiPpddwAmCF64EpV+KUPjK0q2Hhd33YeIk4MLF56cr7njiYeLEFbfnKRgqGWO60J
         cLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PrC4tEx40nBbJRViLS/pt/DUkIvthDYADq4HZdMxFQ=;
        b=KTdOYWvdv1u5dqd+/6glMzrff23XeeTAcKbj4R7auAM603u/a+WkKvC1L67rGFzRFm
         lN0OK6jtYAgFatANwVj1Sp0pdoNu/GORUl5mXr9ltqttojR5z4c+HasU+tD3Pe7CObi6
         ZYFr1+HqwSpmoc+mCkAPME3LTcwQABYRZk28Dvba/bZJg+k5UWe96WTnf4InrKMDRMra
         +4irEaXibY4UtACzRINEhG64wcKyqhxFHY4b+qqDZmCvOoPh7Kp0vq8T0ABe0I4T7ygD
         0KonqqthXpc6xmkEmEUaj3pu+jiu804HpJkxqauaLsG/O5oH9Nyy1FORq/x5UYpUopCs
         tJvQ==
X-Gm-Message-State: AOAM5333GEICT0PNdrMrGQvvBbBoQ3q1tp0ncuWn0jWANSPiNm4JXNE8
        C4NQbcJ7b1GpUk1lTb+hEVg=
X-Google-Smtp-Source: ABdhPJyrDooKjISxPilXM+2pBgsCjlxzBhcr+gTFLjejvP3pbUi8oY4nthFUZzr8VYQg6TyVvAG2Kw==
X-Received: by 2002:a92:c7a9:: with SMTP id f9mr1987220ilk.255.1620271788940;
        Wed, 05 May 2021 20:29:48 -0700 (PDT)
Received: from KSAKATA-T470.us.oracle.com (c-73-243-79-162.hsd1.co.comcast.net. [73.243.79.162])
        by smtp.gmail.com with ESMTPSA id u12sm700319ill.10.2021.05.05.20.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 20:29:48 -0700 (PDT)
From:   oracleks043021@gmail.com
To:     beanhuo@micron.com, kenny.gibbons@oracle.com,
        kimito.sakata@oracle.com, rkamdar@micron.com, chris@printf.net,
        ulf.hansson@linaro.org, avri.altman@wdc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4] Clean up and show effect of ERASE_GROUP_DEF
Date:   Wed,  5 May 2021 21:29:45 -0600
Message-Id: <20210506032945.939-1-oracleks043021@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Kimito Sakata <kimito.sakata@oracle.com>

Replaced unused pointer with NULL on calls to strtol().
Added logic to print High Capacity mode parameters of Erase unit size,
Erase Timeout, Write protect Group Size if the EXT_CSD_ERASE_GrOUP_DEF
bit 0 is enabled.

Tested on X86 but the changes should work on all platforms.

Co-developed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>

Changelog:
V3--V4:
    1. Replace unused pointer var with NULL.
    2. Added msg if ERASE_GROUP_DEF enabled for HC.
v2--v3:
    1. Remove redundant ifndef

V1--V2:
    1. refactor Kimito's original patch
    2. change to use MMC_IOC_MULTI_CMD
    3. add checkup if eMMC devie supports secure erase/trim


---
 mmc_cmds.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3e36ff2..afa85b7 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2518,6 +2518,22 @@ static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
 {
 	int ret = 0;
 	struct mmc_ioc_multi_cmd *multi_cmd;
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
 
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
 			   3 * sizeof(struct mmc_ioc_cmd));
@@ -2559,7 +2575,6 @@ int do_erase(int nargs, char **argv)
 {
 	int dev_fd, ret;
 	char *print_str;
-	char **eptr = NULL;
 	__u8 ext_csd[512], checkup_mask = 0;
 	__u32 arg, start, end;
 
@@ -2569,14 +2584,14 @@ int do_erase(int nargs, char **argv)
 	}
 
 	if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
-		start = strtol(argv[2], eptr, 16);
+		start = strtol(argv[2], NULL, 16);
 	else
-		start = strtol(argv[2], eptr, 10);
+		start = strtol(argv[2], NULL, 10);
 
 	if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
-		end = strtol(argv[3], eptr, 16);
+		end = strtol(argv[3], NULL, 16);
 	else
-		end = strtol(argv[3], eptr, 10);
+		end = strtol(argv[3], NULL, 10);
 
 	if (end < start) {
 		fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x]\n",
-- 
2.31.1


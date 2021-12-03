Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E744C433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 10:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352013AbhLCKys (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351999AbhLCKys (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2021 05:54:48 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A47CC06173E
        for <linux-mmc@vger.kernel.org>; Fri,  3 Dec 2021 02:51:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n8so1836906plf.4
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2021 02:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzRStS7PLTdSoiB/YAtNhRbjOf5D5WuWZrQ35RXkBMM=;
        b=Cg79+S3xEZeQZ2+wqpT6lRPvyL1TT2GPS+UaXUJDLIMntKUFqeF8p1Gua6lv7pIcsN
         gjxkI0skU+9YQYZK68hOlNmuxVypFdtD1XRS7zvWiACxL4PecMtXTUMO9tfQsBF7ppsR
         8qtmBKdSFLc3C8oHCfGhV6MNcUqndQ5OsVtpewLHW9eT7rwbfDGtIpGKQNBS1kas4VsA
         Xu1esOuSA9uqbp5LGiJQ68pvqcnKgV6pgz93wR54hgix/AQbz7/TaF0wpS1aKb5px6Uy
         0u95SqHnMy8OpeegE01QcCpRfuP7+AXBuRkQznGOgOz2Dgk3oUPmspGyvmjdrbPRoDr4
         5Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzRStS7PLTdSoiB/YAtNhRbjOf5D5WuWZrQ35RXkBMM=;
        b=liGTuFJtgAuHMQkTUsvLU/u64p52XWbYyMR4/YGSX8Hd2voZNYu7DYKkjYn1ZPau6s
         SYM21uvjLJuSArZs2KrVsQ+L0tOE8wWtxYgmaXK3MAanhIFf4st5JUNKDsx5KMyZsTPb
         pTxjHP7G2y9EpyekYQpFbp58bL0MifjyC7fd0ehVHofBOSqsnnRcDfw37q0CuMaHzQk3
         SKBB33Y+p//KruSDZ7UX8yG6UjZiXnEXTPA63UOyAxEC5v/Yj7FowtDjKocV7wrIBEmx
         Tj3cnDmwBIBRHeMRkx+DR8fnlcpKtS/dPyRUCPOqrn63ZacM7+Ts2/C8BSONlIdJcqDj
         YaSw==
X-Gm-Message-State: AOAM530jt59FuYY780p/hCIX+dciMxpqcyp3EQDI1Ejs+SuCJjR3IPe+
        TjT7yX5KUyGEVM2v22IuCIaYB12yiW0v5A==
X-Google-Smtp-Source: ABdhPJzFuTRn5Z05HVBas5NRYLlMugq0G9ismGi254AL7aaqloPWWHJv47gUYOYaeAJXw/Y7/EI1sQ==
X-Received: by 2002:a17:90a:ca11:: with SMTP id x17mr13109343pjt.61.1638528684143;
        Fri, 03 Dec 2021 02:51:24 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x18sm2868699pfh.210.2021.12.03.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:51:23 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw, benchuanggli@gmail.com,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH 7/7] mmc: core: Support UHS-II card access
Date:   Fri,  3 Dec 2021 18:51:03 +0800
Message-Id: <20211203105103.11306-8-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

Embed the UHS-II access function into the MMC request processing flow.

Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/core/core.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 19b409179..d4d873971 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -31,6 +31,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/mmc/sd_uhs2.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmc.h>
@@ -42,6 +43,7 @@
 #include "host.h"
 #include "sdio_bus.h"
 #include "pwrseq.h"
+#include "sd_uhs2.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -335,6 +337,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	init_completion(&mrq->cmd_completion);
@@ -352,6 +356,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
+	if (host->flags & MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		uhs2_cmd.payload = payload;
+		mrq->cmd->uhs2_cmd = &uhs2_cmd;
+		sd_uhs2_prepare_cmd(host, mrq);
+	}
+
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
@@ -431,6 +442,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
  */
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	/*
@@ -451,6 +464,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		goto out_err;
 
+	if (host->flags & MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		uhs2_cmd.payload = payload;
+		mrq->cmd->uhs2_cmd = &uhs2_cmd;
+		sd_uhs2_prepare_cmd(host, mrq);
+	}
+
 	err = host->cqe_ops->cqe_request(host, mrq);
 	if (err)
 		goto out_err;
@@ -899,8 +919,10 @@ static inline void mmc_set_ios(struct mmc_host *host)
  */
 void mmc_set_chip_select(struct mmc_host *host, int mode)
 {
-	host->ios.chip_select = mode;
-	mmc_set_ios(host);
+	if (!(host->flags & MMC_UHS2_INITIALIZED)) {
+		host->ios.chip_select = mode;
+		mmc_set_ios(host);
+	}
 }
 
 /*
-- 
2.34.0


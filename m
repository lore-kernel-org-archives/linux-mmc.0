Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0138C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99882076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+n7ZdWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGJLIS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJLIQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:08:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87227C08C5CE;
        Fri, 10 Jul 2020 04:08:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so2128723ple.0;
        Fri, 10 Jul 2020 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBX+zLWZoUU7YT17yBn/8lBjP/8tmr8iWyHaBASouus=;
        b=E+n7ZdWpw4sKWwQtuC6WSFtvBrgcNYj/pWuRfB1lveg4e7Hpzv3o+a27EhPaBs1NxF
         mpDlH3xJ2P1vgVyjoDuA8sjh1RdKVvmCr9W+qy7UWYpiFYyhUN/uZmBjO5ukLdNq/H4J
         KC+BaRZzzmNQkPGA9CbB0ibnI2jjIQX/MDwc34qR2eazOoQlIzBmfy5Scjc7tUD9AV15
         PbK3wH/YxMSE+1cej08SqfG4pBeKWFQfCP5mKENsNeH6JDMT8BdA/Vm7VMZJTThVtXVc
         2MgbnrQxn2thSZps8BpZ9IeVgdeH6mGS+7O6TnUf14dhFK5oangsHBIws3sOqQ/4mSFy
         Rfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBX+zLWZoUU7YT17yBn/8lBjP/8tmr8iWyHaBASouus=;
        b=T6IHwAXsCYiH12USh7w19ZnjYvpk7WME3QfYFJmU+4MmemZ+qKdr/y/wl1/ttMWvgS
         dkaYk8P45OogtVeO7Pw79xDgSoeK2QXLA6oZubpl8gCwOh7FpXgtb/StXSOpkqXZiEi+
         xzYgBGtLsSvxXKSzWvtlej9EyHsrUqcdxFw0eN1N/F9yfR01FGajTP0TZIqL0pwB3YzA
         tJn+AVItlKdo6i3xUAvifOjVfLat7W21vwEeMU3BUoCE0ZbdrVzHjAedD5XFYCCprKwQ
         9nidvFjx+BehIw3saWlxiKqsbpPfs2zpSrZT8kTtiXpHY9147xhAB3XhG+Htd6kXbXh0
         5wcQ==
X-Gm-Message-State: AOAM531xiJdVaxIH2cr8pyfVMa8TsdfJZA4L5yuRaivjE2Cn8ZhLLqDq
        FGese+vDbLziNsk77Cyd254=
X-Google-Smtp-Source: ABdhPJxvP3R+7/6xKd+Ze0bdorOQUhuD5VNFY8wm13WbCL/3Kudo8U1XNgXX38/+8AysaMYEAyMfVQ==
X-Received: by 2002:a17:902:a708:: with SMTP id w8mr16567900plq.128.1594379296110;
        Fri, 10 Jul 2020 04:08:16 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id y80sm5498959pfb.165.2020.07.10.04.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:08:15 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 05/21] mmc: core: UHS-II support, skip TMODE setup in some cases
Date:   Fri, 10 Jul 2020 19:08:58 +0800
Message-Id: <20200710110858.29166-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

UHS-II's data command packet has TMODE fields in which parameters for
data transaction, like Duplex Mode(DM) and Length Mode(LM), are specified.
In some cases, we don't need to initialize them and so set uhs2_tmode0_flag
to 1 in order to skip them in generating a packet.
(The code will be added in the next commit.)

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/block.c  | 7 ++++++-
 drivers/mmc/core/sd_ops.c | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7896952de1ac..212f872d60bc 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -56,6 +56,7 @@
 #include "mmc_ops.h"
 #include "quirks.h"
 #include "sd_ops.h"
+#include "uhs2.h"
 
 MODULE_ALIAS("mmc:block");
 #ifdef MODULE_PARAM_PREFIX
@@ -1526,6 +1527,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
+	bool do_multi;
+
+	do_multi = (card->host->flags & MMC_UHS2_INITIALIZED) ? true : false;
 
 	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);
 
@@ -1536,7 +1540,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->cmd.arg <<= 9;
 	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	if (brq->data.blocks > 1 || do_rel_wr) {
+	if (brq->data.blocks > 1 || do_rel_wr || do_multi) {
 		/* SPI multiblock writes terminate using a special
 		 * token, not a STOP_TRANSMISSION request.
 		 */
@@ -1549,6 +1553,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->mrq.stop = NULL;
 		readcmd = MMC_READ_SINGLE_BLOCK;
 		writecmd = MMC_WRITE_BLOCK;
+		brq->cmd.uhs2_tmode0_flag = 1;
 	}
 	brq->cmd.opcode = rq_data_dir(req) == READ ? readcmd : writecmd;
 
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 22bf528294b9..f58bb50872f6 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -235,6 +235,7 @@ int mmc_app_send_scr(struct mmc_card *card)
 	cmd.opcode = SD_APP_SEND_SCR;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 8;
 	data.blocks = 1;
@@ -282,6 +283,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	cmd.arg &= ~(0xF << (group * 4));
 	cmd.arg |= value << (group * 4);
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 64;
 	data.blocks = 1;
@@ -323,6 +325,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 	cmd.opcode = SD_APP_SD_STATUS;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 64;
 	data.blocks = 1;
-- 
2.27.0


Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35BC6377E
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85254608FC
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGVDV3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhGVDV1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F9C061757;
        Wed, 21 Jul 2021 21:02:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e14so3002083plh.8;
        Wed, 21 Jul 2021 21:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlYdZedfzdwEWYsud6KArWcbSXHSw/yPGnBz1xgAeuA=;
        b=CWhUUvGUikR4GNhQp5D//oZZeD7oHwmvqqG4OyLkktg5JWAGz9CTmJeICFWqsXq8Z+
         8kKVJiG2DJCUbe1EjtGL/jyCUHRF3sTlkyJRR9iBj1+TjJTchis6XaLEgCsO3biOmt1S
         6v9a1YuguvgW7k9WkhIv6c69M8QtX0jyiynZ3Ip4fR/+u6kJ1oNnn9/onF3SRuIADdZn
         l6TzjnVQpfuATSgddatjIMfBYkjH8SxD60H6ZszbluAAtOACdm0KqyDr4eyqCP7OYEt/
         k9WA29DEsmYdDI3ZQejm2MZyqTVj5nPGk4R/M4W6hGaHJMczsPF/satN0IJURjGDr6mn
         6AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlYdZedfzdwEWYsud6KArWcbSXHSw/yPGnBz1xgAeuA=;
        b=EQd7Voh7Rke8epg+mLii1dxp9vPollbd/0XFKBklDknXiXVvfrU5DiFAqLb+caiJmS
         s2hnoOHQv7EjlSxWj5tH5KGKkcpB5gB2a+ihw94By+CrshNLU4WIADYLw3Wkw9Z7fnmm
         NdqRkm+6X+c5rF1wOf7DI50QquAFfXfPcDwMpLzFSNwHxzJyXZecvH5ZlJKlsb8ts94B
         WTrc7wBs7FxNMc21c2JmP110YBIwaR25k0/wQRQn4aOyXT30ScUGI6X/c6jUIM454m8j
         E0KZA27WOZtFT609eArLxZGg1HTT6ac6DIN/nS8M8APdk9nMLvH1KQdgxeMHc0rK5Fg1
         DWNQ==
X-Gm-Message-State: AOAM533LD3j245QbU6mz1eTTYXZH1nUa2VbphMfdCPQ90z2zbzDMlDWL
        KWS9gMZkg9WGLhEX/Vrm/A0=
X-Google-Smtp-Source: ABdhPJzzObRrw2bYzX6SUT8P+jtBNpdWlM/kL2o29VHHPjTRQLySETBZeqEZ8Hb4tmuezSXwhcHnJQ==
X-Received: by 2002:a63:5952:: with SMTP id j18mr21127123pgm.366.1626926522132;
        Wed, 21 Jul 2021 21:02:02 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:01 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 05/29] mmc: core: UHS-II support, skip TMODE setup in some cases
Date:   Thu, 22 Jul 2021 12:01:00 +0800
Message-Id: <20210722040124.7573-5-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
index 689eb9afeeed..d107578cdbff 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -57,6 +57,7 @@
 #include "mmc_ops.h"
 #include "quirks.h"
 #include "sd_ops.h"
+#include "uhs2.h"

 MODULE_ALIAS("mmc:block");
 #ifdef MODULE_PARAM_PREFIX
@@ -1538,6 +1539,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
+	bool do_multi;
+
+	do_multi = (card->host->flags & MMC_UHS2_INITIALIZED) ? true : false;

 	mmc_blk_data_prep(mq, mqrq, disable_multi, &do_rel_wr, &do_data_tag);

@@ -1548,7 +1552,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->cmd.arg <<= 9;
 	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;

-	if (brq->data.blocks > 1 || do_rel_wr) {
+	if (brq->data.blocks > 1 || do_rel_wr || do_multi) {
 		/* SPI multiblock writes terminate using a special
 		 * token, not a STOP_TRANSMISSION request.
 		 */
@@ -1561,6 +1565,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->mrq.stop = NULL;
 		readcmd = MMC_READ_SINGLE_BLOCK;
 		writecmd = MMC_WRITE_BLOCK;
+		brq->cmd.uhs2_tmode0_flag = 1;
 	}
 	brq->cmd.opcode = rq_data_dir(req) == READ ? readcmd : writecmd;

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index d61ff811218c..baa05a6a36c4 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -280,6 +280,7 @@ int mmc_app_send_scr(struct mmc_card *card)
 	cmd.opcode = SD_APP_SEND_SCR;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;

 	data.blksz = 8;
 	data.blocks = 1;
@@ -327,6 +328,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	cmd.arg &= ~(0xF << (group * 4));
 	cmd.arg |= value << (group * 4);
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;

 	data.blksz = 64;
 	data.blocks = 1;
@@ -368,6 +370,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 	cmd.opcode = SD_APP_SD_STATUS;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;

 	data.blksz = 64;
 	data.blocks = 1;
--
2.32.0


Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC3C43219
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 18:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A61860FC0
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 18:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhINSWN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:22:13 -0400
Received: from www.zeus03.de ([194.117.254.33]:56706 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231863AbhINSV5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Sep 2021 14:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=t6jhtQZUmpEfkv
        mP2YyKc9ut4fUY8OiG9AIu1y5QzNU=; b=CcbgGuBzmgy2sUOa6btPKEpAfWAs6P
        2yPuOKtvT+Ewv14S54ayVgJnqjZn8RriGTkR2Fu4d/IaMHx7Xht+uR9g/3I/TnEr
        fo5xJshcuJHrxw595SH05STzx5BAaFFPq8UlBex90WGJtQmBiCVniLjmL1BPWZUu
        ea71O/ed0rSsI=
Received: (qmail 518145 invoked from network); 14 Sep 2021 20:20:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Sep 2021 20:20:34 +0200
X-UD-Smtp-Session: l3s3148p1@7C09o/jLIJEgAwDPXxMyACCkRmvQydX8
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/3] mmc: core: add helper to send STOP
Date:   Tue, 14 Sep 2021 20:20:21 +0200
Message-Id: <20210914182023.8103-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914182023.8103-1-wsa+renesas@sang-engineering.com>
References: <20210914182023.8103-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There was a helper in the block layer already, but we need it in other
parts soon as well. So, make it more generic by adding the 'retries'
parameter and add the helper to mmc_ops.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/block.c   | 14 +-------------
 drivers/mmc/core/mmc_ops.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 431af5e8be2f..58f1aa5ac33f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1642,18 +1642,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 #define MMC_DATA_RETRIES	2
 #define MMC_NO_RETRIES		(MMC_MAX_RETRIES + 1)
 
-static int mmc_blk_send_stop(struct mmc_card *card, unsigned int timeout)
-{
-	struct mmc_command cmd = {
-		.opcode = MMC_STOP_TRANSMISSION,
-		.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC,
-		/* Some hosts wait for busy anyway, so provide a busy timeout */
-		.busy_timeout = timeout,
-	};
-
-	return mmc_wait_for_cmd(card->host, &cmd, 5);
-}
-
 static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 {
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
@@ -1663,7 +1651,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	mmc_retune_hold_now(card->host);
 
-	mmc_blk_send_stop(card, timeout);
+	mmc_send_stop(card->host, timeout, 5);
 
 	err = mmc_poll_for_busy(card, timeout, false, MMC_BUSY_IO);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index ae25ffc2e870..6e9d1b6b9e55 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -9,6 +9,7 @@
 #define _MMC_MMC_OPS_H
 
 #include <linux/types.h>
+#include <linux/mmc/mmc.h>
 
 enum mmc_busy_cmd {
 	MMC_BUSY_CMD6,
@@ -57,5 +58,18 @@ int mmc_cmdq_enable(struct mmc_card *card);
 int mmc_cmdq_disable(struct mmc_card *card);
 int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms);
 
+static inline int mmc_send_stop(struct mmc_host *host, unsigned int timeout,
+			   unsigned int retries)
+{
+	struct mmc_command cmd = {
+		.opcode = MMC_STOP_TRANSMISSION,
+		.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC,
+		/* Some hosts wait for busy anyway, so provide a busy timeout */
+		.busy_timeout = timeout,
+	};
+
+	return mmc_wait_for_cmd(host, &cmd, retries);
+}
+
 #endif
 
-- 
2.30.2


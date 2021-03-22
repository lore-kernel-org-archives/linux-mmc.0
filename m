Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8497FC433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 13:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521D66192A
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 13:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhCVNiF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:38:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49481 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCVNhj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2021 09:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616420259; x=1647956259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wGMs1i8GIsX+8EmvtvhoYSNrVnYNajIZfQ9Kyx3KzkE=;
  b=GO66Cdc7Bh2WZ9MWcJp9byIKeVSCU+m3phlUUgFE/DoBPaVWx64vxv3P
   l6Vd0LkVMy5s7qmV6WsB5BFtq4UsJuTr7PQ2dy+Y1l3TDnDbkUAN7N5b+
   OadGId3tJdpZFhm8hzzJ3iILKBCqZAQyeV8Eyw1jyFHzX7kWkAisssMdu
   QAA537xYNZdBFfLnzRUMIYQzYaqtfjSwvYmj0lf1PUBDzoxvEDfUT7KeB
   oqlANgwAXS3rxGz8h8qumLt/3UHlJPAmsfkmxkhGVbT6NX2HBaJOIlpnI
   ELerAnqRutJ7tup0GBUuI2uXB9liAlSNGuC6Cw2k+qrk22CHv+ItMJEsG
   w==;
IronPort-SDR: ypwj/r+fw7AMTorQERVsJqub6BSnHXxi9AcXIB/7caUesE/sm7KekTT1/y0Qmt5aAHY35WH0zr
 EhvkdCiGVYu22Ba1tO0UMh+lk4N/n+Jxco0bUKKaOBZXFjbSBXytKiI06D72Z9zyeVwJXfUJqE
 Q60r/5lW9yOwrB0BkkYsBFeoj4VPml1IYaSNY9n7hbZD/vxrC4n44/FpgLGfX6Fuq7kXUaE0cX
 bd3fk7A/qjMQF+3lo3r5SuN+eQzxtQdLtX/XIPER+6gbWtGZ8EQY0DNU4ZY/Hd+7KStlJUUL9K
 EPE=
X-IronPort-AV: E=Sophos;i="5.81,269,1610380800"; 
   d="scan'208";a="162662254"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2021 21:37:38 +0800
IronPort-SDR: EKPy2R58q53Zyyv06juLFHVHcn6c7NHkEA4i0Maezs5liJhS/a4E5clLHlvaVeSZQD/++XpTFw
 bVi39YuZxHaetgq76EoE2DGksWuc6jfvx6EE6UnyiZGvGKqZzeunPqBC6cxmbFLPMe1rmjqAIv
 v9MXpJRhljx14lospbFGj64HazZFasBGbaTG64dMx6O7AUFgFprDwbNRqf7X3d97mHosEWZJDq
 WyQ/TrspTPShS81LD4D2wWrc76y0qhVkQROPSlnBi5e+Q8HQLf0lc3XbBqq4kKdIqJrsHb3xQu
 cQBqOkvfPhMJ5lnf9mjbGGdb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 06:19:46 -0700
IronPort-SDR: KnPH3ktiq33w5JmrhXn2KpQbgFZRyaNdd91I2gCPct12qTcVssVzjWADRT7OuD0xk051X7Rctv
 jT3PohrIMcoTBbslNCE0IGlmL4LjFKyPsnUxAmZ5dH1qwwta41aks91tCi8RLib4fFHUXCfRpM
 GFDHUDqVxEsmA8VKvQaWTkW5nE0fqHTnG1XQC4IyY6U+76n/cecqUgzbD5p7OP85FN7j1oaUVa
 IZzP+FyIwWt0IKqI1Od7AXoR+rpJhtuVLW/QRSNxSKPPUxxhIay56JtxgeRoVMLD907Bf4KT+b
 Xyw=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Mar 2021 06:37:36 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Brendan Peter <bpeter@lytx.com>
Subject: [PATCH 1/2] mmc: block: Issue flush only if allowed
Date:   Mon, 22 Mar 2021 15:36:44 +0200
Message-Id: <20210322133645.4901-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322133645.4901-1-avri.altman@wdc.com>
References: <20210322133645.4901-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The cache may be flushed to the nonvolatile storage by writing to
FLUSH_CACHE byte (EXT_CSD byte [32]). When in command queueing mode, the
cache may be flushed by issuing a CMDQ_TASK_ DEV_MGMT (CMD48) with a
FLUSH_CACHE op-code.  Either way, verify that The cache function is
turned ON before doing so.

fixes: 1e8e55b67030 (mmc: block: Add CQE support)

Reported-by: Brendan Peter <bpeter@lytx.com>
Tested-by: Brendan Peter <bpeter@lytx.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c   | 3 +++
 drivers/mmc/core/mmc_ops.c | 4 +---
 drivers/mmc/core/mmc_ops.h | 5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 42e27a298218..a93c66aa91db 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1473,6 +1473,9 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq, req);
 
+	if (mmc_card_mmc(mq->card) && !mmc_flush_allowed(mq->card))
+		return 0;
+
 	mrq->cmd->opcode = MMC_SWITCH;
 	mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 			(EXT_CSD_FLUSH_CACHE << 16) |
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index baa6314f69b4..b8a0c9ac8a20 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -988,9 +988,7 @@ int mmc_flush_cache(struct mmc_card *card)
 {
 	int err = 0;
 
-	if (mmc_card_mmc(card) &&
-			(card->ext_csd.cache_size > 0) &&
-			(card->ext_csd.cache_ctrl & 1)) {
+	if (mmc_card_mmc(card) && mmc_flush_allowed(card)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_FLUSH_CACHE, 1,
 				 MMC_CACHE_FLUSH_TIMEOUT_MS);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 632009260e51..bf2b315addd7 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -19,6 +19,11 @@ enum mmc_busy_cmd {
 struct mmc_host;
 struct mmc_card;
 
+static inline bool mmc_flush_allowed(struct mmc_card *card)
+{
+	return card->ext_csd.cache_size > 0 && (card->ext_csd.cache_ctrl & 1);
+}
+
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
-- 
2.25.1


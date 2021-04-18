Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41740C433B4
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Apr 2021 06:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1235E61245
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Apr 2021 06:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhDRGAy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Apr 2021 02:00:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20872 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhDRGAy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Apr 2021 02:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618725626; x=1650261626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qj4IJhWVk3x7fB3H8V0G0MGUFAMUgjOu/TFYG5r54R4=;
  b=pi+kE7ve5mv3FhgObxCJVDeu+wU340Xt8XVDq+uqjSpAuV58w+TwWFB3
   J9AdQS9NPW0wryxuRBcvdh0hVl4C6TztqdvsXtbSbZ9xJ6Vw1BmTRbmb1
   VUVPgzoJ+JDFmquZL2HOPYLC4gdVCVi6blx9P/r6WmVJVXQotn4ivzDKM
   ZawIFeQ+69ePgwPHd7oN9T4sblidZpSX17irJTsrkTNq8PTH4ay4K66k5
   pskd4AAebS5/cndse6EMTsKxctaiXF5c22qpPPsbAnH+3w+XOfGTOAKdy
   7AmP3LKGJ1T/hYEopT3KPq/GIWqR+2DxbJYEmysLehsoCUpDRqh9CO5FD
   A==;
IronPort-SDR: aYxpIhowG1XbSB/euvEb8Kafg5p8Wjt0qVtKifMhJPHTHnoMaVbMJQ680jsrsvG4os/Oq1H56k
 RNn1P9BVc2wNk+dmPUgI5gINlKjyuA3yowtW9h1upM9Sk+y2cLKPFltuuQLhgTTtdyRObxsSa/
 Wt6iDeecTndyuQXsmla5Ua/cUdAqRUSySW3fzk79pdm65+bo3qT08diPEdtemHyvF7lf3I3Ave
 Tk0r7OHir/jQZku/Vqnq1fDHQrntbQVdb345fPYgcxi/h6CX8maUsEtttD1ecHrjEEpsH6DNBf
 d08=
X-IronPort-AV: E=Sophos;i="5.82,231,1613404800"; 
   d="scan'208";a="165325921"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2021 14:00:26 +0800
IronPort-SDR: IecnpIn2k6KA8AWHDHu/Ka5DEqVgpuQA2ERhpe+GPOdRcdW4Q5Mx1/2XExgdfUtATJskEaMuTi
 230GzaPnjFCAQ0skConiPU80m4s1XxnExD4t4ImiBRFq29kR6HuQ7Ga/SShNFTE21rA5ln8mRW
 4cyeic+OsRMreBQek0Uqm5/KUmJvWgHXOIwf8QEdoOkUcGkdEeN16Knhi6L1PQXdi3WfO8BkVA
 FQ5+6lmrCvU9SuAgrwIoHdsjk5V7PEZzib2V0YiVJwMgjCTs8oo9wMRiIsY5alhBIiDUdX8QeD
 q3j/KOfk5rQ783ZEJ0dIJ3UK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 22:41:13 -0700
IronPort-SDR: TRRnLltwox+dfhV+wOdktE2ftlDZbKqzHBmGiFot0ld6cSFMOLeXleSadxaw5aNacmh/8kVVMn
 Prp6vudnIfZX+Epiis2+rg3DbRQG3fH97XJG29VfBhgXoTJ5umxnJFyUJk30Ez7cmTjNk8sPm2
 03GtXa4IKnFReps3jnSYNmcw0uqsPzDlA9Vf0qIO5S8TiEn9yie635iy4blQWQQQlQQLMm732w
 STR73OjgGVgWNDiaMZDE4YlWZ1kvUiCjkAcca9dWq8b/YApF40zGDzTeTiCNlPZtDY3vcmVhKc
 qOQ=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Apr 2021 23:00:25 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Brendan Peter <bpeter@lytx.com>
Subject: [PATCH v2 1/2] mmc: block: Issue flush only if allowed
Date:   Sun, 18 Apr 2021 08:59:52 +0300
Message-Id: <20210418055953.26959-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210418055953.26959-1-avri.altman@wdc.com>
References: <20210418055953.26959-1-avri.altman@wdc.com>
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
 drivers/mmc/core/block.c   | 7 +++++++
 drivers/mmc/core/mmc_ops.c | 4 +---
 drivers/mmc/core/mmc_ops.h | 5 +++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index fe5892d30778..6800feb70c92 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1476,6 +1476,11 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = mmc_blk_cqe_prep_dcmd(mqrq, req);
 
+	if (mmc_card_mmc(mq->card) && !mmc_flush_allowed(mq->card)) {
+		blk_mq_end_request(req, BLK_STS_OK);
+		return -EPERM;
+	}
+
 	mrq->cmd->opcode = MMC_SWITCH;
 	mrq->cmd->arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 			(EXT_CSD_FLUSH_CACHE << 16) |
@@ -2226,6 +2231,8 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 		switch (req_op(req)) {
 		case REQ_OP_FLUSH:
 			ret = mmc_blk_cqe_issue_flush(mq, req);
+			if (ret == -EPERM)
+				return MMC_REQ_FINISHED;
 			break;
 		case REQ_OP_READ:
 		case REQ_OP_WRITE:
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index f413474f0f80..9c2a665be034 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -967,9 +967,7 @@ int mmc_flush_cache(struct mmc_card *card)
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


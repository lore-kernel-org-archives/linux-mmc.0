Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060A3C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 13:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C0A60FE3
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 13:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhDTNr0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:47:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53204 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhDTNr0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Apr 2021 09:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618926414; x=1650462414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z0lxOkGI1HbA5WK2WYt4hn56ZHJdND607vtOC4lvr5Y=;
  b=jtEvbmFpHwWW5RKW7dsR/A59jTCVRrgbPqOByTVnek+lDa7j88qKeohL
   RFHsvnTI/ODgefw4WB/W0xa0aNaD3JQxiodRJTaVPYy9xdhMFf2kjfmH8
   TQFHE4LBU+zOTp47nuLehFS3TAmizAjJzNiSJ4wRAfi29noFCqTGXcoFZ
   dJt22CwsA+TTJR0henDNN4j0Ez+CXbbB0MIruabWTBwdF1Hd+tJdR4RL9
   kPlcOe7s4kQhiLH34TtH1IWE1G1XcpTtdlnPYdgX+qgSWevE/4yoD2T+t
   pFDg0gtQ5yN0Bs4ltCrgcjUhyRahofVNpiByoYw5BbQf8qMSMjeBu58c9
   g==;
IronPort-SDR: lDfsaT8zKxs3WUXlUan3siXUbgF/2/VUvA0PBpzcvog2lk2DYEEuK/OU3jGywlWsEDuaXjULNj
 +aMTDb4XCvJEGGPYh4QR/DP3S/mYOcpXu9EQvoGRB5L2DF+jaem6qXIaVcJwRmCILdkstYl1aA
 Vo1yYzUmh3Ye5kAZCaD69DaALueyvcqqc0tWyrG7Vc/+7ub1963uL4Q2rWdX4qR/dNTzu0nITp
 VLV0uJC3kQ1uK9qtUfOoMtjxBoPFdB/RhlVaDkQmZV6egU5DqmSQ5Y1msm7DK/cXCuWVWTVgF7
 ZGg=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; 
   d="scan'208";a="164889875"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 21:46:54 +0800
IronPort-SDR: gSyWzu0t1Sdl5ommIbnt7bpo78adkvht9cKBfvGstzGxyQxQVCSKMkM15sk4Txujlj2v8H2JLd
 lY9JC8caC4LvKkjVOvIBhPVOraDTWaGDsUtdN5lFPZP5/RrYEqr24gUqvjOKYaev2bjiOg7Kvi
 UZUxgwECqirOiuU02lDIRZGOtb4/jrOufWYVOFzXKZfw/tTdXer7Tt6or7eq01WhuZDeZ/qEWD
 tVnT823QuYcrA15i8bq9Kh/WjPmfG3NFmITkT/IXOvCCk7zXFK6ue8qfxs4fic2e+Y69e5kt5B
 7uXVUsTwHcoMDtoTF53je6Sq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 06:27:33 -0700
IronPort-SDR: U4EJxG6aXZM6OlimiyeCnHKU0fUaUENG8e6IgsfoiqqteVYSXs7unz4n7Lrrhseypo6ixs3gdy
 D2qeGf77/t7k5szMidetw4mdKEwgKchFUhvE5nwmwO1AebEBsQM15gZ3vJJLypITo4gLO7fYRu
 Dc2QKDwh7JCTunnxHrDrXkdbnvqne1q0aq2ihD7KJILcyAS4/CnzwCBeMsd3X4HUv2/dTqhndU
 xUjjEcKcCmE0U4+5L7Fnbx9AuViVFiganmovHEAFRrsoYfcGqyPG+hlsuxfiw3QEm6jD7n30Ji
 SMM=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2021 06:46:53 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Brendan Peter <bpeter@lytx.com>
Subject: [PATCH v4 1/2] mmc: block: Issue flush only if allowed
Date:   Tue, 20 Apr 2021 16:46:40 +0300
Message-Id: <20210420134641.57343-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420134641.57343-1-avri.altman@wdc.com>
References: <20210420134641.57343-1-avri.altman@wdc.com>
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
 drivers/mmc/core/block.c   | 9 +++++++++
 drivers/mmc/core/mmc.c     | 2 +-
 drivers/mmc/core/mmc_ops.h | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8bfd4d95b386..24e1ecbdd510 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2186,6 +2186,11 @@ static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
 	return mmc_blk_rw_wait(mq, NULL);
 }
 
+static bool mmc_blk_cache_disabled(struct mmc_card *card)
+{
+	return mmc_card_mmc(card) && !mmc_flush_allowed(card);
+}
+
 enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
@@ -2225,6 +2230,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 	case MMC_ISSUE_ASYNC:
 		switch (req_op(req)) {
 		case REQ_OP_FLUSH:
+			if (mmc_blk_cache_disabled(mq->card)) {
+				blk_mq_end_request(req, BLK_STS_OK);
+				return MMC_REQ_FINISHED;
+			}
 			ret = mmc_blk_cqe_issue_flush(mq, req);
 			break;
 		case REQ_OP_READ:
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9ad4aa537867..e3da62ffcb5e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2037,7 +2037,7 @@ static int _mmc_flush_cache(struct mmc_card *card)
 {
 	int err = 0;
 
-	if (card->ext_csd.cache_size > 0 && card->ext_csd.cache_ctrl & 1) {
+	if (mmc_flush_allowed(card)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_FLUSH_CACHE, 1,
 				 CACHE_FLUSH_TIMEOUT_MS);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 5782fdf4e8e9..2682bf66708a 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -19,6 +19,11 @@ enum mmc_busy_cmd {
 struct mmc_host;
 struct mmc_card;
 
+static inline bool mmc_flush_allowed(struct mmc_card *card)
+{
+	return card->ext_csd.cache_size > 0 && card->ext_csd.cache_ctrl & 1;
+}
+
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
-- 
2.25.1


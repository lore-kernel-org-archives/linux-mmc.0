Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC45C433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 05:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9C3613AB
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 05:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhDTFyX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 01:54:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2495 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhDTFyW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Apr 2021 01:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618898033; x=1650434033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++qeqI9b7eA/m4ALuAHxHKzYKebd2W2eMSbBxA7Ug8o=;
  b=DKkz4WumpsjVtAp7P15pwA6dcCzq3Iw9+I0F9a8Ku1VUE3RfmOvlbsFc
   h01rau703XH2zu1kg7Xh0Yxnhyk3zYdbFQ9ZNa2A5roi5rR0Ue6FMdgwP
   1hzToT1oI992J0aQHTmqDxTqbAK6jFUqlGnfQXWHToxTam19WkprkWAKh
   So+wE7BGg117215mxd94Aj7bs9uiEUaDiYTu+3KoEbizHX+wKsftd/5sc
   PodABuVbO/qQXtz1o0RCr6AuZIb2kMY4j0lvnC6bS5HvcTxF+Zonq5+S9
   gAyacoVCpIB4qRIiH4GGB/9ZzrS17NNtOM6KblCfpc7nfMYK8cL7fw8VT
   A==;
IronPort-SDR: XnjCdqp9hV2W37s1lbN523WxVYG2WHZtyuqimhtWZMZ2JiOLhlGrcEqPjvx25YymKk1JPORBfO
 vN1sElhLSZuMZ1juJu6p9SPatoONNjBbNffWkatqjd+C1l0aXCZImkjQZ3C31UycqdNvZ55IEF
 FQh9dJIKAHL5+CF7JQqAF7ODzaBGboeV0wtDwPiPeZd2+YgageIu26FnCFJLva2qWpz1Q11A/S
 Byxojt1lOfRE/JVKnXrzXH56xPLsKmY3Im//vbaL5kOPtfdovCSJwiXgyWV0lYPbDfRLFQz9L6
 uIM=
X-IronPort-AV: E=Sophos;i="5.82,236,1613404800"; 
   d="scan'208";a="269437636"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 13:53:52 +0800
IronPort-SDR: ZW3RNp6tbr2w+5fsT76ggG7COcc145PRIPzF5WseehGyhVilZmEtX6Y6k9fWRZL73jCU7yDjGL
 jr1nUgQ03ImqxEkKlyIbA4+ofGFD6n1gaOwQhjqo8ZEDLhd9jj0vegwRijyHnOfUYdUpNGmPi7
 haD3GSFcQA/PycoDSQA1YXQn4EjbIjf0nl2D4V4vwO3eN5aMPqLETKs2mcWTahpDGYCWBsjLTv
 ZgYhWSDK/9fu/TOQtgm36fgwK+kddF9/lAtCFjMf3oPzaSBLM/Foda4CGFx/ojvb3EjSPuJcTP
 E6vGyE4U82ZlDUqkwzLWJs8C
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 22:34:31 -0700
IronPort-SDR: 6L/qkuUpRLpq5j7Us88MNbIeaasBDhxW4R5pOXqumpUPDYK6dV8wJa1xdir7E7Jb+O35z2TsQi
 6bcJzzfyCjpS8ijVqPGz4NuUBXaRwJFfhSSi30ssUsGKVYVy0J8qYysmc09mS/zoHhWE72/BB8
 7P2FGFC1O9hmghq4d1cV2JzCSeeq91R90q960+Eh7I1Fsj8HTsZdFP+uIUqqtF0wg3mAIP5NYN
 +Cm6IR3zFOBh7JzFDrY30QMLVIEHF6t7yfccekYFy0aEZ3G45+vibgztnnqxpHXfW5v1ZumIK6
 rvs=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Apr 2021 22:53:49 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Brendan Peter <bpeter@lytx.com>
Subject: [PATCH v3 1/2] mmc: block: Issue flush only if allowed
Date:   Tue, 20 Apr 2021 08:53:05 +0300
Message-Id: <20210420055306.4858-2-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420055306.4858-1-avri.altman@wdc.com>
References: <20210420055306.4858-1-avri.altman@wdc.com>
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
 drivers/mmc/core/mmc.c     | 2 +-
 drivers/mmc/core/mmc_ops.h | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8bfd4d95b386..5b6501fc9fb7 100644
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


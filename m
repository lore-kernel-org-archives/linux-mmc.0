Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD65CD5494
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Sep 2023 07:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjISHrr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjISHrn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Sep 2023 03:47:43 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070BD116;
        Tue, 19 Sep 2023 00:47:34 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38J7lGlh044063;
        Tue, 19 Sep 2023 15:47:16 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RqYZS4F8Kz2SK5DM;
        Tue, 19 Sep 2023 15:44:00 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 19 Sep
 2023 15:47:15 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhang.lyra@gmail.com>,
        <zhenxiong.lai@unisoc.com>, <yuelin.tang@unisoc.com>,
        Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V4 2/2] mmc: hsq: dynamic adjustment of hsq->depth
Date:   Tue, 19 Sep 2023 15:47:07 +0800
Message-ID: <20230919074707.25517-3-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230919074707.25517-1-wenchao.chen@unisoc.com>
References: <20230919074707.25517-1-wenchao.chen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 38J7lGlh044063
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Increasing hsq_depth improves random write performance.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/mmc_hsq.c | 21 +++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 8556cacb21a1..869da6472a6d 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -21,6 +21,25 @@ static void mmc_hsq_retry_handler(struct work_struct *work)
 	mmc->ops->request(mmc, hsq->mrq);
 }
 
+static void mmc_hsq_modify_threshold(struct mmc_hsq *hsq)
+{
+	struct mmc_host *mmc = hsq->mmc;
+	struct mmc_request *mrq;
+	int need_change = 0;
+	int tag;
+
+	mmc->hsq_depth = HSQ_NORMAL_DEPTH;
+	for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
+		mrq = hsq->slot[tag].mrq;
+		if (mrq && mrq->data &&
+		   (mrq->data->blksz * mrq->data->blocks == 4096) &&
+		   (mrq->data->flags & MMC_DATA_WRITE) && (++need_change >= 2)) {
+			mmc->hsq_depth = HSQ_PERFORMANCE_DEPTH;
+			break;
+		}
+	}
+}
+
 static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 {
 	struct mmc_host *mmc = hsq->mmc;
@@ -42,6 +61,8 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 		return;
 	}
 
+	mmc_hsq_modify_threshold(hsq);
+
 	slot = &hsq->slot[hsq->next_tag];
 	hsq->mrq = slot->mrq;
 	hsq->qcnt--;
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index aa5c4543b55f..dd352a6ac32a 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -10,6 +10,11 @@
  * flight to avoid a long latency.
  */
 #define HSQ_NORMAL_DEPTH	2
+/*
+ * For 4k random writes, we allow hsq_depth to increase to 5
+ * for better performance.
+ */
+#define HSQ_PERFORMANCE_DEPTH	5
 
 struct hsq_slot {
 	struct mmc_request *mrq;
-- 
2.17.1


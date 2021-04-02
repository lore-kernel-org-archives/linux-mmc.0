Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F423C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF522610CF
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhDBJx5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:53:57 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46051 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231160AbhDBJx5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Apr 2021 05:53:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UUEHCRZ_1617357233;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UUEHCRZ_1617357233)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Apr 2021 17:53:53 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] mmc: moxart: Remove unused variable 'dma_time' and 'pio_time'
Date:   Fri,  2 Apr 2021 17:53:51 +0800
Message-Id: <1617357231-93064-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

drivers/mmc/host/moxart-mmc.c:257:7: warning: variable ‘dma_time’ set
but not used
drivers/mmc/host/moxart-mmc.c:395:7: warning: variable ‘pio_time’ set
but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mmc/host/moxart-mmc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 89bff4e..bde2988 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -257,7 +257,6 @@ static void moxart_dma_complete(void *param)
 static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 {
 	u32 len, dir_slave;
-	long dma_time;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
 
@@ -294,8 +293,8 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 
 	data->bytes_xfered += host->data_remain;
 
-	dma_time = wait_for_completion_interruptible_timeout(
-		   &host->dma_complete, host->timeout);
+	wait_for_completion_interruptible_timeout(&host->dma_complete,
+						  host->timeout);
 
 	dma_unmap_sg(dma_chan->device->dev,
 		     data->sg, data->sg_len,
@@ -395,7 +394,6 @@ static void moxart_prepare_data(struct moxart_host *host)
 static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct moxart_host *host = mmc_priv(mmc);
-	long pio_time;
 	unsigned long flags;
 	u32 status;
 
@@ -431,8 +429,8 @@ static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			spin_unlock_irqrestore(&host->lock, flags);
 
 			/* PIO transfers start from interrupt. */
-			pio_time = wait_for_completion_interruptible_timeout(
-				   &host->pio_complete, host->timeout);
+			wait_for_completion_interruptible_timeout(&host->pio_complete,
+								  host->timeout);
 
 			spin_lock_irqsave(&host->lock, flags);
 		}
-- 
1.8.3.1


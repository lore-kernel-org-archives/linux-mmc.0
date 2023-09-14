Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E633CEE0212
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 00:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjINADw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Sep 2023 20:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjINADv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Sep 2023 20:03:51 -0400
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C828E6A;
        Wed, 13 Sep 2023 17:03:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1061964|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0164707-0.000140752-0.983389;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.UeWrPh0_1694649822;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.UeWrPh0_1694649822)
          by smtp.aliyun-inc.com;
          Thu, 14 Sep 2023 08:03:44 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     ulf.hansson@linaro.org, CLoehle@hyperstone.com,
        adrian.hunter@intel.com, jinpu.wang@ionos.com, hare@suse.de,
        victor.shih@genesyslogic.com.tw, avri.altman@wdc.com,
        asuk4.q@gmail.com
Cc:     axboe@kernel.dk, brauner@kernel.org, f.fainelli@gmail.com,
        beanhuo@micron.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Add new flag to force hardware reset
Date:   Thu, 14 Sep 2023 08:03:48 +0800
Message-Id: <20230914000348.25790-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Entering the recovery system itself indicates a transmission error.
In this situation, we intend to execute the mmc_blk_reset function
to clear any anomalies that may be caused by errors. We have previously
discussed with several MMC device manufacturers, and they expressed
their desire for us to reset the device when errors occur to ensure
stable operation. We aim to make this code compatible with all devices
and ensure its stable performance, so we would like to add this patch

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/mmc/core/block.c | 2 +-
 include/linux/mmc/host.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b5b414a71e0b..29fbe0ddeadb 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1503,7 +1503,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
 	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
 
 	err = mmc_cqe_recovery(host);
-	if (err)
+	if (err || host->cqe_recovery_reset_always)
 		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
 	mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 62a6847a3b6f..f578541a06b5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -518,6 +518,7 @@ struct mmc_host {
 	int			cqe_qdepth;
 	bool			cqe_enabled;
 	bool			cqe_on;
+	bool			cqe_recovery_reset_always;
 
 	/* Inline encryption support */
 #ifdef CONFIG_MMC_CRYPTO
-- 
2.29.0


Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C841C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 May 2022 17:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiEaRTj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 May 2022 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346494AbiEaRTi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2022 13:19:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE5E14022
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2022 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654017577; x=1685553577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7ERBhrGR943wTxCIYHKJMxkSNmAaTIyrZnP4f7D2DLA=;
  b=ZPLhFR/VowA1UYT3x4dH0WH8lSPRGqxS4zxFEegGiMCkjAYtAfCwmc7I
   K9PSY9Zwsu24swFtJM9pLF2k8Hx6UtyUxS7us9Xa/waUqYWbWSAWMVuQr
   MAS0bpLV5rDNpdBV3TSPUwdsyl1fCe2MBtPSiNVrPcesrLnBuBszZ91q7
   linTJsYaSduWgD4/krvvUNOPbK7ySY4gwBVoSQtlyW4gagb7F5LbZD+Xv
   sdxsJiMVORuVWSGkN8c3d+JiBaxPQ2GUTzs8tgBF3J9p2qS2YIO3ymGEN
   U862sx8fIuMIDUNnX6IfWDOQTByJo4XFMxSak2fXnJ/RRjXxH9zS92Rhd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275332064"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="275332064"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:19:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="720403705"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.232])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:19:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc: block: Fix CQE recovery reset success
Date:   Tue, 31 May 2022 20:19:22 +0300
Message-Id: <20220531171922.76080-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The intention of the use of mmc_blk_reset_success() in
mmc_blk_cqe_recovery() was to prevent repeated resets when retrying and
getting the same error. However, that may not be the case - any amount
of time and I/O may pass before another recovery is needed, in which
case there would be no reason to deny it the opportunity to recover via
a reset if necessary. CQE recovery is expected seldom and failure to
recover (if the clear tasks command fails), even more seldom, so it is
better to allow the reset always, which can be done by calling
mmc_blk_reset_success() always.

Fixes: 1e8e55b67030c6 ("mmc: block: Add CQE support")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1259ca22d625..f4a1281658db 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1499,8 +1499,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
 	err = mmc_cqe_recovery(host);
 	if (err)
 		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
-	else
-		mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
+	mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
 
 	pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
 }
-- 
2.25.1


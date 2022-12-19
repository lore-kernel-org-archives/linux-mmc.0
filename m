Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854BFC4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Dec 2022 08:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiLSItp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Dec 2022 03:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiLSItH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2022 03:49:07 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1004D119;
        Mon, 19 Dec 2022 00:48:35 -0800 (PST)
Received: from SHSend.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by SHSQR01.spreadtrum.com with ESMTP id 2BJ8mHoF075381;
        Mon, 19 Dec 2022 16:48:17 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from xm13705pcu.spreadtrum.com (10.13.3.189) by
 shmbx05.spreadtrum.com (10.29.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 19 Dec 2022 16:48:16 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhenxiong.lai@unisoc.com>, <yuelin.tang@unisoc.com>,
        <wenchao.chen666@gmail.com>
Subject: [PATCH] mmc: sdhci-sprd: disable polling scan for sdio card
Date:   Mon, 19 Dec 2022 16:47:54 +0800
Message-ID: <20221219084754.11070-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.3.189]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 2BJ8mHoF075381
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Enable polling will increase the power consumption of the host.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci-sprd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 525f979e2a97..113a5c77578f 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -696,6 +696,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_host;
 
+	if ((host->mmc->caps2 & MMC_CAP2_NO_SD) &&
+			(host->mmc->caps2 & MMC_CAP2_NO_MMC))
+		host->mmc->caps &= ~MMC_CAP_NEEDS_POLL;
+
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-- 
2.17.1


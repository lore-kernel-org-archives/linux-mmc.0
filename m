Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F78EC38A2D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 19:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiJYTPS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiJYTPQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 15:15:16 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B539554657
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 12:15:09 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 26BD784BD2;
        Tue, 25 Oct 2022 21:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1666725307;
        bh=JwqENMpsL1totjuMyWpG/HaTiUhw65sVoibQe9WK7Jo=;
        h=From:To:Cc:Subject:Date:From;
        b=hPQ9Czju7JFuMK3FOi9hvzI+Xjk4Fx4eRoJkuQIIr1GTXdZ3hdEps1BCWJgbzhTuP
         Wz/UJ9hj1CmERLu8hoEZPAAjDynGJPhm7wvZY5WQvr4gXtaELfHCMnO6HbHgoT5b9m
         W6TSBCPHJrfA2Ynl+VizvFuSMX8LWzJ3w7K21Lc0+4rgnUCj1lrQO9LTo5J9cMWuQR
         p3GWzJ/Z5pY+x4V/O73HQgnJWaIp2uiNgCAE3F8iFp0p9Y9L/k5luMBM09nvIp6Uj7
         eGELSlCkp78N4Dx3bji8KOkmTHVsUu+iwQ/YPNHMf5AZJd2MO0DMpLdkEKolPCqELb
         M1hAG1yTtvOGQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mmc: sdhci-of-arasan: Override SDHCI_RETUNING_TIMER_COUNT_MASK on ZynqMP
Date:   Tue, 25 Oct 2022 21:15:00 +0200
Message-Id: <20221025191500.149167-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Xilinx ZynqMP, the reg_capabilities (SDIO) Register

https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
Absolute Address  0x00FF160040 (SD0)
Reset Value       0x280737EC6481

really reads 0x200737EC6481 . The interesting part is the
top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
makes the SDHCI core disable retuning timer.

Fix this up here by explicitly setting tuning_count to 8
as it should be, otherwise an eMMC might fail in various
thermal conditions

Note that the diff is best shown with -w option, this makes it
visible what happened with !sdhci_arasan->has_cqe conditional,
which is placed between sdhci_setup_host() and __sdhci_add_host()
calls. Since sdhci_add_host() is also a sequence of these two
calls and host->tuning_count must be overriden before calling
__sdhci_add_host(), call the two calls separately and do all
the adjustments between them in either case.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
To: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/sdhci-of-arasan.c | 57 ++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 3997cad1f793d..465498f2a7c0f 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1521,37 +1521,56 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	return 0;
 }
 
-static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
+static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan,
+				 struct device *dev)
 {
 	struct sdhci_host *host = sdhci_arasan->host;
 	struct cqhci_host *cq_host;
 	bool dma64;
 	int ret;
 
-	if (!sdhci_arasan->has_cqe)
-		return sdhci_add_host(host);
-
 	ret = sdhci_setup_host(host);
 	if (ret)
 		return ret;
 
-	cq_host = devm_kzalloc(host->mmc->parent,
-			       sizeof(*cq_host), GFP_KERNEL);
-	if (!cq_host) {
-		ret = -ENOMEM;
-		goto cleanup;
-	}
+	/*
+	 * On Xilinx ZynqMP, the reg_capabilities (SDIO) Register
+	 *
+	 * https://www.xilinx.com/htmldocs/registers/ug1087/sdio___reg_capabilities.html#
+	 * Absolute Address  0x00FF160040 (SD0)
+	 * Reset Value	     0x280737EC6481
+	 *
+	 * really reads 0x200737EC6481 . The interesting part is the
+	 * top 32 bits, which are SDHCI_CAPABILITIES_1 = 0x2007. The
+	 * missing 0x800 is SDHCI_RETUNING_TIMER_COUNT_MASK=0, which
+	 * makes the SDHCI core disable retuning timer.
+	 *
+	 * Fix this up here by explicitly setting tuning_count to 8
+	 * as it should be, otherwise an eMMC might fail in various
+	 * thermal conditions.
+	 */
+	if (of_device_is_compatible(dev->of_node, "xlnx,zynqmp-8.9a"))
+		host->tuning_count = 1 << (8 - 1);
+
+	if (sdhci_arasan->has_cqe) {
+		cq_host = devm_kzalloc(host->mmc->parent,
+				       sizeof(*cq_host), GFP_KERNEL);
+		if (!cq_host) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
 
-	cq_host->mmio = host->ioaddr + SDHCI_ARASAN_CQE_BASE_ADDR;
-	cq_host->ops = &sdhci_arasan_cqhci_ops;
+		cq_host->mmio = host->ioaddr + SDHCI_ARASAN_CQE_BASE_ADDR;
+		cq_host->ops = &sdhci_arasan_cqhci_ops;
 
-	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
-	if (dma64)
-		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+		dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+		if (dma64)
+			cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
 
-	ret = cqhci_init(cq_host, host->mmc, dma64);
-	if (ret)
-		goto cleanup;
+		ret = cqhci_init(cq_host, host->mmc, dma64);
+		if (ret)
+			goto cleanup;
+	}
 
 	ret = __sdhci_add_host(host);
 	if (ret)
@@ -1711,7 +1730,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
-	ret = sdhci_arasan_add_host(sdhci_arasan);
+	ret = sdhci_arasan_add_host(sdhci_arasan, &pdev->dev);
 	if (ret)
 		goto err_add_host;
 
-- 
2.35.1


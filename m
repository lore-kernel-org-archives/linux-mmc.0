Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0FDC433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 03:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E0464DEE
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 03:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhA2Dln (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Jan 2021 22:41:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40886 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229757AbhA2Dlm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2021 22:41:42 -0500
X-UUID: 0cac29a904ee46e5802bb015422a89fa-20210129
X-UUID: 0cac29a904ee46e5802bb015422a89fa-20210129
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 426753346; Fri, 29 Jan 2021 11:40:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Jan 2021 11:40:54 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jan 2021 11:40:53 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 1/2] mmc: mediatek: add Inline Crypto Engine support
Date:   Fri, 29 Jan 2021 11:39:16 +0800
Message-ID: <20210129033916.26508-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add Inline Crypto Engine(ICE) support into Mediatek MMC Host.

- add crypto clock control and ungate it before CQHCI init
- set MMC_CAP2_CRYPTO property of MMC

Change-Id: I6dc35391fd2841609c5be0df1fe1d12ec28ee0c4
Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index de09c6347524..e870afd66ae8 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -441,6 +441,7 @@ struct msdc_host {
 	struct clk *bus_clk;	/* bus clock which used to access register */
 	struct clk *src_clk_cg; /* msdc source clock control gate */
 	struct clk *sys_clk_cg;	/* msdc subsys clock control gate */
+	struct clk *crypto_clk; /* msdc crypto clock */
 	struct clk_bulk_data bulk_clks[MSDC_NR_CLOCKS];
 	u32 mclk;		/* mmc subsystem clock frequency */
 	u32 src_clk_freq;	/* source clock frequency */
@@ -802,6 +803,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
 
 static void msdc_gate_clock(struct msdc_host *host)
 {
+	clk_disable_unprepare(host->crypto_clk);
 	clk_bulk_disable_unprepare(MSDC_NR_CLOCKS, host->bulk_clks);
 	clk_disable_unprepare(host->src_clk_cg);
 	clk_disable_unprepare(host->src_clk);
@@ -822,7 +824,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
 		dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
 		return;
 	}
-
+	clk_prepare_enable(host->crypto_clk);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
 }
@@ -2510,6 +2512,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	/* only eMMC has crypto property */
+#ifdef CONFIG_MMC_CRYPTO
+	if ((mmc->caps2 & MMC_CAP2_NO_SD) && (mmc->caps2 & MMC_CAP2_NO_SDIO))
+		mmc->caps2 |= MMC_CAP2_CRYPTO;
+#endif
+	if (mmc->caps2 & MMC_CAP2_CRYPTO) {
+		host->crypto_clk = devm_clk_get(&pdev->dev, "crypto_clk");
+		if (IS_ERR(host->crypto_clk))
+	}
+
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = -EINVAL;
@@ -2580,6 +2592,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		host->dma_mask = DMA_BIT_MASK(32);
 	mmc_dev(mmc)->dma_mask = &host->dma_mask;
 
+	msdc_ungate_clock(host);
 	if (mmc->caps2 & MMC_CAP2_CQE) {
 		host->cq_host = devm_kzalloc(mmc->parent,
 					     sizeof(*host->cq_host),
@@ -2616,7 +2629,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	platform_set_drvdata(pdev, mmc);
-	msdc_ungate_clock(host);
 	msdc_init_hw(host);
 
 	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
-- 
2.18.0


Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960AC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 07:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD65064DEC
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Jan 2021 07:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhA2HKu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:10:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46712 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230388AbhA2HKq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2021 02:10:46 -0500
X-UUID: 64d76fef7d6b4377853ac9ca91fa432b-20210129
X-UUID: 64d76fef7d6b4377853ac9ca91fa432b-20210129
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <peng.zhou@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 99018808; Fri, 29 Jan 2021 15:10:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Jan 2021 15:09:57 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jan 2021 15:09:56 +0800
From:   Peng Zhou <peng.zhou@mediatek.com>
To:     <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Satya Tangirala <satyat@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2 1/2] mmc: mediatek: add Inline Crypto Engine support
Date:   Fri, 29 Jan 2021 15:08:25 +0800
Message-ID: <20210129070825.12304-1-peng.zhou@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8EE6806FE790C68FD0E4DB81044D2C455FAFC63E5C3D67819C01BF20D28B61102000:8
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- add crypto clock control and ungate it before CQHCI init
- set MMC_CAP2_CRYPTO property of eMMC

Change-Id: I3a28eaa3718eee73259b4d60867cce25525f9bba
Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index de09c6347524..928349284998 100644
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
+	if ((mmc->caps2 & MMC_CAP2_NO_SD) && (mmc->caps2 & MMC_CAP2_NO_SDIO))
+		mmc->caps2 |= MMC_CAP2_CRYPTO;
+
+	if (mmc->caps2 & MMC_CAP2_CRYPTO) {
+		host->crypto_clk = devm_clk_get(&pdev->dev, "crypto_clk");
+		if (IS_ERR(host->crypto_clk))
+			host->crypto_clk = NULL;
+	}
+
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = -EINVAL;
@@ -2580,6 +2592,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		host->dma_mask = DMA_BIT_MASK(32);
 	mmc_dev(mmc)->dma_mask = &host->dma_mask;
 
+	/* here ungate due to cqhci init will access registers */
+	msdc_ungate_clock(host);
 	if (mmc->caps2 & MMC_CAP2_CQE) {
 		host->cq_host = devm_kzalloc(mmc->parent,
 					     sizeof(*host->cq_host),
@@ -2616,7 +2630,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	platform_set_drvdata(pdev, mmc);
-	msdc_ungate_clock(host);
 	msdc_init_hw(host);
 
 	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
-- 
2.18.0


Return-Path: <SRS0=rMqt=3C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10FCC33CAE
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8758D24655
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdN9eNr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAMVID (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:08:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46229 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAMVIC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2020 16:08:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so5280014pgb.13;
        Mon, 13 Jan 2020 13:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bZHyA1pnyUOSaH6sIl5fA7IIKshVElY/2p2ut+5kOaQ=;
        b=sdN9eNr07g2kJ1ITVDp0TNjWSLys9RQy1ZdVzcG/3SfKuPwDWgV8Nur8qCGDAVRfE/
         fcTpnrOMRkqfkPmRR8DD4YNCnM+XwpMwvTMp+dUYrAxINFzxj2Xo7cut3iU70gTLRGFa
         ByKJ1sLpMjcsk2JKEPNb28ScvP6tl6urgMRaKncQe0HITx/XtuUM+UKzMj8o6LG5jZ5g
         N8/M4RfvhEWGaLspv4geZbVCycj+Z+m674voNokRIunu6DVzliC0+KdCqTs1ReOBxAnx
         inOoPL0OHVO/slPdMquWDYoLDqzcZ/oDt5kwrAok2LtBhOr+t19+5MZJ/v5cQ36PxREk
         wQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bZHyA1pnyUOSaH6sIl5fA7IIKshVElY/2p2ut+5kOaQ=;
        b=Kq2/Vw1m9SenYDe5KNGVTG54K+mu1DuChjIcuwpTeef2YYmppOaZ0I7JG3NKWUvpEa
         EYvRv1eIWj1lAcaGrQ6fckyIol6U6mlC3kdSngQybI63r2LoNm0Bc0zsErDpfy2OqHKo
         vCiXf6xRGU66Qc6L0kSt352GHVTM5Uk3337Mia+WJvdX/27sYmxVhi7JMpEMA2PMHaPU
         QLIlvjzNQ24dXkwy55R0x4v9I5ZOqoogCpByk4K5c+ifC8nfPoa8cqXkxYGMwmRpuhcW
         IR4hYeklgsXPTVkcw4QfV1DJ7hMJoW/MjjEjpgrsUc+b+/y/HHFwMqxR6dSDm1qlT9hJ
         8Mqw==
X-Gm-Message-State: APjAAAUHP8gBaMTX074mDpAuWO6DwbgFWBy0Xgt0X/fQ8WwIYod2O8Yp
        rMCLu9Wx2Hh2lziOwlsY7Y5RyrY1hRMjeQ==
X-Google-Smtp-Source: APXvYqxU8UBmtvYuVuX3/nVbKboe1z24KIGFrgYkD4UDVAQnisLGoaslVQUYy2VnpHAYyKYJyMAhjQ==
X-Received: by 2002:a63:6507:: with SMTP id z7mr23578729pgb.322.1578949680591;
        Mon, 13 Jan 2020 13:08:00 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s1sm14195827pgv.87.2020.01.13.13.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:08:00 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 5/6] mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)
Date:   Mon, 13 Jan 2020 16:07:05 -0500
Message-Id: <20200113210706.11972-6-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
References: <20200113210706.11972-1-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The latest Arasan controller first used in the 7216 now supports
CQE so enable this feature.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/sdhci-brcmstb.c | 140 +++++++++++++++++++++++++++++--
 2 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d06b2dfe3c95..8897de30959a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -990,6 +990,7 @@ config MMC_SDHCI_BRCMSTB
 	tristate "Broadcom SDIO/SD/MMC support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
 	depends on MMC_SDHCI_PLTFM
+	select MMC_CQHCI
 	default y
 	help
 	  This selects support for the SDIO/SD/MMC Host Controller on
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 7ea426ba5cbc..2c4b6e7e3d9a 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -10,8 +10,10 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include "sdhci-pltfm.h"
+#include "cqhci.h"
 
 #define SDHCI_VENDOR 0x78
 #define  SDHCI_VENDOR_ENHANCED_STRB 0x1
@@ -19,12 +21,16 @@
 #define BRCMSTB_PRIV_FLAGS_NO_64BIT		BIT(0)
 #define BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT	BIT(1)
 
+#define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
+	bool has_cqe;
 };
 
 struct brcmstb_match_priv {
 	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
+	struct sdhci_ops *ops;
 	unsigned int flags;
 };
 
@@ -44,28 +50,74 @@ static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
 	writel(reg, host->ioaddr + SDHCI_VENDOR);
 }
 
-static const struct sdhci_ops sdhci_brcmstb_ops = {
+static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+
+	host->mmc->actual_clock = 0;
+
+	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (clock == 0)
+		return;
+
+	sdhci_enable_clk(host, clk);
+}
+
+static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static void sdhci_brcmstb_cqe_enable(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	while (reg & SDHCI_DATA_AVAILABLE) {
+		sdhci_readl(host, SDHCI_BUFFER);
+		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	}
+
+	sdhci_cqe_enable(mmc);
+}
+
+static const struct cqhci_host_ops sdhci_brcmstb_cqhci_ops = {
+	.enable         = sdhci_brcmstb_cqe_enable,
+	.disable        = sdhci_cqe_disable,
+	.dumpregs       = sdhci_brcmstb_dumpregs,
+};
+
+static struct sdhci_ops sdhci_brcmstb_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-static const struct sdhci_pltfm_data sdhci_brcmstb_pdata = {
-	.ops = &sdhci_brcmstb_ops,
+static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
+	.set_clock = sdhci_brcmstb_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-static const struct brcmstb_match_priv match_priv_7425 = {
+static struct brcmstb_match_priv match_priv_7425 = {
 	.flags = BRCMSTB_PRIV_FLAGS_NO_64BIT |
 	BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
+	.ops = &sdhci_brcmstb_ops,
 };
 
-static const struct brcmstb_match_priv match_priv_7445 = {
+static struct brcmstb_match_priv match_priv_7445 = {
 	.flags = BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
+	.ops = &sdhci_brcmstb_ops,
 };
 
 static const struct brcmstb_match_priv match_priv_7216 = {
 	.hs400es = sdhci_brcmstb_hs400es,
+	.ops = &sdhci_brcmstb_ops_7216,
 };
 
 static const struct of_device_id sdhci_brcm_of_match[] = {
@@ -75,20 +127,85 @@ static const struct of_device_id sdhci_brcm_of_match[] = {
 	{},
 };
 
+static u32 sdhci_brcmstb_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
+static int sdhci_brcmstb_add_host(struct sdhci_host *host,
+				  struct sdhci_brcmstb_priv *priv)
+{
+	struct cqhci_host *cq_host;
+	bool dma64;
+	int ret;
+
+	if (!priv->has_cqe)
+		return sdhci_add_host(host);
+
+	dev_dbg(mmc_dev(host->mmc), "CQE is enabled\n");
+	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	cq_host = devm_kzalloc(mmc_dev(host->mmc),
+			       sizeof(*cq_host), GFP_KERNEL);
+	if (!cq_host) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	cq_host->mmio = host->ioaddr + SDHCI_ARASAN_CQE_BASE_ADDR;
+	cq_host->ops = &sdhci_brcmstb_cqhci_ops;
+
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	if (dma64) {
+		dev_dbg(mmc_dev(host->mmc), "Using 64 bit DMA\n");
+		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+		cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
+	}
+
+	ret = cqhci_init(cq_host, host->mmc, dma64);
+	if (ret)
+		goto cleanup;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	sdhci_cleanup_host(host);
+	return ret;
+}
+
 static int sdhci_brcmstb_probe(struct platform_device *pdev)
 {
 	const struct brcmstb_match_priv *match_priv;
+	struct sdhci_pltfm_data brcmstb_pdata;
 	struct sdhci_pltfm_host *pltfm_host;
 	const struct of_device_id *match;
 	struct sdhci_brcmstb_priv *priv;
 	struct sdhci_host *host;
 	struct resource *iomem;
+	bool has_cqe = false;
 	struct clk *clk;
 	int res;
 
 	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
 	match_priv = match->data;
 
+	dev_dbg(&pdev->dev, "Probe found match for %s\n",  match->compatible);
+
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		if (PTR_ERR(clk) == -EPROBE_DEFER)
@@ -100,7 +217,13 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (res)
 		return res;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_brcmstb_pdata,
+	memset(&brcmstb_pdata, 0, sizeof(brcmstb_pdata));
+	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
+		has_cqe = true;
+		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
+	}
+	brcmstb_pdata.ops = match_priv->ops;
+	host = sdhci_pltfm_init(pdev, &brcmstb_pdata,
 				sizeof(struct sdhci_brcmstb_priv));
 	if (IS_ERR(host)) {
 		res = PTR_ERR(host);
@@ -109,6 +232,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
+	priv->has_cqe = has_cqe;
 
 	/* Map in the non-standard CFG registers */
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -141,13 +265,13 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 		host->caps &= ~SDHCI_CAN_64BIT;
 	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
-			SDHCI_SUPPORT_DDR50);
+			 SDHCI_SUPPORT_DDR50);
 	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
 
 	if (match_priv->flags & BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	res = sdhci_add_host(host);
+	res = sdhci_brcmstb_add_host(host, priv);
 	if (res)
 		goto err;
 
-- 
2.17.1


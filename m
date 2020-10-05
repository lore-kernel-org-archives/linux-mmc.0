Return-Path: <SRS0=j7Ik=DM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC0C4363A
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 10:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FF62075A
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 10:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtrpYIa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJEKy2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJEKy1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2020 06:54:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA56C0613CE;
        Mon,  5 Oct 2020 03:54:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id x2so5371839pjk.0;
        Mon, 05 Oct 2020 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kc2IEv3JfGigt4VvcPf4/imXiA2zA0r0UImduGDyPLs=;
        b=FtrpYIa4biS3xspWPVZx7Rl4dlZzbOP7i4dNzLodRnAZfyYuA/uFTVl8hbNY7X9U6X
         Ae3ke5kb5vnO0wgw75ygfIn8eQi7vcrmRl4EeZIB+TjOrdDPTZeMXga4xNYJn2cYakSs
         NyXlkJH67DyYXEGfNbxVZemRyYdPbRSqfO2QRHCr4JaoEajfABqQN1bJIsf66iKU9A2L
         3KlY1rXrmvD2TCKds88ndohmhIxEYriy/FWQqiVB0hcZpO2UqPrH0yukhv8yx1XWBhmv
         KGAVWefgvTqD6JIFsad035cTHq2G5jScTdIF2VsGMeqH4TFOfoM4F8hafYYeJTq+mEDR
         Isyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kc2IEv3JfGigt4VvcPf4/imXiA2zA0r0UImduGDyPLs=;
        b=bmLFK0irlmosA8HjviviThtFYbtDGgNrJmcw/0OvPDfViNziE/R2HN196BeyFpkjzk
         DAGDUFjXZULqpvStBZxmlZl4lRcBg2OTFhBnzcXKKeXQYSW1CT24yPvQbQUnXFufqA+x
         +2mzYeVkHjMz0EINe+34lVULVsY41oxxy2SUgjJe6quA/5fua08MwNKBXsusy6OWdZ7H
         MUUoNGIeWCO5S4zhBH8m2UPWV3Bu/kZD07B82jgnS+LeON3ZlrJ9PkpaQRdFGJB4qmje
         Ao0siaruK28nKeqnTB/9XrNZBVr47UxmiVpTXbZgeCEK951QIrkMZpdTjMc3N75OSOPY
         q78Q==
X-Gm-Message-State: AOAM530Aawj6l9U4Mf9YGxb3f8winjTn8HZWNW9cAF3SeZ5cXT0gh3Jr
        2iOHnMjod4sqmqyT1ERtTkg=
X-Google-Smtp-Source: ABdhPJzDz8UtqskcUzNMNbSX5dATFgx7DtiVwuiqDs1U/yKwH0x9+LCauwqLoDmVtvHztYso1htocw==
X-Received: by 2002:a17:90a:e64b:: with SMTP id ep11mr13636504pjb.208.1601895265748;
        Mon, 05 Oct 2020 03:54:25 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id p6sm12170526pfn.63.2020.10.05.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 03:54:25 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
X-Google-Original-From: Ben Chuang <ben.chuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuanggli@gmail.com>
Subject: [PATCH -next] mmc: sdhci-pci-gli: Add CQHCI Support for GL9763E
Date:   Mon,  5 Oct 2020 18:55:09 +0800
Message-Id: <20201005105509.11343-1-ben.chuanggli@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add CQHCI initialization and implement CQHCI operations for GL9763E.
Use bit19 of the register (0x888) to decide whether to disable command
queuing. If the bit is set, the command queuing will be disabled.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 150 ++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 5da2b06d84ae..9887485a4134 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include "sdhci.h"
 #include "sdhci-pci.h"
+#include "cqhci.h"
 
 /*  Genesys Logic extra registers */
 #define SDHCI_GLI_9750_WT         0x800
@@ -81,9 +82,16 @@
 #define   GLI_9763E_VHS_REV_R      0x0
 #define   GLI_9763E_VHS_REV_M      0x1
 #define   GLI_9763E_VHS_REV_W      0x2
+#define PCIE_GLI_9763E_MB	 0x888
+#define   GLI_9763E_MB_CMDQ_OFF	   BIT(19)
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define SDHCI_GLI_9763E_CQE_BASE_ADDR	 0x200
+#define GLI_9763E_CQE_TRNS_MODE	   (SDHCI_TRNS_MULTI | \
+				    SDHCI_TRNS_BLK_CNT_EN | \
+				    SDHCI_TRNS_DMA)
+
 #define PCI_GLI_9755_WT       0x800
 #define   PCI_GLI_9755_WT_EN    BIT(0)
 #define   GLI_9755_WT_EN_ON     0x1
@@ -578,6 +586,30 @@ static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
 
 	return sdhci_pci_resume_host(chip);
 }
+
+static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	ret = sdhci_pci_gli_resume(chip);
+	if (ret)
+		return ret;
+
+	return cqhci_resume(slot->host->mmc);
+}
+
+static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	ret = cqhci_suspend(slot->host->mmc);
+	if (ret)
+		return ret;
+
+	return sdhci_suspend_host(slot->host);
+}
 #endif
 
 static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
@@ -614,6 +646,110 @@ static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
+static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
+{
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u32 value;
+
+	value = cqhci_readl(cq_host, CQHCI_CFG);
+	value |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, value, CQHCI_CFG);
+}
+
+static void sdhci_gl9763e_cqe_enable(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_writew(host, GLI_9763E_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
+	sdhci_cqe_enable(mmc);
+}
+
+static u32 sdhci_gl9763e_cqhci_irq(struct sdhci_host *host, u32 intmask)
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
+static void sdhci_gl9763e_cqe_post_disable(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u32 value;
+
+	value = cqhci_readl(cq_host, CQHCI_CFG);
+	value &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, value, CQHCI_CFG);
+	sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+}
+
+static const struct cqhci_host_ops sdhci_gl9763e_cqhci_ops = {
+	.enable         = sdhci_gl9763e_cqe_enable,
+	.disable        = sdhci_cqe_disable,
+	.dumpregs       = sdhci_gl9763e_dumpregs,
+	.pre_enable     = sdhci_gl9763e_cqe_pre_enable,
+	.post_disable   = sdhci_gl9763e_cqe_post_disable,
+};
+
+static int gl9763e_add_host(struct sdhci_pci_slot *slot)
+{
+	struct device *dev = &slot->chip->pdev->dev;
+	struct sdhci_host *host = slot->host;
+	struct cqhci_host *cq_host;
+	bool dma64;
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	cq_host = devm_kzalloc(dev, sizeof(*cq_host), GFP_KERNEL);
+	if (!cq_host) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	cq_host->mmio = host->ioaddr + SDHCI_GLI_9763E_CQE_BASE_ADDR;
+	cq_host->ops = &sdhci_gl9763e_cqhci_ops;
+
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	if (dma64)
+		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
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
+static void sdhci_gl9763e_reset(struct sdhci_host *host, u8 mask)
+{
+	if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
+	    host->mmc->cqe_private)
+		cqhci_deactivate(host->mmc);
+	sdhci_reset(host, mask);
+}
+
 static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -636,7 +772,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 
 static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 {
+	struct pci_dev *pdev = slot->chip->pdev;
 	struct sdhci_host *host = slot->host;
+	u32 value;
 
 	host->mmc->caps |= MMC_CAP_8_BIT_DATA |
 			   MMC_CAP_1_8V_DDR |
@@ -646,6 +784,11 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 			    MMC_CAP2_HS400_ES |
 			    MMC_CAP2_NO_SDIO |
 			    MMC_CAP2_NO_SD;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_MB, &value);
+	if (!(value & GLI_9763E_MB_CMDQ_OFF))
+		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
@@ -699,9 +842,10 @@ static const struct sdhci_ops sdhci_gl9763e_ops = {
 	.set_clock		= sdhci_set_clock,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_reset,
+	.reset			= sdhci_gl9763e_reset,
 	.set_uhs_signaling	= sdhci_set_gl9763e_signaling,
 	.voltage_switch		= sdhci_gli_voltage_switch,
+	.irq                    = sdhci_gl9763e_cqhci_irq,
 };
 
 const struct sdhci_pci_fixes sdhci_gl9763e = {
@@ -709,6 +853,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 	.probe_slot	= gli_probe_slot_gl9763e,
 	.ops            = &sdhci_gl9763e_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume         = sdhci_pci_gli_resume,
+	.resume		= sdhci_cqhci_gli_resume,
+	.suspend	= sdhci_cqhci_gli_suspend,
 #endif
+	.add_host       = gl9763e_add_host,
 };
-- 
2.28.0


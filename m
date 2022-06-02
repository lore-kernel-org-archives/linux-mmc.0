Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C7FC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jun 2022 11:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiFBLXs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jun 2022 07:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFBLXr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2022 07:23:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C021FBEC
        for <linux-mmc@vger.kernel.org>; Thu,  2 Jun 2022 04:23:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p8so4500536pfh.8
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jun 2022 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78cLgF4SeSapv7fMQZnNsSS4D8YUd5vkiitqKH+wfrQ=;
        b=n5dRt01kG/XcAu6Qzk2EdsfmxFdXNELSN5B1Z1HpUBEAJQC5CRnlZbxwS+pNUn2Dr9
         hPxzpiVwulKkrJHp6UZbLnUS7uoe+jluiR4BmOtGi2HUw47GL2vHWD/zPynLUzA0cGxz
         XAKyxIY2r3dOpZ/Kr/xqfb2SHIpeZz3za3nvh+LrkOJaas5WUAk8ZKn/SPtjsGGT9ZWc
         +DMNZcxRvXM2M/UeP3YC4JIRi4gY+w5LNoCAcuhOAYo2jsC4YpCTf6BAWk6YIzmld4L6
         v1gxXxSk/L8DaGOpKa7t7xVeWzhatCe/yRZeyxrq0yOYhR204JhmK3Dc6PlxTDpwWVsi
         UJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78cLgF4SeSapv7fMQZnNsSS4D8YUd5vkiitqKH+wfrQ=;
        b=yysF6yW2ikpgbrauSzQntYoN6L1Ix6eBGmU4gDvrU4vg+RpcAw/v0zBTcm2mQXmJ3K
         AFYxIiEPNDAZVtqT6B8uQt3l2CRiCOjJgFhwS3vd7a/dvXrY7XIj2YEM+rbo6jwVB+dy
         Ag2LBSNDDeS25/SRISXxZIoM+3NTLzj1yYloBRkE85udusY46p/wnZTFHWPtD7vypRR5
         AZoI0R/hPryNXl+jxYVIMyKDMCJThEIVqBSVbPgB8Xsu6LCk9BpkWICb9OyNjTapGckY
         gjNss5AiKXdBY+AbCAhlW6Tk7Jqxamt4sWtww6TreCd8b9L0x/FjfcWl4v66xACAP90l
         WV/g==
X-Gm-Message-State: AOAM530r7zTCv763Fk6Cu2wmHABvpqFgqQEIPSxQU40LPKs7yVUiunKm
        B04r+mvahoqriHfCVTTnTvk=
X-Google-Smtp-Source: ABdhPJwP4bNr3v0JqiAjC96Tny9+0lOWgnMkKqn7fem5M0GnvWVlktP+YYbbYv7WxQkKuQF66oE98w==
X-Received: by 2002:aa7:88c2:0:b0:518:dca4:5b07 with SMTP id k2-20020aa788c2000000b00518dca45b07mr43688020pff.41.1654169024623;
        Thu, 02 Jun 2022 04:23:44 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id r12-20020a17090b050c00b001e0c1044ceasm3045085pjz.43.2022.06.02.04.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 04:23:44 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, SeanHY.chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: host: Improve READ/WRITE Performance of GL9763E
Date:   Thu,  2 Jun 2022 19:23:38 +0800
Message-Id: <20220602112338.49976-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

This patch is the follow-up to the patch [1] and adopt Ulf's comment.

Due to flaws in hardware design, GL9763E takes long time to exit from L1
state. The I/O performance will suffer severe impact if it often enter
and exit L1 state during I/O requests.

To improve READ/WRITE performance and take battery life into account, we
turn on GL9763E L1 negotiation before entering runtime suspend and turn
off GL9763E L1 negotiation while executing runtime resume. That is to to
say, GL9763E will not enter L1 state when executing I/O requests and
enter L1 state when PCIe bus idle.

[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=645922

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 57 +++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d09728c37d03..891bcd38fd6d 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -95,9 +95,12 @@
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define PCIE_GLI_9763E_CFG       0x8A0
+#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
+
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
-#define   GLI_9763E_CFG2_L1DLY_MID 0x54
+#define   GLI_9763E_CFG2_L1DLY_MID 0x54		// Set L1 entry delay time to 21us
 
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
@@ -144,6 +147,10 @@
 
 #define GLI_MAX_TUNING_LOOP 40
 
+struct gli_host {
+	bool lpm_negotiation_enabled;
+};
+
 /* Genesys Logic chipset */
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
@@ -818,6 +825,43 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
+static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
+
+	if (enable)
+		value &= ~GLI_9763E_CFG_LPSN_DIS;
+	else
+		value |= GLI_9763E_CFG_LPSN_DIS;
+
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+	value &= ~GLI_9763E_VHS_REV;
+	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+}
+
+static void gl9763e_set_lpm_negotiation(struct sdhci_pci_slot *slot, bool enable)
+{
+	struct gli_host *gli_host = sdhci_pci_priv(slot);
+
+	if (gli_host->lpm_negotiation_enabled == enable)
+		return;
+
+	gli_host->lpm_negotiation_enabled = enable;
+
+	gl9763e_set_low_power_negotiation(slot, enable);
+}
+
 static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -921,6 +965,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
 	u32 value;
+	struct gli_host *gli_host = sdhci_pci_priv(slot);
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
@@ -941,6 +986,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
 
+	/* Default setting of LPM negotiation is enabled. */
+	gli_host->lpm_negotiation_enabled = true;
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
 	value &= ~GLI_9763E_HS400_RXDLY;
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
@@ -959,6 +1007,9 @@ static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
 	struct sdhci_host *host = slot->host;
 	u16 clock;
 
+	/* Enable LPM negotiatiom to allow entering L1 state */
+	gl9763e_set_lpm_negotiation(slot, true);
+
 	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 	clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
 	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
@@ -989,6 +1040,9 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 	clock |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
 
+	/* Disable LPM negotiatiom to avoid entering L1 state. */
+	gl9763e_set_lpm_negotiation(slot, false);
+
 	return 0;
 }
 #endif
@@ -1109,4 +1163,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 	.allow_runtime_pm = true,
 #endif
 	.add_host       = gl9763e_add_host,
+	.priv_size      = sizeof(struct gli_host),
 };
-- 
2.36.1


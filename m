Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7175EC43334
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jun 2022 11:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiFBLsY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jun 2022 07:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiFBLsX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2022 07:48:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F267926715E
        for <linux-mmc@vger.kernel.org>; Thu,  2 Jun 2022 04:48:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 7so3753566pga.12
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jun 2022 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yHcNDCSzZkf4+zfBC2wet23FQJTTFvErE0wxEeLCHE=;
        b=Cd+Ics1Bhn8aQUMpBokmkwh2lVNaCvtkPkQCz2YDmccpIcZbSPT9wSgGQMY2B2ipeW
         RN/c9/ZeZczbsMxe4BqU8vqn8AzTmgBBYzWdu0HvIyy8sBqUfO2JSog+/LoFC4hiQ3zg
         tR7QvlVyJSgsm/aEiegYqcF8u/cf1Oso9EHzi8PkSsMnvWu1H4JY6F6FEEIYknrE+5rG
         ntPbIYW6Nayz2K/xhuDlirWM3hmYY8jAZEtYF+s32yW9Nh/AVtnSimmsQu3l5l+xrczZ
         j/+Er5jIgsN+21rZl2ePzheb5GPWaxJpGmmNRB7SWEpBVzjSxAbbAm9PZZ7AGZbN4CJa
         xvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yHcNDCSzZkf4+zfBC2wet23FQJTTFvErE0wxEeLCHE=;
        b=Y1rywZsK9nNwIw6DMqw/nQpnYPc1TPRSOqcJMoEpfuIlh/NumCXJTsNl74t6XB8jOV
         uA3Novfdj/RyDlfKG8rO0GNi+MEFP4ryv5AU9AQGSio4Ch+5w/di5M6k4monr6l2udov
         hb8b0r17vm6WCTA3AkNzeIZ1iKNr5n9GajspVFZgjPSZYQuh0kPrj0683uO2Z+eqmFrX
         oP78RF5XYlQ3frxcWhy+YVGQMUHu2erZ31jy1LPBp8H9gmamH6FLBDuGls1g1deWqqZm
         EWGuXz+yI3lw9UFLve1dgOZkrAc21UxPUb2zq4gSay+9xEuFBKszs5rPupgAjEdOHg3r
         5E/g==
X-Gm-Message-State: AOAM530yXBl3qOZeWOBOA1xbl42WvdGH5rGrdFO3H6SyJfEgKT7/rz0i
        DIIAHflZ9Wkvy8RVqQrFNwM=
X-Google-Smtp-Source: ABdhPJwtNsQ8OlVbGjjBlM+zvkjbIz9oHDHs+lloowCTl7Z8MZuxHULuSwGeUZFEKz775/sVT09EPA==
X-Received: by 2002:a63:fe08:0:b0:3fa:b2bd:e616 with SMTP id p8-20020a63fe08000000b003fab2bde616mr3919031pgh.114.1654170500446;
        Thu, 02 Jun 2022 04:48:20 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b0051bb0be7109sm3343679pfa.78.2022.06.02.04.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 04:48:20 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, SeanHY.chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [RESEND] mmc: host: Improve READ/WRITE Performance of GL9763E
Date:   Thu,  2 Jun 2022 19:48:15 +0800
Message-Id: <20220602114815.1801-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

Resend this path to fix typo in the following message.

This patch is the follow-up to the patch [1] and adopt Ulf's comment.

Due to flaws in hardware design, GL9763E takes long time to exit from L1
state. The I/O performance will suffer severe impact if it often enter
and exit L1 state during I/O requests.

To improve READ/WRITE performance and take battery life into account, we
turn on GL9763E L1 negotiation before entering runtime suspend and turn
off GL9763E L1 negotiation while executing runtime resume. That is to say,
GL9763E will not enter L1 state when executing I/O requests and enter L1 
state when PCIe bus idle.

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


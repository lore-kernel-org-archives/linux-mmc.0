Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8878FC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 25 May 2022 12:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiEYM2H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiEYM2G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 08:28:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA66D4CD
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 05:28:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s14so18412976plk.8
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yu/kDBP9c/lSTM9n6WvaoP6AXgngZe8uV9Ddp01io9Q=;
        b=ezGi4Xn4DCbwzcGDBFk24MH9NV9ID0bu93Q8ixAaxxScxPOnpbXdgNC221oiVr+kY+
         wT/yZmCwMehNXo/vPu2JzWwcwa59+P4O+1woX+dB2+8uLooQ7paYEF/PY3IB3wCTqurD
         AOj5xW2ctpt8fyVUjl8jmcP5w1CHgXwnc8GCi26CRMVrNeuqazs3DiWUXPU9EwLrXpQf
         GqPJk9pHE6b26GgdAQ/6XQYTWNu1VD/slkiI24On1ZKsvnhcgXh2x+fPaXBRHFJGCgBt
         9sqiLDBfsXiEaiVq7VmREjSsAfWsEyQrxfkgyPso3VH8DqNyWm2r46vKKysSlxhOmvKj
         ezNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yu/kDBP9c/lSTM9n6WvaoP6AXgngZe8uV9Ddp01io9Q=;
        b=iCSALbFyAnkCpqKhVIcVm+prpAmjDEwQaC0vELglChT6aNEVc/aucKtCgsGFEY7/gh
         kYOiZUQBwaWjOmZefPlA6UxIOb61k/CFdNiOXQn2mv7cMFuPtS44VGX8KMh+t5NJd9+N
         oBETtKnezDPYNtQlkrdRKK4ZnOMiF/iSV6VOAV1FGh5MibAKWomUPQHaeoqkrcqknSeF
         J7qrZw88gtWQ7JVD43hjKRGK0+nO+mpDIDo/XdmVl2Q/y3tGJ6YOUGyf+2b8f3Bg6nNo
         o2VnkX7ggEsM4tyC++R3OlU/axVxTMVTTqJh1v1bx5AMzu0sJ9ISajtnSM9VFyg26YVW
         j6WA==
X-Gm-Message-State: AOAM532RHrrrOhMDR94T8kdBklDqeFJXBNiQO6TEWmI3LTIXPFdXr1rL
        7O/vEJNuR6UQM0k5BG0biGBzTcC2wHc=
X-Google-Smtp-Source: ABdhPJw6iRn7PYQ7QxXbXRkagUSm7tEdrtc1qCYtEYgLsXKTydXUdQbK+XE8J2PoveVp6EC8NBagOg==
X-Received: by 2002:a17:90b:1e0d:b0:1e0:7133:b3dc with SMTP id pg13-20020a17090b1e0d00b001e07133b3dcmr9620238pjb.42.1653481683765;
        Wed, 25 May 2022 05:28:03 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id bd30-20020a056a00279e00b0051868418b06sm11220456pfb.35.2022.05.25.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:28:03 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, SeanHY.chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
Date:   Wed, 25 May 2022 20:27:54 +0800
Message-Id: <20220525122754.6837-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch is based on patch [1] and remove data transfer length
checking.

Due to flaws in hardware design, GL9763E takes long time to exit from L1
state. The I/O performance will suffer severe impact if it often enter
and exit L1 state.

Unfortunately, entering and exiting L1 state is signal handshake in
physical layer, software knows nothiong about it. The only way to stop
entering L1 state is to disable hardware LPM negotiation on GL9763E.

To improve read performance and take battery life into account, we reject
L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enable L1
negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=510801&archive
=both

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 193 ++++++++++---------------------
 1 file changed, 63 insertions(+), 130 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d09728c37d03..0c5aac8047f8 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -13,7 +13,6 @@
 #include <linux/mmc/mmc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/iopoll.h>
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "cqhci.h"
@@ -64,7 +63,6 @@
 #define   GLI_9750_MISC_RX_INV_OFF       0x0
 #define   GLI_9750_MISC_RX_INV_VALUE     GLI_9750_MISC_RX_INV_OFF
 #define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
-#define   SDHCI_GLI_9750_MISC_SSC_OFF    BIT(26)
 
 #define SDHCI_GLI_9750_TUNING_CONTROL	          0x540
 #define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
@@ -95,9 +93,12 @@
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
@@ -139,11 +140,12 @@
 #define PCI_GLI_9755_SerDes  0x70
 #define PCI_GLI_9755_SCP_DIS   BIT(19)
 
-#define PCI_GLI_9755_MISC	    0x78
-#define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
-
 #define GLI_MAX_TUNING_LOOP 40
 
+struct gli_host {
+	bool lpm_negotiation_enabled;
+};
+
 /* Genesys Logic chipset */
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
@@ -376,19 +378,6 @@ static void gl9750_set_pll(struct sdhci_host *host, u8 dir, u16 ldiv, u8 pdiv)
 	mdelay(1);
 }
 
-static bool gl9750_ssc_enable(struct sdhci_host *host)
-{
-	u32 misc;
-	u8 off;
-
-	gl9750_wt_on(host);
-	misc = sdhci_readl(host, SDHCI_GLI_9750_MISC);
-	off = FIELD_GET(SDHCI_GLI_9750_MISC_SSC_OFF, misc);
-	gl9750_wt_off(host);
-
-	return !off;
-}
-
 static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
 {
 	u32 pll;
@@ -410,31 +399,11 @@ static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
 
 static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
 {
-	bool enable = gl9750_ssc_enable(host);
-
-	/* set pll to 205MHz and ssc */
-	gl9750_set_ssc(host, enable, 0xF, 0x5A1D);
+	/* set pll to 205MHz and enable ssc */
+	gl9750_set_ssc(host, 0x1, 0x1F, 0xFFE7);
 	gl9750_set_pll(host, 0x1, 0x246, 0x0);
 }
 
-static void gl9750_set_ssc_pll_100mhz(struct sdhci_host *host)
-{
-	bool enable = gl9750_ssc_enable(host);
-
-	/* set pll to 100MHz and ssc */
-	gl9750_set_ssc(host, enable, 0xE, 0x51EC);
-	gl9750_set_pll(host, 0x1, 0x244, 0x1);
-}
-
-static void gl9750_set_ssc_pll_50mhz(struct sdhci_host *host)
-{
-	bool enable = gl9750_ssc_enable(host);
-
-	/* set pll to 50MHz and ssc */
-	gl9750_set_ssc(host, enable, 0xE, 0x51EC);
-	gl9750_set_pll(host, 0x1, 0x244, 0x3);
-}
-
 static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct mmc_ios *ios = &host->mmc->ios;
@@ -452,10 +421,6 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
 		host->mmc->actual_clock = 205000000;
 		gl9750_set_ssc_pll_205mhz(host);
-	} else if (clock == 100000000) {
-		gl9750_set_ssc_pll_100mhz(host);
-	} else if (clock == 50000000) {
-		gl9750_set_ssc_pll_50mhz(host);
 	}
 
 	sdhci_enable_clk(host, clk);
@@ -556,19 +521,6 @@ static void gl9755_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
 	mdelay(1);
 }
 
-static bool gl9755_ssc_enable(struct pci_dev *pdev)
-{
-	u32 misc;
-	u8 off;
-
-	gl9755_wt_on(pdev);
-	pci_read_config_dword(pdev, PCI_GLI_9755_MISC, &misc);
-	off = FIELD_GET(PCI_GLI_9755_MISC_SSC_OFF, misc);
-	gl9755_wt_off(pdev);
-
-	return !off;
-}
-
 static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
 {
 	u32 pll;
@@ -590,31 +542,11 @@ static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
 
 static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
 {
-	bool enable = gl9755_ssc_enable(pdev);
-
-	/* set pll to 205MHz and ssc */
-	gl9755_set_ssc(pdev, enable, 0xF, 0x5A1D);
+	/* set pll to 205MHz and enable ssc */
+	gl9755_set_ssc(pdev, 0x1, 0x1F, 0xFFE7);
 	gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
 }
 
-static void gl9755_set_ssc_pll_100mhz(struct pci_dev *pdev)
-{
-	bool enable = gl9755_ssc_enable(pdev);
-
-	/* set pll to 100MHz and ssc */
-	gl9755_set_ssc(pdev, enable, 0xE, 0x51EC);
-	gl9755_set_pll(pdev, 0x1, 0x244, 0x1);
-}
-
-static void gl9755_set_ssc_pll_50mhz(struct pci_dev *pdev)
-{
-	bool enable = gl9755_ssc_enable(pdev);
-
-	/* set pll to 50MHz and ssc */
-	gl9755_set_ssc(pdev, enable, 0xE, 0x51EC);
-	gl9755_set_pll(pdev, 0x1, 0x244, 0x3);
-}
-
 static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
@@ -635,10 +567,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
 		host->mmc->actual_clock = 205000000;
 		gl9755_set_ssc_pll_205mhz(pdev);
-	} else if (clock == 100000000) {
-		gl9755_set_ssc_pll_100mhz(pdev);
-	} else if (clock == 50000000) {
-		gl9755_set_ssc_pll_50mhz(pdev);
 	}
 
 	sdhci_enable_clk(host, clk);
@@ -818,6 +746,53 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
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
+static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct gli_host *gli_host = sdhci_pci_priv(slot);
+
+	cmd = mrq->cmd;
+
+	if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && gli_host->lpm_negotiation_enabled) {
+		gl9763e_set_low_power_negotiation(slot, false);
+		gli_host->lpm_negotiation_enabled = false;
+	} else {
+		if (gli_host->lpm_negotiation_enabled == false) {
+			gl9763e_set_low_power_negotiation(slot, true);
+			gli_host->lpm_negotiation_enabled = true;
+		}
+	}
+
+	sdhci_request(mmc, mrq);
+}
+
 static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -952,47 +927,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }
 
-#ifdef CONFIG_PM
-static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	struct sdhci_host *host = slot->host;
-	u16 clock;
-
-	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
-	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
-
-	return 0;
-}
-
-static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	struct sdhci_host *host = slot->host;
-	u16 clock;
-
-	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-
-	clock |= SDHCI_CLOCK_PLL_EN;
-	clock &= ~SDHCI_CLOCK_INT_STABLE;
-	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
-
-	/* Wait max 150 ms */
-	if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
-			      1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
-		pr_err("%s: PLL clock never stabilised.\n",
-		       mmc_hostname(host->mmc));
-		sdhci_dumpregs(host);
-	}
-
-	clock |= SDHCI_CLOCK_CARD_EN;
-	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
-
-	return 0;
-}
-#endif
-
 static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1016,6 +950,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
+
+	host->mmc_host_ops.request = gl9763e_request;
+
 	gli_set_gl9763e(slot);
 	sdhci_enable_v4_mode(host);
 
@@ -1102,11 +1039,7 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 #ifdef CONFIG_PM_SLEEP
 	.resume		= sdhci_cqhci_gli_resume,
 	.suspend	= sdhci_cqhci_gli_suspend,
-#endif
-#ifdef CONFIG_PM
-	.runtime_suspend = gl9763e_runtime_suspend,
-	.runtime_resume  = gl9763e_runtime_resume,
-	.allow_runtime_pm = true,
 #endif
 	.add_host       = gl9763e_add_host,
+	.priv_size      = sizeof(struct gli_host),
 };
-- 
2.36.1


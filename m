Return-Path: <SRS0=zEeD=26=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E5C32771
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE6D206ED
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbpXomGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgAIJOy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:14:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36958 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgAIJOy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2020 04:14:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so3085000pfn.4;
        Thu, 09 Jan 2020 01:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjB+w3YtZtgGJqlFQbtPuwYxWcy4pFRsF5rah4vEdVA=;
        b=UbpXomGmgvtaHf0o8spuX/mwETHNlnb0KQRRRlH4ImcpYEB3XaWFwZgwF7YcZe8sSV
         hKRu7uD774gQIhSTwG9hdpkREnCRzNAW6Wtpurq7o3RkMPRj6rIkI/3pDIWrmWAohfTL
         +0WWieEJWMVBzUl23SekhOaDKUWVywshZo08VHbg+gdbZh7JfUmWar/skLtbp2ikeSa1
         J+AEmOROdRz6EPyMKtxp5gZimVNz7mOCgd/ZsMZZFjcV0vpF/reu5HsfCExSx93IzYOf
         WLI7ixE/fssjNY7ukJr92bJtMqlVmMT+wfd6XtL3Ft7sCPtbNDPHFezh42mYU8yprTch
         bKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjB+w3YtZtgGJqlFQbtPuwYxWcy4pFRsF5rah4vEdVA=;
        b=S1fFTjnhBNe6OXpQhKkpIjsn4LnXSFKwZffcsyWWhhekhOKFLFn3RYpF5rHZ07fiNA
         Np4xNNdM1Y9ZSTLxufaD4kyV6fQsJPy2cEb2giftRIugjVensKNEL1kTb4R60U22l1Va
         MlFPvfHGS/SMJDt4rNV7vKcKmb+LyXCtvNdu+gb2skVbAXAuAxf90uKJ4tCIAdHbLV9l
         7Yk5bYw2qJMKnGZhJGkrsq0tAicTLjCDGoNJlZ79P83XeWTWY3IYOuP++nyefTyk/GhV
         VdQFVCIK+OWtwsK8Rs/pf4myfoV3vaKHvddYocKCdNw9TqeCPrG2l5sXbXRhGYhobA0S
         fzDw==
X-Gm-Message-State: APjAAAUd0lFVHjLnlnaEkeu19EmuSHTERmha/kOEwH3YB6+zVc5KKgwu
        yQouN1EJB7r5bFlcrsJSB++x3CPH
X-Google-Smtp-Source: APXvYqygW7A/q6mGO+1TG14ViyL4VIJ8OFsx8PewmGYnL4A096HMJA7w+O7JZ1A3HHw3wUJtPu/9tg==
X-Received: by 2002:aa7:9474:: with SMTP id t20mr9887640pfq.241.1578561293032;
        Thu, 09 Jan 2020 01:14:53 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (220-128-190-163.HINET-IP.hinet.net. [220.128.190.163])
        by smtp.gmail.com with ESMTPSA id 144sm7383893pfc.124.2020.01.09.01.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:14:52 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH v2 6/6] mmc: sdhci-pci-gli: Fix power/reset/ZC/timeout for GL9755 UHS-II mode
Date:   Thu,  9 Jan 2020 17:15:16 +0800
Message-Id: <58988bcc0979969bba706a0eda94165b9cbae581.1578560282.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560282.git.benchuanggli@gmail.com>
References: <cover.1578560282.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
Enable the internal clock when do reset on UHS-II mode.
Set ZC to 0x0 for Sandisk cards and set ZC to 0xB for others.
Increase timeout value before detecting UHS-II interface.
Add vendor settings fro UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 361 ++++++++++++++++++++++++++++++-
 1 file changed, 360 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 5eea8d70a85d..1be78a609dc3 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include "sdhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 /*  Genesys Logic extra registers */
 #define SDHCI_GLI_9750_WT         0x800
@@ -60,6 +61,42 @@
 #define   SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY    GENMASK(2, 0)
 #define   GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE    0x1
 
+#define PCI_GLI_9755_WT       0x800
+#define   PCI_GLI_9755_WT_EN    BIT(0)
+#define   GLI_9755_WT_EN_ON	0x1
+#define   GLI_9755_WT_EN_OFF    0x0
+
+#define PCI_GLI_9755_PLLSSC                 0x68
+#define   PCI_GLI_9755_PLLSSC_RTL             BIT(24)
+#define   GLI_9755_PLLSSC_RTL_VALUE           0x1
+#define   PCI_GLI_9755_PLLSSC_TRANS_PASS      BIT(27)
+#define   GLI_9755_PLLSSC_TRANS_PASS_VALUE    0x1
+#define   PCI_GLI_9755_PLLSSC_RECV            GENMASK(29, 28)
+#define   GLI_9755_PLLSSC_RECV_VALUE          0x3
+#define   PCI_GLI_9755_PLLSSC_TRAN            GENMASK(31, 30)
+#define   GLI_9755_PLLSSC_TRAN_VALUE          0x3
+
+#define PCI_GLI_9755_UHS2_PLL            0x6C
+#define   PCI_GLI_9755_UHS2_PLL_SSC        GENMASK(9, 8)
+#define   GLI_9755_UHS2_PLL_SSC_VALUE      0x0
+#define   PCI_GLI_9755_UHS2_PLL_DELAY      BIT(18)
+#define   GLI_9755_UHS2_PLL_DELAY_VALUE    0x1
+#define   PCI_GLI_9755_UHS2_PLL_PDRST      BIT(27)
+#define   GLI_9755_UHS2_PLL_PDRST_VALUE    0x1
+
+#define PCI_GLI_9755_UHS2_SERDES	    0x70
+#define   PCI_GLI_9755_UHS2_SERDES_INTR       GENMASK(2, 0)
+#define   GLI_9755_UHS2_SERDES_INTR_VALUE     0x3
+#define   PCI_GLI_9755_UHS2_SERDES_ZC1        BIT(3)
+#define   GLI_9755_UHS2_SERDES_ZC1_VALUE      0x0
+#define   PCI_GLI_9755_UHS2_SERDES_ZC2        GENMASK(7, 4)
+#define   GLI_9755_UHS2_SERDES_ZC2_DEFAULT    0xB
+#define   GLI_9755_UHS2_SERDES_ZC2_SANDISK    0x0
+#define   PCI_GLI_9755_UHS2_SERDES_TRAN       GENMASK(27, 24)
+#define   GLI_9755_UHS2_SERDES_TRAN_VALUE     0xC
+#define   PCI_GLI_9755_UHS2_SERDES_RECV       GENMASK(31, 28)
+#define   GLI_9755_UHS2_SERDES_RECV_VALUE     0xF
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -262,6 +299,324 @@ static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return 0;
 }
 
+static inline void gl9755_wt_on(struct pci_dev *pdev)
+{
+	u32 wt_value;
+	u32 wt_enable;
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_WT, &wt_value);
+	wt_enable = FIELD_GET(PCI_GLI_9755_WT_EN, wt_value);
+
+	if (wt_enable == GLI_9755_WT_EN_ON)
+		return;
+
+	wt_value &= ~PCI_GLI_9755_WT_EN;
+	wt_value |= FIELD_PREP(PCI_GLI_9755_WT_EN, GLI_9755_WT_EN_ON);
+
+	pci_write_config_dword(pdev, PCI_GLI_9755_WT, wt_value);
+}
+
+static inline void gl9755_wt_off(struct pci_dev *pdev)
+{
+	u32 wt_value;
+	u32 wt_enable;
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_WT, &wt_value);
+	wt_enable = FIELD_GET(PCI_GLI_9755_WT_EN, wt_value);
+
+	if (wt_enable == GLI_9755_WT_EN_OFF)
+		return;
+
+	wt_value &= ~PCI_GLI_9755_WT_EN;
+	wt_value |= FIELD_PREP(PCI_GLI_9755_WT_EN, GLI_9755_WT_EN_OFF);
+
+	pci_write_config_dword(pdev, PCI_GLI_9755_WT, wt_value);
+}
+
+static void gl9755_vendor_init(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 serdes;
+	u32 pllssc;
+	u32 uhs2_pll;
+
+	gl9755_wt_on(pdev);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_SERDES, &serdes);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_TRAN;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_TRAN,
+			     GLI_9755_UHS2_SERDES_TRAN_VALUE);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_RECV;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_RECV,
+			     GLI_9755_UHS2_SERDES_RECV_VALUE);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_INTR;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_INTR,
+			     GLI_9755_UHS2_SERDES_INTR_VALUE);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC1;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC1,
+			     GLI_9755_UHS2_SERDES_ZC1_VALUE);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC2;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
+			     GLI_9755_UHS2_SERDES_ZC2_DEFAULT);
+	pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_SERDES, serdes);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, &uhs2_pll);
+	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_SSC;
+	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_SSC,
+			  GLI_9755_UHS2_PLL_SSC_VALUE);
+	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_DELAY;
+	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_DELAY,
+			  GLI_9755_UHS2_PLL_DELAY_VALUE);
+	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_PDRST;
+	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_PDRST,
+			  GLI_9755_UHS2_PLL_PDRST_VALUE);
+	pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, uhs2_pll);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_PLLSSC, &pllssc);
+	pllssc &= ~PCI_GLI_9755_PLLSSC_RTL;
+	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_RTL,
+			  GLI_9755_PLLSSC_RTL_VALUE);
+	pllssc &= ~PCI_GLI_9755_PLLSSC_TRANS_PASS;
+	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_TRANS_PASS,
+			  GLI_9755_PLLSSC_TRANS_PASS_VALUE);
+	pllssc &= ~PCI_GLI_9755_PLLSSC_RECV;
+	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_RECV,
+			  GLI_9755_PLLSSC_RECV_VALUE);
+	pllssc &= ~PCI_GLI_9755_PLLSSC_TRAN;
+	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_TRAN,
+			  GLI_9755_PLLSSC_TRAN_VALUE);
+	pci_write_config_dword(pdev, PCI_GLI_9755_PLLSSC, pllssc);
+
+	gl9755_wt_off(pdev);
+}
+
+static void gl9755_pre_detect_init(struct sdhci_host *host)
+{
+	/* GL9755 need more time on UHS2 detect flow */
+	sdhci_writeb(host, 0xA7, SDHCI_UHS2_TIMER_CTRL);
+}
+
+static void gl9755_post_attach_sd(struct sdhci_host *host)
+{
+	struct pci_dev *pdev;
+	struct sdhci_pci_chip *chip;
+	struct sdhci_pci_slot *slot;
+	u32 serdes;
+
+	slot = sdhci_priv(host);
+	chip = slot->chip;
+	pdev = chip->pdev;
+
+	gl9755_wt_on(pdev);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_SERDES, &serdes);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC1;
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC2;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC1,
+			     GLI_9755_UHS2_SERDES_ZC1_VALUE);
+
+	/* the manfid of sandisk card is 0x3 */
+	if (host->mmc->card->cid.manfid == 0x3)
+		serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
+				     GLI_9755_UHS2_SERDES_ZC2_SANDISK);
+	else
+		serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
+				     GLI_9755_UHS2_SERDES_ZC2_DEFAULT);
+
+	pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_SERDES, serdes);
+
+	gl9755_wt_off(pdev);
+}
+
+static void gl9755_overcurrent_event_enable(struct sdhci_host *host,
+					    bool enable)
+{
+	u32 mask;
+
+	mask = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
+	if (enable)
+		mask |= SDHCI_INT_BUS_POWER;
+	else
+		mask &= ~SDHCI_INT_BUS_POWER;
+
+	sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
+
+	mask = sdhci_readl(host, SDHCI_INT_ENABLE);
+	if (enable)
+		mask |= SDHCI_INT_BUS_POWER;
+	else
+		mask &= ~SDHCI_INT_BUS_POWER;
+
+	sdhci_writel(host, mask, SDHCI_INT_ENABLE);
+}
+
+static void gl9755_set_power(struct sdhci_host *host, unsigned char mode,
+			     unsigned short vdd, unsigned short vdd2)
+{
+	u8 pwr = 0;
+
+	if (mode != MMC_POWER_OFF) {
+		switch (1 << vdd) {
+		case MMC_VDD_165_195:
+		/*
+		 * Without a regulator, SDHCI does not support 2.0v
+		 * so we only get here if the driver deliberately
+		 * added the 2.0v range to ocr_avail. Map it to 1.8v
+		 * for the purpose of turning on the power.
+		 */
+		case MMC_VDD_20_21:
+			pwr = SDHCI_POWER_180;
+			break;
+		case MMC_VDD_29_30:
+		case MMC_VDD_30_31:
+			pwr = SDHCI_POWER_300;
+			break;
+		case MMC_VDD_32_33:
+		case MMC_VDD_33_34:
+			pwr = SDHCI_POWER_330;
+			break;
+		default:
+			WARN(1, "%s: Invalid vdd %#x\n",
+			     mmc_hostname(host->mmc), vdd);
+			break;
+		}
+	}
+
+	if (mode != MMC_POWER_OFF) {
+		if (vdd2 != (unsigned short)-1) {
+			switch (1 << vdd2) {
+			case MMC_VDD2_165_195:
+				pwr |= SDHCI_VDD2_POWER_180;
+				break;
+			default:
+				WARN(1, "%s: Invalid vdd2 %#x\n",
+				     mmc_hostname(host->mmc), vdd2);
+				break;
+			}
+		}
+	}
+
+	if (host->pwr == pwr)
+		return;
+
+	host->pwr = pwr;
+
+	if (pwr == 0) {
+		gl9755_overcurrent_event_enable(host, false);
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+	} else {
+		gl9755_overcurrent_event_enable(host, false);
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		pwr |= SDHCI_POWER_ON;
+		if (vdd2 != (unsigned short)-1)
+			pwr |= SDHCI_VDD2_POWER_ON;
+
+		sdhci_writeb(host, pwr&0xf, SDHCI_POWER_CONTROL);
+		/* wait stable */
+		mdelay(5);
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		/* wait stable */
+		mdelay(5);
+		gl9755_overcurrent_event_enable(host, true);
+	}
+}
+
+static bool sdhci_wait_clock_stable(struct sdhci_host *host)
+{
+	u16 clk = 0;
+	ktime_t timeout;
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return false;
+		}
+		udelay(10);
+	}
+	return true;
+}
+
+static void gl9755_uhs2_reset_sd_tran(struct sdhci_host *host)
+{
+	/* do this on UHS2 mode */
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+		sdhci_uhs2_clear_set_irqs(host,
+					  SDHCI_INT_ALL_MASK,
+					  SDHCI_UHS2_ERR_INT_STATUS_MASK);
+	}
+}
+
+static void sdhci_gl9755_reset(struct sdhci_host *host, u8 mask)
+{
+	ktime_t timeout;
+	u16 ctrl2;
+	u16 clk_ctrl;
+
+	/* need internal clock */
+	if (mask & SDHCI_RESET_ALL) {
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		clk_ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+		if ((ctrl2 & SDHCI_CTRL_V4_MODE) &&
+		    (ctrl2 & SDHCI_CTRL_UHS2_INTERFACE_EN)) {
+			sdhci_writew(host,
+				     SDHCI_CLOCK_INT_EN,
+				     SDHCI_CLOCK_CONTROL);
+		} else {
+			sdhci_writew(host,
+				     SDHCI_CLOCK_INT_EN,
+				     SDHCI_CLOCK_CONTROL);
+			sdhci_wait_clock_stable(host);
+			sdhci_writew(host,
+				     SDHCI_CTRL_V4_MODE,
+				     SDHCI_HOST_CONTROL2);
+		}
+	}
+
+	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+
+	/* reset sd-tran on UHS2 mode if need to reset cmd/data */
+	if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
+		gl9755_uhs2_reset_sd_tran(host);
+
+	if (mask & SDHCI_RESET_ALL)
+		host->clock = 0;
+
+	/* Wait max 100 ms */
+	timeout = ktime_add_ms(ktime_get(), 100);
+
+	/* hw clears the bit when it's done */
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
+			break;
+		if (timedout) {
+			pr_err("%s: Reset 0x%x never completed.\n",
+				mmc_hostname(host->mmc), (int)mask);
+			sdhci_dumpregs(host);
+			/* manual clear */
+			sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
+			return;
+		}
+		udelay(10);
+	}
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -278,6 +633,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
 
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
+	gl9755_vendor_init(host);
 
 	return 0;
 }
@@ -319,11 +675,14 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
 
 static const struct sdhci_ops sdhci_gl9755_ops = {
 	.set_clock		= sdhci_set_clock,
+	.set_power              = gl9755_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_reset,
+	.reset			= sdhci_gl9755_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.voltage_switch		= sdhci_gli_voltage_switch,
+	.uhs2_pre_detect_init    = gl9755_pre_detect_init,
+	.uhs2_post_attach_sd    = gl9755_post_attach_sd,
 };
 
 const struct sdhci_pci_fixes sdhci_gl9755 = {
-- 
2.24.1


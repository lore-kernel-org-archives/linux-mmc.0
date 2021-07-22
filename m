Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2ECC07E9D
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF37608FC
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhGVDWQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhGVDWJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90052C061798;
        Wed, 21 Jul 2021 21:02:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id my10so4367224pjb.1;
        Wed, 21 Jul 2021 21:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJSbWAzAYGsBzQsFL9bycC7oa9Xnequ8bJ2lfah7lU8=;
        b=MdqaJuNnZkCYsIOeRhU1SeL/Ug9GZfSuZg2ckOxfLNbIG0jPSZs5WRGUotSS6uLjov
         zQp6EKQxfcNDV0vOarLEqRTSlnNnI1uNrqdMW7aoXGDuTHfUqC5UJv3607UgnC+9PNf4
         XNAHdafmaRmuWZjfGDztCVuo08ecjjuEgR2RFv9klPzyJQ5Vgo6YIorFOFguACA5SH41
         XMM0GMbnmqemxpQKhyXc+0JB4XQpxtat1ZfiD0VQ8rlVnHQ+p6GE+2Grf8QmKJozVk3I
         fHHoC24O4FhBXryaSQZnUXAysef+Qy4G6HXEV0WDQ/qnemlUlQ3BxaHHq6/na1ZeBYGp
         Jfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJSbWAzAYGsBzQsFL9bycC7oa9Xnequ8bJ2lfah7lU8=;
        b=IpyitzErMnAoLtEcJd19qIlUw4qxHjG+j+pTfA6kcElkMFruOwBF4OiMdjFLx8LJbF
         IGKOalTUDC4AM2BapyKhQ0iKRDyDQhhQGEa525bJZf/rvHLQmYfw4LcraqNVyjJmxMkd
         2U8IbEOXP7KwFakNkqhORKg4EhQeBRnBbDG3mMw3Mk/E+9dTDyK4MnqDxAFDRbGqGGvg
         FLfT68iCQWrLp8O7i5RJQs69PthCTn5CI9BcJSJLvmTPYd8GFotLLPmRMpG3w6IsYMCt
         Kolx1jIZ2Y+8yqWWWSnKMwATpjDrj8H1kRNWz6oXaELLwS8M7mRZ3Bgdf8K5+kpSZ9hg
         xzvQ==
X-Gm-Message-State: AOAM530liOwj2R2/eJeKPSg3fkSPBE33/agDtKbhYRqEt+xH17NGg/Bt
        WHcmj6LtTs7boYzkITwMgTc=
X-Google-Smtp-Source: ABdhPJxwPEpoIDNk6wRkeWfa+D3LdW0ppGHo/PZXCY1TJCkbnPcqpICwheBcsS7bZXCkYUpEbW+BXg==
X-Received: by 2002:a63:a18:: with SMTP id 24mr38959837pgk.309.1626926563167;
        Wed, 21 Jul 2021 21:02:43 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:42 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 27/29] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
Date:   Thu, 22 Jul 2021 12:01:22 +0800
Message-Id: <20210722040124.7573-27-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Changes are:
* Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
* Enable the internal clock when do reset on UHS-II mode.
* Set ZC to 0x0 for Sandisk cards and set ZC to 0xB for others.
* Increase timeout value before detecting UHS-II interface.
* Add vendor settings fro UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/sdhci-pci-gli.c | 318 ++++++++++++++++++++++++++++++-
 2 files changed, 318 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 684539a65692..5a8a5aa83faa 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -102,6 +102,7 @@ config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
+	select MMC_SDHCI_UHS2
 	select IOSF_MBI if X86
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 061618aa247f..3d55c049f14c 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include "sdhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 #include "cqhci.h"

 /*  Genesys Logic extra registers */
@@ -76,6 +77,42 @@
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
 #define SDHCI_GLI_9763E_CTRL_HS400  0x7

 #define SDHCI_GLI_9763E_HS400_ES_REG      0x52C
@@ -586,9 +623,279 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 			    GLI_9755_CFG2_L1DLY_VALUE);
 	pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);

+        gl9755_wt_off(pdev);
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
 	gl9755_wt_off(pdev);
 }

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
+			     unsigned short vdd)
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
+
+		pwr |= SDHCI_VDD2_POWER_180;
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
+		pwr |= (SDHCI_POWER_ON | SDHCI_VDD2_POWER_ON);
+
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
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
+			       mmc_hostname(host->mmc));
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
+			       mmc_hostname(host->mmc), (int)mask);
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
@@ -609,6 +916,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
+	gl9755_vendor_init(host);

 	return 0;
 }
@@ -893,17 +1201,25 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)

 static const struct sdhci_ops sdhci_gl9755_ops = {
 	.set_clock		= sdhci_gl9755_set_clock,
+	.set_power              = gl9755_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_reset,
+	.reset			= sdhci_gl9755_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.voltage_switch		= sdhci_gli_voltage_switch,
+	.dump_uhs2_regs		= sdhci_uhs2_dump_regs,
+	.set_timeout		= sdhci_uhs2_set_timeout,
+	.irq			= sdhci_uhs2_irq,
+	.uhs2_pre_detect_init    = gl9755_pre_detect_init,
+	.uhs2_post_attach_sd    = gl9755_post_attach_sd,
 };

 const struct sdhci_pci_fixes sdhci_gl9755 = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
 	.probe_slot	= gli_probe_slot_gl9755,
+	.add_host	= sdhci_pci_uhs2_add_host,
+	.remove_host	= sdhci_pci_uhs2_remove_host,
 	.ops            = &sdhci_gl9755_ops,
 #ifdef CONFIG_PM_SLEEP
 	.resume         = sdhci_pci_gli_resume,
--
2.32.0


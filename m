Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB81DC754;
	Fri, 13 Sep 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223418; cv=none; b=kFx/coPJVR+Eo0yBeKN56nYbdS+5kLfN9RfWBMb/uQWENP6bR06do5XiYIkS7YI/X60BUB1lhhIl9SU/6KWZKZqF2QixEdxeijZAytuVvr1MSsMZAb6wWgB3FGAHoEU5ZOybRog8bvIKJAtyH7mPRewISw2RQByP37Ic/M6npw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223418; c=relaxed/simple;
	bh=yBPWMM+UcxmD8WxaMTZD9fPg9PqlDCKf90o5THqyUNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5tJ4nCw/LHoCnz7V89IzEWgcFGP5S5zp3YJhTK3Ozc+gDJ6TTS9EtBunFt7FWTWnuy9aKGngWXBzRx2T053vrac3EHdLokCV8bbimmMHah4lYX+4CO0kQFaoYnUQeH05B5HgU8/tMB0tbQbYCwa1hp/i5y5tmL5/OjX8nlhkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW31lDLt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW31lDLt"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1478664a12.0;
        Fri, 13 Sep 2024 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223416; x=1726828216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec3ffwGVG4T3zOAIwR5JyB4bVTuiuJxx1Z4oCNcuYcM=;
        b=eW31lDLtyuOW0TVEAUdJlzIX6qEsORh64qKFGNnt7h5hk+1Zt1QC8PmT2sMLKGmgQe
         75lEWgUD4DPfJUZIT1OORbNccrtWyObASF0cato+qMhw1tY3CmbzKeMG+EETme8yGD8G
         iMqiTx7Wxhqv43y+F5gkhq09klcyKI8PnoCYZamSpa2rFyGwZSC00KsL/qLLQgOQxAyQ
         Oikhoi2r4M0ZL0roBoGE3+m2OPS/pHjrJP2MEiJOzCQWg5YARVC7U2KwUrUxowyQiUL7
         Fp715vyRbCnuPlSDKJjhjbZkME+Tx4L9EeNxUsWyjV5MGcpBlvHqldfnh/OCmD8FoxYV
         /rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223416; x=1726828216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec3ffwGVG4T3zOAIwR5JyB4bVTuiuJxx1Z4oCNcuYcM=;
        b=mxxy5y2G4W36of5+vIS0hhoxNjDhUdb8bqVmWYaDu7b2K2VFNlAnHTcKIEbLqOkad5
         Vdj86NiTUuNVj2n8XN3L9pJFNXiPpLEcMabQ6W1NicGohXIzdUPa1jsGFZ8nSPPVzhR7
         e+0Kn2Aek8lucfZIo9yWlnG5f168d4c0+BQvANe5XIMISG+pBfBOlzM6Nij3M9C1Y+sk
         SvpPrZHX/t/uaTJq+An35RMFrVIgISd4781rGQ9tM0VjgDHyOaNeuQ7tXc3nHRM3+0Mx
         DBXuL9dztuSzFslm0RR5m0UO21ENPTNUqDYLGi0HNJ8+IuVCy/160Ir/5s55ltq7Zbl8
         u+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVXsFja2bGie6M2+7d2BEEgviUUzDlq4g+icDMSJivxeG9/i0SVLysTHB3226JkFp4MT1VMojrxcGAvIYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qgsDzX9giOqop8smVYNKD+0RCwJ0NYpoKFKhlzzOloGeNbWo
	cksX2E/6WZ9G3OGpn1oeuLWidiwLFxyKgwkaG95UpAz35LM1/rqN
X-Google-Smtp-Source: AGHT+IHjegn2vsEdpNBWy/EAK3wUYLv7Sq4Q1GCDlbF1hGt7Ezengttwi4JS31Hard3bDK61p71mWw==
X-Received: by 2002:a05:6a20:c703:b0:1cf:39ea:945e with SMTP id adf61e73a8af0-1cf75e77015mr7581550637.5.1726223415833;
        Fri, 13 Sep 2024 03:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:30:15 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Lucas Lai <lucas.lai@genesyslogic.com.tw>
Subject: [PATCH V22 21/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
Date: Fri, 13 Sep 2024 18:28:35 +0800
Message-Id: <20240913102836.6144-22-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
References: <20240913102836.6144-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Changes are:
 * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
 * Enable the internal clock when do reset on UHS-II mode.
 * Increase timeout value before detecting UHS-II interface.
 * Add vendor settings fro UHS-II mode.
 * Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl variable.
 * Make a function sdhci_gli_wait_software_reset_done() for gl9755 reset.
 * Remove unnecessary code from sdhci_gl9755_reset().

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
---

Updates in V21:
 - Remove unnecessary code from sdhci_gl9755_reset().

Updates in V20:
 - Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl variable.
 - Make a function sdhci_gli_wait_software_reset_done() for gl9755 reset.

Updates in V19:
 - Add sdhci_gli_enable_internal_clock() to simplify the code
   in the sdhci_gl9755_reset().

Updates in V17:
 - Rname gl9755_overcurrent_event_enable() to
   sdhci_gli_overcurrent_event_enable().

Updates in V15:
 - Adjust gl9755_vendor_init() to the correct function.

Updates in V13:
 - Ues uhs2_sd_tran to stead MMC_UHS2_SD_TRAN.

Updates in V9:
 - Rename gl9755_pre_detect_init() to sdhci_gli_pre_detect_init().
 - Rename gl9755_uhs2_reset_sd_tran() to sdhci_gli_uhs2_reset_sd_tran().

Updates in V8:
 - Use sdhci_get_vdd_value() to simplify code in gl9755_set_power().
 - Use read_poll_timeout_atomic() to simplify code in
   sdhci_wait_clock_stable().
 - Use read_poll_timeout_atomic() to simplify code in sdhci_gl9755_reset().

Updates in V7:
 - Drop using gl9755_post_attach_sd().

---

 drivers/mmc/host/sdhci-pci-gli.c | 235 ++++++++++++++++++++++++++++++-
 1 file changed, 234 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 0f81586a19df..708138eecaa7 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -18,6 +18,7 @@
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
 #include "cqhci.h"
+#include "sdhci-uhs2.h"
 
 /*  Genesys Logic extra registers */
 #define SDHCI_GLI_9750_WT         0x800
@@ -139,9 +140,36 @@
 
 #define PCI_GLI_9755_PLLSSC        0x68
 #define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
+#define   PCI_GLI_9755_PLLSSC_RTL             BIT(24)
+#define   GLI_9755_PLLSSC_RTL_VALUE           0x1
+#define   PCI_GLI_9755_PLLSSC_TRANS_PASS      BIT(27)
+#define   GLI_9755_PLLSSC_TRANS_PASS_VALUE    0x1
+#define   PCI_GLI_9755_PLLSSC_RECV            GENMASK(29, 28)
+#define   GLI_9755_PLLSSC_RECV_VALUE          0x0
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
 
 #define PCI_GLI_9755_SerDes  0x70
+#define   PCI_GLI_9755_UHS2_SERDES_INTR       GENMASK(2, 0)
+#define   GLI_9755_UHS2_SERDES_INTR_VALUE     0x3
+#define   PCI_GLI_9755_UHS2_SERDES_ZC1        BIT(3)
+#define   GLI_9755_UHS2_SERDES_ZC1_VALUE      0x0
+#define   PCI_GLI_9755_UHS2_SERDES_ZC2        GENMASK(7, 4)
+#define   GLI_9755_UHS2_SERDES_ZC2_DEFAULT    0xB
+#define   GLI_9755_UHS2_SERDES_ZC2_SANDISK    0x0
 #define PCI_GLI_9755_SCP_DIS   BIT(19)
+#define   PCI_GLI_9755_UHS2_SERDES_TRAN       GENMASK(27, 24)
+#define   GLI_9755_UHS2_SERDES_TRAN_VALUE     0xC
+#define   PCI_GLI_9755_UHS2_SERDES_RECV       GENMASK(31, 28)
+#define   GLI_9755_UHS2_SERDES_RECV_VALUE     0xF
 
 #define PCI_GLI_9755_MISC	    0x78
 #define   PCI_GLI_9755_MISC_SSC_OFF    BIT(26)
@@ -779,6 +807,203 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	gl9755_wt_off(pdev);
 }
 
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
+	pci_read_config_dword(pdev, PCI_GLI_9755_SerDes, &serdes);
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
+	pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, serdes);
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
+static void sdhci_gli_pre_detect_init(struct sdhci_host *host)
+{
+	/* Need more time on UHS2 detect flow */
+	sdhci_writeb(host, 0xA7, SDHCI_UHS2_TIMER_CTRL);
+}
+
+static void sdhci_gli_overcurrent_event_enable(struct sdhci_host *host, bool enable)
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
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr)
+			WARN(1, "%s: Invalid vdd %#x\n", mmc_hostname(host->mmc), vdd);
+		pwr |= SDHCI_VDD2_POWER_180;
+	}
+
+	if (host->pwr == pwr)
+		return;
+
+	host->pwr = pwr;
+
+	if (pwr == 0) {
+		sdhci_gli_overcurrent_event_enable(host, false);
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+	} else {
+		sdhci_gli_overcurrent_event_enable(host, false);
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
+		sdhci_gli_overcurrent_event_enable(host, true);
+	}
+}
+
+static bool sdhci_wait_clock_stable(struct sdhci_host *host)
+{
+	u16 clk = 0;
+
+	if (read_poll_timeout_atomic(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
+				     10, 20000, false, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return false;
+	}
+	return true;
+}
+
+static void sdhci_gli_enable_internal_clock(struct sdhci_host *host)
+{
+	u16 ctrl2;
+
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+	sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
+
+	if (!((ctrl2 & SDHCI_CTRL_V4_MODE) &&
+	      (ctrl2 & SDHCI_CTRL_UHS2_ENABLE))) {
+		sdhci_wait_clock_stable(host);
+		sdhci_writew(host, SDHCI_CTRL_V4_MODE, SDHCI_HOST_CONTROL2);
+	}
+}
+
+static int sdhci_gli_wait_software_reset_done(struct sdhci_host *host, u8 mask)
+{
+	u8 rst;
+
+	/* hw clears the bit when it's done */
+	if (read_poll_timeout_atomic(sdhci_readb, rst, !(rst & mask),
+				     10, 100000, false, host, SDHCI_SOFTWARE_RESET)) {
+		pr_err("%s: Reset 0x%x never completed.\n", mmc_hostname(host->mmc), (int)mask);
+		sdhci_dumpregs(host);
+		/* manual clear */
+		sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void sdhci_gli_uhs2_reset_sd_tran(struct sdhci_host *host)
+{
+	/* do this on UHS2 mode */
+	if (host->mmc->uhs2_sd_tran) {
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+		sdhci_uhs2_clear_set_irqs(host,
+					  SDHCI_INT_ALL_MASK,
+					  SDHCI_UHS2_INT_ERROR_MASK);
+	}
+}
+
+static void sdhci_gl9755_reset(struct sdhci_host *host, u8 mask)
+{
+	/* need internal clock */
+	if (mask & SDHCI_RESET_ALL)
+		sdhci_gli_enable_internal_clock(host);
+
+	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+
+	/* reset sd-tran on UHS2 mode if need to reset cmd/data */
+	if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
+		sdhci_gli_uhs2_reset_sd_tran(host);
+
+	if (mask & SDHCI_RESET_ALL)
+		host->clock = 0;
+
+	sdhci_gli_wait_software_reset_done(host, mask);
+}
+
 static inline void gl9767_vhs_read(struct pci_dev *pdev)
 {
 	u32 vhs_enable;
@@ -1086,6 +1311,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
+	gl9755_vendor_init(host);
 
 	return 0;
 }
@@ -1524,17 +1750,24 @@ static const struct sdhci_ops sdhci_gl9755_ops = {
 	.read_w			= sdhci_gli_readw,
 	.read_b			= sdhci_gli_readb,
 	.set_clock		= sdhci_gl9755_set_clock,
+	.set_power		= gl9755_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_reset,
+	.reset			= sdhci_gl9755_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.voltage_switch		= sdhci_gli_voltage_switch,
+	.dump_uhs2_regs		= sdhci_uhs2_dump_regs,
+	.set_timeout		= sdhci_uhs2_set_timeout,
+	.irq			= sdhci_uhs2_irq,
+	.uhs2_pre_detect_init   = sdhci_gli_pre_detect_init,
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
2.25.1


Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B61AD41F;
	Thu, 20 Jun 2024 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880376; cv=none; b=nUuZ6yTYZmPe9rtbY8y4IfWF0MZuaGYnZGPEsfwRU6A4TeHHpu03ELnudz54YzTZOfrDHVfL3eIHTgkw9q/udwzkEyqQJcgCldquC5jmthmbE46fEpoUiO6qfYh6z/45tXAegd/OsfGLzqDSDfYihV9pypw6sd229UJrGH3olGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880376; c=relaxed/simple;
	bh=ArtHWtS7L6AE4A11elThcteWl1u3Qx1hmTmpR2EUIAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vb9sBQdt1ZWRs03f3M61DXBGXln4X27pn3yLD2/DlK1QQGvIWyG8xwFL0xSvQ2Tx2k+bj3I4MsCxRryWUepj2HsqQG+H3cw7G9EJPdtV+oJoFubDu5PnhMRjITNByQXgCVDpyS1yG3FHMHHJSTLHf8BsfDqpAL5/3qhh9PAgRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7rbPt0Z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7rbPt0Z"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f44b45d6abso5915855ad.0;
        Thu, 20 Jun 2024 03:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880375; x=1719485175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZEKIw6wgi6G3NicKe6SYWsy2FIoj6x/c+3UOgoXT1w=;
        b=L7rbPt0Z0YMXBJA5npukLCXrBKfJq9g/sD34lJKQoQPuadMiM6hSi+O+qOJI4zZ28D
         o1aGSTqKzgAPc8Ax+BtJN+AjHn7y2WFp0Xl0eA/5wmrOT9qohcuiwj6T76aGOZQ5QTG5
         6qP6fh2ekFJ9CUfcj3zrNwybRo0wMiimgmMVOqAaojfHPWKXjcl3dNj17prx57aCjuK2
         Y7bDpO22o8MK/s0uQwt9d9qaEQjAAPBiCKMQ/uRui1e784w5uSB5V/6jg+RvvMcINiro
         m0vv6kCaFZv+cN0ZvLjl7I6VSJEEEZydj48nuBDCg4WN2O0xHejV4GGc5e7aJJZ7hRsx
         ms0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880375; x=1719485175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZEKIw6wgi6G3NicKe6SYWsy2FIoj6x/c+3UOgoXT1w=;
        b=jHWFL29zus1qeGpVtptOD0J5YaC1VLShBHXAitEfgO3q5J5jyOQV6FzbFdK75GHFQo
         EcuRlbBFAj11ETUJgBdh2dxhcSrCDkm5BRsk7JA4K98bw71gUYbnGAP0w64rRXklSyVB
         iOJ3chtA6u6MocbvZm3Bm/TvUm4Xs5mdNhTb+uucBVqzKXCQ1vBu2HDV5lwwa3sjKvEL
         2swF5wrJy2XIpMP4DJ3Jv9Iy9V+UyFPxN/O4ZzHnOnIR8SUwA7f0d3ggvM7Ziip8pkW0
         kpH1K3Wbcpt4We/29zEoUS4yqip1ZSIevolFwav+wvDEtXpUgK/pIDvaSRCH3nBe0vF6
         +NKw==
X-Forwarded-Encrypted: i=1; AJvYcCUGpDUNS5VAJEaipUDxMLwfAIu+aLBzWAtpGF1A+rcmzg2R3K6einz8518XJmhFWQgNNbwFy7wyhbA+9wdYaDSA7ISxeMSQmLrzwcNv
X-Gm-Message-State: AOJu0YwKnNXwN2gWPkvbCcsVQ3nVfngGIDCtk2HHkgYewptKag4AJE9J
	sUCuvL7Ks0LahAOgJ4UcQAKZw0FKTj9x4PUzQRKdAoO47iP8LGtw
X-Google-Smtp-Source: AGHT+IHm+jTXqaLn6RnN0Y2yToz7QibS3ncYvdjwmjp8hNph3nd2JftR/cAM3/5A1KSAAMuTCwSeAw==
X-Received: by 2002:a17:902:da86:b0:1f3:cb7:b0ef with SMTP id d9443c01a7336-1f9aa450652mr61163485ad.51.1718880374558;
        Thu, 20 Jun 2024 03:46:14 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:46:14 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V17 21/22] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
Date: Thu, 20 Jun 2024 18:44:43 +0800
Message-Id: <20240620104444.5862-22-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

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

 drivers/mmc/host/sdhci-pci-gli.c | 232 ++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 0f81586a19df..a4164948de81 100644
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
@@ -779,6 +807,200 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
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
+	u16 clk_ctrl;
+	u16 ctrl2;
+	u8 rst;
+
+	/* need internal clock */
+	if (mask & SDHCI_RESET_ALL) {
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		clk_ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+		if ((ctrl2 & SDHCI_CTRL_V4_MODE) &&
+		    (ctrl2 & SDHCI_CTRL_UHS2_ENABLE)) {
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
+		sdhci_gli_uhs2_reset_sd_tran(host);
+
+	if (mask & SDHCI_RESET_ALL)
+		host->clock = 0;
+
+	/* hw clears the bit when it's done */
+	if (read_poll_timeout_atomic(sdhci_readb, rst, !(rst & mask),
+				     10, 100000, false, host, SDHCI_SOFTWARE_RESET)) {
+		pr_err("%s: Reset 0x%x never completed.\n", mmc_hostname(host->mmc), (int)mask);
+		sdhci_dumpregs(host);
+		/* manual clear */
+		sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
+		return;
+	}
+}
+
 static inline void gl9767_vhs_read(struct pci_dev *pdev)
 {
 	u32 vhs_enable;
@@ -1086,6 +1308,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
+	gl9755_vendor_init(host);
 
 	return 0;
 }
@@ -1524,17 +1747,24 @@ static const struct sdhci_ops sdhci_gl9755_ops = {
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


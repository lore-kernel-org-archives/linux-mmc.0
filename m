Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957594;
	b=ZsaXUlSlhuy3mHx5wQchTV/F7gFUDTzwhBiU3cD5EUELiuz65Axr1f4XiG+UCVMYD0Ve
	 SA9F3GC1vpJ4ck/4fjjsafBveqO6x3qFtfSBJTX7ohOAjN1Vgu081U2+WkAmEz9bRbaAU
	 pqqZGyMKbBZTfxMNs+5uaql5ZuB2sv2FJOZ+gD0hlrXd5tTjT/CE9yfqRQ/HmFCkEZ5Br
	 gR7TzLL9RpTSgOnQ5vaco6aNtkhpd1z42w+694qi2JjtBpIWLvVgl2/2jWv/ywosDxeuu
	 G6+JhIUbH0y3E0MuPPrw/O2W5JnyjEZbVLnMBDsxtxOfh8aN7GOx1g0oOFWOfEE8YJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957594;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=4oXcJbpFaFWcJH0ZN0EO/TEMAwFip7EhrX7KwRsA0so=;
	b=ZvdeaD0Ca4E/xz2L01O3TwHsAbq21kxuZa/WZ6JlhaTNVcl5cnRhS14x3FiH3g1XCIny
	 EgK+TNNPLG7tifoPoqrPYPbe4wmmg1QLbT4k8VQLXDzmRoEdrQAlnZy2Tx2JYDu6pt4ya
	 3XQkBrN6QC0a9mKKeUFn7vGxBfTFOHzqw1yA6bilfEQAaN6qg7IuNLiS5MWKPO0gvmXTO
	 ojQWR68ew3a4WqAHruBpaLg+TocCC79gFvD0/xdEt2HBmQDO9B2DiOrv7NVb5c/TocN1u
	 /CmTyaC339BYB80TmXRsv42VkaBvs8OmPz/wUXXEX0EzK4LyNJfmdYUguon7a7ihU4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jw07in8c;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B7606A33B
	for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2026 09:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A4B7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jw07in8c
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BA7AAC69166;
	Fri,  6 Nov 2026 09:33:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3DF715FFBC;
	Fri,  6 Nov 2026 09:33:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D356103292CA;
	Fri,  6 Nov 2026 10:33:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957587; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4oXcJbpFaFWcJH0ZN0EO/TEMAwFip7EhrX7KwRsA0so=;
	b=jw07in8cOM6edpDXpac+TOB1S+MYgY9J0ufP42QvJnEowAbsHOB7ODDxz5VWYtRMgNOoFJ
	g4+nhS4PRwXqjBUxk2Pg/mt/ndvLvYzB6LlJBQwtkS3x3toyW0ig0PnQ5zjE6nO9wlGi4W
	sR5vBO7HBacK0KjXumJG1PHc3RXCLSlTgJW+ZlmS4/P28zssfAqNBGbc3H76NV17HnCvXR
	vlZq5efzcBzhyIJA7gJ19HTWiw7a1Pp7xp9/+ZRPr8Ks+kY1tyBcf1Il4jpWon6Rj7ZtLX
	rP1T3BqCHWh3uN+HKOjY24cLEoIUGNIYEhhXNWrj8JyxoiLG50RwDkKnHWoDxg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:18 +0100
Subject: [PATCH 21/25] mmc: sdhci-of-dwcmshc: add MT2824 tuning and HS400
 support
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-mt2824-v1-21-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
In-Reply-To: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The MT2824 databook names SDR104 and HS200 as the modes that need
tuning. The controller has a 128-tap sampling delay line, so scan every
center phase code, find the longest run of phases that return a good
tuning block, and select the middle phase. Do not tune at DDR50, where
the scan fails at every phase and the fixed sampling clock works.

During the scan, a CMD19 timeout at a bad phase can be followed by a
data CRC interrupt after the request has completed. Drop data interrupts
that arrive with no data request while scanning.

HS400 needs the PHY DLL locked on the card clock. Configure and enable
the DLL by hand after the clock is set, and reset the CMD and DATA
lines.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 201 +++++++++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index cb248fc572e2..324ae93295af 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
@@ -86,8 +87,12 @@
 #define CV18XX_TUNE_STEP			1
 #define CV18XX_RETRY_TUNING_MAX			50
 
-/* Metanoia MT2824: HOST_CTRL3 sampling edge and PHY pad settings */
+/* Metanoia MT2824: HOST_CTRL3 sampling edge bits and software tuning */
 #define MT2824_HOST_CTRL3_NEGEDGE_DATAOUT	BIT(1)
+#define MT2824_AT_STAT_CENTER_PH_MASK		GENMASK(6, 0)
+#define MT2824_TUNING_PHASES			128	/* DWC_MSHC_DL_CW = 7 */
+/* narrowest passing window accepted, ~8 % of the 128-tap delay line */
+#define MT2824_TUNING_MIN_WINDOW		10
 /* 1.8 V eMMC probe attempts before falling back to the SD slot */
 #define MT2824_PROBE_ATTEMPTS			2
 /* PHY pad settings of the MT2824 pad ring */
@@ -98,6 +103,10 @@
 #define MT2824_PHY_TXSLEW_P_STROBE		0x3
 #define MT2824_PHY_SMPLDL_CNFG			0x0c
 #define MT2824_PHY_ATDL_CNFG			0x0c
+#define MT2824_PHY_DLL_CNFG1			0x20
+#define MT2824_PHY_DLLDL_CNFG			0x60
+#define MT2824_PHY_DLL_LOCKED			BIT(0)
+#define MT2824_PHY_DLL_LOCK_ERR			BIT(1)
 
 /* Rockchip specific Registers */
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
@@ -245,6 +254,7 @@
 #define DLL_ERROR_STS			BIT(1)
 
 #define FLAG_IO_FIXED_1V8	BIT(0)
+#define FLAG_SW_TUNING		BIT(1)	/* MT2824: tuning scan in progress */
 
 #define BOUNDARY_OK(addr, len) \
 	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
@@ -2271,6 +2281,38 @@ static int mt2824_phy_init(struct sdhci_host *host, bool v1v8)
 	return 0;
 }
 
+/* HS400 needs the PHY DLL locked on the card clock; lock it by hand */
+static void mt2824_set_dll(struct sdhci_host *host)
+{
+	u16 clk;
+	u8 status;
+	int ret;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	sdhci_writeb(host, MT2824_PHY_DLL_CNFG1, PHY_DLL_CNFG1_R);
+	sdhci_writeb(host, MT2824_PHY_DLLDL_CNFG, PHY_DLLDL_CNFG_R);
+
+	sdhci_enable_clk(host, clk);
+	usleep_range(10, 20);
+
+	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
+	ret = read_poll_timeout(sdhci_readb, status,
+				status & MT2824_PHY_DLL_LOCKED, 10, 150000,
+				false, host, PHY_DLL_STATUS_R);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "PHY DLL did not lock: 0x%02x\n",
+			status);
+		return;
+	}
+
+	if (status & MT2824_PHY_DLL_LOCK_ERR)
+		dev_err(mmc_dev(host->mmc), "PHY DLL locked with error: 0x%02x\n",
+			status);
+}
+
 static bool mt2824_wait_clk_stable(struct sdhci_host *host, u16 *clk,
 				   const char *what)
 {
@@ -2332,6 +2374,11 @@ static void mt2824_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock)
 		mt2824_enable_clk(host, sdhci_calc_clk(host, clock,
 						       &mmc->actual_clock));
+
+	if (clock && host->timing == MMC_TIMING_MMC_HS400) {
+		mt2824_set_dll(host);
+		dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	}
 }
 
 /* The controller must know that the card is an eMMC (EMMC_CTRL_R, 16 bit) */
@@ -2460,6 +2507,156 @@ static void mt2824_hw_reset(struct sdhci_host *host)
 	sdhci_enable_clk(host, clk);
 }
 
+/*
+ * Software tuning: try every center phase code of the tuning delay line,
+ * find the longest run of phases that return a good tuning block and
+ * select its middle. The sampling clock only follows the delay line while
+ * SAMPLE_CLK_SEL (SDHCI_CTRL_TUNED_CLK) is set, so set it for the scan and
+ * keep it; SW_TUNE_EN also stays set, so the selected phase code stays in
+ * control of the delay line.
+ */
+static int mt2824_set_center_phase(struct sdhci_host *host, u32 at_stat_reg,
+				   unsigned int phase)
+{
+	u32 at_stat;
+	int ret;
+	u16 clk;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	at_stat = sdhci_readl(host, at_stat_reg);
+	at_stat &= ~MT2824_AT_STAT_CENTER_PH_MASK;
+	at_stat |= FIELD_PREP(MT2824_AT_STAT_CENTER_PH_MASK, phase);
+	sdhci_writel(host, at_stat, at_stat_reg);
+	/*
+	 * This configuration has no DL2 busy flag: read the phase code back,
+	 * then wait for the worst case of 180 hclk cycles of the delay line
+	 * (2 us covers an hclk of 90 MHz or more).
+	 */
+	ret = read_poll_timeout(sdhci_readl, at_stat,
+				FIELD_GET(MT2824_AT_STAT_CENTER_PH_MASK, at_stat) == phase,
+				0, 100, false, host, at_stat_reg);
+	if (ret)
+		dev_err(mmc_dev(host->mmc), "tuning phase %u not taken\n", phase);
+	udelay(2);
+
+	sdhci_enable_clk(host, clk);
+
+	return ret;
+}
+
+static int mt2824_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 at_ctrl_reg = dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL;
+	u32 at_stat_reg = dwc_priv->vendor_specific_area1 + DWCMSHC_AT_STAT;
+	DECLARE_BITMAP(good, MT2824_TUNING_PHASES);
+	unsigned int start, end, phase, best_start = 0, best_len = 0;
+	u32 at_ctrl;
+	u16 ctrl2;
+	int ret;
+
+	/*
+	 * The controller databook names SDR104 (and HS200) as the modes that
+	 * need tuning. At DDR50 the scan fails at every phase on this
+	 * controller, while the fixed sampling clock works: do not tune.
+	 */
+	if (host->timing == MMC_TIMING_UHS_DDR50)
+		return 0;
+
+	WRITE_ONCE(dwc_priv->flags, dwc_priv->flags | FLAG_SW_TUNING);
+
+	sdhci_reset_tuning(host);
+	bitmap_zero(good, MT2824_TUNING_PHASES);
+
+	/*
+	 * AT_CTRL_R must not be written while SAMPLE_CLK_SEL is set: enable
+	 * software tuning first, then select the tuned sampling clock.
+	 */
+	at_ctrl = sdhci_readl(host, at_ctrl_reg);
+	sdhci_writel(host, at_ctrl | AT_CTRL_SW_TUNE_EN, at_ctrl_reg);
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	sdhci_writew(host, ctrl2 | SDHCI_CTRL_TUNED_CLK, SDHCI_HOST_CONTROL2);
+	/*
+	 * That HOST_CONTROL2 write breaks the response of the next command:
+	 * send one tuning command for nothing before the scan.
+	 */
+	mmc_send_tuning(host->mmc, opcode, NULL);
+	host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	for (phase = 0; phase < MT2824_TUNING_PHASES; phase++) {
+		ret = mt2824_set_center_phase(host, at_stat_reg, phase);
+		if (ret)
+			goto fail;
+		if (!mmc_send_tuning(host->mmc, opcode, NULL))
+			set_bit(phase, good);
+		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	}
+
+	/* the sample delay line is linear, so the phase codes do not wrap */
+	for_each_set_bitrange(start, end, good, MT2824_TUNING_PHASES) {
+		if (end - start > best_len) {
+			best_start = start;
+			best_len = end - start;
+		}
+	}
+	if (best_len < MT2824_TUNING_MIN_WINDOW) {
+		dev_err(mmc_dev(host->mmc), "tuning failed, best window %u\n",
+			best_len);
+		ret = -EIO;
+		goto fail;
+	}
+	phase = best_start + best_len / 2;
+	/* a window at an end of the delay line may be wider than measured */
+	if (!best_start || best_start + best_len == MT2824_TUNING_PHASES)
+		dev_dbg(mmc_dev(host->mmc), "tuning window %u+%u ends at the delay line end\n",
+			best_start, best_len);
+
+	ret = mt2824_set_center_phase(host, at_stat_reg, phase);
+	if (ret)
+		goto fail;
+	dev_dbg(mmc_dev(host->mmc), "tuning phase %u (window %u+%u), AT_STAT %08x\n",
+		phase, best_start, best_len, sdhci_readl(host, at_stat_reg));
+	sdhci_end_tuning(host);
+	WRITE_ONCE(dwc_priv->flags, dwc_priv->flags & ~FLAG_SW_TUNING);
+
+	return 0;
+
+fail:
+	/* clear SAMPLE_CLK_SEL before AT_CTRL_R is written again */
+	sdhci_reset_tuning(host);
+	sdhci_writel(host, at_ctrl, at_ctrl_reg);
+	host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	sdhci_end_tuning(host);
+	WRITE_ONCE(dwc_priv->flags, dwc_priv->flags & ~FLAG_SW_TUNING);
+	return ret;
+}
+
+/*
+ * A tuning command at a bad phase can time out while the card still sends
+ * the tuning block. Its data interrupt then comes when no data transfer is
+ * in progress (host->data is NULL); once the request reset cleared
+ * pending_reset, sdhci counts it as an unexpected interrupt. Drop such
+ * data interrupts while the tuning scan runs. A late interrupt that comes
+ * after the next tuning command started fails that phase only.
+ */
+static u32 mt2824_irq(struct sdhci_host *host, u32 intmask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 stray = intmask & SDHCI_INT_DATA_MASK;
+
+	if (!(READ_ONCE(dwc_priv->flags) & FLAG_SW_TUNING) || host->data || !stray)
+		return intmask;
+
+	sdhci_writel(host, stray, SDHCI_INT_STATUS);
+
+	return intmask & ~stray;
+}
+
 /*
  * With no card type from the DT, look for an eMMC only, at 1.8 V: an eMMC
  * answers CMD1, an SD card does not, so no 3.3 V signal reaches an eMMC.
@@ -2672,6 +2869,8 @@ static const struct sdhci_ops sdhci_dwcmshc_mt2824_ops = {
 	.reset			= mt2824_reset,
 	.hw_reset		= mt2824_hw_reset,
 	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.platform_execute_tuning = mt2824_execute_tuning,
+	.irq			= mt2824_irq,
 };
 
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_mt2824_pdata = {

-- 
2.56.0


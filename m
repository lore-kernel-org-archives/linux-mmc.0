Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957587;
	b=m71G37fL40OOpVN7nnqJqdLkcidxCvZOknfyV1n1aXJVKbMHD1CAG9u1xTzyklDo6Ap8
	 r1vPWjJarmDNeIPICiPE9wLVpEH+Lt6UHjL/gXLOsycaE7B3hXumis4n5tJR+Xjgn7g9b
	 7zogzQ99L77vsuAE+MyaCChFOhOQb0DdDepLCXocmBpusKHnKHV6xFcU2kKSgXK4Z5Y+y
	 ja0Am5hEQ6dOdkc1cbj6B6hrFQtJNj0Pf2rBwndgBcaEB/dNtahTjAeYIK50svKjTaq6I
	 jj9YpPSJBo+/pCaZ9N4DZ07M/Ruy20HGoVV49JRcnq7XYTsDagrgo0z6qdL0BFB9yFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957587;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=qlBLa5WXWVw6Kxcx7ZKSOuhUJuTOOWpGOGoSj0s1xhA=;
	b=0TXyea/6JEPGuO851/cEJl+5iw9osMXHVjDXpwrJwchmjwPxoUtrFG1+PPvTTSlmiynr
	 Io3qxoLL7E85bkAbfFHe9m2R4aieqQy9CB1zq4AcBah//H+Z8qPrHG4vXGKm6Pk3ObXja
	 p679lqjhRcGjouasuo9ISQJOmSBMF9HrEupbSfiRbr/aNfr+Zbd4XWNJUYJrlNAgar1lb
	 c9WLO8mebG80oGY5m8N+0TfDaZRC0kQavRdi0T6Bf9WOHMwdLJ86yhDI2/FkZ0bBcIK5q
	 lYuSI7qHNNhcsk3yMkKvebq6GYIzBsDdDe28EA64/qgtZkYkpQc+CGz7lcAlkNly+YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=apCcPMA8;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B8606D82F;
	Fri,  6 Nov 2026 09:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 283B8606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=apCcPMA8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1B6CBC69168;
	Fri,  6 Nov 2026 09:33:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93F065FFBC;
	Fri,  6 Nov 2026 09:33:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1FF4D103292E0;
	Fri,  6 Nov 2026 10:32:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957580; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qlBLa5WXWVw6Kxcx7ZKSOuhUJuTOOWpGOGoSj0s1xhA=;
	b=apCcPMA8x9FGzlSSWYtvKcwEEL6bZ6Ok9fEZvJ+Bc53pnff53M/ziVAFUIO/0iM3JxmRHC
	vJTwhp+GWanVJvoBiTENZ19GZoE4IOFknFxUHPJvAQqSTgx2jMecDqQRurcwLoYkLRndhc
	kxjh+3SoktoaPbXDQYPVRdpG6sN5zSIV9U+eV1HYQcPWFHU4MS/1DzSpEKPeghfB8Y7gh7
	kRUhWgd0r973GXuSUWj3JHmk6tDAmXdZnYLQorTAspszgeSfAk61m477XWZcHed2b082ij
	ZvRnnWL6MVQnK+fOqIpipfVZgrwlDMm505Iml0dpux6mWXN4l/DnLLI02sAclA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:17 +0100
Subject: [PATCH 20/25] mmc: sdhci-of-dwcmshc: add MT2824 support
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
Message-Id: <20261106-mt2824-v1-20-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 has a DWC MSHC 2.00a controller with the DWC eMMC/SD
PHY. The evaluation board has a switch that allows connecting the
controller to either an SD card slot or an eMMC; the switch is only
changed between boots.

Add the "metanoia,mt2824-dwcmshc" compatible string and the special
handling needed by the controller and PHY.

Writing to the low byte of the HOST_CONTROL2 register breaks the response
of the next command, even if the value is unchanged. Add a .write_w()
callback to skip the HOST_CONTROL2 register write if its value is
unchanged, and reset the CMD and DATA lines after every change to the
register.

The transmit clock is not stable when CLOCK_CONTROL reports Internal
Clock Stable. Add a 1 ms delay before SD Clock Enable, and clear the
HOST_CTRL3 command conflict check, which breaks tuning at 200 MHz.

The card type on the evaluation board cannot be determined because the
DIP switch that selects it cannot be read by the SoC. Implement card
probing by starting with the eMMC at 1.8 V. Fall back to the SD slot at
3.3 V after a few attempts.

The SD Bus Voltage Select of POWER_CONTROL also drives the EMMC_VSEL
pull-up rail. Ask for 1.8 V whenever the pads run at 1.8 V: for an eMMC,
and for a UHS SD card at 1.8 V signaling. On the evaluation board the SD
VDD rail remains at 3.3 V, so only the pull-up rail changes. Ignore
ios.signal_voltage until the card is powered on because the core powers
up with the value left over from the previous session. Program the rail
before the core enables the new signaling, reconfigure the PHY pads after
each switch, and set the 1.8 V Signal Enable bit on a reset of all when
the pads are at 1.8 V.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/mmc/host/Kconfig            |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 505 ++++++++++++++++++++++++++++++++++++
 2 files changed, 506 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 79bfc425e7c7..6237d8c352cd 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -244,6 +244,7 @@ config MMC_SDHCI_OF_DWCMSHC
 	depends on OF
 	depends on COMMON_CLK
 	select MMC_CQHCI
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects Synopsys DesignWare Cores Mobile Storage Controller
 	  support.
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 09702022e708..cb248fc572e2 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -45,6 +45,7 @@
 /* HPE GSC SoC MSHCCS register */
 #define HPE_GSC_MSHCCS_SCGSYNCDIS	BIT(18)
 #define DWCMSHC_CARD_IS_EMMC		BIT(0)
+#define DWCMSHC_EMMC_RST_N		BIT(2)
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
 #define DWCMSHC_EMMC_ATCTRL		0x40
 #define DWCMSHC_AT_STAT			0x44
@@ -85,6 +86,19 @@
 #define CV18XX_TUNE_STEP			1
 #define CV18XX_RETRY_TUNING_MAX			50
 
+/* Metanoia MT2824: HOST_CTRL3 sampling edge and PHY pad settings */
+#define MT2824_HOST_CTRL3_NEGEDGE_DATAOUT	BIT(1)
+/* 1.8 V eMMC probe attempts before falling back to the SD slot */
+#define MT2824_PROBE_ATTEMPTS			2
+/* PHY pad settings of the MT2824 pad ring */
+#define MT2824_PHY_PAD_SP_3V3			0x9
+#define MT2824_PHY_PAD_SP_1V8			0x8
+#define MT2824_PHY_PAD_SN			0x8
+#define MT2824_PHY_TXSLEW			0x1
+#define MT2824_PHY_TXSLEW_P_STROBE		0x3
+#define MT2824_PHY_SMPLDL_CNFG			0x0c
+#define MT2824_PHY_ATDL_CNFG			0x0c
+
 /* Rockchip specific Registers */
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
 #define DWCMSHC_EMMC_DLL_RXCLK		0x804
@@ -2108,6 +2122,470 @@ static const struct sdhci_ops sdhci_dwcmshc_k230_ops = {
 	.adma_write_desc = dwcmshc_adma_write_desc,
 };
 
+/* Metanoia MT2824 */
+
+enum mt2824_card_type {
+	MT2824_CARD_UNKNOWN,	/* eMMC-first probe in progress */
+	MT2824_CARD_EMMC,
+	MT2824_CARD_SD,
+};
+
+struct mt2824_priv {
+	enum mt2824_card_type card_type;
+	unsigned int probe_attempts;
+};
+
+static struct mt2824_priv *mt2824_get_priv(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+
+	return dwc_priv->priv;
+}
+
+/*
+ * The board jumper selects the SD slot or the eMMC and is only changed
+ * between boots. Until the type is known, probe the eMMC at 1.8 V first.
+ */
+static bool mt2824_card_is_emmc(struct sdhci_host *host)
+{
+	struct mt2824_priv *priv = mt2824_get_priv(host);
+
+	if (priv) {
+		if (priv->card_type == MT2824_CARD_EMMC)
+			return true;
+		if (priv->card_type == MT2824_CARD_SD)
+			return false;
+
+		/* eMMC-first probe; an SD card does not answer CMD1 */
+		return true;
+	}
+
+	return (host->mmc->caps2 & MMC_CAP2_NO_SD) ||
+	       (host->mmc->card && mmc_card_mmc(host->mmc->card));
+}
+
+/* The pads follow the signal voltage, and an eMMC is always at 1.8 V */
+static bool mt2824_pads_1v8(struct sdhci_host *host)
+{
+	return mt2824_card_is_emmc(host) ||
+	       (host->mmc->ios.power_mode == MMC_POWER_ON &&
+		host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180);
+}
+
+/*
+ * On this controller, a write of the HOST_CONTROL2 low byte breaks the
+ * response of the command that follows, even when the value does not
+ * change. Drop the writes that do not change the register.
+ */
+static void mt2824_write_w(struct sdhci_host *host, u16 val, int reg)
+{
+	if (reg == SDHCI_HOST_CONTROL2 && sdhci_readw(host, reg) == val)
+		return;
+
+	writew(val, host->ioaddr + reg);
+}
+
+/*
+ * A timing change must write the new bus speed mode to HOST_CONTROL2.
+ * Reset the CMD and DATA lines after the write, while the card clock is
+ * off, so that the next command gets a good response.
+ */
+static void mt2824_set_uhs_signaling(struct sdhci_host *host,
+				     unsigned int timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg = dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3;
+	u16 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	u8 ctrl;
+
+	ctrl = sdhci_readb(host, reg);
+	ctrl &= ~MT2824_HOST_CTRL3_NEGEDGE_DATAOUT;
+	if (timing == MMC_TIMING_MMC_DDR52 ||
+	    timing == MMC_TIMING_UHS_DDR50)
+		ctrl |= MT2824_HOST_CTRL3_NEGEDGE_DATAOUT;
+	sdhci_writeb(host, ctrl, reg);
+
+	dwcmshc_set_uhs_signaling(host, timing);
+	if (sdhci_readw(host, SDHCI_HOST_CONTROL2) != ctrl2)
+		dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+}
+
+/* PHY pads and delay lines of the MT2824 pad ring, then release the PHY */
+static int mt2824_phy_init(struct sdhci_host *host, bool v1v8)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 rxsel = v1v8 ? PHY_PAD_RXSEL_1V8 : PHY_PAD_RXSEL_3V3;
+	u32 val;
+	int ret;
+
+	val = rxsel;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, MT2824_PHY_TXSLEW);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, MT2824_PHY_TXSLEW);
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, MT2824_PHY_TXSLEW);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, MT2824_PHY_TXSLEW);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	val = PHY_PAD_RXSEL_1V8;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, MT2824_PHY_TXSLEW_P_STROBE);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, MT2824_PHY_TXSLEW);
+	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+
+	sdhci_writeb(host, MT2824_PHY_SMPLDL_CNFG, PHY_SMPLDL_CNFG_R);
+	sdhci_writeb(host, MT2824_PHY_ATDL_CNFG, PHY_ATDL_CNFG_R);
+
+	val = sdhci_readl(host, PHY_CNFG_R);
+	val &= ~(PHY_CNFG_PAD_SP_MASK | PHY_CNFG_PAD_SN_MASK);
+	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK,
+			  v1v8 ? MT2824_PHY_PAD_SP_1V8 : MT2824_PHY_PAD_SP_3V3);
+	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, MT2824_PHY_PAD_SN);
+	sdhci_writel(host, val, PHY_CNFG_R);
+
+	ret = read_poll_timeout(sdhci_readl, val, val & PHY_CNFG_PHY_PWRGOOD_MASK,
+				1000, 20000, false, host, PHY_CNFG_R);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "PHY power never became good\n");
+		return ret;
+	}
+
+	sdhci_writel(host, val | PHY_CNFG_RSTN_DEASSERT, PHY_CNFG_R);
+
+	/*
+	 * Stop the clocks while a tuning phase changes, avoids a glitch. Only
+	 * a reset clears the bit, and AT_CTRL_R must not be written while
+	 * SAMPLE_CLK_SEL is set, so write it only when it is missing.
+	 */
+	val = sdhci_readl(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+	if (!(val & AT_CTRL_TUNE_CLK_STOP_EN))
+		sdhci_writel(host, val | AT_CTRL_TUNE_CLK_STOP_EN,
+			     dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+
+	return 0;
+}
+
+static bool mt2824_wait_clk_stable(struct sdhci_host *host, u16 *clk,
+				   const char *what)
+{
+	u16 val;
+
+	if (read_poll_timeout_atomic(sdhci_readw, val,
+				     val & SDHCI_CLOCK_INT_STABLE, 10, 150000,
+				     false, host, SDHCI_CLOCK_CONTROL)) {
+		dev_err(mmc_dev(host->mmc), "%s never stabilised\n", what);
+		sdhci_err_stats_inc(host, CTRL_TIMEOUT);
+		sdhci_dumpregs(host);
+		return false;
+	}
+
+	*clk = val;
+	return true;
+}
+
+/*
+ * sdhci_enable_clk() with a settle time: the transmit clock is not stable
+ * yet when CLOCK_CONTROL reports the internal clock stable, and the first
+ * command after the SD Clock Enable then gets a bad response.
+ */
+static void mt2824_enable_clk(struct sdhci_host *host, u16 clk)
+{
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	if (!mt2824_wait_clk_stable(host, &clk, "internal clock"))
+		return;
+
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
+		clk |= SDHCI_CLOCK_PLL_EN;
+		clk &= ~SDHCI_CLOCK_INT_STABLE;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+		if (!mt2824_wait_clk_stable(host, &clk, "PLL clock"))
+			return;
+	}
+
+	mdelay(1);
+	sdhci_writew(host, clk | SDHCI_CLOCK_CARD_EN, SDHCI_CLOCK_CONTROL);
+}
+
+static void mt2824_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
+	u32 reg = dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3;
+	u8 ctrl;
+
+	/* The conflict check breaks tuning at 200 MHz */
+	ctrl = sdhci_readb(host, reg);
+	ctrl &= ~DWCMSHC_HOST_CTRL3_CMD_CONFLICT;
+	sdhci_writeb(host, ctrl, reg);
+
+	/* sdhci_set_clock() with mt2824_enable_clk() */
+	mmc->actual_clock = 0;
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	if (clock)
+		mt2824_enable_clk(host, sdhci_calc_clk(host, clock,
+						       &mmc->actual_clock));
+}
+
+/* The controller must know that the card is an eMMC (EMMC_CTRL_R, 16 bit) */
+static void mt2824_update_card_is_emmc(struct sdhci_host *host, bool is_emmc)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg = dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL;
+	u16 ctrl = sdhci_readw(host, reg);
+
+	if (is_emmc)
+		ctrl |= DWCMSHC_CARD_IS_EMMC;
+	else
+		ctrl &= ~DWCMSHC_CARD_IS_EMMC;
+	sdhci_writew(host, ctrl, reg);
+}
+
+/*
+ * The SD Bus Voltage Select of POWER_CONTROL also sets the EMMC_VSEL output,
+ * which picks the board rail of the card signal pull-ups: 3.3 V for an SD
+ * card, 1.8 V for an eMMC or a UHS SD card. The core asks for the VDD voltage
+ * (3.3 V), so ask for 1.8 V when the pads use 1.8 V. On an SD card this only
+ * moves the pull-ups: the SD VDD rail stays at 3.3 V on this board.
+ */
+static void mt2824_set_power(struct sdhci_host *host, unsigned char mode,
+			     unsigned short vdd)
+{
+	if (mode != MMC_POWER_OFF && mt2824_pads_1v8(host))
+		vdd = ilog2(MMC_VDD_165_195);
+
+	sdhci_set_power(host, mode, vdd);
+}
+
+/*
+ * The PHY pads follow every signal voltage change, in both directions:
+ * the core switches back to 3.3 V on each power up.
+ */
+static int mt2824_start_signal_voltage_switch(struct mmc_host *mmc,
+					      struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	int ret;
+
+	/*
+	 * The pull-up rail must change before the generic switch enables the
+	 * new signaling otherwise the lines see an invalid voltage.
+	 */
+	mt2824_set_power(host, ios->power_mode, ios->vdd);
+
+	ret = sdhci_start_signal_voltage_switch(mmc, ios);
+	if (ret)
+		return ret;
+
+	/* a changed 1.8V Signal Enable breaks the next response */
+	if (sdhci_readw(host, SDHCI_HOST_CONTROL2) != ctrl2)
+		dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	ret = mt2824_phy_init(host, mt2824_pads_1v8(host));
+	if (!ret)
+		mt2824_update_card_is_emmc(host, mt2824_card_is_emmc(host));
+
+	return ret;
+}
+
+static void mt2824_reset(struct sdhci_host *host, u8 mask)
+{
+	dwcmshc_reset(host, mask);
+
+	if (mask & SDHCI_RESET_ALL) {
+		u16 old = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		u16 ctrl2 = old;
+
+		mt2824_phy_init(host, mt2824_pads_1v8(host));
+
+		/*
+		 * A reset clears HOST_CONTROL2. Write the bits that the core
+		 * would set later now, in one write followed by a reset of the
+		 * CMD and DATA lines: the core writes them in the request path,
+		 * right before a command. The core sets Host Version 4 Enable
+		 * after each reset of all, and 64-bit Addressing before the
+		 * first DMA request. CMD23 Enable has no effect until a request
+		 * uses CMD23. 1.8 V pads need 1.8V Signal Enable.
+		 */
+		if (host->v4_mode)
+			ctrl2 |= SDHCI_CTRL_V4_MODE;
+		if (host->flags & SDHCI_USE_64_BIT_DMA)
+			ctrl2 |= SDHCI_CTRL_64BIT_ADDR;
+		ctrl2 |= SDHCI_CMD23_ENABLE;
+		if (mt2824_pads_1v8(host))
+			ctrl2 |= SDHCI_CTRL_VDD_180;
+		if (ctrl2 != old) {
+			sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+			dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		}
+
+		/* the reset also cleared CARD_IS_EMMC */
+		mt2824_update_card_is_emmc(host, mt2824_card_is_emmc(host));
+	}
+}
+
+static void mt2824_hw_reset(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 reg = dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL;
+	u16 ctrl, clk;
+
+	/* only an eMMC has RST_n: known from the DT, or from the card */
+	if (!(host->mmc->caps2 & MMC_CAP2_NO_SD) &&
+	    (!host->mmc->card || !mmc_card_mmc(host->mmc->card)))
+		return;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* EMMC_CTRL_R is a 16 bit register */
+	ctrl = sdhci_readw(host, reg);
+	sdhci_writew(host, ctrl & ~DWCMSHC_EMMC_RST_N, reg);
+	usleep_range(10000, 11000);
+	sdhci_writew(host, ctrl | DWCMSHC_EMMC_RST_N, reg);
+	/* tRSCA: the device needs 200 us after RST_n before a command */
+	usleep_range(300, 1000);
+
+	sdhci_enable_clk(host, clk);
+}
+
+/*
+ * With no card type from the DT, look for an eMMC only, at 1.8 V: an eMMC
+ * answers CMD1, an SD card does not, so no 3.3 V signal reaches an eMMC.
+ * The board jumper is only changed between boots. After a few power cycles
+ * without a card, switch to the SD slot at 3.3 V and latch that type for the
+ * rest of the boot. An empty slot goes to the SD search at once.
+ */
+static void mt2824_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mt2824_priv *priv = mt2824_get_priv(host);
+	bool no_card;
+
+	if (ios->power_mode != MMC_POWER_OFF || mmc->card ||
+	    priv->card_type != MT2824_CARD_UNKNOWN) {
+		sdhci_set_ios(mmc, ios);
+		return;
+	}
+
+	no_card = mmc->ops->get_cd && !mmc->ops->get_cd(mmc);
+	if (no_card || ++priv->probe_attempts >= MT2824_PROBE_ATTEMPTS) {
+		priv->card_type = MT2824_CARD_SD;
+		host->mmc_host_ops.set_ios = sdhci_set_ios;
+		mmc->caps2 &= ~MMC_CAP2_NO_SD;
+		mmc->caps2 |= MMC_CAP2_NO_MMC;
+		host->flags |= SDHCI_SIGNALING_330;
+		dev_dbg(mmc_dev(mmc), "no eMMC at 1.8 V, looking for an SD card\n");
+	}
+
+	sdhci_set_ios(mmc, ios);
+}
+
+/*
+ * The device tree did not name the card, and the core identified one
+ * (mmc.c and sd.c call init_card after CMD2). Latch the type for the rest of
+ * the boot and set the pads and CARD_IS_EMMC for it.
+ */
+static void mt2824_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	struct mt2824_priv *priv = dwc_priv->priv;
+	bool is_emmc = mmc_card_mmc(card);
+
+	/* mmc->card is still NULL on the first init of this card */
+	if (!mmc->card)
+		dev_info(mmc_dev(mmc), "%s found\n", is_emmc ? "eMMC" : "SD card");
+
+	priv->card_type = is_emmc ? MT2824_CARD_EMMC : MT2824_CARD_SD;
+	priv->probe_attempts = 0;
+	host->mmc_host_ops.set_ios = sdhci_set_ios;
+
+	if (is_emmc) {
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+		mmc->caps |= MMC_CAP_NONREMOVABLE;
+		mmc->caps2 |= MMC_CAP2_NO_SD;
+		mmc->caps2 &= ~MMC_CAP2_NO_MMC;
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |= SDHCI_SIGNALING_180;
+		mt2824_phy_init(host, true);
+	} else {
+		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
+		mmc->caps &= ~MMC_CAP_NONREMOVABLE;
+		mmc->caps2 &= ~MMC_CAP2_NO_SD;
+		mmc->caps2 |= MMC_CAP2_NO_MMC;
+		host->flags |= SDHCI_SIGNALING_330;
+		mt2824_phy_init(host, mt2824_pads_1v8(host));
+	}
+
+	mt2824_update_card_is_emmc(host, is_emmc);
+}
+
+/*
+ * The controller can drive an SD card slot or an eMMC. A board jumper
+ * selects one; it is only changed between boots. "no-sd" (eMMC) or
+ * "no-mmc" (SD card) in the device tree fixes the card type. Without them,
+ * probe the eMMC at 1.8 V first, then fall back to the SD slot at 3.3 V.
+ */
+static int mt2824_init(struct device *dev, struct sdhci_host *host,
+		       struct dwcmshc_priv *dwc_priv)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct mt2824_priv *priv;
+	bool is_emmc;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	dwc_priv->priv = priv;
+
+	mmc->caps2 |= MMC_CAP2_NO_SDIO;
+	host->mmc_host_ops.start_signal_voltage_switch =
+		mt2824_start_signal_voltage_switch;
+
+	if (mmc->caps2 & MMC_CAP2_NO_SD) {
+		priv->card_type = MT2824_CARD_EMMC;
+		is_emmc = true;
+	} else if (mmc->caps2 & MMC_CAP2_NO_MMC) {
+		priv->card_type = MT2824_CARD_SD;
+		is_emmc = false;
+	} else {
+		/* look for an eMMC first, with no 3.3 V signaling */
+		dev_info(dev, "card type detection, eMMC first at 1.8 V\n");
+		priv->card_type = MT2824_CARD_UNKNOWN;
+		mmc->caps2 |= MMC_CAP2_NO_SD;
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->mmc_host_ops.init_card = mt2824_init_card;
+		host->mmc_host_ops.set_ios = mt2824_set_ios;
+		return 0;
+	}
+
+	dev_info(dev, "%s interface from the device tree\n",
+		 is_emmc ? "eMMC" : "SD");
+	if (is_emmc) {
+		/* an eMMC is soldered to a fixed 1.8 V rail */
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+		mmc->caps |= MMC_CAP_NONREMOVABLE;
+		mmc->caps2 &= ~MMC_CAP2_NO_MMC;
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |= SDHCI_SIGNALING_180;
+	}
+
+	return 0;
+}
+
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
 	.pdata = {
 		.ops = &sdhci_dwcmshc_ops,
@@ -2184,6 +2662,29 @@ static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3588_pdata = {
 	.revision = 1,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_mt2824_ops = {
+	.write_w		= mt2824_write_w,
+	.set_clock		= mt2824_set_clock,
+	.set_power		= mt2824_set_power,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= mt2824_set_uhs_signaling,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.reset			= mt2824_reset,
+	.hw_reset		= mt2824_hw_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+};
+
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_mt2824_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_mt2824_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+			  SDHCI_QUIRK_BROKEN_DMA |
+			  SDHCI_QUIRK_BROKEN_ADMA,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+	.init = mt2824_init,
+};
+
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
 	.pdata = {
 		.ops = &sdhci_dwcmshc_th1520_ops,
@@ -2350,6 +2851,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "canaan,k230-sdio",
 		.data = &k230_sdio_data.dwcmshc_pdata,
 	},
+	{
+		.compatible = "metanoia,mt2824-dwcmshc",
+		.data = &sdhci_dwcmshc_mt2824_pdata,
+	},
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = &sdhci_dwcmshc_rk3588_pdata,

-- 
2.56.0


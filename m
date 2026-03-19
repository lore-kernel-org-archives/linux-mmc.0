Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8213033C2;
	Thu, 19 Mar 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929262; cv=none; b=nD5A/soMIICC4PMrdczpguG5bRf413iJyWZpgC/CETq0JzqwAGUFgCbdjUZ1VTXMXr/UY2K2hx6D+dr8WfPoBCmEPcQgy5lncBXkCvzloUuOUqFT5ee9A37LB57OHvdax48k/28hap35CWp5tsgi3THml+MwFD9GDBIfVkPEzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929262; c=relaxed/simple;
	bh=sxTWxkmCUQYr0rw1ycyKa/yDGjAvnjL0Jh8PB5/o0/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBWNIBXhv838+59TMUeYauSM+kW207PZ29AoeT9XPl6THVaxrCuYhWIywP22SwuNNbKPSzjzAukTfOz0+1heQjRiSV1ZjRTJBiEgOJANeI7Rh2sk0xWB89TubBFqZJAHNroqnVv5cNR+2qwA2kYk3SVwMM+RVp0ioIEP9wUH1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from duge-virtual-machine (unknown [183.192.222.244])
	by APP-03 (Coremail) with SMTP id rQCowABnieAaA7xpRC4mCw--.14810S4;
	Thu, 19 Mar 2026 22:07:25 +0800 (CST)
From: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
To: krzk@kernel.org,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn,
	me@ziyao.cc,
	Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v5 2/3] mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC controller support
Date: Thu, 19 Mar 2026 22:07:04 +0800
Message-ID: <20260319140705.123502-3-jiayu.riscv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319140705.123502-1-jiayu.riscv@isrc.iscas.ac.cn>
References: <20260319140705.123502-1-jiayu.riscv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnieAaA7xpRC4mCw--.14810S4
X-Coremail-Antispam: 1UD129KBjvAXoW3Aw4fWFW3XFW8XrWfCF45ZFb_yoW8Gr43Ko
	WfGFn3Xw48tw4Ig3yqkrn7KF9rAw4qy3ySgwsIvrn5Cwn7u3WDJr13GFW3Ga43Ww1Fkryk
	Aws7try3XFWFy3WDn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO77AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
	8EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRHKZLUUUUU=
X-CM-SenderInfo: 5mld534oul2uny6l223fol2u1dvotugofq/

Add SDHCI controller driver for Canaan k230 SoC. Implement custom
sdhci_ops for set_clock, phy init, init and reset.

Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 260 ++++++++++++++++++++++++++++
 1 file changed, 260 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 2b75a36c096b..2b34444b8608 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -128,9 +128,11 @@
 #define PHY_CNFG_PHY_PWRGOOD_MASK	BIT_MASK(1) /* bit [1] */
 #define PHY_CNFG_PAD_SP_MASK		GENMASK(19, 16) /* bits [19:16] */
 #define PHY_CNFG_PAD_SP			0x0c /* PMOS TX drive strength */
+#define PHY_CNFG_PAD_SP_k230		0x09 /* PMOS TX drive strength for k230 */
 #define PHY_CNFG_PAD_SP_SG2042		0x09 /* PMOS TX drive strength for SG2042 */
 #define PHY_CNFG_PAD_SN_MASK		GENMASK(23, 20) /* bits [23:20] */
 #define PHY_CNFG_PAD_SN			0x0c /* NMOS TX drive strength */
+#define PHY_CNFG_PAD_SN_k230		0x08 /* NMOS TX drive strength for k230 */
 #define PHY_CNFG_PAD_SN_SG2042		0x08 /* NMOS TX drive strength for SG2042 */
 
 /* PHY command/response pad settings */
@@ -153,14 +155,21 @@
 #define PHY_PAD_RXSEL_3V3		0x2 /* Receiver type select for 3.3V */
 
 #define PHY_PAD_WEAKPULL_MASK		GENMASK(4, 3) /* bits [4:3] */
+#define PHY_PAD_WEAKPULL_DISABLED	0x0 /* Weak pull up and pull down disabled */
 #define PHY_PAD_WEAKPULL_PULLUP		0x1 /* Weak pull up enabled */
 #define PHY_PAD_WEAKPULL_PULLDOWN	0x2 /* Weak pull down enabled */
 
 #define PHY_PAD_TXSLEW_CTRL_P_MASK	GENMASK(8, 5) /* bits [8:5] */
 #define PHY_PAD_TXSLEW_CTRL_P		0x3 /* Slew control for P-Type pad TX */
+#define PHY_PAD_TXSLEW_CTRL_P_k230	0x2 /* Slew control for P-Type pad TX for k230 */
 #define PHY_PAD_TXSLEW_CTRL_N_MASK	GENMASK(12, 9) /* bits [12:9] */
 #define PHY_PAD_TXSLEW_CTRL_N		0x3 /* Slew control for N-Type pad TX */
 #define PHY_PAD_TXSLEW_CTRL_N_SG2042	0x2 /* Slew control for N-Type pad TX for SG2042 */
+#define PHY_PAD_TXSLEW_CTRL_N_k230	0x2 /* Slew control for N-Type pad TX for k230 */
+
+/* PHY Common DelayLine config settings */
+#define PHY_COMMDL_CNFG			(DWC_MSHC_PTR_PHY_R + 0x1c)
+#define PHY_COMMDL_CNFG_DLSTEP_SEL	BIT(0) /* DelayLine outputs on PAD enabled */
 
 /* PHY CLK delay line settings */
 #define PHY_SDCLKDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x1d)
@@ -174,7 +183,10 @@
 #define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
 
 #define PHY_SMPLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x20)
+#define PHY_SMPLDL_CNFG_EXTDLY_EN	BIT(0)
 #define PHY_SMPLDL_CNFG_BYPASS_EN	BIT(1)
+#define PHY_SMPLDL_CNFG_INPSEL_MASK	GENMASK(3, 2) /* bits [3:2] */
+#define PHY_SMPLDL_CNFG_INPSEL		0x3 /* delay line input source */
 
 /* PHY drift_cclk_rx delay line configuration setting */
 #define PHY_ATDL_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x21)
@@ -224,9 +236,20 @@
 					 SDHCI_TRNS_BLK_CNT_EN | \
 					 SDHCI_TRNS_DMA)
 
+#define to_pltfm_data(priv, name) \
+	container_of((priv)->dwcmshc_pdata, struct name##_pltfm_data, dwcmshc_pdata)
+
 /* SMC call for BlueField-3 eMMC RST_N */
 #define BLUEFIELD_SMC_SET_EMMC_RST_N	0x82000007
 
+/* Canaan specific Registers */
+#define SD0_CTRL			0x00
+#define SD0_HOST_REG_VOL_STABLE		BIT(4)
+#define SD0_CARD_WRITE_PROT		BIT(6)
+#define SD1_CTRL			0x08
+#define SD1_HOST_REG_VOL_STABLE		BIT(0)
+#define SD1_CARD_WRITE_PROT		BIT(2)
+
 /* Eswin specific Registers */
 #define EIC7700_CARD_CLK_STABLE		BIT(28)
 #define EIC7700_INT_BCLK_STABLE		BIT(16)
@@ -268,6 +291,11 @@ struct eic7700_priv {
 	unsigned int drive_impedance;
 };
 
+struct k230_priv  {
+	/* Canaan k230 specific */
+	struct regmap *hi_sys_regmap;
+};
+
 #define DWCMSHC_MAX_OTHER_CLKS 3
 
 struct dwcmshc_priv {
@@ -278,6 +306,7 @@ struct dwcmshc_priv {
 	int num_other_clks;
 	struct clk_bulk_data other_clks[DWCMSHC_MAX_OTHER_CLKS];
 
+	const struct dwcmshc_pltfm_data *dwcmshc_pdata;
 	void *priv; /* pointer to SoC private stuff */
 	u16 delay_line;
 	u16 flags;
@@ -290,6 +319,14 @@ struct dwcmshc_pltfm_data {
 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
 };
 
+struct k230_pltfm_data {
+	struct dwcmshc_pltfm_data dwcmshc_pdata;
+	bool is_emmc;
+	u32 ctrl_reg;
+	u32 vol_stable_bit;
+	u32 write_prot_bit;
+};
+
 static void dwcmshc_enable_card_clk(struct sdhci_host *host)
 {
 	u16 ctrl;
@@ -1656,6 +1693,181 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 	return 0;
 }
 
+static void dwcmshc_k230_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+
+	sdhci_set_clock(host, clock);
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	/*
+	 * It is necessary to enable SDHCI_PROG_CLOCK_MODE. This is a
+	 * vendor-specific quirk. If this is not done, the eMMC will be
+	 * unable to read or write.
+	 */
+	clk |= SDHCI_PROG_CLOCK_MODE;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
+static void sdhci_k230_config_phy_delay(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 val;
+
+	sdhci_writeb(host, PHY_COMMDL_CNFG_DLSTEP_SEL, PHY_COMMDL_CNFG);
+	sdhci_writeb(host, 0x0, PHY_SDCLKDL_CNFG_R);
+	sdhci_writeb(host, PHY_SDCLKDL_DC_INITIAL, PHY_SDCLKDL_DC_R);
+
+	val = PHY_SMPLDL_CNFG_EXTDLY_EN;
+	val |= FIELD_PREP(PHY_SMPLDL_CNFG_INPSEL_MASK, PHY_SMPLDL_CNFG_INPSEL);
+	sdhci_writeb(host, val, PHY_SMPLDL_CNFG_R);
+
+	sdhci_writeb(host, FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, PHY_ATDL_CNFG_INPSEL),
+		     PHY_ATDL_CNFG_R);
+
+	val = sdhci_readl(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+	val |= AT_CTRL_TUNE_CLK_STOP_EN;
+	val |= FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, AT_CTRL_PRE_CHANGE_DLY);
+	val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY);
+	sdhci_writel(host, val, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
+}
+
+static int dwcmshc_k230_phy_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 rxsel;
+	u32 val;
+	u32 reg;
+	int ret;
+
+	/* reset phy */
+	sdhci_writew(host, 0, PHY_CNFG_R);
+
+	/* Disable the clock */
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	rxsel = dwc_priv->flags & FLAG_IO_FIXED_1V8 ? PHY_PAD_RXSEL_1V8 : PHY_PAD_RXSEL_3V3;
+
+	val = rxsel;
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230);
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
+
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	val = rxsel;
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	val = rxsel;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230);
+	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+
+	sdhci_k230_config_phy_delay(host);
+
+	/* Wait max 150 ms */
+	ret = read_poll_timeout(sdhci_readl, reg,
+				(reg & FIELD_PREP(PHY_CNFG_PHY_PWRGOOD_MASK, 1)),
+				10, 150000, false, host, PHY_CNFG_R);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "READ PHY PWRGOOD timeout!\n");
+		return -ETIMEDOUT;
+	}
+
+	reg = FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN_k230) |
+	      FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP_k230);
+	sdhci_writel(host, reg, PHY_CNFG_R);
+
+	/* de-assert the phy */
+	reg |= PHY_CNFG_RSTN_DEASSERT;
+	sdhci_writel(host, reg, PHY_CNFG_R);
+
+	return 0;
+}
+
+static void dwcmshc_k230_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	const struct k230_pltfm_data *k230_pdata = to_pltfm_data(dwc_priv, k230);
+	u8 emmc_ctrl;
+
+	dwcmshc_reset(host, mask);
+
+	if (mask != SDHCI_RESET_ALL)
+		return;
+
+	emmc_ctrl = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+	sdhci_writeb(host, emmc_ctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+
+	if (k230_pdata->is_emmc)
+		dwcmshc_k230_phy_init(host);
+	else
+		sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
+}
+
+static int dwcmshc_k230_init(struct device *dev, struct sdhci_host *host,
+			     struct dwcmshc_priv *dwc_priv)
+{
+	const struct k230_pltfm_data *k230_pdata = to_pltfm_data(dwc_priv, k230);
+	static const char * const clk_ids[] = {"block", "timer", "axi"};
+	struct device_node *usb_phy_node;
+	struct k230_priv *k230_priv;
+	u32 data;
+	int ret;
+
+	k230_priv = devm_kzalloc(dev, sizeof(struct k230_priv), GFP_KERNEL);
+	if (!k230_priv)
+		return -ENOMEM;
+
+	dwc_priv->priv = k230_priv;
+
+	usb_phy_node = of_parse_phandle(dev->of_node, "canaan,usb-phy", 0);
+	if (!usb_phy_node)
+		return dev_err_probe(dev, -ENODEV, "Failed to find canaan,usb-phy phandle\n");
+
+	k230_priv->hi_sys_regmap = device_node_to_regmap(usb_phy_node);
+	of_node_put(usb_phy_node);
+
+	if (IS_ERR(k230_priv->hi_sys_regmap))
+		return dev_err_probe(dev, PTR_ERR(k230_priv->hi_sys_regmap),
+				     "Failed to get k230-usb-phy regmap\n");
+
+	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
+					    ARRAY_SIZE(clk_ids), clk_ids);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get/enable k230 mmc other clocks\n");
+
+	if (k230_pdata->is_emmc) {
+		host->flags &= ~SDHCI_SIGNALING_330;
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+	} else {
+		host->mmc->caps |= MMC_CAP_SD_HIGHSPEED;
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+	}
+
+	ret = regmap_read(k230_priv->hi_sys_regmap, k230_pdata->ctrl_reg, &data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read control reg 0x%x\n",
+				     k230_pdata->ctrl_reg);
+
+	data |= k230_pdata->write_prot_bit | k230_pdata->vol_stable_bit;
+	ret = regmap_write(k230_priv->hi_sys_regmap, k230_pdata->ctrl_reg, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write control reg 0x%x\n",
+				     k230_pdata->ctrl_reg);
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -1743,6 +1955,15 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
 	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_k230_ops = {
+	.set_clock = dwcmshc_k230_sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.set_uhs_signaling = dwcmshc_set_uhs_signaling,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.reset = dwcmshc_k230_sdhci_reset,
+	.adma_write_desc = dwcmshc_adma_write_desc,
+};
+
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
 	.pdata = {
 		.ops = &sdhci_dwcmshc_ops,
@@ -1834,6 +2055,36 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
 	.init = eic7700_init,
 };
 
+static const struct k230_pltfm_data k230_emmc_data = {
+	.dwcmshc_pdata = {
+		.pdata = {
+			.ops = &sdhci_dwcmshc_k230_ops,
+			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+				  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+		},
+		.init = dwcmshc_k230_init,
+	},
+	.is_emmc = true,
+	.ctrl_reg = SD0_CTRL,
+	.vol_stable_bit = SD0_HOST_REG_VOL_STABLE,
+	.write_prot_bit = SD0_CARD_WRITE_PROT,
+};
+
+static const struct k230_pltfm_data k230_sdio_data = {
+	.dwcmshc_pdata = {
+		.pdata = {
+			.ops = &sdhci_dwcmshc_k230_ops,
+			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+				  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+		},
+		.init = dwcmshc_k230_init,
+	},
+	.is_emmc = false,
+	.ctrl_reg = SD1_CTRL,
+	.vol_stable_bit = SD1_HOST_REG_VOL_STABLE,
+	.write_prot_bit = SD1_CARD_WRITE_PROT,
+};
+
 static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
 	.enable		= dwcmshc_sdhci_cqe_enable,
 	.disable	= sdhci_cqe_disable,
@@ -1906,6 +2157,14 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 }
 
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{
+		.compatible = "canaan,k230-emmc",
+		.data = &k230_emmc_data.dwcmshc_pdata,
+	},
+	{
+		.compatible = "canaan,k230-sdio",
+		.data = &k230_sdio_data.dwcmshc_pdata,
+	},
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,
@@ -1988,6 +2247,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
+	priv->dwcmshc_pdata = pltfm_data;
 
 	if (dev->of_node) {
 		pltfm_host->clk = devm_clk_get(dev, "core");
-- 
2.53.0


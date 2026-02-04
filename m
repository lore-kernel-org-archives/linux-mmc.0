Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D115392C5B;
	Wed,  4 Feb 2026 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193771; cv=none; b=s0iApinYojR9oal7Su6YgtZ/9wQ5ESOQtVBKfIVtf8vFamNbMgs0TTQosNa+nvnX0yoXOJR/9dmpm9HVP3G1NjJXQem/Kt98R6sbrVqTJqgCkYlH4CFCxN9J49W5ofBKN8hKJXIPTUJYUQTeaUAqssJ8IC6DPNfXLELAQBz/5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193771; c=relaxed/simple;
	bh=oJit7aJZkLFhqgs/3ttW+T5AV6Nk+YCT+amqV9HL73A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBgn9vjqgicfpt1cG69VZXhF9JmHG43r0QnUhunHMhjfIKLYfR1dFa+FXXBzF/I5QBmjlPdJosqkMnJpRvFBQD9qjNVwFc3kegtjEkLUkX9CVN3PkD9bpjDAp9mESWn1nypsZS8uWl0UjBC+YL3RXZrtquDIE65Ziz3XePUE5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from duge-virtual-machine (unknown [223.160.207.2])
	by APP-01 (Coremail) with SMTP id qwCowADnjWlcA4NpYqgfBw--.6098S4;
	Wed, 04 Feb 2026 16:29:21 +0800 (CST)
From: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
To: ulf.hansson@linaro.org,
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
	Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Subject: [PATCH 2/3] mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC controller support
Date: Wed,  4 Feb 2026 16:29:07 +0800
Message-ID: <20260204082908.27501-3-jiayu.riscv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
References: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnjWlcA4NpYqgfBw--.6098S4
X-Coremail-Antispam: 1UD129KBjvJXoWfGF47tw4xJF4ruF47ZrW3trb_yoWkKw17pF
	W8AFy5Kr1kKFs5Wwn7Ja1kZw13Kwn2qFZag3sxJ3ySya1Syw1UGFy8uFyYqFy5JrZ7Xw47
	Kw4DJa4UuFZFkwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbH5lUUUUUU==
X-CM-SenderInfo: 5mld534oul2uny6l223fol2u1dvotugofq/

Add SDHCI controller driver for Canaan k230 SoC. Implement custom
sdhci_ops for set_clock, phy init, init and reset.

Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 247 ++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 204830b40587..bc427bfbba25 100644
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
@@ -153,14 +155,22 @@
 #define PHY_PAD_RXSEL_3V3		0x2 /* Receiver type select for 3.3V */
 
 #define PHY_PAD_WEAKPULL_MASK		GENMASK(4, 3) /* bits [4:3] */
+#define PHY_PAD_WEAKPULL_DISABLED	0x0 /* Weak pull up and pull down disabled */
 #define PHY_PAD_WEAKPULL_PULLUP		0x1 /* Weak pull up enabled */
 #define PHY_PAD_WEAKPULL_PULLDOWN	0x2 /* Weak pull down enabled */
 
 #define PHY_PAD_TXSLEW_CTRL_P_MASK	GENMASK(8, 5) /* bits [8:5] */
 #define PHY_PAD_TXSLEW_CTRL_P		0x3 /* Slew control for P-Type pad TX */
+#define PHY_PAD_TXSLEW_CTRL_P_k230_VAL2	0x2 /* Slew control for P-Type pad TX for k230 */
 #define PHY_PAD_TXSLEW_CTRL_N_MASK	GENMASK(12, 9) /* bits [12:9] */
 #define PHY_PAD_TXSLEW_CTRL_N		0x3 /* Slew control for N-Type pad TX */
 #define PHY_PAD_TXSLEW_CTRL_N_SG2042	0x2 /* Slew control for N-Type pad TX for SG2042 */
+#define PHY_PAD_TXSLEW_CTRL_N_k230_VAL2	0x2 /* Slew control for N-Type pad TX for k230 */
+#define PHY_PAD_TXSLEW_CTRL_N_k230_VAL1	0x1 /* Slew control for N-Type pad TX for k230 */
+
+/* PHY Common DelayLine config settings */
+#define PHY_COMMDL_CNFG			(DWC_MSHC_PTR_PHY_R + 0x1c)
+#define PHY_COMMDL_CNFG_DLSTEP_SEL	BIT(0) /* DelayLine outputs on PAD enabled */
 
 /* PHY CLK delay line settings */
 #define PHY_SDCLKDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x1d)
@@ -174,7 +184,10 @@
 #define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
 
 #define PHY_SMPLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x20)
+#define PHY_SMPLDL_CNFG_EXTDLY_EN	BIT(0)
 #define PHY_SMPLDL_CNFG_BYPASS_EN	BIT(1)
+#define PHY_SMPLDL_CNFG_INPSEL_MASK	GENMASK(3, 2) /* bits [3:2] */
+#define PHY_SMPLDL_CNFG_INPSEL		0x3 /* delay line input source */
 
 /* PHY drift_cclk_rx delay line configuration setting */
 #define PHY_ATDL_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x21)
@@ -227,6 +240,14 @@
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
@@ -268,6 +289,12 @@ struct eic7700_priv {
 	unsigned int drive_impedance;
 };
 
+struct k230_priv  {
+	/* Kendryte k230 specific */
+	bool have_phy;
+	struct regmap *hi_sys_regmap;
+};
+
 #define DWCMSHC_MAX_OTHER_CLKS 3
 
 struct dwcmshc_priv {
@@ -1650,6 +1677,201 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 	return 0;
 }
 
+static void dwcmshc_k230_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+
+	sdhci_set_clock(host, clock);
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
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
+	sdhci_writeb(host, PHY_SDCLKDL_DC_INITIAL,
+		     PHY_SDCLKDL_DC_R);
+
+	val = PHY_SMPLDL_CNFG_EXTDLY_EN;
+	val |= FIELD_PREP(PHY_SMPLDL_CNFG_INPSEL_MASK,
+			  PHY_SMPLDL_CNFG_INPSEL);
+	sdhci_writeb(host, val, PHY_SMPLDL_CNFG_R);
+
+	sdhci_writeb(host, FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK,
+		     PHY_ATDL_CNFG_INPSEL), PHY_ATDL_CNFG_R);
+
+	val = sdhci_readl(host, dwc_priv->vendor_specific_area1 +
+		     DWCMSHC_EMMC_ATCTRL);
+	val |= AT_CTRL_TUNE_CLK_STOP_EN;
+	val |= FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK,
+			  AT_CTRL_PRE_CHANGE_DLY);
+	val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK,
+			  AT_CTRL_POST_CHANGE_DLY);
+	sdhci_writel(host, val, dwc_priv->vendor_specific_area1 +
+		     DWCMSHC_EMMC_ATCTRL);
+	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 +
+		     DWCMSHC_AT_STAT);
+}
+
+static int dwcmshc_k230_phy_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 rxsel = PHY_PAD_RXSEL_3V3;
+	unsigned int timeout = 15000;
+	u32 val;
+	u32 reg;
+
+	/* reset phy */
+	sdhci_writew(host, 0, PHY_CNFG_R);
+
+	/* Disable the clock */
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	if (priv->flags & FLAG_IO_FIXED_1V8)
+		rxsel = PHY_PAD_RXSEL_1V8;
+
+	val = rxsel;
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230_VAL2);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230_VAL2);
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
+
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	val = rxsel;
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230_VAL2);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230_VAL2);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	val = rxsel;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230_VAL2);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230_VAL2);
+	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+
+	sdhci_k230_config_phy_delay(host);
+
+	/* Wait max 150 ms */
+	while (1) {
+		reg = sdhci_readl(host, PHY_CNFG_R);
+		if (reg & FIELD_PREP(PHY_CNFG_PHY_PWRGOOD_MASK, 1))
+			break;
+		if (!timeout)
+			return -ETIMEDOUT;
+		timeout--;
+		usleep_range(10, 15);
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
+	struct k230_priv *k230_priv = dwc_priv->priv;
+	u8 emmc_ctrl;
+
+	dwcmshc_reset(host, mask);
+
+	if (mask == SDHCI_RESET_ALL) {
+		emmc_ctrl = sdhci_readw(host,
+				       dwc_priv->vendor_specific_area1 +
+				       DWCMSHC_EMMC_CONTROL);
+		sdhci_writeb(host, emmc_ctrl,
+			     dwc_priv->vendor_specific_area1 +
+			     DWCMSHC_EMMC_CONTROL);
+
+		if (k230_priv->have_phy)
+			dwcmshc_k230_phy_init(host);
+		else
+			sdhci_writel(host, 0x0,
+				     dwc_priv->vendor_specific_area1 +
+				     DWCMSHC_HOST_CTRL3);
+	}
+}
+
+static int dwcmshc_k230_init(struct device *dev, struct sdhci_host *host,
+			     struct dwcmshc_priv *dwc_priv)
+{
+	static const char * const clk_ids[] = {"base", "timer", "ahb"};
+	struct device_node *usb_phy_node;
+	struct k230_priv *k230_priv;
+	u32 data;
+	int ret;
+
+	k230_priv = devm_kzalloc(dev, sizeof(struct k230_priv), GFP_KERNEL);
+	if (!k230_priv)
+		return -ENOMEM;
+	dwc_priv->priv = k230_priv;
+
+	usb_phy_node = of_find_compatible_node(NULL, NULL, "canaan,k230-usb-phy");
+	if (!usb_phy_node) {
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to find k230-usb-phy node\n");
+	}
+
+	k230_priv->hi_sys_regmap = device_node_to_regmap(usb_phy_node);
+	of_node_put(usb_phy_node);
+	if (IS_ERR(k230_priv->hi_sys_regmap)) {
+		return dev_err_probe(dev, PTR_ERR(k230_priv->hi_sys_regmap),
+				     "Failed to get k230-usb-phy regmap\n");
+	}
+
+	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
+					    ARRAY_SIZE(clk_ids), clk_ids);
+	if (ret) {
+		return dev_err_probe(dev, ret,
+				     "Failed to get/enable k230 mmc other clocks\n");
+	}
+
+	if (of_device_is_compatible(dev->of_node, "canaan,k230-sdio")) {
+		k230_priv->have_phy = false;
+		host->mmc->caps |= MMC_CAP_SD_HIGHSPEED;
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+		ret = regmap_read(k230_priv->hi_sys_regmap, SD1_CTRL, &data);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to read SD1_CTRL\n");
+
+		data |= SD1_CARD_WRITE_PROT | SD1_HOST_REG_VOL_STABLE;
+		ret = regmap_write(k230_priv->hi_sys_regmap, SD1_CTRL, data);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to write SD1_CTRL\n");
+	} else {
+		k230_priv->have_phy = true;
+		host->flags &= ~SDHCI_SIGNALING_330;
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+		ret = regmap_read(k230_priv->hi_sys_regmap, SD0_CTRL, &data);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to read SD0_CTRL\n");
+
+		data |= SD0_CARD_WRITE_PROT | SD0_HOST_REG_VOL_STABLE;
+		ret = regmap_write(k230_priv->hi_sys_regmap, SD0_CTRL, data);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to write SD0_CTRL\n");
+	}
+	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -1736,6 +1958,15 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
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
@@ -1827,6 +2058,14 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
 	.init = eic7700_init,
 };
 
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_k230_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_k230_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	},
+	.init = dwcmshc_k230_init,
+};
+
 static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
 	.enable		= dwcmshc_sdhci_cqe_enable,
 	.disable	= sdhci_cqe_disable,
@@ -1899,6 +2138,14 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 }
 
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{
+		.compatible = "canaan,k230-emmc",
+		.data = &sdhci_dwcmshc_k230_pdata,
+	},
+	{
+		.compatible = "canaan,k230-sdio",
+		.data = &sdhci_dwcmshc_k230_pdata,
+	},
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,
-- 
2.52.0


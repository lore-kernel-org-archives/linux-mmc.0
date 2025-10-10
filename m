Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE92D0627;
	Fri, 10 Oct 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089298; cv=none; b=j+tFQyZPlZ+Za49JCyowGfm2dH++ouGeLMNP/uJpo/gMTqvNmJvD91fnxhy2gxatoYGMdO+YS7HpsoHAgwG4J2VGoD5B7HM8jcKiG6f37y8Gm7FbfoRh7vqOOH7cvcVWurFooVHgKGNkDlx8Z+8ZpvfVk+TiplfH3vmPiqRhHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089298; c=relaxed/simple;
	bh=jRebk4897YCwN2eMEJbbx6yXcj0knn5uRX0dU2fRT9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl6R64P4gTQz5RSHWXGNPdQC2lGar53S1+e/isgg55kWICqKdzkzMnkhe8/hW+U1v3cQNbvHHq62TbuvIHD8VWJSPoNsbfGVYPUlAyGs3sUR4C6V9MnU87lbeEV0Ike87F09uT/7ps3mfbuC81wWciLc1PvKlhz3cF0+/z+4srU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app2 (Coremail) with SMTP id TQJkCgAXqZK31OhoEzUDAQ--.40848S2;
	Fri, 10 Oct 2025 17:41:13 +0800 (CST)
From: hehuan1@eswincomputing.com
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jszhang@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com,
	dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com,
	weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com,
	caohang@eswincomputing.com,
	hehuan1@eswincomputing.com
Subject: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700
Date: Fri, 10 Oct 2025 17:41:09 +0800
Message-ID: <20251010094109.1613-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20251010093807.1579-1-hehuan1@eswincomputing.com>
References: <20251010093807.1579-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAXqZK31OhoEzUDAQ--.40848S2
X-Coremail-Antispam: 1UD129KBjvAXoWfCFykZr4Uuw4DCryUAry5Arb_yoW8Zw18Zo
	WfWF13Jw4fJw4xWFWjkFn7tF1UurZ7C3ySkw4a9w4ku3Wku3WUJrWSkF43J34SqryFyr1k
	Jrs7Jry3XrWfAF1kn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRihF4tUUUUU==
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

Add support for the mmc controller in the Eswin EIC7700 with the new
compatible "eswin,eic7700-dwcmshc". Implement custom sdhci_ops for
set_clock, reset, set_uhs_signaling, platform_execute_tuning.

Signed-off-by: Huan He <hehuan1@eswincomputing.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 526 ++++++++++++++++++++++++++--
 1 file changed, 504 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eebd45389956..023f0d7c9819 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -11,6 +11,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -19,8 +20,11 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
+#include <linux/mfd/syscon.h>
+#include <linux/units.h>
 
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
@@ -39,6 +43,7 @@
 #define DWCMSHC_CARD_IS_EMMC		BIT(0)
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
 #define DWCMSHC_EMMC_ATCTRL		0x40
+#define DWCMSHC_AT_STAT			0x44
 /* Tuning and auto-tuning fields in AT_CTRL_R control register */
 #define AT_CTRL_AT_EN			BIT(0) /* autotuning is enabled */
 #define AT_CTRL_CI_SEL			BIT(1) /* interval to drive center phase select */
@@ -194,6 +199,19 @@
 #define PHY_DLLDL_CNFG_SLV_INPSEL_MASK	GENMASK(6, 5) /* bits [6:5] */
 #define PHY_DLLDL_CNFG_SLV_INPSEL	0x3 /* clock source select for slave DL */
 
+/* PHY DLL offset setting register */
+#define PHY_DLL_OFFST_R			(DWC_MSHC_PTR_PHY_R + 0x29)
+/* DLL LBT setting register */
+#define PHY_DLLBT_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x2c)
+/* DLL Status register */
+#define PHY_DLL_STATUS_R		(DWC_MSHC_PTR_PHY_R + 0x2e)
+#define DLL_LOCK_STS			BIT(0)/* DLL is locked and ready */
+/*
+ * Captures the value of DLL's lock error status information. Value is valid
+ * only when LOCK_STS is set.
+ */
+#define DLL_ERROR_STS			BIT(1)
+
 #define FLAG_IO_FIXED_1V8	BIT(0)
 
 #define BOUNDARY_OK(addr, len) \
@@ -206,6 +224,31 @@
 /* SMC call for BlueField-3 eMMC RST_N */
 #define BLUEFIELD_SMC_SET_EMMC_RST_N	0x82000007
 
+/* Eswin specific Registers */
+#define EIC7700_CARD_CLK_STABLE		BIT(28)
+#define EIC7700_INT_BCLK_STABLE		BIT(16)
+#define EIC7700_INT_ACLK_STABLE		BIT(8)
+#define EIC7700_INT_TMCLK_STABLE	BIT(0)
+#define EIC7700_INT_CLK_STABLE		(EIC7700_CARD_CLK_STABLE | \
+					 EIC7700_INT_ACLK_STABLE | \
+					 EIC7700_INT_BCLK_STABLE | \
+					 EIC7700_INT_TMCLK_STABLE)
+#define EIC7700_HOST_VAL_STABLE		BIT(0)
+
+/* strength definition */
+#define PHYCTRL_DR_33OHM		0xee
+#define PHYCTRL_DR_40OHM		0xcc
+#define PHYCTRL_DR_50OHM		0x88
+#define PHYCTRL_DR_66OHM		0x44
+#define PHYCTRL_DR_100OHM		0x00
+
+#define MAX_PHASE_CODE			0xff
+#define TUNING_RANGE_THRESHOLD		40
+#define PHY_CLK_MAX_DELAY_MASK		0x7f
+#define PHY_DELAY_CODE_MAX		0x7f
+#define PHY_DELAY_CODE_EMMC		0x17
+#define PHY_DELAY_CODE_SD		0x55
+
 enum dwcmshc_rk_type {
 	DWCMSHC_RK3568,
 	DWCMSHC_RK3588,
@@ -217,6 +260,11 @@ struct rk35xx_priv {
 	u8 txclk_tapnum;
 };
 
+struct eic7700_priv {
+	struct reset_control *reset;
+	unsigned int drive_impedance;
+};
+
 #define DWCMSHC_MAX_OTHER_CLKS 3
 
 struct dwcmshc_priv {
@@ -238,6 +286,28 @@ struct dwcmshc_pltfm_data {
 	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
 };
 
+static void dwcmshc_enable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
+		ctrl |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+	}
+}
+
+static void dwcmshc_enable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
+		ctrl |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+	}
+}
+
 static int dwcmshc_get_enable_other_clks(struct device *dev,
 					 struct dwcmshc_priv *priv,
 					 int num_clks,
@@ -1095,6 +1165,413 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
 					     ARRAY_SIZE(clk_ids), clk_ids);
 }
 
+static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	u16 clk;
+
+	host->mmc->actual_clock = clock;
+
+	if (clock == 0) {
+		sdhci_set_clock(host, clock);
+		return;
+	}
+	dwcmshc_disable_card_clk(host);
+
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_set_rate(pltfm_host->clk, clock);
+	clk_prepare_enable(pltfm_host->clk);
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	dwcmshc_enable_card_clk(host);
+}
+
+static void sdhci_eic7700_config_phy_delay(struct sdhci_host *host, int delay)
+{
+	delay &= PHY_CLK_MAX_DELAY_MASK;
+
+	/* phy clk delay line config */
+	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
+	sdhci_writeb(host, delay, PHY_SDCLKDL_DC_R);
+	sdhci_writeb(host, 0x0, PHY_SDCLKDL_CNFG_R);
+}
+
+static void sdhci_eic7700_config_phy(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
+	struct eic7700_priv *priv = dwc_priv->priv;
+	unsigned int val, drv;
+
+	drv = FIELD_PREP(PHY_CNFG_PAD_SP_MASK, priv->drive_impedance & 0xF);
+	drv |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, (priv->drive_impedance >> 4) & 0xF);
+
+	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
+		val = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+		val |= DWCMSHC_CARD_IS_EMMC;
+		sdhci_writew(host, val, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+	}
+
+	/* reset phy, config phy's pad */
+	sdhci_writel(host, drv | (~PHY_CNFG_RSTN_DEASSERT), PHY_CNFG_R);
+
+	/* configure phy pads */
+	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
+	val |= PHY_PAD_RXSEL_1V8;
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	/* Clock PAD Setting */
+	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	/* PHY strobe PAD setting (EMMC only) */
+	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
+		val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+		val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+		val |= PHY_PAD_RXSEL_1V8;
+		sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+	}
+	usleep_range(2000, 3000);
+	sdhci_writel(host, drv | PHY_CNFG_RSTN_DEASSERT, PHY_CNFG_R);
+	sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
+}
+
+static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+
+	/* after reset all, the phy's config will be clear */
+	if (mask == SDHCI_RESET_ALL)
+		sdhci_eic7700_config_phy(host);
+}
+
+static int sdhci_eic7700_reset_init(struct device *dev, struct eic7700_priv *priv)
+{
+	int ret;
+
+	priv->reset = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
+		dev_err(dev, "failed to get reset control %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_assert(priv->reset);
+	if (ret) {
+		dev_err(dev, "Failed to assert reset signals: %d\n", ret);
+		return ret;
+	}
+	usleep_range(2000, 2100);
+	ret = reset_control_deassert(priv->reset);
+	if (ret) {
+		dev_err(dev, "Failed to deassert reset signals: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static unsigned int eic7700_convert_drive_impedance_ohm(struct device *dev, unsigned int dr_ohm)
+{
+	switch (dr_ohm) {
+	case 100:
+		return PHYCTRL_DR_100OHM;
+	case 66:
+		return PHYCTRL_DR_66OHM;
+	case 50:
+		return PHYCTRL_DR_50OHM;
+	case 40:
+		return PHYCTRL_DR_40OHM;
+	case 33:
+		return PHYCTRL_DR_33OHM;
+	}
+
+	dev_warn(dev, "Invalid value %u for drive-impedance-ohms.\n", dr_ohm);
+	return PHYCTRL_DR_50OHM;
+}
+
+static int sdhci_eic7700_delay_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	int delay_min = -1;
+	int delay_max = -1;
+	int cmd_error = 0;
+	int delay = 0;
+	int i = 0;
+	int ret;
+
+	for (i = 0; i <= PHY_DELAY_CODE_MAX; i++) {
+		sdhci_eic7700_config_phy_delay(host, i);
+		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
+		if (ret) {
+			host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+			usleep_range(200, 210);
+			if (delay_min != -1 && delay_max != -1)
+				break;
+		} else {
+			if (delay_min == -1) {
+				delay_min = i;
+				continue;
+			} else {
+				delay_max = i;
+				continue;
+			}
+		}
+	}
+	if (delay_min == -1 && delay_max == -1) {
+		pr_err("%s: delay code tuning failed!\n", mmc_hostname(host->mmc));
+		sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
+		return ret;
+	}
+
+	delay = (delay_min + delay_max) / 2;
+	sdhci_eic7700_config_phy_delay(host, delay);
+
+	return 0;
+}
+
+static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
+	int phase_code = -1;
+	int code_range = -1;
+	bool is_sd = false;
+	int code_min = -1;
+	int code_max = -1;
+	int cmd_error = 0;
+	int ret = 0;
+	int i = 0;
+
+	if ((host->mmc->caps2 & sd_caps) == sd_caps)
+		is_sd = true;
+
+	for (i = 0; i <= MAX_PHASE_CODE; i++) {
+		/* Centered Phase code */
+		sdhci_writew(host, i, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
+		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
+		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+		if (ret) {
+			/* SDIO specific range tracking */
+			if (is_sd && code_min != -1 && code_max != -1) {
+				if (code_max - code_min > code_range) {
+					code_range = code_max - code_min;
+					phase_code = (code_min + code_max) / 2;
+					if (code_range > TUNING_RANGE_THRESHOLD)
+						break;
+				}
+				code_min = -1;
+				code_max = -1;
+			}
+			/* EMMC breaks after first valid range */
+			if (!is_sd && code_min != -1 && code_max != -1)
+				break;
+		} else {
+			/* Track valid phase code range */
+			if (code_min == -1) {
+				code_min = i;
+				if (!is_sd)
+					continue;
+			}
+			code_max = i;
+			if (is_sd && i == MAX_PHASE_CODE) {
+				if (code_max - code_min > code_range) {
+					code_range = code_max - code_min;
+					phase_code = (code_min + code_max) / 2;
+				}
+			}
+		}
+	}
+
+	/* Handle tuning failure case */
+	if ((is_sd && phase_code == -1) ||
+	    (!is_sd && code_min == -1 && code_max == -1)) {
+		pr_err("%s: phase code tuning failed!\n", mmc_hostname(host->mmc));
+		sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
+		return -EIO;
+	}
+	if (!is_sd)
+		phase_code = (code_min + code_max) / 2;
+
+	sdhci_writew(host, phase_code, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
+
+	/* SDIO specific final verification */
+	if (is_sd) {
+		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
+		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		if (ret) {
+			pr_err("%s: Final phase code 0x%x verification failed!\n",
+			       mmc_hostname(host->mmc), phase_code);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int sdhci_eic7700_executing_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
+	int ret = 0;
+	u16 ctrl;
+	u32 val;
+
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+	val = sdhci_readl(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+	val |= AT_CTRL_SW_TUNE_EN;
+	sdhci_writew(host, val, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+
+	sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
+	sdhci_writew(host, 0x0, SDHCI_CMD_DATA);
+
+	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
+		ret = sdhci_eic7700_delay_tuning(host, opcode);
+		if (ret)
+			return ret;
+	}
+
+	ret = sdhci_eic7700_phase_code_tuning(host, opcode);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u8 status;
+	u32 val;
+	int ret;
+
+	dwcmshc_set_uhs_signaling(host, timing);
+
+	/* here need make dll locked when in hs400 at 200MHz */
+	if (timing == MMC_TIMING_MMC_HS400 && host->clock == 200000000) {
+		val = sdhci_readl(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+		val &= ~(FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY));
+		/* 2-cycle latency */
+		val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, 0x2);
+		sdhci_writew(host, val, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+
+		sdhci_writeb(host, FIELD_PREP(PHY_DLL_CNFG1_SLVDLY_MASK, PHY_DLL_CNFG1_SLVDLY) |
+			     0x3, PHY_DLL_CNFG1_R);/* DLL wait cycle input */
+		/* DLL jump step input */
+		sdhci_writeb(host, 0x02, PHY_DLL_CNFG2_R);
+		sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK,
+					      PHY_DLLDL_CNFG_SLV_INPSEL), PHY_DLLDL_CNFG_R);
+		/* Sets the value of DLL's offset input */
+		sdhci_writeb(host, 0x00, PHY_DLL_OFFST_R);
+		/* Sets the value of DLL's olbt loadval input. Controls the Ibt
+		 * timer's timeout value at which DLL runs a revalidation cycle.
+		 */
+		sdhci_writew(host, 0xffff, PHY_DLLBT_CNFG_R);
+		sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
+		usleep_range(100, 110);
+
+		ret = read_poll_timeout(sdhci_readb, status, status & DLL_LOCK_STS, 100, 1000000,
+					false, host, PHY_DLL_STATUS_R);
+		if (ret) {
+			pr_err("%s: DLL lock timeout! status: 0x%x\n",
+			       mmc_hostname(host->mmc), status);
+			return;
+		}
+
+		status = sdhci_readb(host, PHY_DLL_STATUS_R);
+		if (status & DLL_ERROR_STS) {
+			pr_err("%s: DLL lock failed!err_status:0x%x\n",
+			       mmc_hostname(host->mmc), status);
+		}
+	}
+}
+
+static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsigned int timing)
+{
+	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
+
+	if ((host->mmc->caps2 & sd_caps) == sd_caps)
+		sdhci_set_uhs_signaling(host, timing);
+	else
+		sdhci_eic7700_set_uhs_signaling(host, timing);
+}
+
+static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
+	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
+	struct of_phandle_args args;
+	struct eic7700_priv *priv;
+	struct regmap *hsp_regmap;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(struct eic7700_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dwc_priv->priv = priv;
+
+	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
+	if (ret) {
+		dev_err(dev, "failed to reset\n");
+		return ret;
+	}
+
+	ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
+	if (ret) {
+		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);
+		return ret;
+	}
+
+	hsp_regmap = syscon_node_to_regmap(args.np);
+	if (IS_ERR(hsp_regmap)) {
+		dev_err(dev, "Failed to get regmap for 'eswin,hsp-sp-csr'\n");
+		of_node_put(args.np);
+		return ret;
+	}
+	hsp_int_status = args.args[0];
+	hsp_pwr_ctrl = args.args[1];
+	of_node_put(args.np);
+	/*
+	 * Assert clock stability: write EIC7700_INT_CLK_STABLE to hsp_int_status.
+	 * This signals to the eMMC controller that platform clocks (card, ACLK,
+	 * BCLK, TMCLK) are enabled and stable.
+	 */
+	regmap_write(hsp_regmap, hsp_int_status, EIC7700_INT_CLK_STABLE);
+	/*
+	 * Assert voltage stability: write EIC7700_HOST_VAL_STABLE to hsp_pwr_ctrl.
+	 * This signals that VDD is stable and permits transition to high-speed
+	 * modes (e.g., UHS-I).
+	 */
+	regmap_write(hsp_regmap, hsp_pwr_ctrl, EIC7700_HOST_VAL_STABLE);
+
+	if ((host->mmc->caps2 & emmc_caps) == emmc_caps)
+		dwc_priv->delay_line = PHY_DELAY_CODE_EMMC;
+	else
+		dwc_priv->delay_line = PHY_DELAY_CODE_SD;
+
+	if (!of_property_read_u32(dev->of_node, "eswin,drive-impedance-ohms", &val))
+		priv->drive_impedance = eic7700_convert_drive_impedance_ohm(dev, val);
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -1169,6 +1646,18 @@ static const struct sdhci_ops sdhci_dwcmshc_sg2042_ops = {
 	.platform_execute_tuning = th1520_execute_tuning,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
+	.set_clock = sdhci_eic7700_set_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_eic7700_reset,
+	.set_uhs_signaling = sdhci_eic7700_set_uhs_wrapper,
+	.set_power = sdhci_set_power_and_bus_voltage,
+	.irq = dwcmshc_cqe_irq_handler,
+	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
+};
+
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
 	.pdata = {
 		.ops = &sdhci_dwcmshc_ops,
@@ -1238,6 +1727,17 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_sg2042_pdata = {
 	.init = sg2042_init,
 };
 
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_eic7700_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	},
+	.init = eic7700_init,
+};
+
 static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
 	.enable		= dwcmshc_sdhci_cqe_enable,
 	.disable	= sdhci_cqe_disable,
@@ -1338,6 +1838,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "sophgo,sg2042-dwcmshc",
 		.data = &sdhci_dwcmshc_sg2042_pdata,
 	},
+	{
+		.compatible = "eswin,eic7700-dwcmshc",
+		.data = &sdhci_dwcmshc_eic7700_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
@@ -1469,17 +1973,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static void dwcmshc_disable_card_clk(struct sdhci_host *host)
-{
-	u16 ctrl;
-
-	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (ctrl & SDHCI_CLOCK_CARD_EN) {
-		ctrl &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
-	}
-}
-
 static void dwcmshc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -1570,17 +2063,6 @@ static int dwcmshc_resume(struct device *dev)
 	return ret;
 }
 
-static void dwcmshc_enable_card_clk(struct sdhci_host *host)
-{
-	u16 ctrl;
-
-	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
-		ctrl |= SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
-	}
-}
-
 static int dwcmshc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-- 
2.25.1


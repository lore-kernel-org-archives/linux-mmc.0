Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CAC176FB6;
	Wed, 26 Jun 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395381; cv=none; b=AeLTnla/ubFavqEYIRF1IVe5btkWycHQsx1etP3r999OvS61P7dgjv4qn2f3wvvejw/omVf1jXSznUA0sYuMoOaNl16m7f/errALI+AbSwd+2vw1AlAEo45itHDCTa1d1tXrz+uJ9mNr0t9VAnYVqQiYQZuuwyUhio0CGHIephc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395381; c=relaxed/simple;
	bh=IOUUbFt04p0fm+KoPwHLHtwRY5b4egjVPzPVSrIfvcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMIlL6jYVzvBCNM+CzsJnZowy/UjzIAFalXUNBF2watHGLsaMkQpdyPcxLQfajAsXeVO2ipWvzAYvOLHVHwCmQq3Vbb39LCDl6C+bf2tP0GQMkfTf5Z+CSPa5U67ktXr81SHZ5HFbDfWG0wsUidURmCR++yoeJLt4TzZSnRG5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcPfaLW8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcPfaLW8"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70679845d69so2509042b3a.1;
        Wed, 26 Jun 2024 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719395379; x=1720000179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QKGlRE6HEz2d2uJeXQz+MuFsll73BEXvmMYpS7vlCY=;
        b=NcPfaLW8bTBrEklAeSgn0J/5UNrYSt57eVHWWJZc7qOP+fqL2zs0RGhe4tHw1MgJRa
         ZjBtP9E2+YscnOqqpvwnWOmWLK81nGIRe12r1qUT5bl4X8bO13IY4DoQMDnMY6+dVmTy
         UfU42w2ZmWJXKo8JSdRaB//MfD5zmvhpFvgnCMmTZJ2esQ34WJzFX0vp42HvgK6zmysH
         Px/9A+l/KzwQksNpMxIa9473WImNiaYpktUGOurHFOHXqcevKplhT9BE28xprjcr9kaS
         2q+54AI8Jewj3Ak5tcrdbeihkPAtFRWw1Rgv0Amd/uJZcPUj79O9jcsYGbAoFfcJEZRA
         PipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395379; x=1720000179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QKGlRE6HEz2d2uJeXQz+MuFsll73BEXvmMYpS7vlCY=;
        b=PUrhAvEkS5fn2RkQMZ5kmJTJZUF0cjwK9ePsqPbGYO/4oR1a4N7ZKekzjW6TtFOlDu
         /O6lTxnHcvZlVjonDsi/fNvekTsAeywYgtqeiSrsNewfHoe/1OE7DysrGermPFJWhamt
         jpfkhKMdiuinHyJiepnDS8wnk0W8d3ko9lXL7ce7DhxMrk15awiJp3mDx4NTS8CcuKUE
         rsowrQEbFv5RR9fXip08X0kSkJQMDz4zmKv62uZe6ooKyao+WG3LciHt+64xx/bnMHsM
         ci2ZBn+nseOa+eclVGyDWEMKlAWbMZ2sFGcdctqUtEPjC9Nn6N9MUvstneDnuifIgKCw
         P3vA==
X-Forwarded-Encrypted: i=1; AJvYcCU5jLnmN0SALIiNAHfwf0rMzvI8cYO6pvgQ6ZYbXP6piclfKM2n7OHCKDoH/ilTIOYkGGv8KDeD96duXNk8qZp/ynshR/gAu//XWkQloRNGA2ZnqrAW8+g7fQ2vA2yp26RfDxKxilqYtwMowf0nX0e9ehCNNfJJxwFVtLREhf4pNGDC7Q==
X-Gm-Message-State: AOJu0YzBnsxqi4P2PfDRAMvm7an63M2IqF/Cdr+eP60047gw5PReHgw6
	tQ0VnApOJu0FD4ToAKD1XaPfOjTpAfzSHsChhlnggpS8dOFTyOHS
X-Google-Smtp-Source: AGHT+IFtlArLppb9vSADfw6PIa7JO7Zgc7hG/5di+hrfk4Cqy9QxBunZPD4GBMT+8RS2C8WaeBJqxw==
X-Received: by 2002:a05:6a20:bf28:b0:1bd:91b0:10a5 with SMTP id adf61e73a8af0-1bd91b0126cmr1256004637.47.1719395379094;
        Wed, 26 Jun 2024 02:49:39 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa6aa7030bsm29726665ad.288.2024.06.26.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:49:38 -0700 (PDT)
From: Shan-Chun Hung <shanchun1218@gmail.com>
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	pbrobinson@gmail.com,
	serghox@gmail.com,
	mcgrof@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	forbidden405@outlook.com,
	tmaimon77@gmail.com,
	andy.shevchenko@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Shan-Chun Hung <shanchun1218@gmail.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
Date: Wed, 26 Jun 2024 17:49:00 +0800
Message-Id: <20240626094900.581552-3-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626094900.581552-1-shanchun1218@gmail.com>
References: <20240626094900.581552-1-shanchun1218@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SDHCI driver for the MA35D1 platform. It is based upon the
SDHCI interface, but requires some extra initialization.

Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
---
 drivers/mmc/host/Kconfig           |  14 ++
 drivers/mmc/host/Makefile          |   1 +
 drivers/mmc/host/sdhci-of-ma35d1.c | 291 +++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index bb0d4fb0892a..31cd076e1c53 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -252,6 +252,20 @@ config MMC_SDHCI_OF_SPARX5

	  If unsure, say N.

+config MMC_SDHCI_OF_MA35D1
+	tristate "SDHCI OF support for the MA35D1 SDHCI controller"
+	depends on ARCH_MA35
+	depends on MMC_SDHCI_PLTFM
+	depends on COMMON_CLK
+	depends on OF || COMPILE_TEST
+	help
+	  This selects the MA35D1 Secure Digital Host Controller Interface.
+
+	  If you have a controller with this interface, say Y or M here. You
+	  also need to enable an appropriate bus interface.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_CADENCE
	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index f53f86d200ac..3ccffebbe59b 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
 obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
 obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
+obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_NPCM)		+= sdhci-npcm.o
diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-of-ma35d1.c
new file mode 100644
index 000000000000..e260aeb12d7f
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-ma35d1.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Nuvoton Technology Corp.
+ *
+ * Author: Shan-Chun Hung <shanchun1218@gmail.com>
+ */
+
+#include <linux/align.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/math.h>
+#include <linux/mfd/syscon.h>
+#include <linux/minmax.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#include "sdhci-pltfm.h"
+#include "sdhci.h"
+
+#define MA35_SYS_MISCFCR0	0x070
+#define MA35_SDHCI_MSHCCTL	0x508
+#define MA35_SDHCI_MBIUCTL	0x510
+
+#define MA35_SDHCI_CMD_CONFLICT_CHK	BIT(0)
+#define MA35_SDHCI_INCR_MSK		GENMASK(3, 0)
+#define MA35_SDHCI_INCR16		BIT(3)
+#define MA35_SDHCI_INCR8		BIT(2)
+
+struct ma35_priv {
+	struct regmap		*regmap;
+	struct reset_control	*rst;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pins_uhs;
+	struct pinctrl_state	*pins_default;
+};
+
+struct ma35_restore_data {
+	u32	reg;
+	u32	width;
+};
+
+static const struct ma35_restore_data restore_data[] = {
+	{ SDHCI_CLOCK_CONTROL,		sizeof(u32)},
+	{ SDHCI_BLOCK_SIZE,		sizeof(u32)},
+	{ SDHCI_INT_ENABLE,		sizeof(u32)},
+	{ SDHCI_SIGNAL_ENABLE,		sizeof(u32)},
+	{ SDHCI_AUTO_CMD_STATUS,	sizeof(u32)},
+	{ SDHCI_HOST_CONTROL,		sizeof(u32)},
+	{ SDHCI_TIMEOUT_CONTROL,	sizeof(u8) },
+	{ MA35_SDHCI_MSHCCTL,		sizeof(u16)},
+	{ MA35_SDHCI_MBIUCTL,		sizeof(u16)},
+};
+
+/*
+ * If DMA addr spans 128MB boundary, we split the DMA transfer into two
+ * so that each DMA transfer doesn't exceed the boundary.
+ */
+static void ma35_adma_write_desc(struct sdhci_host *host, void **desc,
+				  dma_addr_t addr, int len, unsigned int cmd)
+{
+	int tmplen, offset;
+
+	if (likely(!len || (ALIGN(addr, SZ_128M) == ALIGN(addr+len-1, SZ_128M)))) {
+		sdhci_adma_write_desc(host, desc, addr, len, cmd);
+		return;
+	}
+
+	offset = addr & (SZ_128M - 1);
+	tmplen = SZ_128M - offset;
+	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
+
+	addr += tmplen;
+	len -= tmplen;
+	sdhci_adma_write_desc(host, desc, addr, len, cmd);
+}
+
+static void ma35_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u32 ctl;
+
+	/* If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
+	 * disable command conflict check.
+	 */
+	ctl = sdhci_readw(host, MA35_SDHCI_MSHCCTL);
+	if (clock > MMC_HIGH_52_MAX_DTR)
+		ctl &= ~MA35_SDHCI_CMD_CONFLICT_CHK;
+	else
+		ctl |= MA35_SDHCI_CMD_CONFLICT_CHK;
+	sdhci_writew(host, ctl, MA35_SDHCI_MSHCCTL);
+
+	sdhci_set_clock(host, clock);
+}
+
+static int ma35_start_signal_voltage_switch(struct mmc_host *mmc,
+					      struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct ma35_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		if (!IS_ERR(priv->pinctrl) && !IS_ERR(priv->pins_uhs))
+			pinctrl_select_state(priv->pinctrl, priv->pins_uhs);
+		break;
+	case MMC_SIGNAL_VOLTAGE_330:
+		if (!IS_ERR(priv->pinctrl) && !IS_ERR(priv->pins_default))
+			pinctrl_select_state(priv->pinctrl, priv->pins_default);
+		break;
+	default:
+		dev_err(mmc_dev(host->mmc), "Unsupported signal voltage!\n");
+		return -EINVAL;
+	}
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
+static void ma35_voltage_switch(struct sdhci_host *host)
+{
+	/* Wait for 5ms after set 1.8V signal enable bit */
+	fsleep(5000);
+}
+
+static int ma35_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct ma35_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int idx;
+	u32 regs[ARRAY_SIZE(restore_data)] = { };
+
+	/* Limitations require a reset of SD/eMMC before tuning and
+	 * saving the registers before resetting, then restoring
+	 * after the reset.
+	 */
+	for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
+		if (restore_data[idx].width == sizeof(u32))
+			regs[idx] = sdhci_readl(host, restore_data[idx].reg);
+		else if (restore_data[idx].width == sizeof(u16))
+			regs[idx] = sdhci_readw(host, restore_data[idx].reg);
+		else if (restore_data[idx].width == sizeof(u8))
+			regs[idx] = sdhci_readb(host, restore_data[idx].reg);
+	}
+
+	reset_control_assert(priv->rst);
+	reset_control_deassert(priv->rst);
+
+	for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
+		if (restore_data[idx].width == sizeof(u32))
+			sdhci_writel(host, regs[idx], restore_data[idx].reg);
+		else if (restore_data[idx].width == sizeof(u16))
+			sdhci_writew(host, regs[idx], restore_data[idx].reg);
+		else if (restore_data[idx].width == sizeof(u8))
+			sdhci_writeb(host, regs[idx], restore_data[idx].reg);
+	}
+
+	return sdhci_execute_tuning(mmc, opcode);
+}
+
+static const struct sdhci_ops sdhci_ma35_ops = {
+	.set_clock		= ma35_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.reset			= sdhci_reset,
+	.adma_write_desc	= ma35_adma_write_desc,
+	.voltage_switch	= ma35_voltage_switch,
+};
+
+static const struct sdhci_pltfm_data sdhci_ma35_pdata = {
+	.ops = &sdhci_ma35_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_BROKEN_DDR50 |
+		   SDHCI_QUIRK2_ACMD23_BROKEN,
+};
+
+static void ma35_sdhci_pltfm_free(void *data)
+{
+	sdhci_pltfm_free(data);
+}
+
+static int ma35_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct ma35_priv *priv;
+	int err;
+	u32 extra, ctl;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata, sizeof(struct ma35_priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	err = devm_add_action_or_reset(dev, ma35_sdhci_pltfm_free, pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register sdhci_pltfm_free action\n");
+
+	/* Extra adma table cnt for cross 128M boundary handling. */
+	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
+	extra = min(extra, SDHCI_MAX_SEGS);
+
+	host->adma_table_cnt += extra;
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(pltfm_host->clk))
+		return dev_err_probe(dev, IS_ERR(pltfm_host->clk), "failed to get clk\n");
+
+	err = mmc_of_parse(host->mmc);
+	if (err)
+		return err;
+
+	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(priv->rst))
+		return dev_err_probe(dev, PTR_ERR(priv->rst), "failed to get reset control\n");
+
+	sdhci_get_of_property(pdev);
+
+	priv->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR(priv->pinctrl)) {
+		priv->pins_default = pinctrl_lookup_state(priv->pinctrl, "default");
+		priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl, "state_uhs");
+		pinctrl_select_state(priv->pinctrl, priv->pins_default);
+	}
+
+	if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)) {
+		u32 reg;
+
+		priv->regmap = syscon_regmap_lookup_by_phandle(dev_of_node(dev), "nuvoton,sys");
+
+		if (!IS_ERR(priv->regmap)) {
+			/* Enable SDHCI voltage stable for 1.8V */
+			regmap_read(priv->regmap, MA35_SYS_MISCFCR0, &reg);
+			reg |= BIT(17);
+			regmap_write(priv->regmap, MA35_SYS_MISCFCR0, reg);
+		}
+
+		host->mmc_host_ops.start_signal_voltage_switch =
+					ma35_start_signal_voltage_switch;
+	}
+
+	host->mmc_host_ops.execute_tuning = ma35_execute_tuning;
+
+	err = sdhci_add_host(host);
+	if (err)
+		return err;
+
+	/* Enable INCR16 and INCR8 */
+	ctl = sdhci_readw(host, MA35_SDHCI_MBIUCTL);
+	ctl &= ~MA35_SDHCI_INCR_MSK;
+	ctl |= MA35_SDHCI_INCR16|MA35_SDHCI_INCR8;
+	sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
+
+	return 0;
+}
+
+static const struct of_device_id sdhci_ma35_dt_ids[] = {
+	{ .compatible = "nuvoton,ma35d1-sdhci" },
+	{}
+};
+
+static struct platform_driver sdhci_ma35_driver = {
+	.driver	= {
+		.name	= "sdhci-ma35",
+		.of_match_table = sdhci_ma35_dt_ids,
+	},
+	.probe	= ma35_probe,
+	.remove_new = sdhci_pltfm_remove,
+};
+module_platform_driver(sdhci_ma35_driver);
+
+MODULE_DESCRIPTION("SDHCI platform driver for Nuvoton MA35");
+MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@google.com>");
+MODULE_LICENSE("GPL v2");
--
2.25.1

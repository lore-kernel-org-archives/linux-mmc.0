Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A051A0AFA;
	Thu,  4 Jul 2024 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075063; cv=none; b=l209xLBRAXNBvrwRscrzb3cf+OkI9Q57uL13AM0FKVd5uGvu1hbvthReAMsndYbzb5wWm3dPrGyn2Fl0K+GAQJhitTNCorQi2EWrHLJufXB5Yn91v/2lpPhsNHFzN7jtqyTStYE0NG9jAPVjt0+eJ4iXa/v/sqphiMWWxNwOUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075063; c=relaxed/simple;
	bh=Ybu0TwcLr4qNpI9+PJUAa0JNkcZuaL5CKE1O3F6vHT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvhvEPmi2PjKFBlsRMPEO3TxwC0/WiqaBdDZlNO2l8PvW3eo34ejaYn0/mI2UvYhOauOXdkmR6nHnq3KFCGxKtPSA/D4QbxvKV8+TtL6JCKqHNl3BonqHpFHOgzuFB/jRCHQji9YSVDg56Qz4ClPLg6eL2CJTM93/e/F8tnW3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP729HgH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP729HgH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c99afcd453so221481a91.2;
        Wed, 03 Jul 2024 23:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720075061; x=1720679861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiieqOnzWkklX+pSzG+eAQYwbRigLIbFKYqfjFEUkpE=;
        b=AP729HgH0q0ZApWFiyu2yxXNnH7kky5wTDBsoWPiCYwvvsPrf72UCZOA5hKzI2wohe
         h395lWN/V4eud14V6Lq+vVPXU1D/5uOMk3ZJNt2Yae+/+QnKHgRBthILqPlCi1mckYK1
         9QP0Nm0p+qA8BSMn4IHLRQlxhLp7tTmHZa+s4bc+Oa6ZCoWf6i/0v4RmQTCQu22mD09Q
         ORkdfO8i503W9mWPAgLy8L9hngJxJMThCgK5fKPBG4vNMT4Ubjcm8j8AzE7KQxfQFADS
         oXEKDQt5oDDfJLx2/d4aOyZG85MST9wbyJWIJ7BlVdg932sX3lLiNU1nqMgxqncffvts
         W9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075061; x=1720679861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiieqOnzWkklX+pSzG+eAQYwbRigLIbFKYqfjFEUkpE=;
        b=g75+y52nsEDWTfPAbJiQHjOcTUS6IISRczGnIdYVCeew3IQgCHAAPnvl08JJcKbv8n
         1FJedDZQu2PnqzfTxMbLHqX7vR54QaSMj7p45ibAPLj6ELCUz4e3KU+qwx4UCt3iu8RR
         4AGd5Zo7TuiaLig2G6zK+BZBqJMn2pbv69r2iRCPfTTjTssZuSAKqi6TYCYVHLTVPvcP
         ni3gF7CdCORVKX1qZf+ew/4vLIkq/ImcREwI9lKtQoLG1UhEqMDvBwPyci9+qYqK05sL
         vGugfGqPV+V+vAOorVXnEfuzjjA47NpdqKWhzK3LD0V3/M9hbhRsp0MSXBp5POfmToDv
         TWBw==
X-Forwarded-Encrypted: i=1; AJvYcCUyoGfpmNuEIxMAGnEebxrmAxSFH+F37YPQa0GsU454NKOb4icYRWGzj0nbymYXLCxQhvEzUYh3EeOlNEhXJ0FXIA+Kg3syHnatk7WsOFyNOzFmeBvU6PRk62ExS43N4C7VpuXwIIQZGE+AHzv33y/10rt+qUPYPxfh3ZjeiM+Y+o4s9A==
X-Gm-Message-State: AOJu0YwJnnRLkQ6cDnGEydH0Ewn9VdYqWYnpyHDcxIWQ9osSQ4OAnRB9
	PeYl20umQnGyA8vzgOpIzXgzJrt4DSm9VhjOFA/hNFlDceTZB9VV
X-Google-Smtp-Source: AGHT+IEKs5NrJfVdYdIG6ii6JI6gGkoJmLlGqDRE2WEal7p9NvMh22GRiHtt6jWuHWR5alaJxzB9jg==
X-Received: by 2002:a17:90a:6d02:b0:2c9:8891:e128 with SMTP id 98e67ed59e1d1-2c99c5056b8mr505470a91.4.1720075060433;
        Wed, 03 Jul 2024 23:37:40 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa6fd28sm666835a91.36.2024.07.03.23.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:37:39 -0700 (PDT)
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
Subject: [PATCH v4 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
Date: Thu,  4 Jul 2024 14:26:23 +0800
Message-Id: <20240704062623.1480062-3-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704062623.1480062-1-shanchun1218@gmail.com>
References: <20240704062623.1480062-1-shanchun1218@gmail.com>
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
 drivers/mmc/host/Kconfig           |  12 ++
 drivers/mmc/host/Makefile          |   1 +
 drivers/mmc/host/sdhci-of-ma35d1.c | 297 +++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index bb0d4fb0892a..aa6922ff4210 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -252,6 +252,18 @@ config MMC_SDHCI_OF_SPARX5

 	  If unsure, say N.

+config MMC_SDHCI_OF_MA35D1
+	tristate "SDHCI OF support for the MA35D1 SDHCI controller"
+	depends on ARCH_MA35 || COMPILE_TEST
+	depends on MMC_SDHCI_PLTFM
+	help
+	  This selects the MA35D1 Secure Digital Host Controller Interface.
+	  The controller supports SD/MMC/SDIO devices.
+
+	  If you have a controller with this interface, say Y or M here.
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
index 000000000000..b5aab65b9093
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-ma35d1.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0+
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
+static void ma35_adma_write_desc(struct sdhci_host *host, void **desc, dma_addr_t addr, int len,
+				 unsigned int cmd)
+{
+	int tmplen, offset;
+
+	if (likely(!len || (ALIGN(addr, SZ_128M) == ALIGN(addr + len - 1, SZ_128M)))) {
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
+	/*
+	 * If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
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
+static int ma35_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
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
+	u32 regs[ARRAY_SIZE(restore_data)] = {};
+
+	/*
+	 * Limitations require a reset of SD/eMMC before tuning and
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
+	.voltage_switch		= ma35_voltage_switch,
+};
+
+static const struct sdhci_pltfm_data sdhci_ma35_pdata = {
+	.ops = &sdhci_ma35_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_BROKEN_DDR50 |
+		   SDHCI_QUIRK2_ACMD23_BROKEN,
+};
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
+	/* Extra adma table cnt for cross 128M boundary handling. */
+	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
+	extra = min(extra, SDHCI_MAX_SEGS);
+
+	host->adma_table_cnt += extra;
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(pltfm_host->clk)) {
+		err = PTR_ERR(pltfm_host->clk);
+		dev_err_probe(dev, err, "failed to get clk\n");
+		goto err_sdhci;
+	}
+
+	err = mmc_of_parse(host->mmc);
+	if (err)
+		goto err_sdhci;
+
+	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(priv->rst)) {
+		err = PTR_ERR(priv->rst);
+		dev_err_probe(dev, err, "failed to get reset control\n");
+		goto err_sdhci;
+	}
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
+		goto err_sdhci;
+
+	/*
+	 * Split data into chunks of 16 or 8 bytes for transmission.
+	 * Each chunk transfer is guaranteed to be uninterrupted on the bus.
+	 * This likely corresponds to the AHB bus DMA burst size.
+	 */
+	ctl = sdhci_readw(host, MA35_SDHCI_MBIUCTL);
+	ctl &= ~MA35_SDHCI_INCR_MSK;
+	ctl |= MA35_SDHCI_INCR16 | MA35_SDHCI_INCR8;
+	sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
+
+	return 0;
+
+err_sdhci:
+	sdhci_pltfm_free(pdev);
+	return err;
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
+MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@gmail.com>");
+MODULE_LICENSE("GPL");
--
2.25.1


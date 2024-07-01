Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6578F77;
	Mon,  1 Jul 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719794393; cv=none; b=KcfJb2fQJilv4eQ8VqBaRPnrPvJxgmVG3oBcd3eZS5j8yRRfPI1XyuOFklNGnmvJS9/oM3FCju0qtTAXmGlJzDOYK1ax9gkyaQkIEemJjVIHBKRXrxcHZ0JOtP7aAYRk/uUcNXkM4v/BX/qCNK3xELPgkn2iPHHO1RD1UnRqCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719794393; c=relaxed/simple;
	bh=gprsEEUlmspK/xkfaXTo0VxJTVp3rBMptmDboD5nCa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fuw/u6/NbIzMmDKqnE1Nf0YXp/d0C0Po3yBWekb5kdKTJrhrqrkcedFYWzlyAj/yAitzN9vL+TeL4+0sfMES536wrtS+yot3zFk8Tr7z3azIga1Vvw899pXXaPkirzfN+EplEu+SsnUDXMSpGZilcMmsZqsdSlyE1pb6tHvzoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFjWJEik; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFjWJEik"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7065a2f4573so1438150b3a.2;
        Sun, 30 Jun 2024 17:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719794391; x=1720399191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjrMofQ/wylL8mgP+cLq3btmDs/Cn5RZw4wN8l/2kC4=;
        b=NFjWJEiks64Jl+eYAHXv+VjQQ/4a8beQZJ4uUFS3paEpXUdHh+xhCEsmZdTW61B57D
         Nn0pxd8cK+udIMuNk7LoL5icJcTGVE7SBp7AZaqRguSMIQeDsyUC2c0g62Lo4j0DwQ0E
         zcfUASd5bcT/aMzIzoOeGYV3dm5eqNy34Wku5JltXDfmq3wBxBmcJr9lZTswDeKB3zgO
         z4pFJT/Ny1bnLr9IDJ7V28LoBb8krnKQnFaDbYRhVA7X1Bu0n4h5glFdFBjlUibXnwTo
         9XzECAvxQRX75h92Qdmpt0HbketsIyvIn8sWTpfibO46rXPIvooVi5iEABFMI49+av5U
         JagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719794391; x=1720399191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjrMofQ/wylL8mgP+cLq3btmDs/Cn5RZw4wN8l/2kC4=;
        b=uozRvlXzsbP30bNkc0GqrThPFgjE0LlFDBgE5tZ34V+iD9/TC6Z2LrrhxEIlRUodAC
         GaaQECo+woPGePs0J9LcQSoKs2wRHzFL04sajafPgSaf2joGvvm5h63g8Hj+1ooOwt2m
         Hb/+GA/dPTRChgl44OnpMWRPOWBA0igF7XwvKiiimUH4pmoz17TMjLQWYwFVBM+Efh9T
         s4N7kd8quGSaUBYM88D1BK05on6rvYkrh5aQrds0u7UFd5IumDg0X78CkITnoudjIqqs
         4dA6c0OkrzLRfl+npsWBisF6R+Rmf/ciJRDn367R+5d5BlRFboMdHnvSwKPq68E4G4Lt
         p3ag==
X-Forwarded-Encrypted: i=1; AJvYcCVe88EPZMmZj+LYrvEev+A5N/rJ27fngEWb/XDmSO312hDAlSz3wwxAn0IWa5OMbY4mdyoSJQehHjhYTUKy1sR52yDHUBHGL8DZRGZRIPT0rrD+Sp+oyZW9eBICjeTk9Uj+wHHZ19QOKvMEfgKJK9F7RkiBTbjBKgVSr3Rw/7y92hqyZQ==
X-Gm-Message-State: AOJu0YzY2cyA7H/MC2vnj541xYCtvIT1OYU3mUTpLwIAMgTTcshv6Hmd
	cMfX9nDZ5I1XB/iSB/2V6m68kOaETXAyFaiDwGu26ZNf7ivg2KTS
X-Google-Smtp-Source: AGHT+IF8UTooXyuS/kGjuSXsPhDqTd0A74/jhZD1Tlnvr7Ip7qUcBXX7KNcVcK66cANUx+WvGm2zrg==
X-Received: by 2002:aa7:8884:0:b0:706:b19c:46cf with SMTP id d2e1a72fcca58-70aaad605e5mr2263095b3a.20.1719794391237;
        Sun, 30 Jun 2024 17:39:51 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53b47sm5232022b3a.37.2024.06.30.17.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 17:39:50 -0700 (PDT)
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
Subject: [PATCH v3 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
Date: Mon,  1 Jul 2024 08:39:13 +0800
Message-Id: <20240701003913.729428-3-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701003913.729428-1-shanchun1218@gmail.com>
References: <20240701003913.729428-1-shanchun1218@gmail.com>
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
index bb0d4fb0892a..ecd6a63872db 100644
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
index 000000000000..80a5caab88d9
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
+	u32 regs[ARRAY_SIZE(restore_data)] = { };
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


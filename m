Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C44C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796D523381
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 15:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbhATOv6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:51:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389082AbhATO2s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Jan 2021 09:28:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B41723381;
        Wed, 20 Jan 2021 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611152887;
        bh=Qd02fzmFArsS9FD/AjZSBTPR5EFMCK+sb1rmbEN7xi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh6Gg2SWXvTPikcNJDa2/23TDkJtf7meyQu0T8BecWLe6Knqj4djOGjUjlVtPOjhV
         ubhsH003uJ9R14q2iP+EnfCeaXM7YXdZkg3ubOIed8a7pZIXscPVrZZxEAH2Ji+0f7
         MsYKkUXR85wHpXmFH/DkgV3pz/Vmw+dFYInvmElriGvabT/BLFtlRQjxu1i4TBa2fk
         Hwk1f+y5fA2GA0L9RVPzAG41/FwCMpRUNK9nwvwoOSHcmV/ynchKwrPNihSfhveTME
         iF0KqCA4fYxQJIlHDdO/H4bkoPoB5ynN+drnK/stLUu0ltVXCwVRR/PWTqELRrKdRz
         /wuiO+GztOUtw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 1/2] mmc: remove dw_mmc-zx driver
Date:   Wed, 20 Jan 2021 15:28:00 +0100
Message-Id: <20210120142801.334550-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120142801.334550-1-arnd@kernel.org>
References: <20210120142801.334550-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The zte zx platform is getting removed, so this driver is no
longer needed.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/mmc/zx-dw-mshc.txt    |  31 ---
 drivers/mmc/host/Kconfig                      |   9 -
 drivers/mmc/host/Makefile                     |   1 -
 drivers/mmc/host/dw_mmc-zx.c                  | 234 ------------------
 drivers/mmc/host/dw_mmc-zx.h                  |  32 ---
 5 files changed, 307 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
 delete mode 100644 drivers/mmc/host/dw_mmc-zx.c
 delete mode 100644 drivers/mmc/host/dw_mmc-zx.h

diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
deleted file mode 100644
index 0f59bd5361f5..000000000000
--- a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* ZTE specific extensions to the Synopsys Designware Mobile Storage
-  Host Controller
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the ZTE specific
-extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be
-	- "zte,zx296718-dw-mshc": for ZX SoCs
-
-Example:
-
-	mmc1: mmc@1110000 {
-		compatible = "zte,zx296718-dw-mshc";
-		reg = <0x01110000 0x1000>;
-		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		fifo-depth = <32>;
-		data-addr = <0x200>;
-		fifo-watermark-aligned;
-		bus-width = <4>;
-		clock-frequency = <50000000>;
-		clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
-		clock-names = "biu", "ciu";
-		max-frequency = <50000000>;
-		cap-sdio-irq;
-		cap-sd-highspeed;
-	};
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 596f32637315..255d37e8bd3a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -868,15 +868,6 @@ config MMC_DW_ROCKCHIP
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on RK3066, RK3188 and RK3288 SoC's.
 
-config MMC_DW_ZX
-	tristate "ZTE specific extensions for Synopsys DW Memory Card Interface"
-	depends on MMC_DW && ARCH_ZX
-	select MMC_DW_PLTFM
-	help
-	  This selects support for ZTE SoC specific extensions to the
-	  Synopsys DesignWare Memory Card Interface driver. Select this option
-	  for platforms based on ZX296718 SoC's.
-
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 451c25fc2c69..43136d382d5f 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -61,7 +61,6 @@ obj-$(CONFIG_MMC_DW_HI3798CV200) += dw_mmc-hi3798cv200.o
 obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
-obj-$(CONFIG_MMC_DW_ZX)		+= dw_mmc-zx.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_VUB300)	+= vub300.o
diff --git a/drivers/mmc/host/dw_mmc-zx.c b/drivers/mmc/host/dw_mmc-zx.c
deleted file mode 100644
index 51bcc6332f3a..000000000000
--- a/drivers/mmc/host/dw_mmc-zx.c
+++ /dev/null
@@ -1,234 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * ZX Specific Extensions for Synopsys DW Multimedia Card Interface driver
- *
- * Copyright (C) 2016, Linaro Ltd.
- * Copyright (C) 2016, ZTE Corp.
- */
-
-#include <linux/clk.h>
-#include <linux/mfd/syscon.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/mmc.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/regmap.h>
-#include <linux/slab.h>
-
-#include "dw_mmc.h"
-#include "dw_mmc-pltfm.h"
-#include "dw_mmc-zx.h"
-
-struct dw_mci_zx_priv_data {
-	struct regmap	*sysc_base;
-};
-
-enum delay_type {
-	DELAY_TYPE_READ,	/* read dqs delay */
-	DELAY_TYPE_CLK,		/* clk sample delay */
-};
-
-static int dw_mci_zx_emmc_set_delay(struct dw_mci *host, unsigned int delay,
-				    enum delay_type dflag)
-{
-	struct dw_mci_zx_priv_data *priv = host->priv;
-	struct regmap *sysc_base = priv->sysc_base;
-	unsigned int clksel;
-	unsigned int loop = 1000;
-	int ret;
-
-	if (!sysc_base)
-		return -EINVAL;
-
-	ret = regmap_update_bits(sysc_base, LB_AON_EMMC_CFG_REG0,
-				 PARA_HALF_CLK_MODE | PARA_DLL_BYPASS_MODE |
-				 PARA_PHASE_DET_SEL_MASK |
-				 PARA_DLL_LOCK_NUM_MASK |
-				 DLL_REG_SET | PARA_DLL_START_MASK,
-				 PARA_DLL_START(4) | PARA_DLL_LOCK_NUM(4));
-	if (ret)
-		return ret;
-
-	ret = regmap_read(sysc_base, LB_AON_EMMC_CFG_REG1, &clksel);
-	if (ret)
-		return ret;
-
-	if (dflag == DELAY_TYPE_CLK) {
-		clksel &= ~CLK_SAMP_DELAY_MASK;
-		clksel |= CLK_SAMP_DELAY(delay);
-	} else {
-		clksel &= ~READ_DQS_DELAY_MASK;
-		clksel |= READ_DQS_DELAY(delay);
-	}
-
-	regmap_write(sysc_base, LB_AON_EMMC_CFG_REG1, clksel);
-	regmap_update_bits(sysc_base, LB_AON_EMMC_CFG_REG0,
-			   PARA_DLL_START_MASK | PARA_DLL_LOCK_NUM_MASK |
-			   DLL_REG_SET,
-			   PARA_DLL_START(4) | PARA_DLL_LOCK_NUM(4) |
-			   DLL_REG_SET);
-
-	do {
-		ret = regmap_read(sysc_base, LB_AON_EMMC_CFG_REG2, &clksel);
-		if (ret)
-			return ret;
-
-	} while (--loop && !(clksel & ZX_DLL_LOCKED));
-
-	if (!loop) {
-		dev_err(host->dev, "Error: %s dll lock fail\n", __func__);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static int dw_mci_zx_emmc_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
-{
-	struct dw_mci *host = slot->host;
-	struct mmc_host *mmc = slot->mmc;
-	int ret, len = 0, start = 0, end = 0, delay, best = 0;
-
-	for (delay = 1; delay < 128; delay++) {
-		ret = dw_mci_zx_emmc_set_delay(host, delay, DELAY_TYPE_CLK);
-		if (!ret && mmc_send_tuning(mmc, opcode, NULL)) {
-			if (start >= 0) {
-				end = delay - 1;
-				/* check and update longest good range */
-				if ((end - start) > len) {
-					best = (start + end) >> 1;
-					len = end - start;
-				}
-			}
-			start = -1;
-			end = 0;
-			continue;
-		}
-		if (start < 0)
-			start = delay;
-	}
-
-	if (start >= 0) {
-		end = delay - 1;
-		if ((end - start) > len) {
-			best = (start + end) >> 1;
-			len = end - start;
-		}
-	}
-	if (best < 0)
-		return -EIO;
-
-	dev_info(host->dev, "%s best range: start %d end %d\n", __func__,
-		 start, end);
-	return dw_mci_zx_emmc_set_delay(host, best, DELAY_TYPE_CLK);
-}
-
-static int dw_mci_zx_prepare_hs400_tuning(struct dw_mci *host,
-					  struct mmc_ios *ios)
-{
-	int ret;
-
-	/* config phase shift as 90 degree */
-	ret = dw_mci_zx_emmc_set_delay(host, 32, DELAY_TYPE_READ);
-	if (ret < 0)
-		return -EIO;
-
-	return 0;
-}
-
-static int dw_mci_zx_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
-{
-	struct dw_mci *host = slot->host;
-
-	if (host->verid == 0x290a) /* only for emmc */
-		return dw_mci_zx_emmc_execute_tuning(slot, opcode);
-	/* TODO: Add 0x210a dedicated tuning for sd/sdio */
-
-	return 0;
-}
-
-static int dw_mci_zx_parse_dt(struct dw_mci *host)
-{
-	struct device_node *np = host->dev->of_node;
-	struct device_node *node;
-	struct dw_mci_zx_priv_data *priv;
-	struct regmap *sysc_base;
-
-	/* syscon is needed only by emmc */
-	node = of_parse_phandle(np, "zte,aon-syscon", 0);
-	if (node) {
-		sysc_base = syscon_node_to_regmap(node);
-		of_node_put(node);
-
-		if (IS_ERR(sysc_base))
-			return dev_err_probe(host->dev, PTR_ERR(sysc_base),
-					     "Can't get syscon\n");
-	} else {
-		return 0;
-	}
-
-	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-	priv->sysc_base = sysc_base;
-	host->priv = priv;
-
-	return 0;
-}
-
-static unsigned long zx_dwmmc_caps[3] = {
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-};
-
-static const struct dw_mci_drv_data zx_drv_data = {
-	.caps			= zx_dwmmc_caps,
-	.num_caps		= ARRAY_SIZE(zx_dwmmc_caps),
-	.execute_tuning		= dw_mci_zx_execute_tuning,
-	.prepare_hs400_tuning	= dw_mci_zx_prepare_hs400_tuning,
-	.parse_dt               = dw_mci_zx_parse_dt,
-};
-
-static const struct of_device_id dw_mci_zx_match[] = {
-	{ .compatible = "zte,zx296718-dw-mshc", .data = &zx_drv_data},
-	{},
-};
-MODULE_DEVICE_TABLE(of, dw_mci_zx_match);
-
-static int dw_mci_zx_probe(struct platform_device *pdev)
-{
-	const struct dw_mci_drv_data *drv_data;
-	const struct of_device_id *match;
-
-	match = of_match_node(dw_mci_zx_match, pdev->dev.of_node);
-	drv_data = match->data;
-
-	return dw_mci_pltfm_register(pdev, drv_data);
-}
-
-static const struct dev_pm_ops dw_mci_zx_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
-			   dw_mci_runtime_resume,
-			   NULL)
-};
-
-static struct platform_driver dw_mci_zx_pltfm_driver = {
-	.probe		= dw_mci_zx_probe,
-	.remove		= dw_mci_pltfm_remove,
-	.driver		= {
-		.name		= "dwmmc_zx",
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table	= dw_mci_zx_match,
-		.pm		= &dw_mci_zx_dev_pm_ops,
-	},
-};
-
-module_platform_driver(dw_mci_zx_pltfm_driver);
-
-MODULE_DESCRIPTION("ZTE emmc/sd driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/dw_mmc-zx.h b/drivers/mmc/host/dw_mmc-zx.h
deleted file mode 100644
index 09ac52766f14..000000000000
--- a/drivers/mmc/host/dw_mmc-zx.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _DW_MMC_ZX_H_
-#define _DW_MMC_ZX_H_
-
-/* ZX296718 SoC specific DLL register offset. */
-#define LB_AON_EMMC_CFG_REG0  0x1B0
-#define LB_AON_EMMC_CFG_REG1  0x1B4
-#define LB_AON_EMMC_CFG_REG2  0x1B8
-
-/* LB_AON_EMMC_CFG_REG0 register defines */
-#define PARA_DLL_START(x)	((x) & 0xFF)
-#define PARA_DLL_START_MASK	0xFF
-#define DLL_REG_SET		BIT(8)
-#define PARA_DLL_LOCK_NUM(x)	(((x) & 7) << 16)
-#define PARA_DLL_LOCK_NUM_MASK  (7 << 16)
-#define PARA_PHASE_DET_SEL(x)	(((x) & 7) << 20)
-#define PARA_PHASE_DET_SEL_MASK	(7 << 20)
-#define PARA_DLL_BYPASS_MODE	BIT(23)
-#define PARA_HALF_CLK_MODE	BIT(24)
-
-/* LB_AON_EMMC_CFG_REG1 register defines */
-#define READ_DQS_DELAY(x)	((x) & 0x7F)
-#define READ_DQS_DELAY_MASK	(0x7F)
-#define READ_DQS_BYPASS_MODE	BIT(7)
-#define CLK_SAMP_DELAY(x)	(((x) & 0x7F) << 8)
-#define CLK_SAMP_DELAY_MASK	(0x7F << 8)
-#define CLK_SAMP_BYPASS_MODE	BIT(15)
-
-/* LB_AON_EMMC_CFG_REG2 register defines */
-#define ZX_DLL_LOCKED		BIT(2)
-
-#endif /* _DW_MMC_ZX_H_ */
-- 
2.29.2


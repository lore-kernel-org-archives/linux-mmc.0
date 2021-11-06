Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B46C433FE
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 14:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FC06120D
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 14:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhKFO0O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 Nov 2021 10:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbhKFO0L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Nov 2021 10:26:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7494C061570;
        Sat,  6 Nov 2021 07:23:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g19so5615329pfb.8;
        Sat, 06 Nov 2021 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AtZMzM/45thyh2q78RxQqNmMgUqpvkvH2rNyBK4nxYo=;
        b=Qjok3BDfFwbVx+BqLLq8cR1qL1uPxwDFKynYPD9nLI24jTwU5QYaCtakcQQzQY5HG8
         cJAoag3ykclZ297KN9oGa5Sg7lGH9Fl5m+P4JY4ffjNOjqwH0O7Wd20w7cDaXeMfWLpn
         dksm0YxQMSeHIk+zol3xOef9tbWoH8AOQtqO7zNxaza65AQtPnKK5lxP4mPRH38IL+8/
         ANjS9pHofbn2kTc2ZFt5b8jFLswv8ie5eRTmFs8nEwphSuPJduOzTmYyZlr8IViHB7lX
         uL1OCFKmZx9ln35q7RWgw8pcul2ZULI6iIIRbiT3gJEkzqxrx7fKbocRg8xUU4t1Zlfx
         jsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AtZMzM/45thyh2q78RxQqNmMgUqpvkvH2rNyBK4nxYo=;
        b=v4iHPvSgsh2F2wtXNW3UUha8YBNyYFOVcoCIYv5WB81IdIphMoG3dg0KMi79Bc2arb
         mMn0ht83f81KV8LUtqSY9qUlNSelzPv8SItwJu5Ws5oXFngSbgjwoRXAUujwjYNzOF7j
         DwVCt2qAFm4XLDYJ+eq6IAKBAHlyuY3kqavqkdeK0c3Cu9tm+nC9Nymh7bRi8+niXxaB
         HyzYsUruWTBO9Z+Ppn/ghw+8mkK2M5F4A30u2Nv+wVS8rxR38+PyC+4IDieiPn/k0qsj
         GPzpcNTvyUmcDCY64EBCsS+ubv08EK4OsR0W/DwtGbzjFDso278gWbUitKLYTjpsBCTo
         LAGg==
X-Gm-Message-State: AOAM533JZg1++GbqIOoBFPp5w39ieMbm7DV3XmiLhVv9CcIDnGznCG5g
        iQJHRtnTh8sFcZlwB2x76uU=
X-Google-Smtp-Source: ABdhPJxtDa+uBw3HMCTx4xR8FkLcoaRTlebMp+86fFSbdshzcHQ5DiCSs1BJzOhnQgjVmJhkQUvZDA==
X-Received: by 2002:a63:790e:: with SMTP id u14mr51476881pgc.478.1636208609019;
        Sat, 06 Nov 2021 07:23:29 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m4sm10859258pjs.1.2021.11.06.07.23.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Nov 2021 07:23:28 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
X-Google-Original-From: Tony Huang <tony.huang@sunplus.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, Tony Huang <tony.huang@sunplus.com>
Subject: [PATCH 2/2] mmc: Add mmc driver for Sunplus SP7021
Date:   Sat,  6 Nov 2021 22:23:18 +0800
Message-Id: <1636208598-18234-3-git-send-email-tony.huang@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
References: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add mmc driver for Sunplus SP7021

Signed-off-by: Tony Huang <tony.huang@sunplus.com>
---
 MAINTAINERS                    |    2 +
 drivers/mmc/host/Kconfig       |    9 +
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sunplus_mmc.c | 1593 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sunplus_mmc.h |  181 +++++
 5 files changed, 1786 insertions(+)
 create mode 100644 drivers/mmc/host/sunplus_mmc.c
 create mode 100644 drivers/mmc/host/sunplus_mmc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 179e60a..47dc9ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,8 @@ SUNPLUS MMC DRIVER
 M:	Tony Huang <tony.huang@sunplus.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/sunplu-mmc.yaml
+F:	drivers/mmc/host/sunplus_mmc.c
+F:	drivers/mmc/host/sunplus_mmc.h
 
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index ccc148c..2a78cbc 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -14,6 +14,15 @@ config MMC_DEBUG
 	  added host drivers please don't invent their private macro for
 	  debugging.
 
+config MMC_SUNPLUS
+	tristate "Sunplus SP7021 MMC Controller"
+	depends on ARCH_SUNPLUS || SOC_I143 || SOC_Q645
+	default y
+	help
+		If you say yes here, you will get support for eMMC host interface
+		on sunplus Socs.
+		If unsure, say N.
+		Sunplus  eMMC Host Controller v4.51 support"
 config MMC_ARMMMCI
 	tristate "ARM AMBA Multimedia Card Interface support"
 	depends on ARM_AMBA
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 14004cc..5de6788 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
 obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
 obj-$(CONFIG_MMC_SDHCI_SPRD)		+= sdhci-sprd.o
+obj-$(CONFIG_MMC_SUNPLUS)			+= sunplus_mmc.o
 obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
 cqhci-y					+= cqhci-core.o
 cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
diff --git a/drivers/mmc/host/sunplus_mmc.c b/drivers/mmc/host/sunplus_mmc.c
new file mode 100644
index 0000000..05cc5a4
--- /dev/null
+++ b/drivers/mmc/host/sunplus_mmc.c
@@ -0,0 +1,1593 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * (C) Copyright 2019 Sunplus Technology. <http://www.sunplus.com/>
+ *
+ * Sunplus SD host controller v3.0
+ *
+ */
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_device.h>
+#include <linux/reset.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/bitops.h>
+#include <linux/uaccess.h>
+
+#include "sunplus_mmc.h"
+
+enum loglevel {
+	SPMMC_LOG_OFF,
+	SPMMC_LOG_ERROR,
+	SPMMC_LOG_WARNING,
+	SPMMC_LOG_INFO,
+	SPMMC_LOG_DEBUG,
+	SPMMC_LOG_VERBOSE,
+	SPMMC_LOG_MAX
+};
+static int loglevel = SPMMC_LOG_WARNING;
+
+/**
+ * we do not need `SPMMC_LOG_' prefix here, when specify @level.
+ */
+#define spmmc_pr(level, fmt, ...)	\
+		do {	\
+			if (unlikely(SPMMC_LOG_##level <= loglevel)) \
+				pr_info("SPMMC [" #level "] " fmt, ##__VA_ARGS__);	\
+		} while (0)
+
+static const u8 tuning_blk_pattern_4bit[] = {
+	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
+	0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
+	0xff, 0xdf, 0xff, 0xdd, 0xff, 0xfb, 0xff, 0xfb,
+	0xbf, 0xff, 0x7f, 0xff, 0x77, 0xf7, 0xbd, 0xef,
+	0xff, 0xf0, 0xff, 0xf0, 0x0f, 0xfc, 0xcc, 0x3c,
+	0xcc, 0x33, 0xcc, 0xcf, 0xff, 0xef, 0xff, 0xee,
+	0xff, 0xfd, 0xff, 0xfd, 0xdf, 0xff, 0xbf, 0xff,
+	0xbb, 0xff, 0xf7, 0xff, 0xf7, 0x7f, 0x7b, 0xde,
+};
+
+static const u8 tuning_blk_pattern_8bit[] = {
+	0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
+	0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
+	0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
+	0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
+	0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
+	0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
+	0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
+	0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
+	0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
+	0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
+	0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
+	0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
+	0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
+	0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
+	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
+};
+
+/* Produces a mask of set bits covering a range of a 32-bit value */
+static inline u32 bitfield_mask(u32 shift, u32 width)
+{
+	return ((1 << width) - 1) << shift;
+}
+
+/* Extract the value of a bitfield found within a given register value */
+static inline u32 bitfield_extract(u32 reg_val, u32 shift, u32 width)
+{
+	return (reg_val & bitfield_mask(shift, width)) >> shift;
+}
+
+/* Replace the value of a bitfield found within a given register value */
+static inline u32 bitfield_replace(u32 reg_val, u32 shift, u32 width, u32 val)
+{
+	u32 mask = bitfield_mask(shift, width);
+
+	return (reg_val & ~mask) | (val << shift);
+}
+/* for register value with mask bits */
+#define __bitfield_replace(value, shift, width, new_value)		\
+	(bitfield_replace(value, shift, width, new_value)|bitfield_mask(shift+16, width))
+
+#ifdef SPMMC_DEBUG
+#define SPMMC_REG_SIZE (sizeof(struct spmmc_regs)) /* register address space size */
+#define SPMMC_REG_GRPS (sizeof(struct spmmc_regs) / 128) /* we organize 32 registers as a group */
+#define SPMMC_REG_CNT  (sizeof(struct spmmc_regs) / 4) /* total registers */
+
+/**
+ * dump a range of registers.
+ * @host: host
+ * @start_group: dump start from which group, base is 0
+ * @start_reg: dump start from which register in @start_group
+ * @len: how many registers to dump
+ */
+static void spmmc_dump_regs(struct spmmc_host *host, int start_group, int start_reg, int len)
+{
+	u32 *p = (u32 *)host->base;
+	u32 *reg_end = p + SPMMC_REG_CNT;
+	u32 *end;
+	int groups;
+	int i, j;
+
+	if (start_group > SPMMC_REG_GRPS || start_reg > 31)
+		return;
+	p += start_group * 32 + start_reg;
+	if (p > reg_end)
+		return;
+	end = p + len;
+	groups = (len + 31) / 32;
+	pr_info("groups = %d\n", groups);
+	pr_info("### dump sd card controller registers start ###\n");
+	for (i = 0; i < groups; i++) {
+		for (j =  start_reg; j < 32 && p < end; j++) {
+			pr_info("g%02d.%02d = 0x%08x\n", i+start_group, j, readl(p));
+			p++;
+		}
+		start_reg = 0;
+	}
+	pr_info("### dump sd card controller registers end ###\n");
+}
+#endif /* ifdef SPMMC_DEBUG */
+
+/**
+ * wait for transaction done, return -1 if error.
+ */
+static inline int spmmc_wait_finish(struct spmmc_host *host)
+{
+	/* Wait for transaction finish */
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (!time_after(jiffies, timeout)) {
+		if (readl(&host->base->sd_state) & SPMMC_SDSTATE_FINISH)
+			return 0;
+		if (readl(&host->base->sd_state) & SPMMC_SDSTATE_ERROR)
+			return -1;
+	}
+	return -1;
+}
+
+static inline int spmmc_wait_sdstatus(struct spmmc_host *host, unsigned int status_bit)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+
+	while (!time_after(jiffies, timeout)) {
+		if (readl(&host->base->sd_status) & status_bit)
+			return 0;
+		if (readl(&host->base->sd_state) & SPMMC_SDSTATE_ERROR)
+			return -1;
+	}
+	return -1;
+}
+
+#define spmmc_wait_rspbuf_full(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_RSP_BUF_FULL)
+#define spmmc_wait_rxbuf_full(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_RX_DATA_BUF_FULL)
+#define spmmc_wait_txbuf_empty(host) spmmc_wait_sdstatus(host, SPMMC_SDSTATUS_TX_DATA_BUF_EMPTY)
+
+static void spmmc_get_rsp(struct spmmc_host *host, struct mmc_command *cmd)
+{
+	u32 value0_3, value4_5;
+
+	if (unlikely(!(cmd->flags & MMC_RSP_PRESENT)))
+		return;
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		if (spmmc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(&host->base->sd_rspbuf0_3);
+		value4_5 = readl(&host->base->sd_rspbuf4_5) & 0xffff;
+		cmd->resp[0] = (value0_3 << 8) | (value4_5 >> 8);
+		cmd->resp[1] = value4_5 << 24;
+		value0_3 = readl(&host->base->sd_rspbuf0_3);
+		value4_5 = readl(&host->base->sd_rspbuf4_5) & 0xffff;
+		cmd->resp[1] |= value0_3 >> 8;
+		cmd->resp[2] = value0_3 << 24;
+		cmd->resp[2] |= value4_5 << 8;
+		value0_3 = readl(&host->base->sd_rspbuf0_3);
+		value4_5 = readl(&host->base->sd_rspbuf4_5) & 0xffff;
+		cmd->resp[2] |= value0_3 >> 24;
+		cmd->resp[3] = value0_3 << 8;
+		cmd->resp[3] |= value4_5 >> 8;
+	} else {
+		if (spmmc_wait_rspbuf_full(host))
+			return;
+		value0_3 = readl(&host->base->sd_rspbuf0_3);
+		value4_5 = readl(&host->base->sd_rspbuf4_5) & 0xffff;
+		cmd->resp[0] = (value0_3 << 8) | (value4_5 >> 8);
+		cmd->resp[1] = value4_5 << 24;
+	}
+	//return;
+}
+
+static void spmmc_set_bus_clk(struct spmmc_host *host, int clk)
+{
+	unsigned int clkdiv;
+	int f_min = host->mmc->f_min;
+	int f_max = host->mmc->f_max;
+	u32 value = readl(&host->base->sd_config0);
+
+	if (clk < f_min)
+		clk = f_min;
+	if (clk > f_max)
+		clk = f_max;
+	spmmc_pr(INFO, "set bus clock to %d\n", clk);
+	#ifdef CONFIG_SOC_SP7021
+	clkdiv = (clk_get_rate(host->clk)+clk)/clk-1;
+	#endif
+	#ifdef CONFIG_SOC_I143
+	clkdiv = (SPMMC_SYS_CLK/clk)-1;
+	#endif
+	#ifdef CONFIG_SOC_Q645
+	clkdiv = (clk_get_rate(host->clk)+clk)/clk-1;
+	#endif
+	spmmc_pr(INFO, "clkdiv= %d\n", clkdiv);
+	if (clkdiv > 0xfff) {
+		spmmc_pr(WARNING, "clock %d is too low to be set!\n", clk);
+		clkdiv = 0xfff;
+	}
+	value = bitfield_replace(value, 20, 12, clkdiv);
+	writel(value, &host->base->sd_config0);
+
+	/* In order to reduce the frequency of context switch,
+	 * if it is high speed or upper, we do not use interrupt
+	 * when send a command that without data transferring.
+	 */
+	if (clk > 25000000)
+		host->use_int = 0;
+	else
+		host->use_int = 1;
+}
+
+static void spmmc_set_bus_timing(struct spmmc_host *host, unsigned int timing)
+{
+	u32 value = readl(&host->base->sd_config1);
+	int clkdiv = readl(&host->base->sd_config0) >> 20;
+	int delay = clkdiv/2 < 7 ? clkdiv/2 : 7;
+	int hs_en = 1;
+	char *timing_name;
+
+	host->ddr_enabled = 0;
+	switch (timing) {
+	case MMC_TIMING_LEGACY:
+		hs_en = 0;
+		timing_name = "legacy";
+		break;
+	case MMC_TIMING_MMC_HS:
+		timing_name = "mmc high-speed";
+		break;
+	case MMC_TIMING_SD_HS:
+		timing_name = "sd high-speed";
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		timing_name = "sd uhs SDR50";
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		timing_name = "sd uhs SDR104";
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		host->ddr_enabled = 1;
+		timing_name = "sd uhs DDR50";
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		host->ddr_enabled = 1;
+		timing_name = "mmc DDR52";
+		break;
+	case MMC_TIMING_MMC_HS200:
+		timing_name = "mmc HS200";
+		break;
+	default:
+		timing_name = "invalid";
+		hs_en = 0;
+		break;
+	}
+
+	if (hs_en) {
+		value = bitfield_replace(value, 31, 1, 1); /* sd_high_speed_en */
+		writel(value, &host->base->sd_config1);
+		value = readl(&host->base->sd_timing_config0);
+		value = bitfield_replace(value, 4, 3, delay); /* sd_wr_dat_dly_sel */
+		value = bitfield_replace(value, 8, 3, delay); /* sd_wr_cmd_dly_sel */
+		writel(value, &host->base->sd_timing_config0);
+	} else {
+		value = bitfield_replace(value, 31, 1, 0);
+		writel(value, &host->base->sd_config1);
+	}
+	if (host->ddr_enabled) {
+		value = readl(&host->base->sd_config0);
+		value = bitfield_replace(value, 1, 1, 1); /* sdddrmode */
+		writel(value, &host->base->sd_config0);
+	} else {
+		value = readl(&host->base->sd_config0);
+		value = bitfield_replace(value, 1, 1, 0);
+		writel(value, &host->base->sd_config0);
+	}
+	spmmc_pr(INFO, "set bus timing to %s\n", timing_name);
+}
+
+static void spmmc_set_bus_width(struct spmmc_host *host, int width)
+{
+	u32 value = readl(&host->base->sd_config0);
+	int bus_width;
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		value = bitfield_replace(value, 11, 1, 0);
+		value = bitfield_replace(value, 18, 1, 1);
+		bus_width = 8;
+		break;
+	case MMC_BUS_WIDTH_4:
+		value = bitfield_replace(value, 11, 1, 1);
+		value = bitfield_replace(value, 18, 1, 0);
+		bus_width = 4;
+		break;
+	default:
+		value = bitfield_replace(value, 11, 1, 0);
+		value = bitfield_replace(value, 18, 1, 0);
+		bus_width = 1;
+		break;
+	};
+	spmmc_pr(INFO, "set bus width to %d bit(s)\n", bus_width);
+	writel(value, &host->base->sd_config0);
+}
+
+/**
+ * select the working mode of controller: sd/sdio/emmc
+ */
+static void spmmc_select_mode(struct spmmc_host *host, int mode)
+{
+	u32 value = readl(&host->base->sd_config0);
+
+	host->mode = mode;
+	/* set `sdmmcmode', as it will sample data at fall edge */
+	/* of SD bus clock if `sdmmcmode' is not set when */
+	/* `sd_high_speed_en' is not set, which is not compliant */
+	/* with SD specification */
+	value = bitfield_replace(value, 10, 1, 1);
+	switch (mode) {
+	case SPMMC_MODE_EMMC:
+		value = bitfield_replace(value, 9, 1, 0);
+		writel(value, &host->base->sd_config0);
+		break;
+	case SPMMC_MODE_SDIO:
+		value = bitfield_replace(value, 9, 1, 1);
+		writel(value, &host->base->sd_config0);
+		value = readl(&host->base->sdio_ctrl);
+		value = bitfield_replace(value, 6, 1, 1); /* int_multi_trig */
+		writel(value, &host->base->sdio_ctrl);
+		break;
+	case SPMMC_MODE_SD:
+	default:
+		value = bitfield_replace(value, 9, 1, 0);
+		writel(value, &host->base->sd_config0);
+		break;
+	}
+}
+
+static void spmmc_sw_reset(struct spmmc_host *host)
+{
+	u32 value;
+
+	spmmc_pr(DEBUG, "sw reset\n");
+	/* Must reset dma operation first, or it will*/
+	/* be stuck on sd_state == 0x1c00 because of*/
+	/* a controller software reset bug */
+	value = readl(&host->base->hw_dma_ctrl);
+	value = bitfield_replace(value, 10, 1, 1);
+	writel(value, &host->base->hw_dma_ctrl);
+	value = bitfield_replace(value, 10, 1, 0);
+	writel(value, &host->base->hw_dma_ctrl);
+	value = readl(&host->base->hw_dma_ctrl);
+	value = bitfield_replace(value, 9, 1, 1);
+	writel(value, &host->base->hw_dma_ctrl);
+	writel(0x7, &host->base->sd_rst);
+	while (readl(&host->base->sd_hw_state) & BIT(6))
+		;
+	spmmc_pr(DEBUG, "sw reset done\n");
+}
+
+static void spmmc_prepare_cmd(struct spmmc_host *host, struct mmc_command *cmd)
+{
+
+	u32 value;
+
+	/* add start bit, according to spec, command format */
+	value = ((cmd->opcode | 0x40) << 24) | (cmd->arg >> 8);
+	writel(value, &host->base->sd_cmdbuf0_3);
+	writeb(cmd->arg & 0xff, &host->base->sd_cmdbuf4);
+
+	/* disable interrupt if needed */
+	value = readl(&host->base->sd_int);
+	value = bitfield_replace(value, 2, 1, 1); /* sd_cmp_clr */
+	if (likely(!host->use_int || cmd->flags & MMC_RSP_136))
+		value = bitfield_replace(value, 0, 1, 0); /* sdcmpen */
+	else
+		value = bitfield_replace(value, 0, 1, 1);
+	writel(value, &host->base->sd_int);
+
+	value = readl(&host->base->sd_config0);
+	value = bitfield_replace(value, 4, 2, 0); /* sd_trans_mode */
+	value = bitfield_replace(value, 7, 1, 1); /* sdcmddummy */
+	if (likely(cmd->flags & MMC_RSP_PRESENT)) {
+		value = bitfield_replace(value, 6, 1, 1); /* sdautorsp */
+	} else {
+		value = bitfield_replace(value, 6, 1, 0);
+		writel(value, &host->base->sd_config0);
+		return;
+	}
+	/*
+	 * Currently, host is not capable of checking R2's CRC7,
+	 * thus, enable crc7 check only for 48 bit response commands
+	 */
+	if (likely(cmd->flags & MMC_RSP_CRC && !(cmd->flags & MMC_RSP_136)))
+		value = bitfield_replace(value, 8, 1, 1); /* sdrspchk_en */
+	else
+		value = bitfield_replace(value, 8, 1, 0);
+
+	if (unlikely(cmd->flags & MMC_RSP_136))
+		value = bitfield_replace(value, 15, 1, 1); /* sdrsptype */
+	else
+		value = bitfield_replace(value, 15, 1, 0);
+	writel(value, &host->base->sd_config0);
+}
+
+static void spmmc_prepare_data(struct spmmc_host *host, struct mmc_data *data)
+{
+	u32 value, srcdst;
+	//struct mmc_command *cmd = data->mrq->cmd;
+
+	writel(data->blocks - 1, &host->base->sd_page_num);
+	writel(data->blksz - 1, &host->base->sd_blocksize);
+	value = readl(&host->base->sd_config0);
+	if (data->flags & MMC_DATA_READ) {
+		value = bitfield_replace(value, 4, 2, 2); /* sd_trans_mode */
+		value = bitfield_replace(value, 6, 1, 0); /* sdautorsp */
+		value = bitfield_replace(value, 7, 1, 0); /* sdcmddummy */
+		srcdst = readl(&host->base->card_mediatype_srcdst);
+		srcdst = bitfield_replace(srcdst, 4, 7, 0x12);
+		writel(srcdst, &host->base->card_mediatype_srcdst);
+	} else {
+		value = bitfield_replace(value, 4, 2, 1);
+		srcdst = readl(&host->base->card_mediatype_srcdst);
+		srcdst = bitfield_replace(srcdst, 4, 7, 0x21);
+		writel(srcdst, &host->base->card_mediatype_srcdst);
+	}
+	value = bitfield_replace(value, 2, 1, 1);
+	if (likely(host->dmapio_mode == SPMMC_DMA_MODE)) {
+		struct scatterlist *sg;
+		dma_addr_t dma_addr;
+		unsigned int dma_size;
+		u32 *reg_addr;
+		int dma_direction = data->flags & MMC_DATA_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+		int i, count = 1;
+
+		count = dma_map_sg(host->mmc->parent, data->sg, data->sg_len, dma_direction);
+		if (unlikely(!count || count > SPMMC_MAX_DMA_MEMORY_SECTORS)) {
+			spmmc_pr(ERROR, "error occurred at dma_mapp_sg: count = %d\n", count);
+			data->error = -EINVAL;
+			return;
+		}
+		for_each_sg(data->sg, sg, count, i) {
+			dma_addr = sg_dma_address(sg);
+			dma_size = sg_dma_len(sg) / 512 - 1;
+			if (i == 0) {
+				writel(dma_addr, &host->base->dma_base_addr);
+				writel(dma_size, &host->base->sdram_sector_0_size);
+			} else {
+				reg_addr = &host->base->sdram_sector_1_addr + (i - 1) * 2;
+				writel(dma_addr, reg_addr);
+				writel(dma_size, reg_addr + 1);
+			}
+		}
+		value = bitfield_replace(value, 0, 1, 0); /* sdpiomode */
+		writel(value, &host->base->sd_config0);
+		/* enable interrupt if needed */
+		if (!host->use_int && data->blksz * data->blocks > host->dma_int_threshold) {
+			host->dma_use_int = 1;
+			value = readl(&host->base->sd_int);
+			value = bitfield_replace(value, 0, 1, 1); /* sdcmpen */
+			writel(value, &host->base->sd_int);
+		}
+	} else {
+		value = bitfield_replace(value, 0, 1, 1);
+		value = bitfield_replace(value, 14, 1, 1); /* rx4_en */
+		writel(value, &host->base->sd_config0);
+	}
+}
+
+static inline void spmmc_trigger_transaction(struct spmmc_host *host)
+{
+	u32 value = readl(&host->base->sd_ctrl);
+
+	value = bitfield_replace(value, 0, 1, 1); /* trigger transaction */
+	writel(value, &host->base->sd_ctrl);
+}
+
+static void __send_stop_cmd(struct spmmc_host *host)
+{
+	struct mmc_command stop = {};
+	u32 value;
+
+	stop.opcode = MMC_STOP_TRANSMISSION;
+	stop.arg = 0;
+	stop.flags = MMC_RSP_R1B;
+	spmmc_prepare_cmd(host, &stop);
+	value = readl(&host->base->sd_int);
+	value = bitfield_replace(value, 0, 1, 0); /* sdcmpen */
+	writel(value, &host->base->sd_int);
+	spmmc_trigger_transaction(host);
+	spmmc_wait_finish(host);
+}
+
+/**
+ * check if error occurred during transaction.
+ * @host -  host
+ * @mrq - the mrq
+ * @return 0 if no error otherwise the error number.
+ */
+static int spmmc_check_error(struct spmmc_host *host, struct mmc_request *mrq)
+{
+	int ret = 0;
+	struct mmc_command *cmd = mrq->cmd;
+	struct mmc_data *data = mrq->data;
+
+	u32 value = readl(&host->base->sd_state);
+	u32 crc_token = bitfield_extract(value, 4, 3);
+
+	if (unlikely(value & SPMMC_SDSTATE_ERROR)) {
+		u32 timing_cfg0 = 0;
+
+		spmmc_pr(DEBUG, "%s cmd %d with data %p error!\n", __func__, cmd->opcode, data);
+		spmmc_pr(VERBOSE, "%s sd_state: 0x%08x\n", __func__, value);
+		value = readl(&host->base->sd_status);
+		spmmc_pr(VERBOSE, "%s sd_status: 0x%08x\n", __func__, value);
+
+		if (host->tuning_info.enable_tuning) {
+			timing_cfg0 = readl(&host->base->sd_timing_config0);
+			host->tuning_info.rd_crc_dly = bitfield_extract(timing_cfg0, 20, 3);
+			host->tuning_info.rd_dat_dly = bitfield_extract(timing_cfg0, 16, 3);
+			host->tuning_info.rd_rsp_dly = bitfield_extract(timing_cfg0, 12, 3);
+			host->tuning_info.wr_cmd_dly = bitfield_extract(timing_cfg0, 8, 3);
+			host->tuning_info.wr_dat_dly = bitfield_extract(timing_cfg0, 4, 3);
+		}
+
+		if (value & SPMMC_SDSTATUS_RSP_TIMEOUT) {
+			ret = -ETIMEDOUT;
+			host->tuning_info.wr_cmd_dly++;
+		} else if (value & SPMMC_SDSTATUS_RSP_CRC7_ERROR) {
+			ret = -EILSEQ;
+			host->tuning_info.rd_rsp_dly++;
+		} else if (data) {
+			if ((value & SPMMC_SDSTATUS_STB_TIMEOUT)) {
+				ret = -ETIMEDOUT;
+				host->tuning_info.rd_dat_dly++;
+			} else if (value & SPMMC_SDSTATUS_RDATA_CRC16_ERROR) {
+				ret = -EILSEQ;
+				host->tuning_info.rd_dat_dly++;
+			} else if (value & SPMMC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT) {
+				ret = -ETIMEDOUT;
+				host->tuning_info.rd_crc_dly++;
+			} else if (value & SPMMC_SDSTATUS_CRC_TOKEN_CHECK_ERROR) {
+				ret = -EILSEQ;
+				if (crc_token == 0x5)
+					host->tuning_info.wr_dat_dly++;
+				else
+					host->tuning_info.rd_crc_dly++;
+			}
+		}
+		cmd->error = ret;
+		if (data) {
+			data->error = ret;
+			data->bytes_xfered = 0;
+		}
+		if (!host->tuning_info.need_tuning && host->tuning_info.enable_tuning)
+			cmd->retries = SPMMC_MAX_RETRIES; /* retry it */
+		spmmc_sw_reset(host);
+		mdelay(5);
+
+		if (host->tuning_info.enable_tuning) {
+			timing_cfg0 = bitfield_replace(timing_cfg0, 20, 3,
+				host->tuning_info.rd_crc_dly);
+			timing_cfg0 = bitfield_replace(timing_cfg0, 16, 3,
+				host->tuning_info.rd_dat_dly);
+			timing_cfg0 = bitfield_replace(timing_cfg0, 12, 3,
+				host->tuning_info.rd_rsp_dly);
+			timing_cfg0 = bitfield_replace(timing_cfg0, 8, 3,
+				host->tuning_info.wr_cmd_dly);
+			timing_cfg0 = bitfield_replace(timing_cfg0, 4, 3,
+				host->tuning_info.wr_dat_dly);
+			writel(timing_cfg0, &host->base->sd_timing_config0);
+		}
+
+
+	} else if (data) {
+		data->error = 0;
+		data->bytes_xfered = data->blocks * data->blksz;
+	}
+	host->tuning_info.need_tuning = ret;
+    /* controller will not send cmd 12 automatically if error occurred */
+	if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+	    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {
+		__send_stop_cmd(host);
+		spmmc_sw_reset(host);
+	}
+	return ret;
+}
+
+/**
+ * the strategy is:
+ * 1. if several continuous delays are acceptable, we choose a middle one;
+ * 2. otherwise, we choose the first one.
+ */
+static inline int __find_best_delay(u8 candidate_dly)
+{
+	int f, w;
+
+	if (!candidate_dly)
+		return 0;
+	f = ffs(candidate_dly) - 1;
+	w = hweight8(candidate_dly);
+	if (0xff == (bitfield_mask(f, w) & ~candidate_dly))
+		return (f + w / 2);
+	else
+		return (f);
+}
+
+static inline __maybe_unused void spmmc_txdummy(struct spmmc_host *host, int count)
+{
+	u32 value;
+
+	count &= 0x1ff;
+	value = readl(&host->base->sd_config1);
+	value = bitfield_replace(value, 0, 9, count);
+	writel(value, &host->base->sd_config1);
+	value = readl(&host->base->sd_ctrl);
+	value = bitfield_replace(value, 1, 1, 1); /* trigger tx dummy */
+	writel(value, &host->base->sd_ctrl);
+}
+
+static void spmmc_xfer_data_pio(struct spmmc_host *host, struct mmc_data *data)
+{
+	u32 *buf; /* tx/rx 4 bytes one time in pio mode */
+	int data_left = data->blocks * data->blksz;
+	int consumed, remain;
+
+	struct sg_mapping_iter *sg_miter = &host->sg_miter;
+	unsigned int flags = 0;
+
+	if (data->flags & MMC_DATA_WRITE)
+		flags |= SG_MITER_FROM_SG;
+	else
+		flags |= SG_MITER_TO_SG;
+	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
+	while (data_left > 0) {
+		consumed = 0;
+		if (!sg_miter_next(sg_miter))
+			break;
+		buf = sg_miter->addr;
+		remain = sg_miter->length;
+		do {
+			if (data->flags & MMC_DATA_WRITE) {
+				if (spmmc_wait_txbuf_empty(host))
+					goto done;
+				writel(*buf, &host->base->sd_piodatatx);
+			} else {
+				if (spmmc_wait_rxbuf_full(host))
+					goto done;
+				*buf = readl(&host->base->sd_piodatarx);
+			}
+			buf++;
+			consumed += 4;
+			remain -= 4;
+		} while (remain);
+		sg_miter->consumed = consumed;
+		data_left -= consumed;
+	}
+done:
+	sg_miter_stop(sg_miter);
+}
+
+static void spmmc_controller_init(struct spmmc_host *host)
+{
+	u32 value;
+	int ret = reset_control_assert(host->rstc);
+
+	if (!ret) {
+		mdelay(1);
+		ret = reset_control_deassert(host->rstc);
+	}
+	if (ret)
+		spmmc_pr(WARNING, "Failed to reset SD controller!\n");
+	value = readl(&host->base->card_mediatype_srcdst);
+	value = bitfield_replace(value, 0, 3, SPMMC_MEDIA_SD);
+	writel(value, &host->base->card_mediatype_srcdst);
+	host->signal_voltage = MMC_SIGNAL_VOLTAGE_330;
+#ifdef SPMMC_EMMC_VCCQ_1V8
+	/* Because we do not have a regulator to change the voltage at
+	 * runtime, we can only rely on hardware circuit to ensure that
+	 * the eMMC's Vccq is 1.8V and use the macro `SPMMC_EMMC_VCCQ_1V8'
+	 * to indicate that. Set signal voltage to 1.8V here.
+	 */
+	if (host->mode == SPMMC_MODE_EMMC) {
+		value = readl(&host->base->sd_vol_ctrl);
+		value = bitfield_replace(value, 2, 1, 1);
+		writel(value, &host->base->sd_vol_ctrl);
+		host->signal_voltage = MMC_SIGNAL_VOLTAGE_180;
+		spmmc_pr(INFO, "use signal voltage 1.8V for eMMC\n");
+	}
+#endif
+}
+
+static void spmmc_set_power_mode(struct spmmc_host *host, struct mmc_ios *ios)
+{
+	if (host->power_state == ios->power_mode)
+		return;
+
+	switch (ios->power_mode) {
+		/* power off->up->on */
+	case MMC_POWER_ON:
+		spmmc_pr(DEBUG, "set MMC_POWER_ON\n");
+		spmmc_controller_init(host);
+		pm_runtime_get_sync(host->mmc->parent);
+		break;
+	case MMC_POWER_UP:
+		spmmc_pr(DEBUG, "set MMC_POWER_UP\n");
+		break;
+	case MMC_POWER_OFF:
+		spmmc_pr(DEBUG, "set MMC_POWER_OFF\n");
+		pm_runtime_put(host->mmc->parent);
+		break;
+	}
+	host->power_state = ios->power_mode;
+}
+
+/**
+ * 1. unmap scatterlist if needed;
+ * 2. get response & check error conditions;
+ * 3. unlock host->mrq_lock
+ * 4. notify mmc layer the request is done
+ */
+static void spmmc_finish_request(struct spmmc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+
+	if (!mrq)
+		return;
+
+	cmd = mrq->cmd;
+	data = mrq->data;
+
+	if (data && SPMMC_DMA_MODE == host->dmapio_mode) {
+		int dma_direction = data->flags & MMC_DATA_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+		dma_unmap_sg(host->mmc->parent, data->sg, data->sg_len, dma_direction);
+		host->dma_use_int = 0;
+	}
+	spmmc_get_rsp(host, cmd);
+	spmmc_check_error(host, mrq);
+	host->mrq = NULL;
+	mutex_unlock(&host->mrq_lock);
+	spmmc_pr(VERBOSE, "request done > error:%d, cmd:%d, resp:0x%08x\n",
+		cmd->error, cmd->opcode, cmd->resp[0]);
+	mmc_request_done(host->mmc, mrq);
+}
+
+/* Interrupt Service Routine */
+irqreturn_t spmmc_irq(int irq, void *dev_id)
+{
+	struct spmmc_host *host = dev_id;
+	u32 value = readl(&host->base->sd_int);
+
+	spin_lock(&host->lock);
+	if ((value & SPMMC_SDINT_SDCMP) &&
+		(value & SPMMC_SDINT_SDCMPEN)) {
+		value = bitfield_replace(value, 0, 1, 0); /* disable sdcmp */
+		value = bitfield_replace(value, 2, 1, 1); /* sd_cmp_clr */
+		writel(value, &host->base->sd_int);
+		/* if error occurred, we my need send cmd 12 to stop data transaction,*/
+		/* which is time consuming, so make use of tasklet to handle this.*/
+		if (unlikely(readl(&host->base->sd_state) & SPMMC_SDSTATE_ERROR))
+			tasklet_schedule(&host->tsklet_finish_req);
+		else
+			spmmc_finish_request(host, host->mrq);
+	}
+	if (value & SPMMC_SDINT_SDIO &&
+		(value & SPMMC_SDINT_SDIOEN)) {
+		mmc_signal_sdio_irq(host->mmc);
+	}
+	spin_unlock(&host->lock);
+	return IRQ_HANDLED;
+}
+
+static void spmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	struct mmc_data *data;
+	struct mmc_command *cmd;
+
+	mutex_lock_interruptible(&host->mrq_lock);
+	host->mrq = mrq;
+	data = mrq->data;
+	cmd = mrq->cmd;
+	spmmc_pr(VERBOSE, "%s > cmd:%d, arg:0x%08x, data len:%d\n", __func__,
+		 cmd->opcode, cmd->arg, data ? (data->blocks*data->blksz) : 0);
+
+	spmmc_prepare_cmd(host, cmd);
+	/* we need manually read response R2. */
+	if (unlikely(cmd->flags & MMC_RSP_136)) {
+		spmmc_trigger_transaction(host);
+		spmmc_get_rsp(host, cmd);
+		spmmc_wait_finish(host);
+		spmmc_check_error(host, mrq);
+		host->mrq = NULL;
+		spmmc_pr(VERBOSE, "request done > error:%d, cmd:%d, resp:%08x %08x %08x %08x\n",
+			cmd->error, cmd->opcode, cmd->resp[0], cmd->resp[1], cmd->resp[2],
+			cmd->resp[3]);
+		mutex_unlock(&host->mrq_lock);
+		mmc_request_done(host->mmc, mrq);
+	} else {
+		if (data)
+			spmmc_prepare_data(host, data);
+
+		if (unlikely(host->dmapio_mode == SPMMC_PIO_MODE && data)) {
+			u32 value;
+			/* pio data transfer do not use interrupt */
+			value = readl(&host->base->sd_int);
+			value = bitfield_replace(value, 0, 1, 0); /* sdcmpen */
+			writel(value, &host->base->sd_int);
+			spmmc_trigger_transaction(host);
+			spmmc_xfer_data_pio(host, data);
+			spmmc_wait_finish(host);
+			spmmc_finish_request(host, mrq);
+		} else {
+			if (!(host->use_int || host->dma_use_int)) {
+				spmmc_trigger_transaction(host);
+				spmmc_wait_finish(host);
+				spmmc_finish_request(host, mrq);
+			} else {
+				spmmc_trigger_transaction(host);
+			}
+		}
+	}
+}
+
+static void spmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct spmmc_host *host = (struct spmmc_host *)mmc_priv(mmc);
+
+	mutex_lock(&host->mrq_lock);
+	spmmc_set_power_mode(host, ios);
+	spmmc_set_bus_clk(host, ios->clock);
+	spmmc_set_bus_timing(host, ios->timing);
+	spmmc_set_bus_width(host, ios->bus_width);
+	/* ensure mode is correct, because we might have hw reset the controller */
+	spmmc_select_mode(host, host->mode);
+	mutex_unlock(&host->mrq_lock);
+	//return;
+}
+
+/**
+ * Return values for the get_cd callback should be:
+ *   0 for a absent card
+ *   1 for a present card
+ *   -ENOSYS when not supported (equal to NULL callback)
+ *   or a negative errno value when something bad happened
+ */
+int spmmc_get_cd(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (mmc_can_gpio_cd(mmc))
+		ret = mmc_gpio_get_cd(mmc);
+	else
+		spmmc_pr(WARNING, "no gpio assigned for card detection\n");
+
+	if (ret < 0) {
+		spmmc_pr(ERROR, "Failed to get card presence status\n");
+		ret = 0;
+	}
+
+	return ret;
+}
+
+#ifdef SPMMC_SUPPORT_VOLTAGE_1V8
+static int spmmc_card_busy(struct mmc_host *mmc)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+
+	return !(readl(&host->base->sd_status) & SPMMC_SDSTATUS_DAT0_PIN_STATUS);
+}
+
+static int spmmc_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	u32 value;
+
+	if (host->signal_voltage == ios->signal_voltage)
+		return 0;
+
+	/* we do not support switch signal voltage for eMMC at runtime at present */
+	if (host->mode == SPMMC_MODE_EMMC)
+		return -EIO;
+
+	if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
+		spmmc_pr(WARNING, "can not switch voltage, only support 3.3v -> 1.8v switch!\n");
+		return -EIO;
+	}
+
+	value = readl(&host->base->sd_vol_ctrl);
+	value = bitfield_replace(value, 0, 2, 3); /* 1ms timeout for 400K */
+	value = bitfield_replace(value, 3, 1, 1);
+	writel(value, &host->base->sd_vol_ctrl);
+	spmmc_txdummy(host, 401);
+	mdelay(1);
+	/* mmc layer has guaranteed that CMD11 had issued to SD card at*/
+	/* this time, so we can just continue to check the status.*/
+	value = readl(&host->base->sd_vol_ctrl);
+	while (1) {
+		if (value >> 4 == SPMMC_SWITCH_VOLTAGE_1V8_ERROR)
+			return -EIO;
+		if (value >> 4 == SPMMC_SWITCH_VOLTAGE_1V8_TIMEOUT)
+			return -EIO;
+		if (value >> 4 == SPMMC_SWITCH_VOLTAGE_1V8_FINISH)
+			break;
+	}
+	value = bitfield_replace(value, 3, 1, 0);
+	writel(value, &host->base->sd_vol_ctrl);
+	host->signal_voltage = ios->signal_voltage;
+	return 0;
+}
+#endif /* ifdef SPMMC_SUPPORT_VOLTAGE_1V8 */
+
+static int spmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	const u8 *blk_pattern;
+	u8 *blk_test;
+	int blksz;
+	u8 smpl_dly = 0, candidate_dly = 0;
+	u32 value;
+
+	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
+		blk_pattern = tuning_blk_pattern_8bit;
+		blksz = sizeof(tuning_blk_pattern_8bit);
+	} else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+		blk_pattern = tuning_blk_pattern_4bit;
+		blksz = sizeof(tuning_blk_pattern_4bit);
+	} else {
+		return -EINVAL;
+	}
+
+	blk_test = kmalloc(blksz, GFP_KERNEL);
+	if (!blk_test)
+		return -ENOMEM;
+
+	host->tuning_info.enable_tuning = 0;
+	do {
+		struct mmc_request mrq = {NULL};
+		struct mmc_command cmd = {0};
+		struct mmc_command stop = {0};
+		struct mmc_data data = {0};
+		struct scatterlist sg;
+
+		cmd.opcode = opcode;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+		stop.opcode = MMC_STOP_TRANSMISSION;
+		stop.arg = 0;
+		stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
+		data.blksz = blksz;
+		data.blocks = 1;
+		data.flags = MMC_DATA_READ;
+		data.sg = &sg;
+		data.sg_len = 1;
+
+		sg_init_one(&sg, blk_test, blksz);
+		mrq.cmd = &cmd;
+		mrq.stop = &stop;
+		mrq.data = &data;
+		host->mrq = &mrq;
+
+		value = readl(&host->base->sd_timing_config0);
+		value = bitfield_replace(value, 12, 3, smpl_dly); /* sd_rd_rsp_dly_sel */
+		value = bitfield_replace(value, 16, 3, smpl_dly); /* sd_rd_dat_dly_sel */
+		value = bitfield_replace(value, 20, 3, smpl_dly); /* sd_rd_crc_dly_sel */
+		writel(value, &host->base->sd_timing_config0);
+
+		mmc_wait_for_req(mmc, &mrq);
+		if (!cmd.error && !data.error) {
+			if (!memcmp(blk_pattern, blk_test, blksz))
+				candidate_dly |= (1 << smpl_dly);
+		} else {
+			spmmc_pr(DEBUG, "Tuning error: cmd.error:%d, data.error:%d\n",
+				cmd.error, data.error);
+		}
+	} while (smpl_dly++ <= SPMMC_MAX_TUNABLE_DLY);
+	host->tuning_info.enable_tuning = 1;
+
+	spmmc_pr(DEBUG, "sampling delay candidates: %x\n", candidate_dly);
+	if (candidate_dly) {
+		smpl_dly = __find_best_delay(candidate_dly);
+		spmmc_pr(DEBUG, "set sampling delay to: %d\n", smpl_dly);
+		value = readl(&host->base->sd_timing_config0);
+		value = bitfield_replace(value, 12, 3, smpl_dly); /* sd_rd_rsp_dly_sel */
+		value = bitfield_replace(value, 16, 3, smpl_dly); /* sd_rd_dat_dly_sel */
+		value = bitfield_replace(value, 20, 3, smpl_dly); /* sd_rd_crc_dly_sel */
+		writel(value, &host->base->sd_timing_config0);
+		return 0;
+	}
+	return -EIO;
+}
+
+static void spmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct spmmc_host *host = mmc_priv(mmc);
+	u32 value = readl(&host->base->sd_int);
+
+	value = bitfield_replace(value, 5, 1, 1); /* sdio_int_clr */
+	if (enable)
+		value = bitfield_replace(value, 3, 1, 1);
+	else
+		value = bitfield_replace(value, 3, 1, 0);
+	writel(value, &host->base->sd_int);
+}
+
+static const struct mmc_host_ops spmmc_ops = {
+	.request = spmmc_request,
+	.set_ios = spmmc_set_ios,
+	.get_cd = spmmc_get_cd,
+#ifdef SPMMC_SUPPORT_VOLTAGE_1V8
+	.card_busy = spmmc_card_busy,
+	.start_signal_voltage_switch = spmmc_start_signal_voltage_switch,
+#endif
+	.execute_tuning = spmmc_execute_tuning,
+	.enable_sdio_irq = spmmc_enable_sdio_irq,
+};
+
+/****** sysfs files ******/
+struct spmmc_config {
+	char *name;
+#define SPMMC_CFG_SUCCESS	0
+#define SPMMC_CFG_FAIL		-1
+#define SPMMC_CFG_REINIT	1 /* succeeded and need re-initialize */
+	int (*store)(struct spmmc_host *host, const char *arg);
+	int (*show)(struct spmmc_host *host, char *buf);
+};
+
+static int config_controller_clock_show(struct spmmc_host *host, char *buf)
+{
+	return sprintf(buf, "controller clock: %lu\n", clk_get_rate(host->clk));
+}
+
+static int config_bus_clock_show(struct spmmc_host *host, char *buf)
+{
+	return sprintf(buf, "*bus_clock: %d\n", host->mmc->ios.clock);
+}
+
+static int config_bus_clock_store(struct spmmc_host *host, const char *arg)
+{
+	unsigned long val;
+
+	if (kstrtoul(arg, 10, &val))
+		return SPMMC_CFG_FAIL;
+	if (val >= host->mmc->f_min && val <= SPMMC_MAX_CLK) {
+		host->mmc->f_max = val;
+		return SPMMC_CFG_REINIT;
+	}
+	return SPMMC_CFG_FAIL;
+}
+
+static int config_bus_width_show(struct spmmc_host *host, char *buf)
+{
+	int bus_width;
+
+	switch (host->mmc->ios.bus_width) {
+	case MMC_BUS_WIDTH_8:
+		bus_width = 8;
+		break;
+	case MMC_BUS_WIDTH_4:
+		bus_width = 4;
+		break;
+	default:
+		bus_width = 1;
+		break;
+	};
+	return sprintf(buf, "*bus_width: %d\n", bus_width);
+}
+
+static int config_bus_width_store(struct spmmc_host *host, const char *arg)
+{
+	unsigned long val;
+
+	if (kstrtoul(arg, 10, &val))
+		return SPMMC_CFG_FAIL;
+	switch (val) {
+	case 8:
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
+		return SPMMC_CFG_REINIT;
+	case 4:
+		host->mmc->caps &= ~MMC_CAP_8_BIT_DATA;
+		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
+		return SPMMC_CFG_REINIT;
+	case 1:
+		host->mmc->caps &= ~MMC_CAP_8_BIT_DATA;
+		host->mmc->caps &= ~MMC_CAP_4_BIT_DATA;
+		return SPMMC_CFG_REINIT;
+	default:
+		return SPMMC_CFG_FAIL;
+	}
+}
+
+static int config_mode_show(struct spmmc_host *host, char *buf)
+{
+	char *mode = "";
+
+	switch (host->mode) {
+	case SPMMC_MODE_SD:
+		mode = "SD";
+		break;
+	case SPMMC_MODE_SDIO:
+		mode = "SDIO";
+		break;
+	case SPMMC_MODE_EMMC:
+		mode = "eMMC";
+		break;
+	}
+	return sprintf(buf, "*mode: %s\n", mode);
+}
+
+static int config_mode_store(struct spmmc_host *host, const char *arg)
+{
+	if (!strcasecmp("sd", arg)) {
+		spmmc_select_mode(host, SPMMC_MODE_SD);
+		return SPMMC_CFG_REINIT;
+	}
+	if (!strcasecmp("sdio", arg)) {
+		spmmc_select_mode(host, SPMMC_MODE_SDIO);
+		return SPMMC_CFG_REINIT;
+	}
+	if (!strcasecmp("emmc", arg)) {
+		spmmc_select_mode(host, SPMMC_MODE_EMMC);
+		return SPMMC_CFG_REINIT;
+	}
+	return SPMMC_CFG_FAIL;
+}
+
+static int config_dmapio_mode_show(struct spmmc_host *host, char *buf)
+{
+	char *dmapio_mode = "";
+
+	switch (host->dmapio_mode) {
+	case SPMMC_DMA_MODE:
+		dmapio_mode = "DMA";
+		break;
+	case SPMMC_PIO_MODE:
+		dmapio_mode = "PIO";
+		break;
+	}
+	return sprintf(buf, "*dmapio_mode: %s\n", dmapio_mode);
+}
+
+static int config_dmapio_mode_store(struct spmmc_host *host, const char *arg)
+{
+	if (!strcasecmp("dma", arg)) {
+		host->dmapio_mode = SPMMC_DMA_MODE;
+		return SPMMC_CFG_SUCCESS;
+	}
+	if (!strcasecmp("pio", arg)) {
+		host->dmapio_mode = SPMMC_PIO_MODE;
+		return SPMMC_CFG_SUCCESS;
+	}
+	return SPMMC_CFG_FAIL;
+}
+
+static int config_dma_int_threshold_show(struct spmmc_host *host, char *buf)
+{
+	return sprintf(buf, "*dma_int_threshold: %d\n", host->dma_int_threshold);
+}
+
+static int config_dma_int_threshold_store(struct spmmc_host *host, const char *arg)
+{
+	unsigned long val;
+
+	if (kstrtoul(arg, 10, &val))
+		return SPMMC_CFG_FAIL;
+	host->dma_int_threshold = val;
+	return SPMMC_CFG_SUCCESS;
+}
+
+static struct spmmc_config spmmc_configs[] = {
+	{
+		.name = "controller clock",
+		.show = config_controller_clock_show,
+	},
+	{
+		.name = "mode",
+		.show = config_mode_show,
+		.store = config_mode_store
+	},
+	{
+		.name = "bus_clock",
+		.show = config_bus_clock_show,
+		.store = config_bus_clock_store
+	},
+	{
+		.name = "bus_width",
+		.show = config_bus_width_show,
+		.store = config_bus_width_store
+	},
+	{
+		.name = "dmapio_mode",
+		.show = config_dmapio_mode_show,
+		.store = config_dmapio_mode_store
+	},
+	{
+		.name = "dma_int_threshold",
+		.show = config_dma_int_threshold_show,
+		.store = config_dma_int_threshold_store
+	},
+	{} /* sentinel */
+};
+
+static ssize_t config_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct spmmc_host *host = dev_get_drvdata(dev);
+	struct spmmc_config *p = spmmc_configs;
+	int len;
+
+	if (!host) {
+		pr_err("No host data!\n");
+		return 0;
+	}
+
+	len = sprintf(buf, "configures start with '*' could be configured:\n");
+	while (p->name) {
+		if (p->show)
+			len += p->show(host, buf + len);
+		p++;
+	}
+	return len;
+
+}
+
+static ssize_t config_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct spmmc_host *host = dev_get_drvdata(dev);
+	char *tmp;
+	char *name, *arg,  **s;
+	int ret;
+	int need_reinit = 0;
+	struct spmmc_config *p;
+
+	if (!host) {
+		pr_err("No host data!\n");
+		return 0;
+	}
+	tmp = kmalloc(count, GFP_KERNEL);
+	if (!tmp) {
+		//pr_err("No enough memory for operation!\n");
+		return 0;
+	}
+	memcpy(tmp, buf, count);
+	s = &tmp;
+	while ((name = strsep(s, "\n")) && (arg = strsep(s, "\n"))) {
+		p = spmmc_configs;
+		while (p->name && strcasecmp(p->name, name))
+			p++;
+		if (p->name) {
+			spmmc_pr(INFO, "trying to set config %s to %s\n", name, arg);
+			ret = p->store(host, arg);
+			if (ret == SPMMC_CFG_REINIT)
+				need_reinit = 1;
+			else if (ret == SPMMC_CFG_FAIL)
+				pr_err("Invalid argument '%s' to config %s\n", arg, name);
+		} else {
+			pr_err("Invalid config name: %s\n", name);
+		}
+	}
+
+	if (need_reinit) {
+		mmc_remove_host(host->mmc);
+		mmc_add_host(host->mmc);
+	}
+	kfree(tmp);
+	return count;
+}
+static DEVICE_ATTR_RW(config);
+
+static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", loglevel);
+}
+
+static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		goto out;
+	if (val < SPMMC_LOG_MAX) {
+		loglevel = val;
+		return count;
+	}
+out:
+	pr_err("Invalid value\n");
+	return 0;
+}
+static DEVICE_ATTR_RW(loglevel);
+
+static int spmmc_device_create_sysfs(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = device_create_file(&pdev->dev, &dev_attr_loglevel);
+	if (ret)
+		return ret;
+	ret = device_create_file(&pdev->dev, &dev_attr_config);
+	if (ret)
+		device_remove_file(&pdev->dev, &dev_attr_loglevel);
+	return ret;
+}
+
+static void spmmc_device_remove_sysfs(struct platform_device *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_config);
+	device_remove_file(&pdev->dev, &dev_attr_loglevel);
+}
+
+static void tsklet_func_finish_req(unsigned long data)
+{
+	struct spmmc_host *host = (struct spmmc_host *)data;
+
+	spin_lock(&host->lock);
+	spmmc_finish_request(host, host->mrq);
+	spin_unlock(&host->lock);
+}
+
+static int spmmc_drv_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct mmc_host *mmc;
+	struct resource *resource;
+	struct spmmc_host *host;
+	unsigned int mode;
+
+	ret = spmmc_device_create_sysfs(pdev);
+	if (ret) {
+		return -ENODEV;
+		goto probe_free_host;
+	}
+
+	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
+	if (!mmc) {
+		ret = -ENOMEM;
+		goto probe_free_host;
+	}
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->power_state = MMC_POWER_OFF;
+	host->dma_int_threshold = 1024;
+	host->dmapio_mode = SPMMC_DMA_MODE;
+
+	host->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(host->clk)) {
+		spmmc_pr(ERROR, "Can not find clock source\n");
+		ret = PTR_ERR(host->clk);
+		goto probe_free_host;
+	}
+
+	host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(host->rstc)) {
+		spmmc_pr(ERROR, "Can not find reset controller\n");
+		ret = PTR_ERR(host->rstc);
+		goto probe_free_host;
+	}
+
+	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (IS_ERR(resource)) {
+		spmmc_pr(ERROR, "get sd register resource fail\n");
+		ret = PTR_ERR(resource);
+		goto probe_free_host;
+	}
+
+	if ((resource->end - resource->start + 1) < sizeof(*host->base)) {
+		spmmc_pr(ERROR, "register size is not right\n");
+		ret = -EINVAL;
+		goto probe_free_host;
+	}
+
+	host->base = devm_ioremap_resource(&pdev->dev, resource);
+	if (IS_ERR((void *)host->base)) {
+		spmmc_pr(ERROR, "devm_ioremap_resource fail\n");
+		ret = PTR_ERR((void *)host->base);
+		goto probe_free_host;
+	}
+
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
+		spmmc_pr(ERROR, "get sd irq resource fail\n");
+		ret = -EINVAL;
+		goto probe_free_host;
+	}
+	if (devm_request_irq(&pdev->dev, host->irq, spmmc_irq, IRQF_SHARED,
+		dev_name(&pdev->dev), host)) {
+		spmmc_pr(ERROR, "Failed to request sd card interrupt.\n");
+		ret = -ENOENT;
+		goto probe_free_host;
+	}
+	spmmc_pr(INFO, "spsdc driver probe, reg base:0x%p, irq:%d\n", host->base, host->irq);
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto probe_free_host;
+
+	ret = clk_prepare(host->clk);
+	if (ret)
+		goto probe_free_host;
+	ret = clk_enable(host->clk);
+	if (ret)
+		goto probe_clk_unprepare;
+
+	spin_lock_init(&host->lock);
+	mutex_init(&host->mrq_lock);
+	tasklet_init(&host->tsklet_finish_req, tsklet_func_finish_req, (unsigned long)host);
+	mmc->ops = &spmmc_ops;
+	mmc->f_min = SPMMC_MIN_CLK;
+	if (mmc->f_max > SPMMC_MAX_CLK) {
+		spmmc_pr(DEBUG, "max-frequency is too high, set it to %d\n", SPMMC_MAX_CLK);
+		mmc->f_max = SPMMC_MAX_CLK;
+	}
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->max_seg_size = SPMMC_MAX_BLK_COUNT * 512;
+	/* Host controller supports up to "SPMMC_MAX_DMA_MEMORY_SECTORS"*/
+	/* a.k.a. max scattered memory segments per request*/
+	mmc->max_segs = SPMMC_MAX_DMA_MEMORY_SECTORS;
+	mmc->max_req_size = SPMMC_MAX_BLK_COUNT * 512;
+	/* Limited by the max value of dma_size & data_length, set it to 512 bytes for now */
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = SPMMC_MAX_BLK_COUNT; /* Limited by sd_page_num */
+
+	dev_set_drvdata(&pdev->dev, host);
+	spmmc_controller_init(host);
+	mode = (int)of_device_get_match_data(&pdev->dev);
+	spmmc_select_mode(host, mode);
+	mmc_add_host(mmc);
+	host->tuning_info.enable_tuning = 1;
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+probe_clk_unprepare:
+	spmmc_pr(ERROR, "unable to enable controller clock\n");
+	clk_unprepare(host->clk);
+probe_free_host:
+	spmmc_device_remove_sysfs(pdev);
+	if (mmc)
+		mmc_free_host(mmc);
+
+	return ret;
+}
+
+static int spmmc_drv_remove(struct platform_device *dev)
+{
+	struct spmmc_host *host = platform_get_drvdata(dev);
+
+	mmc_remove_host(host->mmc);
+	clk_disable(host->clk);
+	clk_unprepare(host->clk);
+	pm_runtime_disable(&dev->dev);
+	platform_set_drvdata(dev, NULL);
+	mmc_free_host(host->mmc);
+	spmmc_device_remove_sysfs(dev);
+
+	return 0;
+}
+
+
+static int spmmc_drv_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct spmmc_host *host;
+
+	host = platform_get_drvdata(dev);
+	mutex_lock(&host->mrq_lock); /* Make sure that no one is holding the controller */
+	mutex_unlock(&host->mrq_lock);
+	clk_disable(host->clk);
+	return 0;
+}
+
+static int spmmc_drv_resume(struct platform_device *dev)
+{
+	struct spmmc_host *host;
+
+	host = platform_get_drvdata(dev);
+	return clk_enable(host->clk);
+}
+
+#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
+static int spmmc_pm_suspend(struct device *dev)
+{
+	pm_runtime_force_suspend(dev);
+	return 0;
+}
+
+static int spmmc_pm_resume(struct device *dev)
+{
+	pm_runtime_force_resume(dev);
+	return 0;
+}
+#endif /* ifdef CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM_RUNTIME
+static int spmmc_pm_runtime_suspend(struct device *dev)
+{
+	struct spmmc_host *host;
+
+	host = dev_get_drvdata(dev);
+	clk_disable(host->clk);
+	return 0;
+}
+
+static int spmmc_pm_runtime_resume(struct device *dev)
+{
+	struct spmmc_host *host;
+
+	host = dev_get_drvdata(dev);
+	return clk_enable(host->clk);
+}
+#endif /* ifdef CONFIG_PM_RUNTIME */
+
+static const struct dev_pm_ops spmmc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend, spmmc_pm_resume)
+#ifdef CONFIG_PM_RUNTIME
+	SET_RUNTIME_PM_OPS(spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL)
+#endif
+};
+#endif /* ifdef CONFIG_PM */
+
+static const struct of_device_id spmmc_of_table[] = {
+	{
+		.compatible = "sunplus,sp7021-emmc",
+		.data = (void *)SPMMC_MODE_EMMC,
+	},
+	{
+		.compatible = "sunplus,i143-emmc",
+		.data = (void *)SPMMC_MODE_EMMC,
+	},
+	{
+		.compatible = "sunplus,q645-emmc",
+		.data = (void *)SPMMC_MODE_EMMC,
+	},
+	{/* sentinel */}
+
+};
+MODULE_DEVICE_TABLE(of, spmmc_of_table);
+
+static struct platform_driver spmmc_driver = {
+	.probe = spmmc_drv_probe,
+	.remove = spmmc_drv_remove,
+	.suspend = spmmc_drv_suspend,
+	.resume = spmmc_drv_resume,
+	.driver = {
+		.name = "spmmc",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &spmmc_pm_ops,
+#endif
+		.of_match_table = spmmc_of_table,
+	},
+};
+module_platform_driver(spmmc_driver);
+
+MODULE_AUTHOR("Tony Huang <tony.huang@sunplus.com>");
+MODULE_DESCRIPTION("Sunplus MMC controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sunplus_mmc.h b/drivers/mmc/host/sunplus_mmc.h
new file mode 100644
index 0000000..d827679
--- /dev/null
+++ b/drivers/mmc/host/sunplus_mmc.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/**
+ * (C) Copyright 2019 Sunplus Technology. <http://www.sunplus.com/>
+ *
+ * Sunplus SD host controller v3.0
+ */
+#ifndef __SPMMC_H__
+#define __SPMMC_H__
+
+#include <linux/types.h>
+#include <linux/spinlock_types.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+
+/* #define SPMMC_SUPPORT_VOLTAGE_1V8 */
+/* #define SPMMC_EMMC_VCCQ_1V8 */
+#define SPMMC_MIN_CLK	400000
+#define SPMMC_MAX_CLK	52000000
+#define SPMMC_MAX_BLK_COUNT 65536
+#define SPMMC_MAX_TUNABLE_DLY 7
+#ifdef CONFIG_SOC_I143
+#define SPMMC_SYS_CLK	270000000
+#endif
+#ifdef CONFIG_SOC_Q645
+#define SPMMC_SYS_CLK	360000000
+#endif
+#define __rsvd_regs(l) __append_suffix(l, __COUNTER__)
+#define __append_suffix(l, s) _append_suffix(l, s)
+#define _append_suffix(l, s) (reserved##s[l])
+
+struct spmmc_regs {
+#define SPMMC_MEDIA_NONE 0
+#define SPMMC_MEDIA_SD 6
+#define SPMMC_MEDIA_MS 7
+	u32 card_mediatype_srcdst;
+	u32 card_cpu_page_cnt;
+	u32 sdram_sector_0_size;
+	u32 dma_base_addr;
+	u32 hw_dma_ctrl;
+	u32 card_gclk_disable;
+#define SPMMC_MAX_DMA_MEMORY_SECTORS 8 /* support up to 8 fragmented memory blocks */
+	u32 sdram_sector_1_addr;
+	u32 sdram_sector_1_size;
+	u32 sdram_sector_2_addr;
+	u32 sdram_sector_2_size;
+	u32 sdram_sector_3_addr;
+	u32 sdram_sector_3_size;
+	u32 sdram_sector_4_addr;
+	u32 sdram_sector_4_size;
+	u32 sdram_sector_5_addr;
+	u32 sdram_sector_5_size;
+	u32 sdram_sector_6_addr;
+	u32 sdram_sector_6_size;
+	u32 sdram_sector_7_addr;
+	u32 sdram_sector_7_size;
+	u32 sdram_sector_cnt;
+	u32 dma_hw_page_addr0;
+	u32 dma_hw_page_addr1;
+	u32 dma_hw_page_addr2;
+	u32 dma_hw_page_addr3;
+	u32 dma_hw_page_num0;
+	u32 dma_hw_page_num1;
+	u32 dma_hw_page_num2;
+	u32 dma_hw_page_num3;
+	u32 dma_hw_wait_num;
+	u32 dma_hw_delay_num;
+	u32 dma_debug;
+
+	u32 boot_ctrl;
+#define SPMMC_SWITCH_VOLTAGE_1V8_FINISH		1
+#define SPMMC_SWITCH_VOLTAGE_1V8_ERROR		2
+#define SPMMC_SWITCH_VOLTAGE_1V8_TIMEOUT	3
+	u32 sd_vol_ctrl;
+#define SPMMC_SDINT_SDCMPEN	BIT(0)
+#define SPMMC_SDINT_SDCMP	BIT(1)
+#define SPMMC_SDINT_SDIOEN	BIT(3)
+#define SPMMC_SDINT_SDIO	BIT(4)
+	u32 sd_int;
+	u32 sd_page_num;
+#define SPMMC_MODE_SDIO	2
+#define SPMMC_MODE_EMMC	1
+#define SPMMC_MODE_SD	0
+	u32 sd_config0;
+	u32 sdio_ctrl;
+	u32 sd_rst;
+	u32 sd_ctrl;
+#define SPMMC_SDSTATUS_DUMMY_READY			BIT(0)
+#define SPMMC_SDSTATUS_RSP_BUF_FULL			BIT(1)
+#define SPMMC_SDSTATUS_TX_DATA_BUF_EMPTY		BIT(2)
+#define SPMMC_SDSTATUS_RX_DATA_BUF_FULL			BIT(3)
+#define SPMMC_SDSTATUS_CMD_PIN_STATUS			BIT(4)
+#define SPMMC_SDSTATUS_DAT0_PIN_STATUS			BIT(5)
+#define SPMMC_SDSTATUS_RSP_TIMEOUT			BIT(6)
+#define SPMMC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT		BIT(7)
+#define SPMMC_SDSTATUS_STB_TIMEOUT			BIT(8)
+#define SPMMC_SDSTATUS_RSP_CRC7_ERROR			BIT(9)
+#define SPMMC_SDSTATUS_CRC_TOKEN_CHECK_ERROR		BIT(10)
+#define SPMMC_SDSTATUS_RDATA_CRC16_ERROR		BIT(11)
+#define SPMMC_SDSTATUS_SUSPEND_STATE_READY		BIT(12)
+#define SPMMC_SDSTATUS_BUSY_CYCLE			BIT(13)
+#define SPMMC_SDSTATUS_DAT1_PIN_STATUS			BIT(14)
+#define SPMMC_SDSTATUS_SD_SENSE_STATUS			BIT(15)
+#define SPMMC_SDSTATUS_BOOT_ACK_TIMEOUT			BIT(16)
+#define SPMMC_SDSTATUS_BOOT_DATA_TIMEOUT		BIT(17)
+#define SPMMC_SDSTATUS_BOOT_ACK_ERROR			BIT(18)
+	u32 sd_status;
+#define SPMMC_SDSTATE_IDLE	(0x0)
+#define SPMMC_SDSTATE_TXDUMMY	(0x1)
+#define SPMMC_SDSTATE_TXCMD	(0x2)
+#define SPMMC_SDSTATE_RXRSP	(0x3)
+#define SPMMC_SDSTATE_TXDATA	(0x4)
+#define SPMMC_SDSTATE_RXCRC	(0x5)
+#define SPMMC_SDSTATE_RXDATA	(0x6)
+#define SPMMC_SDSTATE_MASK	(0x7)
+#define SPMMC_SDSTATE_BADCRC	(0x5)
+#define SPMMC_SDSTATE_ERROR	BIT(13)
+#define SPMMC_SDSTATE_FINISH	BIT(14)
+	u32 sd_state;
+	u32 sd_hw_state;
+	u32 sd_blocksize;
+	u32 sd_config1;
+	u32 sd_timing_config0;
+	u32 sd_rx_data_tmr;
+	u32 sd_piodatatx;
+	u32 sd_piodatarx;
+	u32 sd_cmdbuf0_3;
+	u32 sd_cmdbuf4;
+	u32 sd_rspbuf0_3;
+	u32 sd_rspbuf4_5;
+
+	u32 __rsvd_regs(32);
+};
+
+struct spmmc_tuning_info {
+	int enable_tuning;
+	int need_tuning;
+#define SPMMC_MAX_RETRIES (8 * 8)
+	int retried; /* how many times has been retried */
+	u32 rd_crc_dly:3;
+	u32 rd_dat_dly:3;
+	u32 rd_rsp_dly:3;
+	u32 wr_cmd_dly:3;
+	u32 wr_dat_dly:3;
+	u32 clk_dly:3;
+};
+
+struct spmmc_host {
+	struct spmmc_regs *base;
+	struct clk *clk;
+	struct reset_control *rstc;
+	int mode; /* SD/SDIO/eMMC */
+	spinlock_t lock; /* controller lock */
+	struct mutex mrq_lock;
+	/* tasklet used to handle error then finish the request */
+	struct tasklet_struct tsklet_finish_req;
+	struct mmc_host *mmc;
+	struct mmc_request *mrq; /* current mrq */
+
+	int irq;
+	int use_int; /* should raise irq when done? */
+	int power_state; /* current power state: off/up/on */
+	int ddr_enabled;
+	int signal_voltage;
+
+#define SPMMC_DMA_MODE 0
+#define SPMMC_PIO_MODE 1
+	int dmapio_mode;
+	/* for purpose of reducing context switch, only when transfer data that*/
+	/* length is greater than `dma_int_threshold' should use interrupt */
+	int dma_int_threshold;
+	struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
+	int dma_use_int; /* should raise irq when dma done */
+	struct spmmc_tuning_info tuning_info;
+};
+
+#endif /* #ifndef __SPMMC_H__ */
-- 
2.7.4


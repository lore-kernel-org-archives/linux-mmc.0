Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC1C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 22:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578AF20787
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 22:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="DDhnzIdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOWWP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 18:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgEOWWP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 18:22:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E798C05BD09
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 15:22:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t25so3413959qtc.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZPj5RtVoBDyPcIcQQy/IwxNC3fWk1lZThfdaTJvTUA=;
        b=DDhnzIdQVnlM+fJ3ZiIDXYDW/R51fLF7ULYd4hfqUCXiYZf/nWq+vmgmg4WZ+ClBok
         ySIK1Su7RVM+AO9OzZhNKBLpF/omB0oDU1onaFnLFoj2+gc4nPj+qH32x5Gf44CIehV2
         rndeyP46Z8deVLaUz7MCxQGvOugW7mgA/nHhNrj468McGxUK0s91enbIlRKSWCTpcyts
         34ech2FzCFheaV/jqSv7mPyzdjzzFFfQpj5KmuNr/dOZhJNs5ND5e0d18vwuUfoGp3z+
         78/RBLhcuP8TTYZq9TqKGL7v5RG0oDkLmtP4UOODQs3wrZPeKRBSq+bFkj+wTxSD98nV
         wImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZPj5RtVoBDyPcIcQQy/IwxNC3fWk1lZThfdaTJvTUA=;
        b=goJ0LbMR9Xn5PDzaXkTJABCQKa5g8eZw7e2YQIbckXaQhDG/7nz1QDuEtfWCF0JcPQ
         7K58zmWYCxHh3WhOQDQEkLxJEr21F0dKqY6NKmjkN2YzCOOq+p4f2ydKnmYrk/xFMxOw
         gd/PC4HyHNya4PahKapK4oGdfD+T5ADEkbZ2G5M/zFomq7B0TsS25UNaQlrXHWQEOqYG
         wHGi51zvoeN2enC1aApbi1T6l6kerAYriq0PnsYfcQaby8569ZRxMLSOM+ToBoXRYZm3
         690N1flz90a2EI8hIFwiEMFEIXYrzMC6Kh/SFW01DN8K2/kAJUVO9O1VtPXDu56yLY3P
         1qpQ==
X-Gm-Message-State: AOAM533yr0Rtv0Q2Z4dGurgqvh/lx/JiPY2C/KyVKC3m3CYkkwp5rswa
        3AWwwDJiC1qhJG8kEJNx/poQJ9m6W3w=
X-Google-Smtp-Source: ABdhPJxd2cs1Pj5+MYZhvZ8DQcbzEgt+Y1IDvNBBPWqHxUCvUyE2joh2buAWOZwG70mNaFePnItTgw==
X-Received: by 2002:aed:2142:: with SMTP id 60mr4388370qtc.177.1589581334072;
        Fri, 15 May 2020 15:22:14 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host203-36-dynamic.30-79-r.retail.telecomitalia.it. [79.30.36.203])
        by smtp.gmail.com with ESMTPSA id h134sm2607072qke.6.2020.05.15.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 15:22:13 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        gerg@linux-m68k.org
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH v5 1/3] m68k: mcf5441x: add support for esdhc mmc controller
Date:   Sat, 16 May 2020 00:27:28 +0200
Message-Id: <20200515222730.967105-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support for sdhci-edshc mmc controller.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
Changes for v3:
- removed volatile cast from clk.c
Changes for v4:
- comment style fix in m5441xsim.h
Changes for v5:
- fix compilation warnings from __clk_enable2 and __clk_disable2
---
 arch/m68k/coldfire/clk.c                    | 15 ++++++++++
 arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
 arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
 arch/m68k/include/asm/m5441xsim.h           | 15 ++++++++++
 arch/m68k/include/asm/mcfclk.h              |  2 ++
 include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
 6 files changed, 91 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h

diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index 7bc666e482eb..75a057445472 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -73,6 +73,21 @@ struct clk_ops clk_ops1 = {
 #endif /* MCFPM_PPMCR1 */
 #endif /* MCFPM_PPMCR0 */
 
+static void __clk_enable2(struct clk *clk)
+{
+	__raw_writel(__raw_readl(MCFSDHC_CLK) | (1 << clk->slot), MCFSDHC_CLK);
+}
+
+static void __clk_disable2(struct clk *clk)
+{
+	__raw_writel(__raw_readl(MCFSDHC_CLK) & ~(1 << clk->slot), MCFSDHC_CLK);
+}
+
+struct clk_ops clk_ops2 = {
+	.enable		= __clk_enable2,
+	.disable	= __clk_disable2,
+};
+
 struct clk *clk_get(struct device *dev, const char *id)
 {
 	const char *clk_name = dev ? dev_name(dev) : id ? id : NULL;
diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
index b4103b6bfdeb..9ef4ec0aea00 100644
--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -22,6 +22,7 @@
 #include <asm/mcfqspi.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/dma-mcf-edma.h>
+#include <linux/platform_data/mmc-esdhc-mcf.h>
 
 /*
  *	All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
@@ -551,9 +552,35 @@ static struct platform_device mcf_edma = {
 		.platform_data = &mcf_edma_data,
 	}
 };
-
 #endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
 
+#if IS_ENABLED(CONFIG_MMC)
+static struct mcf_esdhc_platform_data mcf_esdhc_data = {
+	.max_bus_width = 4,
+	.cd_type = ESDHC_CD_NONE,
+};
+
+static struct resource mcf_esdhc_resources[] = {
+	{
+		.start = MCFSDHC_BASE,
+		.end = MCFSDHC_BASE + MCFSDHC_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = MCF_IRQ_SDHC,
+		.end = MCF_IRQ_SDHC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mcf_esdhc = {
+	.name			= "sdhci-esdhc-mcf",
+	.id			= 0,
+	.num_resources		= ARRAY_SIZE(mcf_esdhc_resources),
+	.resource		= mcf_esdhc_resources,
+	.dev.platform_data	= &mcf_esdhc_data,
+};
+#endif /* IS_ENABLED(CONFIG_MMC) */
+
 static struct platform_device *mcf_devices[] __initdata = {
 	&mcf_uart,
 #if IS_ENABLED(CONFIG_FEC)
@@ -586,6 +613,9 @@ static struct platform_device *mcf_devices[] __initdata = {
 #if IS_ENABLED(CONFIG_MCF_EDMA)
 	&mcf_edma,
 #endif
+#if IS_ENABLED(CONFIG_MMC)
+	&mcf_esdhc,
+#endif
 };
 
 /*
@@ -614,4 +644,3 @@ static int __init mcf_init_devices(void)
 }
 
 arch_initcall(mcf_init_devices);
-
diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 5bd24c9b865d..ffa02de1a3fb 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -52,7 +52,7 @@ DEFINE_CLK(0, "mcfssi.0", 47, MCF_CLK);
 DEFINE_CLK(0, "pll.0", 48, MCF_CLK);
 DEFINE_CLK(0, "mcfrng.0", 49, MCF_CLK);
 DEFINE_CLK(0, "mcfssi.1", 50, MCF_CLK);
-DEFINE_CLK(0, "mcfsdhc.0", 51, MCF_CLK);
+DEFINE_CLK(0, "sdhci-esdhc-mcf.0", 51, MCF_CLK);
 DEFINE_CLK(0, "enet-fec.0", 53, MCF_CLK);
 DEFINE_CLK(0, "enet-fec.1", 54, MCF_CLK);
 DEFINE_CLK(0, "switch.0", 55, MCF_CLK);
@@ -74,6 +74,10 @@ DEFINE_CLK(1, "mcfpwm.0", 34, MCF_BUSCLK);
 DEFINE_CLK(1, "sys.0", 36, MCF_BUSCLK);
 DEFINE_CLK(1, "gpio.0", 37, MCF_BUSCLK);
 
+DEFINE_CLK(2, "ipg.0", 0, MCF_CLK);
+DEFINE_CLK(2, "ahb.0", 1, MCF_CLK);
+DEFINE_CLK(2, "per.0", 2, MCF_CLK);
+
 struct clk *mcf_clks[] = {
 	&__clk_0_2,
 	&__clk_0_8,
@@ -131,6 +135,11 @@ struct clk *mcf_clks[] = {
 	&__clk_1_34,
 	&__clk_1_36,
 	&__clk_1_37,
+
+	&__clk_2_0,
+	&__clk_2_1,
+	&__clk_2_2,
+
 	NULL,
 };
 
@@ -151,6 +160,7 @@ static struct clk * const enable_clks[] __initconst = {
 	&__clk_0_33, /* pit.1 */
 	&__clk_0_37, /* eport */
 	&__clk_0_48, /* pll */
+	&__clk_0_51, /* esdhc */
 
 	&__clk_1_36, /* CCM/reset module/Power management */
 	&__clk_1_37, /* gpio */
diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index 4892f314ff38..e091e36d3464 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -278,6 +278,13 @@
 #define MCFGPIO_IRQ_VECBASE	(MCFINT_VECBASE - MCFGPIO_IRQ_MIN)
 #define MCFGPIO_PIN_MAX		87
 
+/*
+ * Phase Locked Loop (PLL)
+ */
+#define MCF_PLL_CR		0xFC0C0000
+#define MCF_PLL_DR		0xFC0C0004
+#define MCF_PLL_SR		0xFC0C0008
+
 /*
  *  DSPI module.
  */
@@ -298,5 +305,13 @@
 #define MCFEDMA_IRQ_INTR16	(MCFINT1_VECBASE + MCFEDMA_EDMA_INTR16)
 #define MCFEDMA_IRQ_INTR56	(MCFINT2_VECBASE + MCFEDMA_EDMA_INTR56)
 #define MCFEDMA_IRQ_ERR	(MCFINT0_VECBASE + MCFINT0_EDMA_ERR)
+/*
+ *  esdhc module.
+ */
+#define MCFSDHC_BASE		0xfc0cc000
+#define MCFSDHC_SIZE		256
+#define MCFINT2_SDHC		31
+#define MCF_IRQ_SDHC		(MCFINT2_VECBASE + MCFINT2_SDHC)
+#define MCFSDHC_CLK		(MCFSDHC_BASE + 0x2c)
 
 #endif /* m5441xsim_h */
diff --git a/arch/m68k/include/asm/mcfclk.h b/arch/m68k/include/asm/mcfclk.h
index 0aca504fae31..722627e06d66 100644
--- a/arch/m68k/include/asm/mcfclk.h
+++ b/arch/m68k/include/asm/mcfclk.h
@@ -30,6 +30,8 @@ extern struct clk_ops clk_ops0;
 extern struct clk_ops clk_ops1;
 #endif /* MCFPM_PPMCR1 */
 
+extern struct clk_ops clk_ops2;
+
 #define DEFINE_CLK(clk_bank, clk_name, clk_slot, clk_rate) \
 static struct clk __clk_##clk_bank##_##clk_slot = { \
 	.name = clk_name, \
diff --git a/include/linux/platform_data/mmc-esdhc-mcf.h b/include/linux/platform_data/mmc-esdhc-mcf.h
new file mode 100644
index 000000000000..85cb786a62fe
--- /dev/null
+++ b/include/linux/platform_data/mmc-esdhc-mcf.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
+#define __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
+
+enum cd_types {
+	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
+	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
+	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
+};
+
+struct mcf_esdhc_platform_data {
+	int max_bus_width;
+	int cd_type;
+};
+
+#endif /* __LINUX_PLATFORM_DATA_MCF_ESDHC_H__ */
-- 
2.26.2


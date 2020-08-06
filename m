Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B958C433E1
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B982221E3
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739044;
	bh=D1+9AmB8yaDm6+iMV1TG40QRlTP2+KI+dVoYAxhwdPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=opMRp5ODWmsW8mOGZJWKwPYggir0tYFTBpgreyA3EvzJffL2VBnR1wkr/DcVqE0SC
	 X8Ckrs3EgDpTKynU5t7lWFPPijQZqS7NDyZwbwolKgbd8hah98gOELkH/GTrXXVa+U
	 VtrPtArC2znvjKsJoPPJfhLYNqDEO+MNBcdLXCtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgHFShX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgHFSf7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E9122D0A;
        Thu,  6 Aug 2020 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738155;
        bh=D1+9AmB8yaDm6+iMV1TG40QRlTP2+KI+dVoYAxhwdPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZghzyiY7vh/WaG7QyfBJJNLyAJj4CZvSwPvbbLXKiTw1JWEv6YBCwyE+W9d262W4
         KQXW9RC5Lb0J6wPcDvm4PEx1PqOtYCLu1SyBz9d9WgNbHAX0/cVeO/jsdGdpsD1XJC
         jprsOp4IfKMewZ3GlB0OldO01mCjUp6dxJWf8TYM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 15/41] ARM: exynos: stop selecting PLAT_SAMSUNG
Date:   Thu,  6 Aug 2020 20:20:32 +0200
Message-Id: <20200806182059.2431-15-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Now that no code in arch/arm is shared between mach-exynos and the
others, make the split formal.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/Kconfig.debug        | 8 ++++----
 arch/arm/Makefile             | 1 -
 arch/arm/mach-exynos/Makefile | 4 ----
 arch/arm/plat-samsung/Kconfig | 4 ++--
 drivers/mmc/host/Kconfig      | 2 +-
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 7c34cf5c4a5b..153a9a35dd20 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1005,7 +1005,7 @@ choice
 		  via SCIFA4 on Renesas SH-Mobile AG5 (SH73A0).
 
 	config DEBUG_S3C_UART0
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1017,7 +1017,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART1
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1029,7 +1029,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART2
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1041,7 +1041,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART3
-		depends on PLAT_SAMSUNG && (ARCH_EXYNOS || ARCH_S5PV210)
+		depends on ARCH_EXYNOS || ARCH_S5PV210
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4e877354515f..826613a20b7d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -232,7 +232,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-plat-$(CONFIG_ARCH_EXYNOS)	+= samsung
 plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
 plat-$(CONFIG_ARCH_S5PV210)	+= samsung
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 0fd3fcf8bfb0..53fa363c8e44 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -3,10 +3,6 @@
 # Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
-
-# Core
-
 obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index c3d18b0aad75..920931c3fefd 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -4,7 +4,7 @@
 
 config PLAT_SAMSUNG
 	bool
-	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_EXYNOS || ARCH_S5PV210
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	default y
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
@@ -240,7 +240,7 @@ config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
 	depends on PM && DEBUG_KERNEL
 	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
-	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
+	depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
 	  Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9c89a5b780e8..ddce8e62280c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -289,7 +289,7 @@ config MMC_SDHCI_TEGRA
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && PLAT_SAMSUNG
+	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_EXYNOS)
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
-- 
2.17.1


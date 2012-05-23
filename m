From: <ludovic.desroches@atmel.com>
Subject: [PATCH v4 2/3] ARM: at91: add clocks for DT entries
Date: Wed, 23 May 2012 21:38:51 +0200
Message-ID: <1337801931-13823-1-git-send-email-ludovic.desroches@atmel.com>
References: <1337681352-18521-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:52655 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab2EWTjg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 May 2012 15:39:36 -0400
In-Reply-To: <1337681352-18521-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add clocks to clock lookup table for DT entries.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
v4: add new chips

 arch/arm/mach-at91/at91sam9260.c |    1 +
 arch/arm/mach-at91/at91sam9263.c |    2 ++
 arch/arm/mach-at91/at91sam9g45.c |    2 ++
 arch/arm/mach-at91/at91sam9n12.c |    1 +
 arch/arm/mach-at91/at91sam9x5.c  |    2 ++
 5 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 2b1e438..ddba004 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -226,6 +226,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t1_clk", "fffdc000.timer", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "fffdc000.timer", &tc5_clk),
 	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "fffa8000.mmc", &mmc_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 0eb20f9..f165b25 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -211,6 +211,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("hclk", "a00000.ohci", &ohci_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "fff80000.mmc", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "fff84000.mmc", &mmc1_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 4792682..aa24e82 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -242,6 +242,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
 	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "fff80000.mmc", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "fffd0000.mmc", &mmc1_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
index 0849466..cce4e0f 100644
--- a/arch/arm/mach-at91/at91sam9n12.c
+++ b/arch/arm/mach-at91/at91sam9n12.c
@@ -168,6 +168,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("usart", "f8028000.serial", &usart3_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "f8008000.timer", &tcb_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "f0008000.mmc", &mmc_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma_clk),
 	CLKDEV_CON_ID("pioA", &pioAB_clk),
 	CLKDEV_CON_ID("pioB", &pioAB_clk),
diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 1b144b4..de86e37 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -231,6 +231,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
 	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "f0008000.mmc", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "f000c000.mmc", &mmc1_clk),
 	CLKDEV_CON_ID("pioA", &pioAB_clk),
 	CLKDEV_CON_ID("pioB", &pioAB_clk),
 	CLKDEV_CON_ID("pioC", &pioCD_clk),
-- 
1.7.5.4


From: ludovic.desroches@atmel.com
Subject: [PATCH 2/4] arm: at91: at91sam9x5 add mci clk_lookup
Date: Wed, 21 Mar 2012 19:03:12 +0100
Message-ID: <1332352994-20983-3-git-send-email-ludovic.desroches@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:60312 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab2CUQEM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 12:04:12 -0400
In-Reply-To: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/at91sam9x5.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 13c8cae..39cbef3 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -225,6 +225,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
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


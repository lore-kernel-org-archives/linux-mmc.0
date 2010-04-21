From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 5/7] OMAP4-HSMMC: Adds Dummy Interface clock's for MMC
     controllers
Date: Wed, 21 Apr 2010 23:50:56 +0530 (IST)
Message-ID: <63593.10.24.255.18.1271874056.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33763 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132Ab0DUSVJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Apr 2010 14:21:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

This patch adds dummy Interface clocks for MMC controllers

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 1dd7dc8..6177a89 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2675,11 +2675,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap-mcspi.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcspi.3",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcspi.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.0",	"ick",			&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.4",	"ick",			&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.0",	"ick",		&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.1",	"ick",		&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.2",	"ick",		&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.3",	"ick",		&dummy_ck,	CK_443X),
+	CLK("mmci-omap-hs.4",	"ick",		&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
-- 
1.6.3.3


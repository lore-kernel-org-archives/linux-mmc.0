From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v2 4/5] OMAP4-HSMMC: Adds Dummy Interface clock's for MMC
     controllers
Date: Tue, 4 May 2010 21:31:45 +0530 (IST)
Message-ID: <35156.10.24.255.17.1272988905.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com
List-Id: linux-mmc@vger.kernel.org

This patch adds dummy Interface clocks for MMC controllers

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index a5c0c9c..0280422 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2675,6 +2675,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap2_mcspi.2",	"ick",			&dummy_ck,	CK_443X),
 	CLK("omap2_mcspi.3",	"ick",			&dummy_ck,	CK_443X),
 	CLK("omap2_mcspi.4",	"ick",			&dummy_ck,	CK_443X),
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


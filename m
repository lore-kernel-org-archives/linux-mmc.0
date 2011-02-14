From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 2/5] arm: mach-mmp: mmp2.c use revised APMU registers
 defines for APMU_CLK_OPS
Date: Sun, 13 Feb 2011 22:50:32 -0800
Message-ID: <3A0B1D79-FBC5-4952-94FE-AF91A87C8292@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:37877 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506Ab1BNGyH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 01:54:07 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

Subject: [PATCH 2/5] arm: mach-mmp: mmp2.c use revised APMU registers defines for APMU_CLK_OPS

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/mmp2.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 8e6c3ac..564bfbc 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -151,10 +151,10 @@ static APBC_CLK(twsi5, MMP2_TWSI5, 0, 26000000);
 static APBC_CLK(twsi6, MMP2_TWSI6, 0, 26000000);
 
 static APMU_CLK(nand, NAND, 0xbf, 100000000);
-static APMU_CLK_OPS(sdh0, SDH0, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh1, SDH1, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh2, SDH2, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh3, SDH3, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh0, MMP2_SDH0, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh1, MMP2_SDH1, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh2, MMP2_SDH2, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh3, MMP2_SDH3, 0x1b, 200000000, &sdhc_clk_ops);
 
 static struct clk_lookup mmp2_clkregs[] = {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
-- 
1.7.0.4



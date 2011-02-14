From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 2/2] mach-mmp: Support for SD/MMC clock adjustment in
 brownstone
Date: Sun, 13 Feb 2011 22:56:22 -0800
Message-ID: <9C2307EC-8314-40D5-A33B-38834F0F4698@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43526 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373Ab1BNHAV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:00:21 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>


Set timing for brownstone for SD/MMC cards to enable detection
timing adjustments are needed when speed > 25MHz
remove limitation on maximum speed of 25MHz

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 0e92fd7..35afe60 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -178,14 +178,22 @@ static struct i2c_board_info brownstone_twsi1_info[] = {
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
-	.max_speed	= 25000000,
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 31,
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 15,
 	.flags		= PXA_FLAG_CARD_PERMANENT,
 };
 
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
+	.adjust_clocks	= 1,
+	.clk_select	= 1,
+	.clk_delay	= 31,
 	.flags		= PXA_FLAG_CARD_PERMANENT |
 				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
 };
-- 
1.7.0.4



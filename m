From: <wei_wang@realsil.com.cn>
Subject: [PATCH v3 7/8] MFD:rtsx: Fix checkpatch warning
Date: Fri, 28 Dec 2012 10:41:52 +0800
Message-ID: <932361ec1ff3320031279bb60b3ec597c83a9638.1356662294.git.wei_wang@realsil.com.cn>
References: <cover.1356662293.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:47884 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2L1CmY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Dec 2012 21:42:24 -0500
In-Reply-To: <cover.1356662293.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>

From: Wei WANG <wei_wang@realsil.com.cn>

WARNING: Avoid CamelCase: <min_N>
+	u8 N, min_N, max_N, clk_divider;

WARNING: Avoid CamelCase: <max_N>
+	u8 N, min_N, max_N, clk_divider;

Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mfd/rtsx_pcr.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
index 958b738..7632e7f 100644
--- a/drivers/mfd/rtsx_pcr.c
+++ b/drivers/mfd/rtsx_pcr.c
@@ -590,7 +590,7 @@ int rtsx_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		u8 ssc_depth, bool initial_mode, bool double_clk, bool vpclk)
 {
 	int err, clk;
-	u8 N, min_N, max_N, clk_divider;
+	u8 n, min_n, max_n, clk_divider;
 	u8 mcu_cnt, div, max_div;
 	u8 depth[] = {
 		[RTSX_SSC_DEPTH_4M] = SSC_DEPTH_4M,
@@ -615,8 +615,8 @@ int rtsx_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 	card_clock /= 1000000;
 	dev_dbg(&(pcr->pci->dev), "Switch card clock to %dMHz\n", card_clock);
 
-	min_N = 80;
-	max_N = 208;
+	min_n = 80;
+	max_n = 208;
 	max_div = CLK_DIV_8;
 
 	clk = card_clock;
@@ -630,30 +630,30 @@ int rtsx_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		return 0;
 
 	if (pcr->ops->conv_clk_and_div_n)
-		N = (u8)pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
+		n = (u8)pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
 	else
-		N = (u8)(clk - 2);
-	if ((clk <= 2) || (N > max_N))
+		n = (u8)(clk - 2);
+	if ((clk <= 2) || (n > max_n))
 		return -EINVAL;
 
 	mcu_cnt = (u8)(125/clk + 3);
 	if (mcu_cnt > 15)
 		mcu_cnt = 15;
 
-	/* Make sure that the SSC clock div_n is equal or greater than min_N */
+	/* Make sure that the SSC clock div_n is equal or greater than min_n */
 	div = CLK_DIV_1;
-	while ((N < min_N) && (div < max_div)) {
+	while ((n < min_n) && (div < max_div)) {
 		if (pcr->ops->conv_clk_and_div_n) {
-			int dbl_clk = pcr->ops->conv_clk_and_div_n(N,
+			int dbl_clk = pcr->ops->conv_clk_and_div_n(n,
 					DIV_N_TO_CLK) * 2;
-			N = (u8)pcr->ops->conv_clk_and_div_n(dbl_clk,
+			n = (u8)pcr->ops->conv_clk_and_div_n(dbl_clk,
 					CLK_TO_DIV_N);
 		} else {
-			N = (N + 2) * 2 - 2;
+			n = (n + 2) * 2 - 2;
 		}
 		div++;
 	}
-	dev_dbg(&(pcr->pci->dev), "N = %d, div = %d\n", N, div);
+	dev_dbg(&(pcr->pci->dev), "N = %d, div = %d\n", n, div);
 
 	ssc_depth = depth[ssc_depth];
 	if (double_clk)
@@ -670,7 +670,7 @@ int rtsx_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL1, SSC_RSTB, 0);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL2,
 			SSC_DEPTH_MASK, ssc_depth);
-	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_DIV_N_0, 0xFF, N);
+	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_DIV_N_0, 0xFF, n);
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SSC_CTL1, SSC_RSTB, SSC_RSTB);
 	if (vpclk) {
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_VPCLK0_CTL,
-- 
1.7.9.5


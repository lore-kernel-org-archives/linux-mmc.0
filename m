From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 08/13] mmc: mmci: add edge support to data and command out in variant data.
Date: Wed, 28 May 2014 14:47:12 +0100
Message-ID: <1401284832-16769-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1401284608-16428-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54205 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbaE1NrU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 09:47:20 -0400
Received: by mail-we0-f174.google.com with SMTP id k48so11551001wev.33
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2014 06:47:19 -0700 (PDT)
In-Reply-To: <1401284608-16428-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds edge support for data and command out to variant structure
giving more flexibility to the driver to support more SOCs which have
different clock register layout.

Without this patch other new SOCs like Qcom will have to add more code to
special case them

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2f4cdf3..8deea4a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -53,6 +53,7 @@ static unsigned int fmax = 515633;
  * @clkreg: default value for MCICLOCK register
  * @clkreg_enable: enable value for MMCICLOCK register
  * @clkreg_8bit_bus_enable: enable value for 8 bit bus
+ * @clkreg_neg_edge_enable: enable value for inverted data/cmd output
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -74,6 +75,7 @@ struct variant_data {
 	unsigned int		clkreg;
 	unsigned int		clkreg_enable;
 	unsigned int		clkreg_8bit_bus_enable;
+	unsigned int		clkreg_neg_edge_enable;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
@@ -143,6 +145,7 @@ static struct variant_data variant_ux500 = {
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
+	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
 	.datalength_bits	= 24,
 	.sdio			= true,
 	.st_clkdiv		= true,
@@ -159,6 +162,7 @@ static struct variant_data variant_ux500v2 = {
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= MCI_ST_UX500_HWFCEN,
 	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
+	.clkreg_neg_edge_enable	= MCI_ST_UX500_NEG_EDGE,
 	.datactrl_mask_ddrmode	= MCI_ST_DPSM_DDRMODE,
 	.datalength_bits	= 24,
 	.sdio			= true,
@@ -322,7 +326,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 		clk |= variant->clkreg_8bit_bus_enable;
 
 	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
-		clk |= MCI_ST_UX500_NEG_EDGE;
+		clk |= variant->clkreg_neg_edge_enable;
 
 	mmci_write_clkreg(host, clk);
 }
-- 
1.9.1


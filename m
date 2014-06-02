From: srinivas.kandagatla@linaro.org
Subject: [PATCH v6 08/12] mmc: mmci: Add support to data commands via variant structure.
Date: Mon,  2 Jun 2014 10:09:39 +0100
Message-ID: <1401700179-11752-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:49689 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbaFBJJo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jun 2014 05:09:44 -0400
Received: by mail-wi0-f182.google.com with SMTP id r20so4201130wiv.9
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jun 2014 02:09:43 -0700 (PDT)
In-Reply-To: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On some SOCs like Qcom there are explicit bits in the command register
to specify if its a data transfer command or not. So this patch adds
support to such bits in variant data, giving more flexibility to the
driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4c95a9b..8534c29 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -59,6 +59,7 @@ static unsigned int fmax = 515633;
  *	      is asserted (likewise for RX)
  * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
  *		  is asserted (likewise for RX)
+ * @data_cmd_enable: enable value for data commands.
  * @sdio: variant supports SDIO
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
@@ -79,6 +80,7 @@ struct variant_data {
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
+	unsigned int		data_cmd_enable;
 	unsigned int		datactrl_mask_ddrmode;
 	bool			sdio;
 	bool			st_clkdiv;
@@ -839,6 +841,9 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 	if (/*interrupt*/0)
 		c |= MCI_CPSM_INTERRUPT;
 
+	if (mmc_cmd_type(cmd) == MMC_CMD_ADTC)
+		c |= host->variant->data_cmd_enable;
+
 	host->cmd = cmd;
 
 	writel(cmd->arg, base + MMCIARGUMENT);
-- 
1.9.1


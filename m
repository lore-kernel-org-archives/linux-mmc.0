From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 8/8] mmc: mmci: Support any block sizes for ux500v2 variant
Date: Tue, 17 Jan 2012 15:34:27 +0100
Message-ID: <1326810867-5346-9-git-send-email-ulf.hansson@stericsson.com>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:49630 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754199Ab2AQOfH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2012 09:35:07 -0500
In-Reply-To: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

For the ux500v2 variant of the PL18x block, any block sizes are
supported. This will make it possible to decrease data overhead
for SDIO transfers.

This patch is based upon a patch from Stefan Nilsson.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 94c04c3..1c6c874 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -57,6 +57,7 @@ static unsigned int fmax = 515633;
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_ctrl_power: bits in MMCIPOWER register controls ext. power supply
+ * @any_blksize: true if block any sizes are supported
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -71,6 +72,7 @@ struct variant_data {
 	u32			pwrreg_powerup;
 	bool			signal_direction;
 	bool			pwrreg_ctrl_power;
+	bool			any_blksize;
 };
 
 static struct variant_data variant_arm = {
@@ -124,6 +126,7 @@ static struct variant_data variant_ux500v2 = {
 	.blksz_datactrl16	= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
+	.any_blksize		= true,
 };
 
 /*
@@ -132,10 +135,12 @@ static struct variant_data variant_ux500v2 = {
 static int mmci_validate_data(struct mmci_host *host,
 			      struct mmc_data *data)
 {
+	struct variant_data *variant = host->variant;
+
 	if (!data)
 		return 0;
 
-	if (!is_power_of_2(data->blksz)) {
+	if (!is_power_of_2(data->blksz) && !variant->any_blksize) {
 		dev_err(mmc_dev(host->mmc),
 			"unsupported block size (%d bytes)\n", data->blksz);
 		return -EINVAL;
@@ -669,7 +674,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	writel(host->size, base + MMCIDATALENGTH);
 
 	blksz_bits = ffs(data->blksz) - 1;
-	BUG_ON(1 << blksz_bits != data->blksz);
 
 	if (variant->blksz_datactrl16)
 		datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
-- 
1.7.5.4


From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] mmc: mmci: support 8bit mode on the Nomadik
Date: Mon,  4 Jan 2016 02:22:08 +0100
Message-ID: <1451870528-21095-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34866 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbcADBWO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jan 2016 20:22:14 -0500
Received: by mail-lf0-f43.google.com with SMTP id c192so91141858lfe.2
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jan 2016 17:22:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

The Nomadik variant supports 8bit mode for (e)MMC cards.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index acece3299756..0d6ca4116f3d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -151,6 +151,7 @@ static struct variant_data variant_nomadik = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
+	.clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
 	.datalength_bits	= 24,
 	.datactrl_mask_sdio	= MCI_ST_DPSM_SDIOEN,
 	.st_sdio		= true,
-- 
2.4.3


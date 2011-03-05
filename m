From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] mmc: reset card voltage after power off
Date: Sat, 5 Mar 2011 14:36:24 +0100
Message-ID: <1299332184-13803-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:34180 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750982Ab1CEOBL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Mar 2011 09:01:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Ulf Hansson <ulf.hansson@stericsson.com>

At power off, reset OCR mask to be the highest possible voltage
supported for the current mmc host.

This solves the re-initialization during the power up sequence.
The voltage may have been decreased due to the card accepts a lower
voltage than the voltage used during the initialization sequence.
We need to reset the voltage to by the host highest possible value
since according to specification the initialization must always be
done at high voltage.

Reviewed-by: Jonas Aberg <jonas.aberg@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2521794..b9d39ec 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1002,6 +1002,13 @@ static void mmc_power_off(struct mmc_host *host)
 {
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
+
+	/*
+	 * Reset ocr mask to be the highest possible voltage supported for
+	 * this mmc host. This value will be used at next power up.
+	 */
+	host->ocr = 1 << (fls(host->ocr_avail) - 1);
+
 	if (!mmc_host_is_spi(host)) {
 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
 		host->ios.chip_select = MMC_CS_DONTCARE;
-- 
1.7.3.2


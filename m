From: "Torne (Richard Coles)" <torne@google.com>
Subject: [PATCH] MMC: core: cap MMC card timeouts at 2 seconds.
Date: Mon, 14 May 2012 16:51:28 +0100
Message-ID: <1337010688-30459-1-git-send-email-torne@google.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:43975 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab2ENPwL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 11:52:11 -0400
Received: by eeit10 with SMTP id t10so265255eei.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 08:52:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linus.walleij@linaro.org, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Torne (Richard Coles)" <torne@google.com>

From: "Torne (Richard Coles)" <torne@google.com>

MMC CSD info can specify very large, ridiculous timeouts, big enough to
overflow timeout_ns on 32-bit machines. This can result in the card
timing out on every operation because the wrapped timeout value is far
too small.

Fix the overflow by calculating the timeout in microseconds first and
capping the result at 2 seconds.  Cards specifying longer timeouts are
almost certainly insane, and host controllers generally cannot support
timeouts that long in any case.

2 seconds should be plenty of time for any card to actually function;
the timeout calculation code is already using 1 second as a "worst case"
timeout for cards running in SPI mode.

Signed-off-by: Torne (Richard Coles) <torne@google.com>
---
 drivers/mmc/core/core.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ba821fe..368452e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -488,7 +488,7 @@ EXPORT_SYMBOL(mmc_wait_for_cmd);
  */
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 {
-	unsigned int mult;
+	unsigned int mult, timeout_us;
 
 	/*
 	 * SDIO cards only define an upper 1 s limit on access.
@@ -511,16 +511,26 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 	if (data->flags & MMC_DATA_WRITE)
 		mult <<= card->csd.r2w_factor;
 
-	data->timeout_ns = card->csd.tacc_ns * mult;
+	/*
+	 * The timeout in nanoseconds may overflow, so calculate it in
+	 * microseconds first. Cap it at two seconds both to avoid the overflow
+	 * and also because host controllers cannot generally generate timeouts
+	 * that long anyway.
+	 */
+	timeout_us = (card->csd.tacc_ns / 1000) * mult;
+	if (timeout_us < 2000000)
+		data->timeout_ns = card->csd.tacc_ns * mult;
+	else
+		data->timeout_ns = 2000000000;
+
 	data->timeout_clks = card->csd.tacc_clks * mult;
 
 	/*
 	 * SD cards also have an upper limit on the timeout.
 	 */
 	if (mmc_card_sd(card)) {
-		unsigned int timeout_us, limit_us;
+		unsigned int limit_us;
 
-		timeout_us = data->timeout_ns / 1000;
 		if (mmc_host_clk_rate(card->host))
 			timeout_us += data->timeout_clks * 1000 /
 				(mmc_host_clk_rate(card->host) / 1000);
-- 
1.7.7.3


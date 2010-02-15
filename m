From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] tmio_mmc: use 100ms mmc_detect_change() delay
Date: Mon, 15 Feb 2010 21:12:29 +0900
Message-ID: <20100215121229.23116.16376.sendpatchset@t400s>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f200.google.com ([209.85.210.200]:49124 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab0BOMMt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2010 07:12:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch changes the tmio_mmc driver to wait 100ms
before checking the card detect status. This type of
delay is quite common among mmc drivers, it seems that
most hardware platforms need to give the hardware some
time to settle before checking card availabilty.

Hotplug is half-broken without this patch on the sh7724
Ecovec board. Hot plugging seems ok but eject is never
detected without this patch.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/tmio_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/mmc/host/tmio_mmc.c
+++ work/drivers/mmc/host/tmio_mmc.c	2010-02-15 20:28:15.000000000 +0900
@@ -323,7 +323,7 @@ static irqreturn_t tmio_mmc_irq(int irq,
 		if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
 			ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
 				TMIO_STAT_CARD_REMOVE);
-			mmc_detect_change(host->mmc, 0);
+			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
 		}
 
 		/* CRC and other errors */

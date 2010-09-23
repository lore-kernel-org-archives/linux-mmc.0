From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 2/2] tmio_mmc: fix CMD irq handling
Date: Thu, 23 Sep 2010 15:33:54 +0200
Message-ID: <1285248834-4434-2-git-send-email-arnd@arndnet.de>
References: <1285248834-4434-1-git-send-email-arnd@arndnet.de>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:58396 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752160Ab0IWNd6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 09:33:58 -0400
In-reply-to: <1285248834-4434-1-git-send-email-arnd@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ian Molton <spyro@f2s.com>, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>

With current code card insert/eject interrupts will acknowledge outstanding
commands. Normally this seems to be no problem, however if the hardware gets
stuck and no interrupts for CMD_TIMEOUT or CMD_RESPEND are generated, then
inserting and ejecting cards will falsely acknowledge outstanding commands from
the core.

This patch changes the behavior so that CMDs are only acked, if
CMD_TIMEOUT or CMD_RESPEND is received.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/host/tmio_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index cb66af5..75a0aca 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -430,8 +430,10 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
  */
 
 		/* Command completion */
-		if (ireg & TMIO_MASK_CMD) {
-			ack_mmc_irqs(host, TMIO_MASK_CMD);
+		if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
+			ack_mmc_irqs(host,
+				     TMIO_STAT_CMDRESPEND |
+				     TMIO_STAT_CMDTIMEOUT);
 			tmio_mmc_cmd_irq(host, status);
 		}
 
-- 
1.7.0.4


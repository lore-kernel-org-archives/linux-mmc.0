From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] mmc: dw_mmc: print card frequency in debug level
Date: Wed, 30 Apr 2014 15:44:44 +0200
Message-ID: <1398865484-527-2-git-send-email-bigeasy@linutronix.de>
References: <1398865484-527-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51466 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbaD3NpD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 09:45:03 -0400
In-Reply-To: <1398865484-527-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Printing this at info level can be very noisy the CD is not working and
we poll for the card.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 82f5ea2..b8afc70 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -800,7 +800,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
 
 		if ((clock << div) != slot->__clk_old || force_clkinit)
-			dev_info(&slot->mmc->class_dev,
+			dev_dbg(&slot->mmc->class_dev,
 				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
 				 slot->id, host->bus_hz, clock,
 				 div ? ((host->bus_hz / div) >> 1) :
-- 
1.9.2


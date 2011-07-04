From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: mmc: dw_mmc: Add the function call for board-specific initialization.
Date: Mon,  4 Jul 2011 16:07:59 +0900
Message-ID: <1309763279-29862-1-git-send-email-tgih.jun@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:56077 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab1GDHja (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 03:39:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

Need to call init() function of dw_mci_board.
It seems to be omitted to call this function.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a524416..688d58a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1585,6 +1585,15 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 	}
 }

+static irqreturn_t dw_mci_detect_interrupt(int irq, void *dev_id)
+{
+	struct dw_mci_slot *slot = dev_id;
+
+	queue_work(dw_mci_card_workqueue, &slot->host->card_work);
+
+	return IRQ_HANDLED;
+}
+
 static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
@@ -1657,6 +1666,8 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	} else
 		regulator_enable(host->vmmc);

+	host->pdata->init(id, dw_mci_detect_interrupt, host);
+
 	if (dw_mci_get_cd(mmc))
 		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 	else
--
1.7.0.4


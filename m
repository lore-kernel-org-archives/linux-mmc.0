From: "Madhusudhan" <madhu.cr@ti.com>
Subject: MMC card removal in suspend state
Date: Thu, 5 Aug 2010 16:45:28 -0500
Message-ID: <621C9491683D48E5992B340E62198CD6@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33851 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979Ab0HEVpe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 17:45:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, 'Pierre Ossman' <pierre@ossman.eu>

Hi,

Recently, while looking at some stuff I saw the below patch done by Pierre
which is part of the drivers/mmc/card/queue.c file. I wonder if someone can
through more light on this to understand where could be a potential deadlock
without calling mmc_queue_resume.

Is there a need for the mmc queue to be resumed before calling
del_gendisk(md->disk) in the card removal path??

Regards,
Madhu

commit d2b46f66b4b342be07a4194bd5e82384d07e470d
Author: Pierre Ossman <drzeus@drzeus.cx>
Date:   Sat Apr 28 16:52:12 2007 +0200

    mmc: allow suspended block driver to be removed

    Make sure we don't deadlock when removing a suspended block
    queue, something that might happen if the card is removed during
    suspend.

    Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index aa75ac1..2e77963 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -191,6 +191,9 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
        q->queuedata = NULL;
        spin_unlock_irqrestore(q->queue_lock, flags);

+       /* Make sure the queue isn't suspended, as that will deadlock */
+       mmc_queue_resume(mq);
+
        /* Then terminate our worker thread */
        kthread_stop(mq->thread);


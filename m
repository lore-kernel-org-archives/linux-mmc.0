From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: vub300: Remove bogus check of irqs_queued
Date: Wed, 11 Jan 2017 12:14:49 +0800
Message-ID: <1484108089-5454-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:38790 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934079AbdAKEQS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 23:16:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

It's unnecessary to check the irqs_queued value as
it always needs to queue one if irq isn't enabled.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/vub300.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index bb3e0d1..21ea776 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -640,8 +640,6 @@ static void __vub300_irqpoll_response(struct vub300_mmc_host *vub300)
 		mutex_lock(&vub300->irq_mutex);
 		if (vub300->irq_enabled)
 			mmc_signal_sdio_irq(vub300->mmc);
-		else if (vub300->irqs_queued)
-			vub300->irqs_queued += 1;
 		else
 			vub300->irqs_queued += 1;
 		vub300->irq_disabled = 0;
-- 
1.9.1



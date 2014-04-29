From: Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH v2] mmc: jz4740: don't wait for PRG_DONE after stop command with R1 response
Date: Tue, 29 Apr 2014 13:54:54 +0100
Message-ID: <1398776094-51282-1-git-send-email-alex.smith@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.89.28.114]:60113 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbaD2MzF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Apr 2014 08:55:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Alex Smith <alex.smith@imgtec.com>, Lars-Peter Clausen <lars@metafoo.de>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, James Hogan <james.hogan@imgtec.com>

As of commit bcc3e1726d ("mmc: block: Use R1 responses for stop cmds for
read requests"), stop commands for reads do not have MMC_RSP_BUSY set.
In this case we should not wait for a PRG_DONE IRQ after sending the
stop command: it will not get raised when the busy flag is not set,
causing the request to fail with a timeout.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>
Cc: James Hogan <james.hogan@imgtec.com>
---
Changes in v2:
 - Fix checkpatch errors
---
 drivers/mmc/host/jz4740_mmc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index de2139c..537d6c7 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -515,10 +515,13 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 
 		jz4740_mmc_send_command(host, req->stop);
 
-		timeout = jz4740_mmc_poll_irq(host, JZ_MMC_IRQ_PRG_DONE);
-		if (timeout) {
-			host->state = JZ4740_MMC_STATE_DONE;
-			break;
+		if (mmc_resp_type(req->stop) & MMC_RSP_BUSY) {
+			timeout = jz4740_mmc_poll_irq(host,
+						      JZ_MMC_IRQ_PRG_DONE);
+			if (timeout) {
+				host->state = JZ4740_MMC_STATE_DONE;
+				break;
+			}
 		}
 	case JZ4740_MMC_STATE_DONE:
 		break;
-- 
1.9.2


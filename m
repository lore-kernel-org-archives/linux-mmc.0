From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 1/2] sdhci : handle busy timeout irq
Date: Thu, 14 Aug 2014 16:03:17 +0200
Message-ID: <1408024998-4097-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:60509 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbaHNODJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Aug 2014 10:03:09 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so1120775wgh.26
        for <linux-mmc@vger.kernel.org>; Thu, 14 Aug 2014 07:03:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Matthieu CASTET <matthieu.castet@parrot.com>

When we wait for busy after sending a command, if there is
a timeout, we got SDHCI_INT_DATA_TIMEOUT flags.
Before this commit we got the message :
"Got data interrupt 0x00100000 even though no data  operation was in progress."
and we need to wait 10s that sdhci_timeout_timer expires.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 drivers/mmc/host/sdhci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..9df59a4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2301,6 +2301,11 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * above in sdhci_cmd_irq().
 		 */
 		if (host->cmd && (host->cmd->flags & MMC_RSP_BUSY)) {
+			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
+				host->cmd->error = -ETIMEDOUT;
+				tasklet_schedule(&host->finish_tasklet);
+				return;
+			}
 			if (intmask & SDHCI_INT_DATA_END) {
 				sdhci_finish_command(host);
 				return;
-- 
2.1.0.rc1


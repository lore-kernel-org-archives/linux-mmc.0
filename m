From: Neal Buckendahl <nealb001@gmail.com>
Subject: [PATCH] mmc: host: sdhci: prevent mmcqd from becoming locked on mmc timeout
Date: Thu, 14 Nov 2013 08:36:15 -0800
Message-ID: <1384446975-2574-1-git-send-email-nealb001@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:49089 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab3KNQge (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2013 11:36:34 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nealb001@gmail.com, cjb@laptop.org, narayan.1979@gmail.com, prakity@nvidia.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

fixed a condition where device issues a status cmd to sdcard but no response
comes from sdcard. The sdhci irq fires and we hit a timeout case which calls
sdhci_finish_data(). sdhci_finish_data eventually attempt to reset controller
and issues stop cmd. However mmcdq is wait_for_completion(&mrq->completion)
in function mmc_wait_for_req_done which never occurs.

Signed-off-by: Neal Buckendahl <nealb001@gmail.com>
Signed-off-by: Narayanan Gopalakrishnan <narayan.1979@gmail.com>
Signed-off-by: Philip Rakity <prakity@nvidia.com>
---
 drivers/mmc/host/sdhci.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6785fb1..2a703f0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -973,6 +973,10 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		if (data->error) {
 			sdhci_reset(host, SDHCI_RESET_CMD);
 			sdhci_reset(host, SDHCI_RESET_DATA);
+			if (data->error == -ETIMEDOUT) {
+				host->mrq->cmd->error = -ETIMEDOUT;
+				tasklet_schedule(&host->finish_tasklet);
+			}
 		}
 
 		sdhci_send_command(host, data->stop);
-- 
1.7.10.4


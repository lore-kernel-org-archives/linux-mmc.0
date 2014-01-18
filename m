From: Philip Rakity <prakity@nvidia.com>
Subject: https://lkml.org/lkml/2013/11/13/574  (Ping !)
Date: Sat, 18 Jan 2014 14:37:47 +0100
Message-ID: <93E165F0-A8B9-4EF2-94B6-B9C913F9CE09@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2302 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbaARNhu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Jan 2014 08:37:50 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Hi Chris,

Hi Chris,

Could we progress this patch ?

Fixes a loop that never terminates if the SD card is bad in just the right way.

Philip


From	Neal Buckendahl <>
Subject	[PATCH] mmc: host: sdhci: prevent mmcqd from becoming locked on mmc timeout
Date	Wed, 13 Nov 2013 20:22:54 -0800

fixed a condition where device issues a status cmd to sdcard but no response
comes from sdcard. The sdhci irq fires and we hit a timeout case which calls
sdhci_finish_data(). sdhci_finish_data eventually attempt to reset controller
and issues stop cmd. However mmcdq is wait_for_completion(&mrq->completion)
in function mmc_wait_for_req_done which never occurs.

Signed-off-by: Neal Buckendahl <nealb001@gmail.com>
Signed-off-by: Narayanan Gopalakrishnan <narayan.1979@gmail.com>
Signed-off-by: Philip Rakity <prakity@nvidia.com>
---
 drivers/mmc/host/sdhci.c |    5 +++++
 1 file changed, 5 insertions(+)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6785fb1..21620d2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -973,6 +973,11 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		if (data->error) {
 			sdhci_reset(host, SDHCI_RESET_CMD);
 			sdhci_reset(host, SDHCI_RESET_DATA);
+			if (data->error == -ETIMEDOUT) {
+				host->mrq->cmd->error = -ETIMEDOUT;
+				tasklet_schedule(&host->finish_tasklet);
+				WARN_ON(1);
+			}
 		}
 
 		sdhci_send_command(host, data->stop);
-- 
1.7.10.4
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH 2/5] mmc: sdhci: fix error conditions for controller reset
Date: Wed, 1 Oct 2014 07:14:08 -0500
Message-ID: <1412165651-2652-3-git-send-email-andrew_gabbasov@mentor.com>
References: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62099 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAMPB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 08:15:01 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1XZIo9-0001wC-B0 from Andrew_Gabbasov@mentor.com
	for linux-mmc@vger.kernel.org; Wed, 01 Oct 2014 05:15:01 -0700
In-Reply-To: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Add the case of SET_BLOCK_COUNT command error to the error conditions
check for making a controller reset at request handling finish.
Otherwise, if the SET_BLOCK_COUNT command failed, e.g. with a timeout,
the controller state was not reset, and the next command failed too.

In the case of data error the controller reset is already done in
finish_data() function before sending stop command (if present),
so the finish tasklet should make a reset after data error only
if no stop command existed in the request.

Also, fix the indentation of this condition check to make it more logical.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 drivers/mmc/host/sdhci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0272021..46e84a0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2122,9 +2122,10 @@ static void sdhci_tasklet_finish(unsigned long param)
 	 */
 	if (!(host->flags & SDHCI_DEVICE_DEAD) &&
 	    ((mrq->cmd && mrq->cmd->error) ||
-		 (mrq->data && (mrq->data->error ||
-		  (mrq->data->stop && mrq->data->stop->error))) ||
-		   (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
+	     (mrq->sbc && mrq->sbc->error) ||
+	     (mrq->data && ((mrq->data->error && !mrq->data->stop) ||
+			    (mrq->data->stop && mrq->data->stop->error))) ||
+	     (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
 
 		/* Some controllers need this kick or reset won't work here */
 		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
-- 
2.1.0


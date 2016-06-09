From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 19/46] mmc: sdhci: Do not reset cmd or data circuits that are in use
Date: Thu,  9 Jun 2016 14:52:19 +0300
Message-ID: <1465473166-22532-20-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbcFIL6F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:58:05 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

In order to support commands during data transfer, it will be possible to
need to reset the command circuit while the data circuit is in use, and
vice versa. It is now easy to determine whether the command or data circuit
is in use, and so just skip the corresponding reset if it is.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 690bffa24e93..e9eb71861764 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1022,7 +1022,8 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		 * upon error conditions.
 		 */
 		if (data->error) {
-			sdhci_do_reset(host, SDHCI_RESET_CMD);
+			if (!host->cmd)
+				sdhci_do_reset(host, SDHCI_RESET_CMD);
 			sdhci_do_reset(host, SDHCI_RESET_DATA);
 		}
 
@@ -2299,8 +2300,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 		/* Spec says we should do both at the same time, but Ricoh
 		   controllers do not like that. */
-		sdhci_do_reset(host, SDHCI_RESET_CMD);
-		sdhci_do_reset(host, SDHCI_RESET_DATA);
+		if (!host->cmd)
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+		if (!host->data_cmd)
+			sdhci_do_reset(host, SDHCI_RESET_DATA);
 
 		host->pending_reset = false;
 	}
-- 
1.9.1


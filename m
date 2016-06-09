From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 20/46] mmc: sdhci: Support cap_cmd_during_tfr requests
Date: Thu,  9 Jun 2016 14:52:20 +0300
Message-ID: <1465473166-22532-21-git-send-email-adrian.hunter@intel.com>
References: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbcFIL6J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 07:58:09 -0400
In-Reply-To: <1465473166-22532-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>

Now SDHCI supports commands during transfer, enable support for the core
API.

There are 3 small changes needed:

First, auto-CMD12 cannot be used with a cap_cmd_during_tfr request because
the host controller cannot expect the command line to be available.

Secondly, a cap_cmd_during_tfr request must not send a stop command, again
because the host controller cannot expect the command line to be available.

Thirdly, when a cap_cmd_during_tfr command completes, use
mmc_command_complete() to notify the upper layers that the command line is
now available for further commands.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9eb71861764..aa2aa16386b9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -884,7 +884,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 				    struct mmc_request *mrq)
 {
-	return !mrq->sbc && (host->flags & SDHCI_AUTO_CMD12);
+	return !mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
+	       !mrq->cap_cmd_during_tfr;
 }
 
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
@@ -1027,7 +1028,15 @@ static void sdhci_finish_data(struct sdhci_host *host)
 			sdhci_do_reset(host, SDHCI_RESET_DATA);
 		}
 
-		sdhci_send_command(host, data->stop);
+		/*
+		 * 'cap_cmd_during_tfr' request must not use the command line
+		 * after mmc_command_done() has been called. It is upper layer's
+		 * responsibility to send the stop command if required.
+		 */
+		if (data->mrq->cap_cmd_during_tfr)
+			sdhci_finish_mrq(host, data->mrq);
+		else
+			sdhci_send_command(host, data->stop);
 	} else {
 		sdhci_finish_mrq(host, data->mrq);
 	}
@@ -1159,6 +1168,9 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		}
 	}
 
+	if (cmd->mrq->cap_cmd_during_tfr && cmd == cmd->mrq->cmd)
+		mmc_command_done(host->mmc, cmd->mrq);
+
 	/*
 	 * The host can send and interrupt when the busy state has
 	 * ended, allowing us to wait without wasting CPU cycles.
-- 
1.9.1


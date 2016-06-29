From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 24/54] mmc: sdhci: Avoid STOP cmd triggering warning in sdhci_send_command()
Date: Wed, 29 Jun 2016 16:24:37 +0300
Message-ID: <1467206707-30185-25-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55539 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098AbcF2Na7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:30:59 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

The STOP command is sent in error conditions, even when the command is
not finished. Avoid triggering the warning for that in sdhci_send_command()
by setting host->cmd to NULL first.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 614d77694f17..6c8cc1a1b858 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1027,6 +1027,8 @@ static void sdhci_finish_data(struct sdhci_host *host)
 			sdhci_do_reset(host, SDHCI_RESET_DATA);
 		}
 
+		/* Avoid triggering warning in sdhci_send_command() */
+		host->cmd = NULL;
 		sdhci_send_command(host, data->stop);
 	} else {
 		sdhci_finish_mrq(host, data->mrq);
-- 
1.9.1


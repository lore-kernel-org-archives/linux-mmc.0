From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: mxcmmc: check the return value of mxcmci_finish_data
Date: Thu,  6 Jul 2017 16:09:12 +0800
Message-ID: <1499328552-83340-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:42450 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbdGFIJo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jul 2017 04:09:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We got a compile warning for mxcmmc,

drivers/mmc/host/mxcmmc.c: In function 'mxcmci_data_done':
drivers/mmc/host/mxcmmc.c:661:6: warning: variable 'data_error' set but
not used [-Wunused-but-set-variable]

The easiest method is to remove the data_error. But looking into
the code closely, I think we should check the return value of
mxcmci_finish_data as if it got data->error(the same as data_error),
we shouldn't try to read the response.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/mxcmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index fb3ca82..3814942 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -681,6 +681,9 @@ static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	if (data_error)
+		return;
+
 	mxcmci_read_response(host, stat);
 	host->cmd = NULL;
 
-- 
1.9.1



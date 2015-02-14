From: Addy Ke <addy.ke@rock-chips.com>
Subject: [PATCH v4 3/3] mmc: dw_mmc: Don't start command while data busy
Date: Sat, 14 Feb 2015 14:17:48 +0800
Message-ID: <1423894668-8886-4-git-send-email-addy.ke@rock-chips.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:35722 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbbBNGSg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Feb 2015 01:18:36 -0500
In-Reply-To: <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, olof@lixom.net, alim.akhtar@gmail.com, a.hajda@samsung.com, dianders@chromium.org
Cc: heiko@sntech.de, cf@rock-chips.com, lintao@rock-chips.com, huangtao@rock-chips.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Addy Ke <addy.ke@rock-chips.com>

We should wait until unbusy before the next request.
But this does't need if the command is CMD13, which can access
SD Status register regardless of data busy.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
Changes in v4:
- CMD13 doesn't need wait until unbusy.

 drivers/mmc/host/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ac21863..692d97a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1076,6 +1076,10 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	WARN_ON(slot->mrq);
 
+	/* Wait until unbusy if the command isn't CMD13 */
+	if (mrq->cmd->opcode != MMC_SEND_STATUS)
+		dw_mci_wait_busy(slot);
+
 	/*
 	 * The check for card presence and queueing of the request must be
 	 * atomic, otherwise the card could be removed in between and the
-- 
1.8.3.2



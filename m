From: Addy Ke <addy.ke@rock-chips.com>
Subject: [PATCH v3 3/3] mmc: dw_mmc: Don't start command while data busy
Date: Fri, 13 Feb 2015 19:52:48 +0800
Message-ID: <1423828368-18456-4-git-send-email-addy.ke@rock-chips.com>
References: <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
 <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:47152 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbbBMLxe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Feb 2015 06:53:34 -0500
In-Reply-To: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, olof@lixom.net, alim.akhtar@gmail.com, a.hajda@samsung.com, dianders@chromium.org
Cc: heiko@sntech.de, cf@rock-chips.com, lintao@rock-chips.com, huangtao@rock-chips.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Addy Ke <addy.ke@rock-chips.com>

We should wait for data busy here in non-volt-switch state.
This may happend when sdio sends CMD53.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f0d9da5..23507c9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1076,6 +1076,12 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(slot->mrq);
 
 	/*
+	 * We should wait for data busy here in non-volt-switch state.
+	 * This may happend when sdio sends CMD53.
+	 */
+	dw_mci_wait_busy(slot);
+
+	/*
 	 * The check for card presence and queueing of the request must be
 	 * atomic, otherwise the card could be removed in between and the
 	 * request wouldn't fail until another card was inserted.
-- 
1.8.3.2



From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] mmc: fix division by zero in MMC core
Date: Wed,  5 Jan 2011 00:44:32 +0100
Message-ID: <1294184672-31644-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:36555 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751616Ab1AEAac (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jan 2011 19:30:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Pierre Tardy <tardyp@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

The card is not always clocked and the clock frequency zero
is perfectly legal, thus this code in mmc_set_data_timeout()
may cause a division by zero. It will be triggered more often
if you're using software clock gating but can be triggered
under other conditions too.

Reported-by: Pierre Tardy <tardyp@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/core/core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 97e0624..ef4f7f8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -299,8 +299,9 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 		unsigned int timeout_us, limit_us;
 
 		timeout_us = data->timeout_ns / 1000;
-		timeout_us += data->timeout_clks * 1000 /
-			(mmc_host_clk_rate(card->host) / 1000);
+		if (mmc_host_clk_rate(card->host))
+			timeout_us += data->timeout_clks * 1000 /
+				(mmc_host_clk_rate(card->host) / 1000);
 
 		if (data->flags & MMC_DATA_WRITE)
 			/*
-- 
1.7.3.3


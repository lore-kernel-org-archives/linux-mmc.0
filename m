From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] mmc: core: add comment why sdio_reset is done at init time
Date: Sun, 13 Feb 2011 23:12:28 -0800
Message-ID: <1091D46E-68D9-49FC-BBA6-6908BC1835AD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57294 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408Ab1BNHQ0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:16:26 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


sdio_reset sends a CMD52 to reset the sdio card.  This is
highly recommended for sdio cards being reinitialized.  Since
we do not know if the card is being reinitialized we just send
the command.  SD/eMMC cards are supposed to ignore the CMD
before the CMD0.  Document why we are doing this.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 34a7e8c..d9fb0d3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1494,6 +1494,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 		mmc_hostname(host), __func__, host->f_init);
 #endif
 	mmc_power_up(host);
+
+	/*
+	 * sdio_reset sends CMD52 to reset card.  Since we do not know
+	 * if the card is being re-initialzed just send it.  CMD52
+	 * should be ignored by SD/eMMC cards
+	 */
 	sdio_reset(host);
 	mmc_go_idle(host);
 
-- 
1.7.0.4



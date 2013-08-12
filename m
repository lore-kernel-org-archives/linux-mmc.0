From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: mmc: core: Add check for card type before =?utf-8?b?bW1jX2h3X3Jlc2V0X2Zvcl9pbml0?=
Date: Mon, 12 Aug 2013 07:02:02 +0000 (UTC)
Message-ID: <loom.20130812T082444-829@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48575 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab3HLHCZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Aug 2013 03:02:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1V8m91-0007fs-OJ
	for linux-mmc@vger.kernel.org; Mon, 12 Aug 2013 09:02:24 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2013 09:02:23 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 12 Aug 2013 09:02:23 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Almost all the places, before calling hw_reset ops, the card type is checked
to make sure it is eMMC but missed during mmc_rescan_try_freq.
The below patch adds the check for card type before calling hardware reset
for init as double safety measure.

>From e7941c5b3b4999318feb59fa83b78c15c13493b3 Mon Sep 17 00:00:00 2001
From: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
Date: Mon, 12 Aug 2013 12:26:57 +0530
Subject: [PATCH] mmc: core: add check for card type before
 mmc_hw_reset_for_init

During mmc_hw_reset_for_init, the card type is not checked before
calling hw_reset ops.
Add check for the card type as emmc before issuing hw_reset during init.

Signed-off-by: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
---
 drivers/mmc/core/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 49a5bca..2dad69a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2196,7 +2196,8 @@ EXPORT_SYMBOL(mmc_set_blockcount);
 
 static void mmc_hw_reset_for_init(struct mmc_host *host)
 {
-	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
+	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset ||
+			!mmc_card_mmc(host->card))
 		return;
 	mmc_host_clk_hold(host);
 	host->ops->hw_reset(host);
-- 
1.7.6





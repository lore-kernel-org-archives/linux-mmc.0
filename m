From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] mmc: block: switch card to User Data Area when removing the block driver
Date: Thu, 23 Jun 2011 13:40:26 +0300
Message-ID: <1308825629-27375-2-git-send-email-adrian.hunter@intel.com>
References: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21043 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759157Ab1FWKlM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2011 06:41:12 -0400
In-Reply-To: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andrei Warkentin <andreiw@motorola.com>

The MMC block driver and other drivers (e.g. mmc-test) will expect
the card to be switched to the User Data Area eMMC partition when
they start.  Hence the MMC block driver should ensure it is that
way when it is removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e5d1c8a..d36b7ea 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1440,6 +1440,9 @@ static void mmc_blk_remove(struct mmc_card *card)
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	mmc_blk_remove_parts(card, md);
+	mmc_claim_host(card->host);
+	mmc_blk_part_switch(card, md);
+	mmc_release_host(card->host);
 	mmc_blk_remove_req(md);
 	mmc_set_drvdata(card, NULL);
 }
-- 
1.7.4.4


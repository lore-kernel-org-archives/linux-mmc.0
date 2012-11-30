From: "Al Cooper" <alcooperx@gmail.com>
Subject: [RESEND PATCH] mmc: Limit MMC speed to 52MHz if not HS200
Date: Fri, 30 Nov 2012 10:53:35 -0500
Message-ID: <1354290815-21995-1-git-send-email-alcooperx@gmail.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:2999 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030982Ab2K3P4Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Nov 2012 10:56:24 -0500
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>

If "caps2" host capabilities does not indicate support for MMC
HS200, don't allow clock speeds >52MHz. Currently, for MMC, the
clock speed is set to the lesser of the max speed the eMMC module
supports (card->ext_csd.hs_max_dtr) or the max base clock of the
host controller (host->f_max based on BASE_CLK_FREQ in the host
CAPS register). This means that a host controller that doesn't
support HS200 mode but has a base clock of 100MHz and an eMMC module
that supports HS200 speeds will end up using a 100MHz clock.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/mmc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7cc4638..6d669c3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1051,6 +1051,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
 		if (max_dtr > card->ext_csd.hs_max_dtr)
 			max_dtr = card->ext_csd.hs_max_dtr;
+		if (mmc_card_highspeed(card) && (max_dtr > 52000000))
+			max_dtr = 52000000;
 	} else if (max_dtr > card->csd.max_dtr) {
 		max_dtr = card->csd.max_dtr;
 	}
-- 
1.7.6



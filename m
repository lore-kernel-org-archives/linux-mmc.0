From: "Al Cooper" <acooper@gmail.com>
Subject: [PATCH] mmc: Limit MMC speed to 25MHz if HIGHSPEED CAPS bit is
 not set.
Date: Mon, 14 May 2012 16:11:54 -0400
Message-ID: <1337026314-14003-1-git-send-email-acooper@gmail.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:3302 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932341Ab2ENUNq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 May 2012 16:13:46 -0400
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org, cernekee@gmail.com
Cc: Al Cooper <acooper@gmail.com>

If the HIGHSPEED capabilities bit is not set, limit the MMC clock
speed to 25MHz.

Signed-off-by: Al Cooper <acooper@gmail.com>
---
 drivers/mmc/core/mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 54df5ad..912c893 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1045,7 +1045,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				mmc_card_set_hs200(card);
 				mmc_set_timing(card->host,
 					       MMC_TIMING_MMC_HS200);
-			} else {
+			} else if (host->caps & MMC_CAP_MMC_HIGHSPEED) {
 				mmc_card_set_highspeed(card);
 				mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 			}
-- 
1.7.6



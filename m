From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: mmc_ops: fix a typo for comment of mmc_start_bkops
Date: Tue,  4 Jul 2017 10:30:03 +0800
Message-ID: <1499135403-56224-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:36065 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbdGDCak (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jul 2017 22:30:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Just a trivial fix for that found by reading the code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 5f7c592..6dd8ecd 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -946,7 +946,7 @@ static int mmc_read_bkops_status(struct mmc_card *card)
 /**
  *	mmc_start_bkops - start BKOPS for supported cards
  *	@card: MMC card to start BKOPS
- *	@form_exception: A flag to indicate if this function was
+ *	@from_exception: A flag to indicate if this function was
  *			 called due to an exception raised by the card
  *
  *	Start background operations whenever requested.
-- 
1.9.1



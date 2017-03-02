From: Piotr Sroka <piotrs@cadence.com>
Subject: [PATCH] mmc: core: fix changing bus witdh in hs400es mode
Date: Thu, 2 Mar 2017 13:47:34 +0000
Message-ID: <1488462454-905-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from keymaster.Cadence.COM ([158.140.2.26]:36312 "EHLO
        mx-sanjose5.cadence.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdCBNsg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Mar 2017 08:48:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Gwendal Grignou <gwendal@chromium.org>, Dong Aisheng <aisheng.dong@nxp.com>, linux-kernel@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>

Fix the code to avoid changing bus width if HS400ES mode is selected.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7fd7228..c7d9c9f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1730,7 +1730,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_select_hs400(card);
 		if (err)
 			goto free_card;
-	} else {
+	} else if (!mmc_card_hs400(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
 		if (err > 0 && mmc_card_hs(card)) {
-- 
2.2.2


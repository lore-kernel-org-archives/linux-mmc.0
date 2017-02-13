From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH] mmc: core: fix multi-bit bus width without high-speed mode
Date: Mon, 13 Feb 2017 13:46:41 +0200
Message-ID: <20170213114641.372-1-anssi.hannula@bitwise.fi>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:38786 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752207AbdBML4D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Feb 2017 06:56:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, stable@vger.kernel.org

Commit 577fb13199b1 ("mmc: rework selection of bus speed mode")
refactored bus width selection code to mmc_select_bus_width().

However, it also altered the behavior to not call the selection code in
non-high-speed modes anymore.

This causes 1-bit mode to always be used when the high-speed mode is not
enabled, even though 4-bit and 8-bit bus are valid bus widths in the
backwards-compatibility (legacy) mode as well (see e.g. 5.3.2 Bus Speed
Modes in JEDEC 84-B50). This results in a significant regression in
transfer speeds.

Fix the code to allow 4-bit and 8-bit widths even without high-speed
mode, as before.

Tested with a Zynq-7000 PicoZed 7020 board.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: <stable@vger.kernel.org>
Fixes: 577fb13199b1 ("mmc: rework selection of bus speed mode")
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b61b52f9..0fccca0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1706,10 +1706,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_select_hs400(card);
 		if (err)
 			goto free_card;
-	} else if (mmc_card_hs(card)) {
+	} else {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
-		if (err > 0) {
+		if (err > 0 && mmc_card_hs(card)) {
 			err = mmc_select_hs_ddr(card);
 			if (err)
 				goto free_card;
-- 
2.8.3


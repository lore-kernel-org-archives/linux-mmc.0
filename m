From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 1/3] mmc: core: Remove some redundant validations in mmc_erase() function
Date: Tue,  6 Sep 2016 10:55:10 +0800
Message-ID: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, heiko@sntech.de, david@protonic.nl, hdegoede@redhat.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, baolin.wang@linaro.org
List-Id: linux-mmc@vger.kernel.org

Before issuing mmc_erase() function, users always have checked if it can
erase with mmc_can_erase/trim/discard() function, thus remove the redundant
erase checking in mmc_erase() function.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Changes since v3:
 - Split into 3 separate patches.
 - Add test tag by Shawn.

Changes since v2:
 - Add nr checking and other optimization in mmc_erase() function.

Changes since v1:
 - Add the alignment if card->erase_size is not power of 2.
---
 drivers/mmc/core/core.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e55cde6..7d7209d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2217,13 +2217,6 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	unsigned int rem, to = from + nr;
 	int err;
 
-	if (!(card->host->caps & MMC_CAP_ERASE) ||
-	    !(card->csd.cmdclass & CCC_ERASE))
-		return -EOPNOTSUPP;
-
-	if (!card->erase_size)
-		return -EOPNOTSUPP;
-
 	if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
 		return -EOPNOTSUPP;
 
-- 
1.7.9.5

From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH v1 1/1] mmc: core: control EXT_CSD_CACHE_CTRL from device tree
Date: Tue, 20 Nov 2018 15:06:39 -0500
Message-ID: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, David Woods <dwoods@mellanox.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Currently the EXT_CSD_CACHE_CTRL register is controlled by API
mmc_card_broken_hpi(), which only works for the quirks settings.
This commit enhances it to use card->ext_csd.hpi instead. This
flag works for both the quirks and the broken-hpi configuration
in the device tree.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/core/mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bc1bd2c..2f2b65c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1791,8 +1791,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * If cache size is higher than 0, this indicates
 	 * the existence of cache and it can be turned on.
 	 */
-	if (!mmc_card_broken_hpi(card) &&
-	    card->ext_csd.cache_size > 0) {
+	if (card->ext_csd.hpi && card->ext_csd.cache_size > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_CACHE_CTRL, 1,
 				card->ext_csd.generic_cmd6_time);
-- 
1.8.3.1

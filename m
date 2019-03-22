From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 17/25] mmc: core: don't try to switch block size for dual rate mode
Date: Fri, 22 Mar 2019 16:44:08 +0100
Message-ID: <20190322154425.3852517-18-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Avri Altman <avri.altman@wdc.com>, Ritesh Harjani <riteshh@codeaurora.org>, Jiong Wu <lohengrin1024@gmail.com>, Martin Hicks <mort@bork.org>
Cc: Ziyuan Xu <xzy.xu@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Ziyuan Xu <xzy.xu@rock-chips.com>

Per spec, block size should always be 512 bytes for dual rate mode,
so any attempts to switch the block size under dual rate mode should
be neglected.

Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 1712c9373f98ae8ed41599a8d7841a6fba29c264)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index df074f8c7cb7..3e17268b9994 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2406,7 +2406,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd = {0};
 
-	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card))
+	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card) ||
+	    mmc_card_hs400(card) || mmc_card_hs400es(card))
 		return 0;
 
 	cmd.opcode = MMC_SET_BLOCKLEN;
-- 
2.20.0

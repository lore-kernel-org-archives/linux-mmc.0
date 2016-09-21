From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/5] mmc: core: don't try to switch block size for dual rate mode
Date: Wed, 21 Sep 2016 09:43:49 +0800
Message-ID: <1474422233-29355-2-git-send-email-shawn.lin@rock-chips.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Ziyuan Xu <xzy.xu@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

From: Ziyuan Xu <xzy.xu@rock-chips.com>

Per spec, block size should always be 512 bytes for dual rate mode,
so any attempts to switch the block size under dual rate mode should
be neglected.

Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f0ed0af..2553d90 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2576,7 +2576,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd = {0};
 
-	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card))
+	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card) ||
+	    mmc_card_hs400(card) || mmc_card_hs400es(card))
 		return 0;
 
 	cmd.opcode = MMC_SET_BLOCKLEN;
-- 
2.3.7

From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH v2 2/4] mmc: core: changes frequency to hs_max_dtr when selecting hs400es
Date: Fri, 23 Sep 2016 08:12:55 +0800
Message-ID: <1474589577-11193-2-git-send-email-shawn.lin@rock-chips.com>
References: <1474589577-11193-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474589577-11193-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Per JESD84-B51 P69, Host need to change frequency to <=52MHz
after setting HS_TIMING to 0x1, and host may changes frequency
to <= 200MHz after setting HS_TIMING to 0x3. That means the card
expects the clock rate to increase from the current used f_init
(which is less than 400KHz, but still being less than 52MHz) to
52MHz, otherwise we find some eMMC devices significantly report
failure when sending status.

Reported-by: Xiao Yao <xiaoyao@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- improve the changelog

 drivers/mmc/core/mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f4ed5ac..39fc5b2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1282,6 +1282,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	if (err)
 		goto out_err;
 
+	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
+
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
-- 
2.3.7

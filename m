From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when selecting hs400es
Date: Wed, 21 Sep 2016 09:43:51 +0800
Message-ID: <1474422233-29355-4-git-send-email-shawn.lin@rock-chips.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Per JESD84-B51 P69, Host need to change frequency to <=52MHz after
setting HS_TIMING to 0x1, and host may changes frequency to <= 200MHz
after setting HS_TIMING to 0x3. It seems there is no difference if
we don't change frequency to <= 52MHz as f_init is already less than
52MHz. But actually it does make difference. When doing compatibility
test we see failures for some eMMC devices without changing the
frequency to hs_max_dtr. And let's read the spec again, we could see
that "Host may changes frequency to 200MHz" implies that it's not
mandatory. But the "Host need to change frequency to <= 52MHz" implies
that we should do this.

Reported-by: Xiao Yao <xiaoyao@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3163bb9..989d37e 100644
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

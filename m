From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/3] mmc: core: switch to 1V8 or 1V2 for hs400es mode
Date: Fri, 30 Sep 2016 14:18:58 +0800
Message-ID: <1475216340-15344-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:56279 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935528AbcI3GQJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2016 02:16:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>, stable@vger.kernel.org

When introducing hs400es, I didn't notice that we haven't
switched voltage to 1V2 or 1V8 for it. That happens to work
as the first controller claiming to support hs400es, arasan(5.1),
which is designed to only support 1V8. So the voltage is fixed to 1V8.
But it actually is wrong, and will not fit for other host controllers.
Let's fix it.

Fixes: commit 81ac2af65793ecf ("mmc: core: implement enhanced strobe support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- add Doug's tag

Changes in v2:
- fix copy-paste error, mea culpa

 drivers/mmc/core/mmc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3486bc7..f4ed5ac 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1263,6 +1263,16 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 	}
 
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_2V)
+		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
+
+	if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V)
+		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+
+	/* If fails try again during next card power cycle */
+	if (err)
+		goto out_err;
+
 	err = mmc_select_bus_width(card);
 	if (err < 0)
 		goto out_err;
-- 
2.3.7



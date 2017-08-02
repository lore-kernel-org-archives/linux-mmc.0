From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] mmc: core: not need to check timeout for SDHC
Date: Wed,  2 Aug 2017 11:12:43 +0800
Message-ID: <1501643563-16094-2-git-send-email-shawn.lin@rock-chips.com>
References: <1501643563-16094-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:44529 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdHBDNL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Aug 2017 23:13:11 -0400
In-Reply-To: <1501643563-16094-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Per the SD physical layer simplified specification V4.10,
section 4.6.2, the taac and nasc for SDHC are always fixed and
the software should use the recommended value for timeout.
When parsing the CSD, we sanely set them to zero for SDHC, the
additional check of SDHC in mmc_set_data_timeout is bogus since
all the calculation for timeout_ns and timeout_clk is zero as well,
so the we could safely remove it and let the following check to
cover it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6177eb0..bcd72b4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -761,14 +761,10 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 			limit_us = 100000;
 
 		/*
-		 * SDHC cards always use these fixed values.
+		 * Assign limit value if invalid. Note that for the SDHC case,
+		 * we set taac and nasc to zero when parsing CSD, so it's safe
+		 * to fall through here.
 		 */
-		if (timeout_us > limit_us || mmc_card_blockaddr(card)) {
-			data->timeout_ns = limit_us * 1000;
-			data->timeout_clks = 0;
-		}
-
-		/* assign limit value if invalid */
 		if (timeout_us == 0)
 			data->timeout_ns = limit_us * 1000;
 	}
-- 
1.9.1



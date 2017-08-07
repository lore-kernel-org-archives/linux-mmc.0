From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3] mmc: core: remove the check of mmc_card_blockaddr for SD cards
Date: Mon,  7 Aug 2017 10:07:14 +0800
Message-ID: <1502071634-94106-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:45918 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbdHGCIC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Aug 2017 22:08:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Per the SD physical layer simplified specification V4.10,
section 4.6.2, CSD version 1.0 SD card should use taac, nsac
and r2w_factor for calculating the data access time. But the
taac and nsac for SDHC(CSD version 2.0) are always fixed and
the software should use the recommended value for timeout. When
parsing the CSD, we sanely set them to zero for SDHC(CSD version
2.0), all the calculation for timeout_ns and timeout_clk is zero
as well. So what we actually want to limit here is either SDHC
case or unreasonable timeout reported by the cards. In principle
we should at least be able to remove the bogus check for the
mmc_card_blockaddr.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- still keep data->timeout_clks = 0 for hosts

Changes in v2:
- rephrase the changelog and only remove mmc_card_blockaddr.

 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6177eb0..5dd1c00 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -763,7 +763,7 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 		/*
 		 * SDHC cards always use these fixed values.
 		 */
-		if (timeout_us > limit_us || mmc_card_blockaddr(card)) {
+		if (timeout_us > limit_us) {
 			data->timeout_ns = limit_us * 1000;
 			data->timeout_clks = 0;
 		}
-- 
1.9.1



From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V8 RESEND] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Mon, 17 Oct 2011 20:17:03 +0530
Message-ID: <1318862823-22909-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63695 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab1JQOrS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 10:47:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>

This patch adds the support for power off notify feature, available in
eMMC 4.5 devices. If the the host has support for this feature, then the
mmc core will notify it to the device by setting the POWER_OFF_NOTIFICATION
byte in the extended csd register with a value 1(POWER_ON).

For suspend mode short timeout is used, whereas for the normal poweroff long
timeout is used.

cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changes in V8:
	Updated with review comments of Chris Ball and rebased to 
	chris-mmc/mmc-next branch.
Changes in V7:
	Rebased to chris-mmc/mmc-next branch. merged to patches 
	to single patch.
Changes in V6:
	Fixes checkpatch errors. The patches are generated after
	rebasing to chris's mmc-next branch.
Changes in V5:
	This patch version fixes the problem with power off
	notify function, when called for the first time and
	card is not yet initialised.
Changes in V4:
	Updated with review comments of Jeon
Changes in V2:
	Adds poweroff notification handling in suspend/normal.


 drivers/mmc/core/core.c  |    6 ++----
 include/linux/mmc/host.h |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index db368b2..b1eca96 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1217,16 +1217,14 @@ void mmc_power_off(struct mmc_host *host)
 	unsigned int timeout;
 	int err;
 
-	BUG_ON(!host);
-
 	mmc_host_clk_hold(host);
 
 	card = host->card;
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
-	if (card != NULL && mmc_card_mmc(card) &&
-	    (card->poweroff_notify_state == MMC_POWERED_ON)) {
+	if (card && mmc_card_mmc(card) &&
+	    card->poweroff_notify_state == MMC_POWERED_ON) {
 
 		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
 			notify_type = EXT_CSD_POWER_OFF_SHORT;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 65c47fc..a991ae7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -243,7 +243,7 @@ struct mmc_host {
 #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
-	unsigned int        power_notify_type;
+	unsigned int		power_notify_type;
 #define MMC_HOST_PW_NOTIFY_NONE		0
 #define MMC_HOST_PW_NOTIFY_SHORT	1
 #define MMC_HOST_PW_NOTIFY_LONG		2
-- 
1.7.1


From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] mmc: add a short delay in mmc_power_off
Date: Wed,  7 Sep 2011 10:22:09 +0100 (BST)
Message-ID: <20110907092209.A52409D401C@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:63019 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755848Ab1IGQQv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Sep 2011 12:16:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, ohad@wizery.com

Stress-testing the runtime power management of libertas_sdio
through a rmmod/insmod loop revealed that it is quite easy to
cause an ETIMEDOUT failure in mmc_sdio_power_restore() leading to:
   libertas_sdio: probe of mmc1:0001:1 failed with error -16

Experimentation shows that a very short delay (100us) is needed in
the power down path before the card can be successfully booted again.
We know that this setup is lacking poweroff clamps on the card's power
lines, but as only a short delay is needed, apply this unconditionally.
Also bump up to 1ms sleep for extra legroom.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/core/core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 557856b..7289e99 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1214,6 +1214,13 @@ static void mmc_power_off(struct mmc_host *host)
 	host->ios.timing = MMC_TIMING_LEGACY;
 	mmc_set_ios(host);
 
+	/*
+	 * Some configurations, such as the 802.11 SDIO card in the OLPC
+	 * XO-1.5, require a short delay after poweroff before the card
+	 * can be successfully turned on again.
+	 */
+	mmc_delay(1);
+
 	mmc_host_clk_release(host);
 }
 
-- 
1.7.6


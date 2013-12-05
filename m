From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/6] mmc: Do not call get_cd for non removable cards
Date: Thu,  5 Dec 2013 14:34:46 +0100
Message-ID: <1386250491-4708-2-git-send-email-s.hauer@pengutronix.de>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49777 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab3LENfC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 08:35:02 -0500
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

Non removable cards are always present, so do not call get_cd for them.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 57a2b40..098374b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2460,7 +2460,8 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	mmc_bus_put(host);
 
-	if (host->ops->get_cd && host->ops->get_cd(host) == 0) {
+	if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
+			host->ops->get_cd(host) == 0) {
 		mmc_claim_host(host);
 		mmc_power_off(host);
 		mmc_release_host(host);
-- 
1.8.4.3


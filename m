From: r66093@freescale.com
Subject: [PATCH 1/3] MMC/SD: power on before detecting card
Date: Fri,  4 Dec 2009 15:54:41 +0800
Message-ID: <1259913281-27045-1-git-send-email-r66093@freescale.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:63203 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbZLDH5Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2009 02:57:16 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id nB47vNIx012782
	for <linux-mmc@vger.kernel.org>; Fri, 4 Dec 2009 00:57:23 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nB47vNmh001925
	for <linux-mmc@vger.kernel.org>; Fri, 4 Dec 2009 01:57:24 -0600 (CST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

power on before detecting card.

The driver will not get the right status when using the callback function 'get_cd' to check if the card is present because the power is not on.
Therefore, the controller must be power on before detecting the card status.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 drivers/mmc/core/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dab2e5..7b3aee1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1067,12 +1067,13 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	mmc_bus_put(host);
 
+	mmc_power_up(host);
+
 	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
 		goto out;
 
 	mmc_claim_host(host);
 
-	mmc_power_up(host);
 	mmc_go_idle(host);
 
 	mmc_send_if_cond(host, host->ocr_avail);
-- 
1.6.4


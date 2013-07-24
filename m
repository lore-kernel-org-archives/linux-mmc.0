From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [RFC 2/2] mmc: host: allow setting index via devicetree
Date: Wed, 24 Jul 2013 11:09:33 +0200
Message-ID: <1374656973-16250-3-git-send-email-s.trumtrar@pengutronix.de>
References: <1374656973-16250-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56714 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab3GXJKH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2013 05:10:07 -0400
In-Reply-To: <1374656973-16250-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>

As with gpio, uart and others, allow specifying the host index via the
aliases-node in the devicetree.

On embedded devices, there is often a combination of removable (e.g.
SD card) and non-removable mmc devices (e.g. eMMC).
Therefore the mmcblk name_idx might change depending on
	- host of removable device
	- removable card present or not

This makes it difficult to hard code the root device, if it is on the
non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
if SD card is not present at boot, eMMC will be mmcblk0.

To match the host index with the mmcblk, allow setting the index via
an alias node.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/mmc/core/host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 6fb6f77..640228f 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -450,16 +450,21 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
 	int err;
 	struct mmc_host *host;
+	int alias_id;
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
 		return NULL;
 
+	alias_id = of_alias_get_id(dev->of_node, "mmc");
+	if (alias_id < 0)
+		alias_id = 0;
+
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
 	idr_preload(GFP_KERNEL);
 	spin_lock(&mmc_host_lock);
-	err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
+	err = idr_alloc(&mmc_host_idr, host, alias_id, 0, GFP_NOWAIT);
 	if (err >= 0)
 		host->index = err;
 	spin_unlock(&mmc_host_lock);
-- 
1.8.3.2


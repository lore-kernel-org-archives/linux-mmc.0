From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH]omap hsmmc: fix incorrect capability reporting
Date: Tue, 30 Mar 2010 20:07:19 +0530
Message-ID: <618f0c911003300737w5562c18as1bfcb21671919718@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52398 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab0C3OhY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2010 10:37:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, kishore.kadiyala@ti.com
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>

MMC slots that support 8 bit mode also support 4 bit mode.
The capability flag has to reflect this, otherwise SDHC cards operate
in 1 bit mode.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 83f0aff..dbf83a6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2093,7 +2093,7 @@ static int __init omap_hsmmc_probe(struct
platform_device *pdev)

 	if (mmc_slot(host).wires >= 8)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
-	else if (mmc_slot(host).wires >= 4)
+	if (mmc_slot(host).wires >= 4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;

 	if (mmc_slot(host).nonremovable)
-- 
1.6.3.3

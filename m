From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: always save error codes in mmc_regulator_get_supply()
Date: Wed, 27 Jun 2012 17:18:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206271714270.24173@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51686 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757413Ab2F0PSq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jun 2012 11:18:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

If mmc_regulator_get_supply() fails to obtain any of the regulators, store
the error codes in struct mmc_host to unify error reporting to the host
driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Chris, if you don't mind rebasing your mmc-next branch, feel free to roll 
this patch into the original "mmc: add a function to get regulators, 
supplying card's power". Otherwise, committing it as an incremental patch 
is also ok.

 drivers/mmc/core/core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 385cadf..d0f17d8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1020,13 +1020,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	int ret;
 
 	supply = devm_regulator_get(dev, "vmmc");
+	mmc->supply.vmmc = supply;
+	mmc->supply.vqmmc = devm_regulator_get(dev, "vqmmc");
 
 	if (IS_ERR(supply))
 		return PTR_ERR(supply);
 
-	mmc->supply.vmmc = supply;
-	mmc->supply.vqmmc = devm_regulator_get(dev, "vqmmc");
-
 	ret = mmc_regulator_get_ocrmask(supply);
 	if (ret > 0)
 		mmc->ocr_avail = ret;
-- 
1.7.2.5


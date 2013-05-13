From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V2 05/10] mmc: sdhi-pxav3: handle mmc_of_parse() errors during probe
Date: Mon, 13 May 2013 23:18:56 +0200
Message-ID: <1368479941-10084-6-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:36504 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab3EMVTv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 17:19:51 -0400
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 1ae358e..67ea388 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -252,7 +252,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
 	if (match) {
-		mmc_of_parse(host->mmc);
+		ret = mmc_of_parse(host->mmc);
+		if (ret)
+			goto err_of_parse;
 		sdhci_get_of_property(pdev);
 		pdata = pxav3_get_mmc_pdata(dev);
 	} else if (pdata) {
@@ -313,10 +315,11 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_of_parse:
+err_cd_req:
 err_add_host:
 	clk_disable_unprepare(clk);
 	clk_put(clk);
-err_cd_req:
 err_clk_get:
 	sdhci_pltfm_free(pdev);
 	kfree(pxa);
-- 
1.7.9.5


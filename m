From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V2 02/10] mmc: sh_mmcif: handle mmc_of_parse() errors during probe
Date: Mon, 13 May 2013 23:18:53 +0200
Message-ID: <1368479941-10084-3-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:38396 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab3EMVTo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 17:19:44 -0400
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/sh_mmcif.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index ba76a53..6ded7fb 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1369,7 +1369,11 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto ealloch;
 	}
-	mmc_of_parse(mmc);
+
+	ret = mmc_of_parse(mmc);
+	if (ret < 0)
+		goto eofparse;
+
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->addr	= reg;
@@ -1464,6 +1468,7 @@ eclkupdate:
 	clk_put(host->hclk);
 eclkget:
 	pm_runtime_disable(&pdev->dev);
+eofparse:
 	mmc_free_host(mmc);
 ealloch:
 	iounmap(reg);
-- 
1.7.9.5


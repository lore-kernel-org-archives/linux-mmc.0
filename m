From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V2 04/10] mmc: mxcmmc: handle mmc_of_parse() errors during probe
Date: Mon, 13 May 2013 23:18:55 +0200
Message-ID: <1368479941-10084-5-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:13020 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab3EMVTt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 17:19:49 -0400
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/mxcmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index d503635..f47546f 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1067,7 +1067,9 @@ static int mxcmci_probe(struct platform_device *pdev)
 		goto out_release_mem;
 	}
 
-	mmc_of_parse(mmc);
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto out_free;
 	mmc->ops = &mxcmci_ops;
 
 	/* For devicetree parsing, the bus width is read from devicetree */
-- 
1.7.9.5


From: Simon Baatz <gmbnomis@gmail.com>
Subject: [RESEND PATCH V3 4/8] mmc: mxcmmc: handle mmc_of_parse() errors during probe
Date: Sun,  9 Jun 2013 22:14:14 +0200
Message-ID: <1370808858-32241-5-git-send-email-gmbnomis@gmail.com>
References: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:39084 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab3FIUPJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 16:15:09 -0400
In-Reply-To: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Chris Ball <cjb@laptop.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

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


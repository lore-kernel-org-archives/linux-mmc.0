From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V2 03/10] mmc: tmio-mmc: handle mmc_of_parse() errors during probe
Date: Mon, 13 May 2013 23:18:54 +0200
Message-ID: <1368479941-10084-4-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:31636 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab3EMVTr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 17:19:47 -0400
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/tmio_mmc_pio.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f508ecb..f1a9d4a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -988,7 +988,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (!mmc)
 		return -ENOMEM;
 
-	mmc_of_parse(mmc);
+	ret = mmc_of_parse(mmc);
+	if (ret < 0)
+		goto host_free;
 
 	pdata->dev = &pdev->dev;
 	_host = mmc_priv(mmc);
-- 
1.7.9.5


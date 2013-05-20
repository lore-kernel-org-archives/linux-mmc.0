From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V3 03/10] mmc: tmio-mmc: handle mmc_of_parse() errors during probe
Date: Tue, 21 May 2013 01:01:44 +0200
Message-ID: <1369090911-1479-4-git-send-email-gmbnomis@gmail.com>
References: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:23305 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323Ab3ETXCV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2013 19:02:21 -0400
In-Reply-To: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
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


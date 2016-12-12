From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/9] mmc: sh_mobile_sdhi: remove superfluous check in init_tuning
Date: Mon, 12 Dec 2016 20:51:24 +0100
Message-ID: <20161212195128.16633-6-wsa+renesas@sang-engineering.com>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41914 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752821AbcLLTvt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Dec 2016 14:51:49 -0500
In-Reply-To: <20161212195128.16633-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

The function will only be available if SDR104 was detected in probe,
so no need to check in the function itself again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 7964f9a87d9c20..22bedbea8ec502 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -327,9 +327,6 @@ static unsigned int sh_mobile_sdhi_init_tuning(struct tmio_mmc_host *host)
 {
 	struct sh_mobile_sdhi *priv;
 
-	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
-		return 0;
-
 	priv = host_to_priv(host);
 
 	/* set sampling clock selection range */
-- 
2.10.2


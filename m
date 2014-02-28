From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/2] mmc: omap_hsmmc: fix return error code for of_get_hsmmc_pdata
Date: Fri, 28 Feb 2014 19:52:31 +0530
Message-ID: <1393597352-13282-2-git-send-email-balajitk@ti.com>
References: <1393597352-13282-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40062 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaB1OWm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 09:22:42 -0500
In-Reply-To: <1393597352-13282-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

of_get_hsmmc_pdata returns a pointer, returning NULL is invalid,
return ERR_PTR for error case.

Signed-off-by: Balaji T K <balajitk@ti.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 014bfe5..7d03d36 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1725,7 +1725,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-		return NULL; /* out of memory */
+		return ERR_PTR(-ENOMEM); /* out of memory */
 
 	if (of_find_property(np, "ti,dual-volt", NULL))
 		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
@@ -1760,7 +1760,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 static inline struct omap_mmc_platform_data
 			*of_get_hsmmc_pdata(struct device *dev)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 #endif
 
-- 
1.7.5.4


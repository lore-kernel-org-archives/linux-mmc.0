From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: omap_hsmmc: Prevent potential NULL dereference
Date: Mon, 18 Mar 2013 17:34:28 +0800
Message-ID: <1363599268.20778.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:37712 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab3CRJek (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Mar 2013 05:34:40 -0400
Received: by mail-pb0-f41.google.com with SMTP id um15so6297747pbc.14
        for <linux-mmc@vger.kernel.org>; Mon, 18 Mar 2013 02:34:39 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

of_get_hsmmc_pdata() may return NULL, thus ensure pdata is not NULL
before dereference it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bc58078..a8f9717 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1774,7 +1774,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
 		pdata = of_get_hsmmc_pdata(&pdev->dev);
-		if (match->data) {
+		if (pdata && match->data) {
 			const u16 *offsetp = match->data;
 			pdata->reg_offset = *offsetp;
 		}
-- 
1.7.9.5




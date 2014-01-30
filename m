From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] mmc: omap_hsmmc: checking for ERR_PTR instead of NULL
Date: Thu, 30 Jan 2014 15:15:49 +0300
Message-ID: <20140130121548.GB10368@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The of_get_hsmmc_pdata() function returns NULL on error, it doesn't
return ERR_PTRs.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bfb0dbd052c0..76dbc7b759c2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1761,9 +1761,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
 		pdata = of_get_hsmmc_pdata(&pdev->dev);
-
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
+		if (!pdata)
+			return -ENOMEM;
 
 		if (match->data) {
 			const u16 *offsetp = match->data;

From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] at91_mci.c: use resource_size()
Date: Fri, 27 Aug 2010 20:08:13 +0100
Message-ID: <20100827190812.GD20407@void.printf.net>
References: <BD79186B4FD85F4B8E60E381CAEE19090200E9E8@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51208 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040Ab0H0TIW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:08:22 -0400
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200E9E8@mi8nycmail19.Mi8.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org

From: H Hartley Sweeten <hsweeten@visionengravers.com>
Date: Mon, 14 Dec 2009 14:10:26 -0500

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
[cjb: rebased patch against Linus]
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/at91_mci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 5f3a599..3995db3 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -927,7 +927,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENXIO;
 
-	if (!request_mem_region(res->start, res->end - res->start + 1, DRIVER_NAME))
+	if (!request_mem_region(res->start, resource_size(res), DRIVER_NAME))
 		return -EBUSY;
 
 	mmc = mmc_alloc_host(sizeof(struct at91mci_host), &pdev->dev);
@@ -1016,7 +1016,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	/*
 	 * Map I/O region
 	 */
-	host->baseaddr = ioremap(res->start, res->end - res->start + 1);
+	host->baseaddr = ioremap(res->start, resource_size(res));
 	if (!host->baseaddr) {
 		ret = -ENOMEM;
 		goto fail1;
@@ -1092,7 +1092,7 @@ fail4b:
 fail5:
 	mmc_free_host(mmc);
 fail6:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 	dev_err(&pdev->dev, "probe failed, err %d\n", ret);
 	return ret;
 }
@@ -1137,7 +1137,7 @@ static int __exit at91_mci_remove(struct platform_device *pdev)
 
 	iounmap(host->baseaddr);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	mmc_free_host(mmc);
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.0.1

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

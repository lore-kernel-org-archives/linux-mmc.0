From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] at91_mci.c: use resource_size()
Date: Mon, 14 Dec 2009 14:10:26 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200E9E8@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932444AbZLNTKb@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 63924e0..05a3fb4 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -992,7 +992,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENXIO;
 
-	if (!request_mem_region(res->start, res->end - res->start + 1, DRIVER_NAME))
+	if (!request_mem_region(res->start, resource_size(res), DRIVER_NAME))
 		return -EBUSY;
 
 	mmc = mmc_alloc_host(sizeof(struct at91mci_host), &pdev->dev);
@@ -1063,7 +1063,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	/*
 	 * Map I/O region
 	 */
-	host->baseaddr = ioremap(res->start, res->end - res->start + 1);
+	host->baseaddr = ioremap(res->start, resource_size(res));
 	if (!host->baseaddr) {
 		ret = -ENOMEM;
 		goto fail1;
@@ -1135,7 +1135,7 @@ fail4:
 fail5:
 	mmc_free_host(mmc);
 fail6:
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 	dev_err(&pdev->dev, "probe failed, err %d\n", ret);
 	return ret;
 }
@@ -1176,7 +1176,7 @@ static int __exit at91_mci_remove(struct platform_device *pdev)
 
 	iounmap(host->baseaddr);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	mmc_free_host(mmc);
 	platform_set_drvdata(pdev, NULL); 

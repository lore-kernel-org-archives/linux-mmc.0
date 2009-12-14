From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] au1xmmc.c: use resource_size()
Date: Mon, 14 Dec 2009 14:28:06 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200E9FB@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:58962 "EHLO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282AbZLNT2M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 14:28:12 -0500
Content-class: urn:content-classes:message
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index d3f5561..2d2119b 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -963,7 +963,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 		goto out1;
 	}
 
-	host->ioarea = request_mem_region(r->start, r->end - r->start + 1,
+	host->ioarea = request_mem_region(r->start, resource_size(r),
 					   pdev->name);
 	if (!host->ioarea) {
 		dev_err(&pdev->dev, "mmio already in use\n"); 

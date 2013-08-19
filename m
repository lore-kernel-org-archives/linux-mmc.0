From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 7/7] mmc: mvsdio: replace devm_request_and_ioremap by devm_ioremap_resource
Date: Mon, 19 Aug 2013 13:20:41 +0200
Message-ID: <1376911241-27720-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1376911241-27720-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1376911241-27720-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: kernel-janitors@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Use devm_ioremap_resource instead of devm_request_and_ioremap.

This was done using the semantic patch
scripts/coccinelle/api/devm_ioremap_resource.cocci

The relevant call to platform_get_resource was manually moved down to the
call to devm_ioremap_resource.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/mvsdio.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 4ddd83f..2ac7d3a 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -687,9 +687,8 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	int ret, irq;
 	struct pinctrl *pinctrl;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (!r || irq < 0)
+	if (irq < 0)
 		return -ENXIO;
 
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
@@ -774,9 +773,10 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->lock);
 
-	host->base = devm_request_and_ioremap(&pdev->dev, r);
-	if (!host->base) {
-		ret = -ENOMEM;
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
 		goto out;
 	}
 


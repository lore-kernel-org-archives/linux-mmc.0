From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH] drivers: mmc: host: use devm_ioremap_resource()
Date: Sun, 12 May 2013 16:44:20 +0200
Message-ID: <1368369860-32085-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:51517 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab3ELOjo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 May 2013 10:39:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nico@fluxnic.net, cjb@laptop.org
Cc: andrew@lunn.ch, thomas.petazzoni@free-electrons.com, jason@lakedaemon.net, jg1.han@samsung.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>

eplace a call to deprecated devm_request_and_ioremap by devm_ioremap_resource.

Found with coccicheck and this semantic patch:
 scripts/coccinelle/api/devm_ioremap_resource.cocci

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/mmc/host/mvsdio.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 8960fc8..a66ee4b 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -758,9 +758,9 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->lock);
 
-	host->base = devm_request_and_ioremap(&pdev->dev, r);
-	if (!host->base) {
-		ret = -ENOMEM;
+	host->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
 		goto out;
 	}
 
-- 
1.7.10.4


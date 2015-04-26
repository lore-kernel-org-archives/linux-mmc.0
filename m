From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH mmc 3/4] mmc: TMIO: Use devm_request_irq()
Date: Mon, 27 Apr 2015 00:01:36 +0100
Message-ID: <1430089296.5802.20.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34193 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbDZXBm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Apr 2015 19:01:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk

From: Ian Molton <ian.molton@codethink.co.uk>

Clean up resource allocation and freeing.

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/mmc/host/tmio_mmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 3d368b830e7c..e897e7fc3b14 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -103,7 +103,8 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto host_free;
 
-	ret = request_irq(irq, tmio_mmc_irq, IRQF_TRIGGER_FALLING,
+	ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq,
+				IRQF_TRIGGER_FALLING,
 				dev_name(&pdev->dev), host);
 	if (ret)
 		goto host_remove;
@@ -131,7 +132,6 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 
 	if (mmc) {
 		struct tmio_mmc_host *host = mmc_priv(mmc);
-		free_irq(platform_get_irq(pdev, 0), host);
 		tmio_mmc_host_remove(host);
 		if (cell->disable)
 			cell->disable(pdev);
-- 
1.7.10.4





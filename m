From: Ian Molton <ian.molton@codethink.co.uk>
Subject: [PATCH 4/6] mmc: TMIO: use devm_ for requesting irq
Date: Wed, 30 Apr 2014 17:59:09 +0100
Message-ID: <1398877151-6965-5-git-send-email-ian.molton@codethink.co.uk>
References: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:47934 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964792AbaD3Q7h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 12:59:37 -0400
In-Reply-To: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@linaro.org, chris@printf.net, Ian Molton <ian.molton@codethink.co.uk>

	Trivial patch to cleanup resource allocation and freeing.

Reviewed-by: Violeta Menendez <violeta.menendez@codethink.co.uk>
Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/mmc/host/tmio_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 17415f8..6b5184c 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -104,7 +104,8 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto cell_disable;
 
-	ret = request_irq(irq, tmio_mmc_irq, IRQF_TRIGGER_FALLING,
+	ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq,
+				IRQF_TRIGGER_FALLING,
 				dev_name(&pdev->dev), host);
 	if (ret)
 		goto host_remove;
@@ -130,7 +131,6 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 
 	if (mmc) {
 		struct tmio_mmc_host *host = mmc_priv(mmc);
-		free_irq(platform_get_irq(pdev, 0), host);
 		tmio_mmc_host_remove(host);
 		if (cell->disable)
 			cell->disable(pdev);
-- 
1.9.1


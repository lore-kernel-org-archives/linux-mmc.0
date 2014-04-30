From: Ian Molton <ian.molton@codethink.co.uk>
Subject: [PATCH 3/6] mmc: TMIO: Use devm_ioremap()
Date: Wed, 30 Apr 2014 17:59:08 +0100
Message-ID: <1398877151-6965-4-git-send-email-ian.molton@codethink.co.uk>
References: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:47927 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964792AbaD3Q7g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 12:59:36 -0400
In-Reply-To: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@linaro.org, chris@printf.net, Ian Molton <ian.molton@codethink.co.uk>

	Use devm_ioremap for tmio / sh_mobile.

Reviewed-by: Violeta Menendez <violeta.menendez@codethink.co.uk>
Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/mmc/host/tmio_mmc_pio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 7db9310..50e8c01 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1021,7 +1021,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *host)
 	if (ret < 0)
 		goto host_free;
 
-	host->ctl = ioremap(res_ctl->start, resource_size(res_ctl));
+	host->ctl = devm_ioremap(dev, res_ctl->start, resource_size(res_ctl));
 	if (!host->ctl) {
 		ret = -ENOMEM;
 		goto host_free;
@@ -1119,7 +1119,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *host)
 
 pm_disable:
 	pm_runtime_disable(dev);
-	iounmap(host->ctl);
 host_free:
 	mmc_free_host(mmc);
 
@@ -1145,7 +1144,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	iounmap(host->ctl);
 	mmc_free_host(mmc);
 }
 EXPORT_SYMBOL(tmio_mmc_host_remove);
-- 
1.9.1


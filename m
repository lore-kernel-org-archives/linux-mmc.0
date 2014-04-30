From: Ian Molton <ian.molton@codethink.co.uk>
Subject: [PATCH 2/6] mmc: TMIO: Fixup error return path
Date: Wed, 30 Apr 2014 17:59:07 +0100
Message-ID: <1398877151-6965-3-git-send-email-ian.molton@codethink.co.uk>
References: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:47920 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964792AbaD3Q7c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 12:59:32 -0400
In-Reply-To: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@linaro.org, chris@printf.net, Ian Molton <ian.molton@codethink.co.uk>

	Trivial patch to correct the error return path.

Reviewed-by: Violeta Menendez <violeta.menendez@codethink.co.uk>
Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/mmc/host/tmio_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index bf6252c..17415f8 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -85,8 +85,10 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
+	if (!res) {
+		ret = -EINVAL;
+		goto cell_disable;
+	}
 
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	pdata->bus_shift = resource_size(res) >> 10;
-- 
1.9.1


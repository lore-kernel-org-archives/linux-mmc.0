From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH mmc 1/4] mmc: TMIO: Ensure MFD cell is disabled on probe
 error path
Date: Mon, 27 Apr 2015 00:01:06 +0100
Message-ID: <1430089266.5802.18.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34149 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbDZXBK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Apr 2015 19:01:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk

From: Ian Molton <ian.molton@codethink.co.uk>

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/mmc/host/tmio_mmc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index f746df493892..3d368b830e7c 100644
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
 
 	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
 
-- 
1.7.10.4





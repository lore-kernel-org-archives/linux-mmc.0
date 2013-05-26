From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 1/1] mmc: of_mmc_spi: fix card detect irq
Date: Sun, 26 May 2013 14:28:57 +0200
Message-ID: <1369571337-9300-1-git-send-email-plagnioj@jcrosoft.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:44294 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752120Ab3EZMdN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 May 2013 08:33:13 -0400
Received: from mail421.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 09E24DC1B88
	for <linux-mmc@vger.kernel.org>; Sun, 26 May 2013 14:33:12 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-mmc@vger.kernel.org

set missing irq type the IRQF_ONESHOT

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: stable <stable@vger.kernel.org> # 3.4+
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/of_mmc_spi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index d720b5e..cfb2e61 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -74,8 +74,8 @@ static int of_mmc_spi_init(struct device *dev,
 {
 	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
 
-	return request_threaded_irq(oms->detect_irq, NULL, irqhandler, 0,
-				    dev_name(dev), mmc);
+	return request_threaded_irq(oms->detect_irq, NULL, irqhandler,
+		IRQF_ONESHOT, dev_name(dev), mmc);
 }
 
 static void of_mmc_spi_exit(struct device *dev, void *mmc)
-- 
1.7.10.4


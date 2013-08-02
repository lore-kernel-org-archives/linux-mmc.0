From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 2/4] mmc: sdhci-s3c: initialize host->quirks2 for using
 quirk2
Date: Fri, 02 Aug 2013 23:09:00 +0900
Message-ID: <51FBBD7C.10800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35720 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab3HBOJA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 10:09:00 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQW00JXDPYX1HO0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Aug 2013 23:08:58 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>

In order to use the quirks2, initialized the host->quirks2.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
---
Changelog v2:
	- Nothing

 drivers/mmc/host/sdhci-s3c.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 1572b6a..6debda9 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -611,6 +611,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	host->hw_name = "samsung-hsmmc";
 	host->ops = &sdhci_s3c_ops;
 	host->quirks = 0;
+	host->quirks2 = 0;
 	host->irq = irq;
 
 	/* Setup quirks for the controller */
-- 
1.7.9.5

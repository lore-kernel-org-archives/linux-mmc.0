From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/4] mmc: sdhci-s3c: initialize host->quirks2 for using quirk2
Date: Tue, 25 Jun 2013 10:20:57 +0900
Message-ID: <51C8F079.5020801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12306 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3FYBUz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jun 2013 21:20:55 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MOX00KHID295570@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 25 Jun 2013 10:20:54 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Kyungmin Park <kyungmin.park@samsung.com>

In order to use the quirks2, initialized the host->quirks2.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index ce71f32..cfcacc3 100644
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

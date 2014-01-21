From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/7] mmc: core add the property for hs200
Date: Tue, 21 Jan 2014 19:16:54 +0900
Message-ID: <52DE4916.4090603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12969 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbaAUKQb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 05:16:31 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZQ00MBZXVI4A60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Jan 2014 19:16:30 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

caps2-mmc-hs200-1.8v and caps2-mmc-hs200-1.2v can be used to the general capability.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/host.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 49bc403..96ac4c1 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -429,6 +429,10 @@ int mmc_of_parse(struct mmc_host *host)
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (of_find_property(np, "enable-sdio-wakeup", &len))
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (of_find_property(np, "caps2-mmc-hs200-1_8v", NULL))
+		host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
+	if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
+		host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
 
 	return 0;
 
-- 
1.7.9.5

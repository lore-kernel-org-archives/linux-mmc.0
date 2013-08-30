From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 07/22] mmc: dw_mmc: move the platform specific init call
Date: Sat, 31 Aug 2013 00:12:19 +0900
Message-ID: <000a01cea593$51e8f440$f5badcc0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47185 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab3H3PMo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:12:44 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00E8VNKJ1260@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:12:19 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>

Current platform specific private data initialization call
dw_mci_exynos_priv_init() can be used to do platform specific
initialization of SMU and others in future. So the drv_data->init
call has moved to dw_mci_probe().

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |    7 -------
 drivers/mmc/host/dw_mmc.c       |    9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 2089752..5c49656 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -39,7 +39,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 {
 	struct dw_mci *host;
 	struct resource	*regs;
-	int ret;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
 	if (!host)
@@ -59,12 +58,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	if (IS_ERR(host->regs))
 		return PTR_ERR(host->regs);
 
-	if (drv_data && drv_data->init) {
-		ret = drv_data->init(host);
-		if (ret)
-			return ret;
-	}
-
 	platform_set_drvdata(pdev, host);
 	return dw_mci_probe(host);
 }
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b5bf6eb..52d7731 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2227,6 +2227,15 @@ int dw_mci_probe(struct dw_mci *host)
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 	}
 
+	if (drv_data && drv_data->init) {
+		ret = drv_data->init(host);
+		if (ret) {
+			dev_err(host->dev,
+				"implementation specific init failed\n");
+			goto err_clk_ciu;
+		}
+	}
+
 	if (drv_data && drv_data->setup_clock) {
 		ret = drv_data->setup_clock(host);
 		if (ret) {
-- 
1.7.0.4



From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: dw-mmc: fix the return value for exynos's
 setup_clock()
Date: Mon, 18 Feb 2013 19:12:05 +0900
Message-ID: <5121FE75.8000607@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:18921 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573Ab3BRKMB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 05:12:01 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIE00691UYMDXA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Feb 2013 19:12:00 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MIE00GGJUZZIF90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Feb 2013 19:11:59 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>

Before adjusting this patch, always return 0.
Then clock-setup would be always succeed.
In dw-mmc.c, it's checked like below

ret = drv_data->setup_clock(host);
if (ret) {
	...
	Never entered at here..
}

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 72fd0f2..764ff29 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -99,7 +99,7 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
 		host->bus_hz /= EXYNOS4210_FIXED_CIU_CLK_DIV;
 
-	return 0;
+	return host->bus_hz ? 0 : -EINVAL;
 }
 
 static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
-- 
1.7.9.5

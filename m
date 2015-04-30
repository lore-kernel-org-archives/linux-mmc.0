From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] mmc: dw_mmc: init desc in dw_mci_idmac_init
Date: Thu, 30 Apr 2015 22:16:28 +0800
Message-ID: <1430403388-4184-1-git-send-email-zhangfei.gao@linaro.org>
References: <1430314316-15971-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34155 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbD3OQn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 10:16:43 -0400
Received: by pacyx8 with SMTP id yx8so61155419pac.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 07:16:43 -0700 (PDT)
In-Reply-To: <1430314316-15971-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>, Fei Wang <w.f@huawei.com>

Set 0 to des1 in 32bit case.
Otherwise the random value of des1 will be used in
dw_mci_translate_sglist: IDMAC_SET_BUFFER1_SIZE(desc, length)

Signed-off-by: Fei Wang <w.f@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 241454f..488a8af 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -589,9 +589,11 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 		host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
 
 		/* Forward link the descriptor list */
-		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
+		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++) {
 			p->des3 = cpu_to_le32(host->sg_dma +
 					(sizeof(struct idmac_desc) * (i + 1)));
+			p->des1 = 0;
+		}
 
 		/* Set the last descriptor as the end-of-ring descriptor */
 		p->des3 = cpu_to_le32(host->sg_dma);
-- 
1.9.1


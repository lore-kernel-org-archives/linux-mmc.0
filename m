From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: android-goldfish: fix potential panic due to null pointer
Date: Sun, 21 Aug 2016 11:34:36 +0800
Message-ID: <1471750476-335-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:39929 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbcHUDi5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Aug 2016 23:38:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

We should never compare virt_base with zero to indicate whether
we get the right buffer or not from dma_alloc_coherent. It's quite
architecture related. If failing to get the address from CMA or swoitlb
cases, the sub architecture code should decide the return value for it.
So we should never presume that zero always means the failure.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/android-goldfish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index dca5518..6d8bd03 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -484,7 +484,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 	host->virt_base = dma_alloc_coherent(&pdev->dev, BUFFER_SIZE,
 					     &buf_addr, GFP_KERNEL);
 
-	if (host->virt_base == 0) {
+	if (!host->virt_base) {
 		ret = -ENOMEM;
 		goto dma_alloc_failed;
 	}
-- 
2.3.7



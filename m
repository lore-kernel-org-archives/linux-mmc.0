From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: sdhci-of-arasan: Fix non static symbol warning
Date: Sun, 25 Sep 2016 15:44:03 +0000
Message-ID: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34072 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034226AbcIYPoK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Sep 2016 11:44:10 -0400
Received: by mail-pa0-f67.google.com with SMTP id hm5so463407pac.1
        for <linux-mmc@vger.kernel.org>; Sun, 25 Sep 2016 08:44:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/mmc/host/sdhci-of-arasan.c:253:6: warning:
 symbol 'sdhci_arasan_reset' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index da8e40a..e263671 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -250,7 +250,7 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
 	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
 }
 
-void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
+static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
 {
 	u8 ctrl;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);




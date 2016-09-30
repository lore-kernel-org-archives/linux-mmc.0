From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-of-arasan: mark sdhci_arasan_reset() static
Date: Fri, 30 Sep 2016 09:37:39 +0800
Message-ID: <1475199459-4775-2-git-send-email-baoyou.xie@linaro.org>
References: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35866 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935272AbcI3Bi4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2016 21:38:56 -0400
Received: by mail-pf0-f171.google.com with SMTP id q2so34471421pfj.3
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2016 18:38:56 -0700 (PDT)
In-Reply-To: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: michal.simek@xilinx.com, soren.brinkmann@xilinx.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, han.fei@zte.com.cn, tang.qiang007@zte.com.cn

We get 1 warning when building kernel with W=1:
drivers/mmc/host/sdhci-of-arasan.c:253:6: warning: no previous prototype for 'sdhci_arasan_reset' [-Wmissing-prototypes]

In fact, this function is only used in the file in which it is
declared and don't need a declaration, but can be made static.
So this patch marks it 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
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
-- 
2.7.4


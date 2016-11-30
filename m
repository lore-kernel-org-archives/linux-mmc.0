From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: add spin_unlock_irq() before calling
 clk_round_rate
Date: Wed, 30 Nov 2016 15:05:42 +0900
Message-ID: <20161130060542.18225-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60203 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756437AbcK3GFq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 01:05:46 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHF00UHTY9KNB30@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 30 Nov 2016 15:05:44 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

Before calling clk_round_rate(), put the spin_unlock_irq() in
sdhci_s3c_consider_clock() function.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 784c5a8..de219ca 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -121,7 +121,9 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 	 * speed possible with selected clock source and skip the division.
 	 */
 	if (ourhost->no_divider) {
+		spin_unlock_irq(&ourhost->host->lock);
 		rate = clk_round_rate(clksrc, wanted);
+		spin_lock_irq(&ourhost->host->lock);
 		return wanted - rate;
 	}
 
-- 
2.10.2


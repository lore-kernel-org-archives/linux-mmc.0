From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/6] mmc: sdhci-spear: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 01:58:20 +0530
Message-ID: <1510950502-22565-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34343 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758621AbdKQU2s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Nov 2017 15:28:48 -0500
In-Reply-To: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, carlo@caione.org, khilman@baylibre.com, ben-linux@fluff.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/sdhci-spear.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 8c0f884..900838b 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -82,6 +82,10 @@ static int sdhci_probe(struct platform_device *pdev)
 	host->hw_name = "sdhci";
 	host->ops = &sdhci_pltfm_ops;
 	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq < 0) {
+		ret = host->irq;
+		goto err_host;
+	}
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
 
 	sdhci = sdhci_priv(host);
-- 
2.7.4


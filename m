From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/6] mmc: sdhci-acpi: Handle return value of platform_get_irq
Date: Sat, 18 Nov 2017 01:58:19 +0530
Message-ID: <1510950502-22565-4-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44413 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761011AbdKQU2o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Nov 2017 15:28:44 -0500
In-Reply-To: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, carlo@caione.org, khilman@baylibre.com, ben-linux@fluff.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/sdhci-acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b988997..dd8129e 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -566,6 +566,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->hw_name	= "ACPI";
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
+	if (host->irq < 0) {
+		err = host->irq;
+		goto err_free;
+	}
 
 	host->ioaddr = devm_ioremap_nocache(dev, iomem->start,
 					    resource_size(iomem));
-- 
2.7.4


From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/6 v3] mmc: sdhci-acpi: Handle return value of platform_get_irq
Date: Sun, 19 Nov 2017 10:22:45 +0530
Message-ID: <ecd11732b6a29aee23a1be94616755e575b0d438.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45536 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdKSExJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Nov 2017 23:53:09 -0500
In-Reply-To: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk, carlo@caione.org, khilman@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes in v3 :
              return -EINVAL instead of host->irq.

 drivers/mmc/host/sdhci-acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b988997..0d9965b 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -566,6 +566,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->hw_name	= "ACPI";
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
+		err = -EINVAL;
+		goto err_free;
+	}
 
 	host->ioaddr = devm_ioremap_nocache(dev, iomem->start,
 					    resource_size(iomem));
-- 
2.7.4


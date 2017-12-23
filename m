From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v3 07/27] mmc: replace devm_ioremap_nocache with devm_ioremap
Date: Sat, 23 Dec 2017 18:58:29 +0800
Message-ID: <1514026709-32921-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:46165 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757136AbdLWLHV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 23 Dec 2017 06:07:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: ysxie@foxmail.com, Yisheng Xie <xieyisheng1@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/mmc/host/sdhci-acpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b988997..b1aa909 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -567,8 +567,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
 
-	host->ioaddr = devm_ioremap_nocache(dev, iomem->start,
-					    resource_size(iomem));
+	host->ioaddr = devm_ioremap(dev, iomem->start, resource_size(iomem));
 	if (host->ioaddr == NULL) {
 		err = -ENOMEM;
 		goto err_free;
-- 
1.8.3.1


From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 4/9] mmc: sdhci-pci: use to_pci_dev()
Date: Sun, 27 Dec 2015 18:46:00 +0800
Message-ID: <7ec8850ded7ef24fa8e68d2482ac1046f1a9dc1b.1451211133.git.geliangtang@163.com>
References: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m50-133.163.com ([123.125.50.133]:60126 "EHLO m50-133.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbbL0KrJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 27 Dec 2015 05:47:09 -0500
In-Reply-To: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
In-Reply-To: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
References: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Guo <peter.guo@bayhubtech.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Use to_pci_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 08f4a9f..cc851b0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1464,7 +1464,7 @@ static int sdhci_pci_resume(struct device *dev)
 
 static int sdhci_pci_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
 	int i, ret;
@@ -1500,7 +1500,7 @@ err_pci_runtime_suspend:
 
 static int sdhci_pci_runtime_resume(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
 	int i, ret;
-- 
2.5.0



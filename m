From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mmc: sdhci-pci: Use dev_get_drvdata
Date: Tue, 23 Jul 2019 20:47:07 +0800
Message-ID: <20190723124707.24782-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 4041878eb0f3..d10aceed5bb7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1759,8 +1759,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
 #ifdef CONFIG_PM_SLEEP
 static int sdhci_pci_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
+	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
 
 	if (!chip)
 		return 0;
@@ -1773,8 +1772,7 @@ static int sdhci_pci_suspend(struct device *dev)
 
 static int sdhci_pci_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
+	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
 
 	if (!chip)
 		return 0;
@@ -1789,8 +1787,7 @@ static int sdhci_pci_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int sdhci_pci_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
+	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
 
 	if (!chip)
 		return 0;
@@ -1803,8 +1800,7 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
 
 static int sdhci_pci_runtime_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
+	struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
 
 	if (!chip)
 		return 0;
-- 
2.20.1

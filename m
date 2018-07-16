From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V7 5/5] mmc: sdhci: Add MSI interrupt support for O2 SD host
Date: Mon, 16 Jul 2018 14:26:55 +0800
Message-ID: <20180716062655.24703-5-ernest.zhang@bayhubtech.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com, mike.li@bayhubtech.com, chevron.li@bayhubtech.com, shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com, bobby.wu@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

Add MSI interrupt support if the SD host device can support MSI interrupt.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Changes in V7:
	N/A

Changes in V6:
	1. Move change log to correct place.
	2. Reduce unneeded pr_info prints.
	3. In function sdhci_pci_o2_probe_slot, remove using local
	variable 'mmc' instead of using 'host->mmc'.
	4. Make the msi enable code a sperate function.

Changes in V5:
	1. Because pci_enable_msi is marked as deprecated and should not be
	used in new code, use pci_alloc_irq_vectors instead.
	2. Remove unneeded CONFIG_PCI_MSI macro check.

Changes in V4:
	Enable MSI interrupt if the MSI capability bit is set in
	capability register.

Changes in V1~V3:
	N/A
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 7747e8ba2e3d..56bc71763956 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -260,6 +260,29 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
 	pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL4, scratch_32);
 }
 
+static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
+				    struct sdhci_host *host)
+{
+	int ret;
+
+	ret = pci_find_capability(chip->pdev, PCI_CAP_ID_MSI);
+	if (!ret) {
+		pr_info("%s: unsupport msi, use INTx irq\n",
+			mmc_hostname(host->mmc));
+		return;
+	}
+
+	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
+				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	if (ret < 0) {
+		pr_err("%s: enable PCI MSI failed, err=%d\n",
+		       mmc_hostname(host->mmc), ret);
+		return;
+	}
+
+	host->irq = pci_irq_vector(chip->pdev, 0);
+}
+
 int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
@@ -279,6 +302,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		sdhci_pci_o2_enable_msi(chip, host);
+
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_MISC_SETTING, &reg);
-- 
2.17.1

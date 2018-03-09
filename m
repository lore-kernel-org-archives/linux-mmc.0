From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V4 3/3] mmc: sdhci: Add MSI interrupt support for O2 SD host
Date: Fri,  9 Mar 2018 22:04:25 +0800
Message-ID: <1520604265-4430-3-git-send-email-ernest.zhang@bayhubtech.com>
References: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520604265-4430-1-git-send-email-ernest.zhang@bayhubtech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com, yuxiang.wan@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

Add MSI interrupt support if the SD host device can support MSI interrupt.

Changes: Enable MSI interrupt if the MSI capability bit is set in 
capability register.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index a918984..7d04f4b 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -391,6 +391,23 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+#if defined(CONFIG_PCI_MSI)
+		if (pci_find_capability(chip->pdev, PCI_CAP_ID_MSI)) {
+			ret = pci_enable_msi(chip->pdev);
+			if (!ret) {
+				host->irq = chip->pdev->irq;
+				pr_info("%s: use MSI irq, irq=%d\n",
+					mmc_hostname(host->mmc), host->irq);
+			} else {
+				pr_err("%s: enable PCI MSI failed, err=%d\n",
+					mmc_hostname(host->mmc), ret);
+			}
+		} else {
+			pr_info("%s: unsupport msi, use INTx irq\n",
+				mmc_hostname(host->mmc));
+		}
+#endif
+
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_MISC_SETTING, &reg);
-- 
2.7.4

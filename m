From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 107/167] mmc: sdhci-pci: Add support for Intel CML
Date: Tue,  3 Sep 2019 12:24:19 -0400
Message-ID: <20190903162519.7136-107-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 765c59675ab571caf7ada456bbfd23a73136b535 ]

Add PCI Ids for Intel CML.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 ++
 drivers/mmc/host/sdhci-pci.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index c4115bae5db18..71794391f48fa 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1577,6 +1577,8 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(INTEL, CNPH_SD,   intel_byt_sd),
 	SDHCI_PCI_DEVICE(INTEL, ICP_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(INTEL, ICP_SD,    intel_byt_sd),
+	SDHCI_PCI_DEVICE(INTEL, CML_EMMC,  intel_glk_emmc),
+	SDHCI_PCI_DEVICE(INTEL, CML_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(O2, 8120,     o2),
 	SDHCI_PCI_DEVICE(O2, 8220,     o2),
 	SDHCI_PCI_DEVICE(O2, 8221,     o2),
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 2ef0bdca91974..6f04a62b2998e 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -50,6 +50,8 @@
 #define PCI_DEVICE_ID_INTEL_CNPH_SD	0xa375
 #define PCI_DEVICE_ID_INTEL_ICP_EMMC	0x34c4
 #define PCI_DEVICE_ID_INTEL_ICP_SD	0x34f8
+#define PCI_DEVICE_ID_INTEL_CML_EMMC	0x02c4
+#define PCI_DEVICE_ID_INTEL_CML_SD	0x02f5
 
 #define PCI_DEVICE_ID_SYSKONNECT_8000	0x8000
 #define PCI_DEVICE_ID_VIA_95D0		0x95d0
-- 
2.20.1

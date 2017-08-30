From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2] mmc: mmci: stop building qcom dml as module
Date: Wed, 30 Aug 2017 14:22:12 +0200
Message-ID: <20170830122212.8590-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: arnd@arndb.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

It does not make sense for qcom dml code to be a seperate module, as
this has just 2 helper functions specific to qcom, and used directly by
mmci driver, so just compile this along with main mmci driver.

This would also fix issues arrising due to Kconfig combinations between
mmci and qcom dml.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/Kconfig  | 2 +-
 drivers/mmc/host/Makefile | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5755b69..3345384 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -15,7 +15,7 @@ config MMC_ARMMMCI
 	  If unsure, say N.
 
 config MMC_QCOM_DML
-	tristate "Qualcomm Data Mover for SD Card Controller"
+	bool "Qualcomm Data Mover for SD Card Controller"
 	depends on MMC_ARMMMCI && QCOM_BAM_DMA
 	default y
 	help
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4d45471..ef12fd2 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -2,8 +2,9 @@
 # Makefile for MMC/SD host controller drivers
 #
 
-obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o
-obj-$(CONFIG_MMC_QCOM_DML)	+= mmci_qcom_dml.o
+obj-$(CONFIG_MMC_ARMMMCI) += armmmci.o
+armmmci-y := mmci.o
+armmmci-$(CONFIG_MMC_QCOM_DML) += mmci_qcom_dml.o
 obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
-- 
2.9.3

From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: [PATCH 3/3] mmc: sdhci-msm: Get COMPILE_TEST support
Date: Fri, 11 Jul 2014 20:48:13 +0300
Message-ID: <1405100893-32107-4-git-send-email-gdjakov@mm-sol.com>
References: <1405100893-32107-1-git-send-email-gdjakov@mm-sol.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1405100893-32107-1-git-send-email-gdjakov@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Georgi Djakov <gdjakov@mm-sol.com>
List-Id: linux-mmc@vger.kernel.org

Increase the build testing coverage.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index a565254..1325cae 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -343,7 +343,7 @@ config MMC_ATMELMCI
 
 config MMC_SDHCI_MSM
 	tristate "Qualcomm SDHCI Controller Support"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on MMC_SDHCI_PLTFM
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-- 
1.7.9.5

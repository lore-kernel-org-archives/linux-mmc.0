From: Sayali Lokhande <sayalil@codeaurora.org>
Subject: [PATCH RFC 5/7] mmc: sdhci-msm: Kconfig: select devfreq ondemand for sdhci-msm
Date: Fri, 13 Jul 2018 15:23:01 +0530
Message-ID: <1531475583-7050-6-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

SDHCI-MSM platform is using devfreq ondemand governor.
Select devfreq governor for SDHCI-MSM platform.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/mmc/host/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c19..2ba2c62 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -442,6 +442,8 @@ config MMC_SDHCI_MSM
 	tristate "Qualcomm SDHCI Controller Support"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on MMC_SDHCI_PLTFM
+	select PM_DEVFREQ
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

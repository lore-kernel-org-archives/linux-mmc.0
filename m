From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH 5/5] defconfig: msm: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date: Fri, 18 Aug 2017 10:49:42 +0530
Message-ID: <1503033582-48703-6-git-send-email-vviswana@codeaurora.org>
References: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org, Vijay Viswanath <vviswana@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
register read and write APIs, if registered, can be used.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 65cdd87..a3c93ed 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -398,6 +398,7 @@ CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MMC_SDHCI_MSM=y
+CONFIG_MMC_SDHCI_IO_ACCESSORS=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

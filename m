From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v3 3/5] arm: configs: remove CONFIG_MMC_DW_IDMAC
Date: Wed,  5 Aug 2015 16:18:10 +0800
Message-ID: <1438762690-22286-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: dianders@chromium.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Stefan Agner <stefan@agner.ch>, Zhou Wang <wangzhou.bry@gmail.com>, Kumar Gala <galak@codeaurora.org>, Alim Akhtar <alim.akhtar@samsung.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Wang Long <long.wanglong@huawei.com>, Rob Herring <robh+dt@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jun Nie <jun.nie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>, Govindraj Raja <govind>
List-Id: linux-mmc@vger.kernel.org

DesignWare MMC Controller's transfer mode should be decided
at runtime instead of compile-time. So we remove this config
option, and elaborate more in Documentation(synopsys-dw-mshc).

Modify these files:
arch/arc/configs/axs101_defconfig
arch/arc/configs/axs103_defconfig
arch/arc/configs/axs103_smp_defconfig
arch/arm/configs/exynos_defconfig
arch/arm/configs/hisi_defconfig
arch/arm/configs/lpc18xx_defconfig
arch/arm/configs/multi_v7_defconfig
arch/arm/configs/zx_defconfig

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 arch/arc/configs/axs101_defconfig     | 1 -
 arch/arc/configs/axs103_defconfig     | 1 -
 arch/arc/configs/axs103_smp_defconfig | 1 -
 arch/arm/configs/exynos_defconfig     | 1 -
 arch/arm/configs/hisi_defconfig       | 1 -
 arch/arm/configs/lpc18xx_defconfig    | 1 -
 arch/arm/configs/multi_v7_defconfig   | 1 -
 arch/arm/configs/zx_defconfig         | 1 -
 8 files changed, 8 deletions(-)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 562dac6..c92c0ef 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -89,7 +89,6 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 83a6d8d..cfac24e 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -95,7 +95,6 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index f1e1c84..9922a11 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -96,7 +96,6 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 9504e77..7e4af6e 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -161,7 +161,6 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S3C=y
 CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 5997dbc..b2e340b 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -69,7 +69,6 @@ CONFIG_NOP_USB_XCEIV=y
 CONFIG_MMC=y
 CONFIG_RTC_CLASS=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 1c47f86..b7e8cda 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -119,7 +119,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_PCA9532=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fd8df6..a3734b5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -520,7 +520,6 @@ CONFIG_MMC_ATMELMCI=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
diff --git a/arch/arm/configs/zx_defconfig b/arch/arm/configs/zx_defconfig
index b200bb0..ab683fb 100644
--- a/arch/arm/configs/zx_defconfig
+++ b/arch/arm/configs/zx_defconfig
@@ -83,7 +83,6 @@ CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.3.7

From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RFC PATCH v5 4/9] arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
Date: Fri, 14 Aug 2015 16:35:28 +0800
Message-ID: <1439541328-30271-1-git-send-email-shawn.lin@rock-chips.com>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1439541232-30100-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Alexey Brodkin <abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Govindraj Raja <govindraj.raja-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

DesignWare MMC Controller's transfer mode should be decided
at runtime instead of compile-time. So we remove this config
option and read dw_mmc's register to select DMA master.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Acked-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arc/configs/axs101_defconfig     | 1 -
 arch/arc/configs/axs103_defconfig     | 1 -
 arch/arc/configs/axs103_smp_defconfig | 1 -
 3 files changed, 3 deletions(-)

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
-- 
2.3.7

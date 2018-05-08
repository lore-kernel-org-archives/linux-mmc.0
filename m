From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH v7 3/3] arm64: defconfig: Enable dw_mmc-bluefield driver
Date: Tue,  8 May 2018 14:46:50 -0400
Message-ID: <1525805210-15246-3-git-send-email-lsun@mellanox.com>
References: <1525805210-15246-1-git-send-email-lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525805210-15246-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch updates arm64 defconfig to enable dw_mmc-bluefield,
which is a driver extension of Synopsys Designware MMC for the
Mellanox BlueField Soc.

Signed-off-by: Liming Sun <lsun@mellanox.com>
Reviewed-by: David Woods <dwoods@mellanox.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..43464ab 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -487,6 +487,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_K3=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_DW_BLUEFIELD=y
 CONFIG_MMC_SUNXI=y
 CONFIG_MMC_BCM2835=y
 CONFIG_MMC_SDHCI_XENON=y
-- 
1.8.3.1

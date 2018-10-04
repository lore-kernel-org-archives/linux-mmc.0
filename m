From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 6/6] arm64: defconfig: Enable MMC PHY for AM65xx
Date: Thu, 4 Oct 2018 16:44:51 +0530
Message-ID: <20181004111451.9539-7-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111451.9539-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, faiz_abbas@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org, catalin.marinas@arm.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Enable the MMC phy implemented in the AM65xx SOC.
This phy is required for the sdhci host controller
driving the MMC ports.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a51967154caa..d897ec2ba390 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -659,6 +659,7 @@ CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_UNIPHIER_USB2=y
+CONFIG_PHY_AM654_MMC=y
 CONFIG_HISI_PMU=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
-- 
2.18.0

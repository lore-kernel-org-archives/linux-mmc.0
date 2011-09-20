From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH REPOST 2/2] arm/dt: Tegra: Add support-8bit to SDHCI nodes
Date: Tue, 20 Sep 2011 10:46:26 -0600
Message-ID: <1316537186-26753-2-git-send-email-swarren@nvidia.com>
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, nicolas.pitre@linaro.org
Cc: Olof Johansson <olof@lixom.net>, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

For Seaboard's internal eMMC, this makes the difference between a
5.5MB/s and 10.2MB/s transfer rate. On Harmony, there wasn't any
measurable difference on my cheap/slow ~2MB/s card.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-harmony.dts  |    1 +
 arch/arm/boot/dts/tegra-seaboard.dts |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index e581866..0e225b8 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -66,5 +66,6 @@
 		cd-gpios = <&gpio 58 0>; /* gpio PH2 */
 		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
+		support-8bit;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 64cedca..a72299b 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -25,4 +25,8 @@
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 	};
+
+	sdhci@c8000600 {
+		support-8bit;
+	};
 };
-- 
1.7.0.4

From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 3/3] arm/dt: Tegra: Add support-bit to SDHCI nodes
Date: Tue, 30 Aug 2011 13:17:17 -0600
Message-ID: <1314731837-6985-3-git-send-email-swarren@nvidia.com>
References: <1314731837-6985-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314731837-6985-1-git-send-email-swarren@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>
Cc: Olof Johansson <olof@lixom.net>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

For Seaboard's internal eMMC, this makes the difference between a
5.5MB/s and 10.2MB/s transfer rate. On Harmony, there wasn't any
measurable difference on my cheap/slow ~2MB/s card.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This depends on patch 1 in this series. I assume Grant or Arnd will apply
them both to whatever branch usually takes .dts updates.

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

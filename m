From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/4] ARM tegra: add SDHCI nodes with common properties
Date: Wed, 20 Feb 2013 13:35:14 -0500
Message-ID: <1361385317-6020-2-git-send-email-rklein@nvidia.com>
References: <1361385317-6020-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361385317-6020-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pritesh Raithatha <praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Pritesh Raithatha <praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This patch adds in the SDHCI nodes for the busses supported on Tegra114
boards.

Signed-off-by: Pritesh Raithatha <praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
[Rhyland added clk refs to & reordered sdhci nodes and removed spaces]
Signed-off-by: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra114.dtsi |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 1dfaf28..92d4c7d 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -92,6 +92,38 @@
 		status = "disabled";
 	};
 
+	sdhci@78000000 {
+		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
+		reg = <0x78000000 0x200>;
+		interrupts = <0 14 0x04>;
+		clocks = <&tegra_car 14>;
+		status = "disable";
+	};
+
+	sdhci@78000200 {
+		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
+		reg = <0x78000200 0x200>;
+		interrupts = <0 15 0x04>;
+		clocks = <&tegra_car 9>;
+		status = "disable";
+	};
+
+	sdhci@78000400 {
+		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
+		reg = <0x78000400 0x200>;
+		interrupts = <0 19 0x04>;
+		clocks = <&tegra_car 69>;
+		status = "disable";
+	};
+
+	sdhci@78000600 {
+		compatible = "nvidia,tegra114-sdhci", "nvidia,tegra30-sdhci";
+		reg = <0x78000600 0x200>;
+		interrupts = <0 31 0x04>;
+		clocks = <&tegra_car 15>;
+		status = "disable";
+	};
+
 	rtc {
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
-- 
1.7.9.5

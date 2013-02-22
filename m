From: Joseph Lo <josephl@nvidia.com>
Subject: [PATCH V2 1/2] ARM: dts: tegra: fix the activate polarity of cd-gpio in mmc host
Date: Fri, 22 Feb 2013 11:23:39 +0800
Message-ID: <1361503420-16473-2-git-send-email-josephl@nvidia.com>
References: <1361503420-16473-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:4550 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab3BVDX5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 22:23:57 -0500
In-Reply-To: <1361503420-16473-1-git-send-email-josephl@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, Joseph Lo <josephl@nvidia.com>

The GPIO pin of SD slot card detection should active low.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
---
V2:
* add Tamonten-based board
* add Toradex-based board (assume it also need this fix)
---
 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 2 +-
 arch/arm/boot/dts/tegra20-harmony.dts      | 4 ++--
 arch/arm/boot/dts/tegra20-paz00.dts        | 2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts     | 2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi    | 2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts    | 2 +-
 arch/arm/boot/dts/tegra20-ventana.dts      | 2 +-
 arch/arm/boot/dts/tegra20-whistler.dts     | 1 +
 arch/arm/boot/dts/tegra30-beaver.dts       | 2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi      | 2 +-
 10 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 4441620..cb73e62 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -444,7 +444,7 @@
 	};
 
 	sdhci@c8000600 {
-		cd-gpios = <&gpio 23 0>; /* gpio PC7 */
+		cd-gpios = <&gpio 23 1>; /* gpio PC7 */
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 61d027f..1f79c0d 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -437,7 +437,7 @@
 
 	sdhci@c8000200 {
 		status = "okay";
-		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 155 0>; /* gpio PT3 */
 		bus-width = <4>;
@@ -445,7 +445,7 @@
 
 	sdhci@c8000600 {
 		status = "okay";
-		cd-gpios = <&gpio 58 0>; /* gpio PH2 */
+		cd-gpios = <&gpio 58 1>; /* gpio PH2 */
 		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 		bus-width = <8>;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 54d6fce..9db36da 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -436,7 +436,7 @@
 
 	sdhci@c8000000 {
 		status = "okay";
-		cd-gpios = <&gpio 173 0>; /* gpio PV5 */
+		cd-gpios = <&gpio 173 1>; /* gpio PV5 */
 		wp-gpios = <&gpio 57 0>;  /* gpio PH1 */
 		power-gpios = <&gpio 169 0>; /* gpio PV1 */
 		bus-width = <4>;
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 37b3a57..715a8b8 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -584,7 +584,7 @@
 
 	sdhci@c8000400 {
 		status = "okay";
-		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 		bus-width = <4>;
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 4766aba..6e9d91f 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -465,7 +465,7 @@
 	};
 
 	sdhci@c8000600 {
-		cd-gpios = <&gpio 58 0>; /* gpio PH2 */
+		cd-gpios = <&gpio 58 1>; /* gpio PH2 */
 		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
 		bus-width = <4>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 5d79e4f..98f3e44 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -325,7 +325,7 @@
 
 	sdhci@c8000600 {
 		status = "okay";
-		cd-gpios = <&gpio 121 0>; /* gpio PP1 */
+		cd-gpios = <&gpio 121 1>; /* gpio PP1 */
 		wp-gpios = <&gpio 122 0>; /* gpio PP2 */
 		bus-width = <4>;
 	};
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 425c890..4aef56f 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -520,7 +520,7 @@
 
 	sdhci@c8000400 {
 		status = "okay";
-		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
 		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 		bus-width = <4>;
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index ea57c0f..5762188 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -510,6 +510,7 @@
 
 	sdhci@c8000400 {
 		status = "okay";
+		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
 		wp-gpios = <&gpio 173 0>; /* gpio PV5 */
 		bus-width = <8>;
 	};
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 8ff2ff2..0a2cd24 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -257,7 +257,7 @@
 
 	sdhci@78000000 {
 		status = "okay";
-		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
 		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
 		power-gpios = <&gpio 31 0>; /* gpio PD7 */
 		bus-width = <4>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 1749927..3e2d210 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -311,7 +311,7 @@
 
 	sdhci@78000000 {
 		status = "okay";
-		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
 		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
 		power-gpios = <&gpio 31 0>; /* gpio PD7 */
 		bus-width = <4>;
-- 
1.8.1.1


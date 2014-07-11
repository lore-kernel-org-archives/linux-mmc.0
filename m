From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: [PATCH 1/3] mmc: sdhci-msm: Fix the binding example
Date: Fri, 11 Jul 2014 20:48:11 +0300
Message-ID: <1405100893-32107-2-git-send-email-gdjakov@mm-sol.com>
References: <1405100893-32107-1-git-send-email-gdjakov@mm-sol.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405100893-32107-1-git-send-email-gdjakov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Georgi Djakov <gdjakov@mm-sol.com>
List-Id: linux-mmc@vger.kernel.org

The DT binding example in the documentation is missing the -supply
suffix for the vmmc and vqmmc regulators. Fix it.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt          |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 81b33b5..485483a 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -27,8 +27,8 @@ Example:
 		bus-width = <8>;
 		non-removable;
 
-		vmmc = <&pm8941_l20>;
-		vqmmc = <&pm8941_s3>;
+		vmmc-supply = <&pm8941_l20>;
+		vqmmc-supply = <&pm8941_s3>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
@@ -44,8 +44,8 @@ Example:
 		bus-width = <4>;
 		cd-gpios = <&msmgpio 62 0x1>;
 
-		vmmc = <&pm8941_l21>;
-		vqmmc = <&pm8941_l13>;
+		vmmc-supply = <&pm8941_l21>;
+		vqmmc-supply = <&pm8941_l13>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
-- 
1.7.9.5

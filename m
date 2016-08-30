From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 08/11] arm64: r8a7795: Set maximum frequencies for SDHI clocks
Date: Tue, 30 Aug 2016 23:09:56 +0200
Message-ID: <1472591399-13907-9-git-send-email-horms+renesas@verge.net.au>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45906 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758632AbcH3VK3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 17:10:29 -0400
In-Reply-To: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5
* New patch
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 70949f4d50a2..f83b87e9366e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1099,6 +1099,7 @@
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 314>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			max-frequency = <200000000>;
 			status = "disabled";
 		};
 
@@ -1108,6 +1109,7 @@
 			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 313>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			max-frequency = <200000000>;
 			status = "disabled";
 		};
 
@@ -1117,6 +1119,7 @@
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 312>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			max-frequency = <200000000>;
 			status = "disabled";
 		};
 
@@ -1126,6 +1129,7 @@
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 311>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			max-frequency = <200000000>;
 			status = "disabled";
 		};
 
-- 
2.7.0.rc3.207.g0ac5344


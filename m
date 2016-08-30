From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 07/11] arm64: dts: r8a7795: remove unnecessary cap-mmc-highspeed property
Date: Tue, 30 Aug 2016 23:09:55 +0200
Message-ID: <1472591399-13907-8-git-send-email-horms+renesas@verge.net.au>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45906 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758650AbcH3VKc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 17:10:32 -0400
In-Reply-To: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Remove cap-mmc-highspeed property from SDHI2 and SDHI3.

This property is unnecessary as the driver automatically sets
the highspeed capability. Furthermore its use is inconsistent with SDHI0
and SDHI1 which are also highspeed capable but do not have this property
present.

Found by inspection.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5
* New patch
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b902356873c2..70949f4d50a2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1117,7 +1117,6 @@
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 312>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			cap-mmc-highspeed;
 			status = "disabled";
 		};
 
@@ -1127,7 +1126,6 @@
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 311>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			cap-mmc-highspeed;
 			status = "disabled";
 		};
 
-- 
2.7.0.rc3.207.g0ac5344


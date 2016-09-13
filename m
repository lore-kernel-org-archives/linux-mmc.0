From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v7 03/11] arm64: dts: r8a7795: salvator-x: Enable UHS-I SDR-104
Date: Tue, 13 Sep 2016 12:57:00 +0200
Message-ID: <1473764228-24768-4-git-send-email-horms+renesas@verge.net.au>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Add the sd-uhs-sdr104 property to SDHI0 and SDHI1.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5
* New patch
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index ff4e4fe843ed..8964b1ea3cea 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -394,6 +394,7 @@
 	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
@@ -408,6 +409,7 @@
 	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 3/3] arm64: renesas: salvator: set driver type for eMMC
Date: Sun, 15 Oct 2017 14:46:15 +0200
Message-ID: <20171015124615.31391-4-wsa+renesas@sang-engineering.com>
References: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

These boards are known to have eMMC issues with the default driver type.
Specify a working one.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

no changes since v2

 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 4786c67b5e6527..215e2d11a0490a 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -579,6 +579,7 @@
 	bus-width = <8>;
 	mmc-hs200-1_8v;
 	non-removable;
+	fixed-emmc-driver-type = <1>;
 	status = "okay";
 };
 
-- 
2.11.0

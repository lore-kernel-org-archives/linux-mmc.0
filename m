From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 3/3] arm64: renesas: salvator: set driver type for eMMC
Date: Wed,  4 Oct 2017 19:39:20 +0200
Message-ID: <20171004173920.15232-4-wsa+renesas@sang-engineering.com>
References: <20171004173920.15232-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171004173920.15232-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Adrian Hunter <adrian.hunter@intel.com>, Marek Vasut <marek.vasut@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

These boards are known to have eMMC issues with the default driver type.
Specify a working one.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since RFC v1:
* rebased to mmc/next based on 4.14-rc3
* moved the property to salvator common because the BSP applies this property
  to all Salvator variants, too

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

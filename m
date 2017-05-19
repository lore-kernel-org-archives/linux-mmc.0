From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 36/41] ARM: dts: am57xx-idk: Set MMC2 IO voltage to 3.3V
Date: Fri, 19 May 2017 13:45:36 +0530
Message-ID: <20170519081541.26753-37-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

MMC2 interface on AM57xx IDK, connected to
onboard eMMC, has IO voltage fixed to 3.3V.

Add no-1-8-v device-tree property to mmc2 node
in the board's device-tree file to reflect
this.

Note that the AM57xx SoC itself supports
dual-voltage on MMC2. The limitation above is
due to the board.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 5d6965ab7339..a8c9e5f714e4 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -413,6 +413,7 @@
 	bus-width = <8>;
 	ti,non-removable;
 	max-frequency = <96000000>;
+	no-1-8-v;
 	/delete-property/ mmc-hs200-1_8v;
 };
 
-- 
2.11.0

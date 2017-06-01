From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/7] ARM: dts: dra72-evm: Add vmmc_aux supply to mmc1
Date: Thu, 1 Jun 2017 20:03:56 +0530
Message-ID: <20170601143401.16852-3-kishon@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170601143401.16852-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add vmmc_aux-supply property to mmc1 dt node and populate
it with ldo1_reg to reflect ldo1_out is connected to mmc1 IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index adbcc570eba9..b25e7c67badf 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -54,6 +54,10 @@
 	phy-mode = "rgmii";
 };
 
+&mmc1 {
+	vmmc_aux-supply = <&ldo1_reg>;
+};
+
 &mmc2 {
 	vmmc-supply = <&evm_1v8_sw>;
 };
-- 
2.11.0

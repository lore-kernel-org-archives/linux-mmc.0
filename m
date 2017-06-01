From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/7] ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes
Date: Thu, 1 Jun 2017 20:04:00 +0530
Message-ID: <20170601143401.16852-7-kishon@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170601143401.16852-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Add "max-frequency" property to MMC dt nodes and set the
maximum frequency to 192MHz for MMC1/MMC2, 64MHz for MMC3
and 192MHz for MMC4. pdata quirks must be utilized to
detect presence of rev 1.1/1.0 of silicon and adjust
maximum frequencies as per restrictions documented in i843.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e7144662af45..c09a91e77f53 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1037,6 +1037,7 @@
 			dma-names = "tx", "rx";
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
+			max-frequency = <192000000>;
 		};
 
 		mmc2: mmc@480b4000 {
@@ -1048,6 +1049,7 @@
 			dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			max-frequency = <192000000>;
 		};
 
 		mmc3: mmc@480ad000 {
@@ -1059,6 +1061,8 @@
 			dmas = <&sdma_xbar 77>, <&sdma_xbar 78>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			/* Errata i887 limits max-frequency of MMC3 to 64 MHz */
+			max-frequency = <64000000>;
 		};
 
 		mmc4: mmc@480d1000 {
@@ -1070,6 +1074,7 @@
 			dmas = <&sdma_xbar 57>, <&sdma_xbar 58>;
 			dma-names = "tx", "rx";
 			status = "disabled";
+			max-frequency = <192000000>;
 		};
 
 		mmu0_dsp1: mmu@40d01000 {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

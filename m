From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 8/9] ARM: shmobile: r8a7790: Set maximum frequencies for SDHI clocks
Date: Fri,  1 Apr 2016 17:44:38 +0200
Message-ID: <1459525479-20842-9-git-send-email-wsa@the-dreams.de>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Taken from the datasheet.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index abd7d88c411e4a..1a3b6b08f1f3c9 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -607,6 +607,7 @@
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>,
 		       <&dmac0 0xcd>, <&dmac0 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <156000000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -619,6 +620,7 @@
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>,
 		       <&dmac0 0xc9>, <&dmac0 0xca>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <156000000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -631,6 +633,7 @@
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>,
 		       <&dmac0 0xc1>, <&dmac0 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <97500000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -643,6 +646,7 @@
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>,
 		       <&dmac0 0xd3>, <&dmac0 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
+		max-frequency = <97500000>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.7.0

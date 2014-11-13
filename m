From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 3/3] ARM: dts: dra72-evm: Set the max-frequency to 192MHz
Date: Thu, 13 Nov 2014 18:26:19 +0530
Message-ID: <1415883379-19654-4-git-send-email-kishon@ti.com>
References: <1415883379-19654-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1415883379-19654-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, afenkart@gmail.com, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Set the maximum operating frequency of MMC2 to 192MHz.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index abbaaa7..5cc1110 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -364,6 +364,7 @@
 	vmmc-supply = <&evm_3v3>;
 	bus-width = <8>;
 	ti,non-removable;
+	max-frequency = <192000000>;
 };
 
 &dra7_pmx_core {
-- 
1.7.9.5


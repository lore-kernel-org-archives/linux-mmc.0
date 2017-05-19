From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 18/41] ARM: dts: dra72-evm-revc: Add vmmc_aux supply to mmc1
Date: Fri, 19 May 2017 13:45:18 +0530
Message-ID: <20170519081541.26753-19-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:46370 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdESIRp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2017 04:17:45 -0400
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com

Add vmmc_aux-supply property to mmc1 dt node and populate
it with ldo1_reg to reflect ldo1_out is connected to mmc1 IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm-revc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 3ecac56bf504..58a2e6599ea7 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -82,3 +82,7 @@
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
 	};
 };
+
+&mmc1 {
+	vmmc_aux-supply = <&ldo1_reg>;
+};
-- 
2.11.0


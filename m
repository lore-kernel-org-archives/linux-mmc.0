From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 7/7] ARM: mvebu: Add Device Tree description of SDHCI for Armada 388 RD
Date: Wed, 21 Jan 2015 10:32:06 +0100
Message-ID: <1421832726-21656-8-git-send-email-gregory.clement@free-electrons.com>
References: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35010 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751501AbbAUJcd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jan 2015 04:32:33 -0500
In-Reply-To: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

The Device Tree description of SDHCI on Armada 388 RD board was
missing. This commit adds the node for it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-388-rd.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index c98a8f8d01a9..7dfede145ea3 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -51,6 +51,16 @@
 				clock-frequency = <100000>;
 			};
 
+			sdhci@d8000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&sdhci_pins>;
+				broken-cd;
+				no-1-8-v;
+				wp-inverted;
+				bus-width = <8>;
+				status = "okay";
+			};
+
 			serial@12000 {
 				status = "okay";
 			};
-- 
1.9.1


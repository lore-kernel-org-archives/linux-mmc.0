From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 08/12] dt-bindings: mmc: Add Xenon description
Date: Thu,  9 Jun 2016 09:10:14 +0200
Message-ID: <1465456218-28354-9-git-send-email-gregory.clement@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46286 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162058AbcFIHLb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 03:11:31 -0400
In-Reply-To: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

This patch documents the Xenon SDHCI controller that we can find in the
Armada 37xx and the Armada 7K and 8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/mmc/sdhci-xenon.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-xenon.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
new file mode 100644
index 000000000000..e8d49fda5f12
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
@@ -0,0 +1,27 @@
+* Marvell sdhci-xenon controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-xenon drivers.
+
+Required properties:
+- compatible: Should be "marvell,xenon-sdhci".
+- reg:
+  one register area for the SDHCI registers.
+- interrupts-extended: interrupt number and attributes
+- clocks: array of clocks required for SDHCI.
+- bus-width: max bus width in unit of bit, normally should be 1 bit, 4 bits or 8 bits
+
+Optional properties:
+- non-removable: whether card is non-removable.
+- auto-cmd12: whether cmd12 is sent automatically.
+Example:
+
+sdhci0: sdhci@D8000 {
+	compatible = "marvell,xenon-sdhci";
+	reg = <0xD8000 0x300>;
+	interrupts-extended = <&gic GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+	non-removable;
+	bus-width = <8>;
+	auto-cmd12;
+	status = "disabled";
+};
-- 
2.5.0


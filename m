From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 3/3] arm64: renesas: salvator-xs: set driver type for eMMC
Date: Fri, 15 Sep 2017 20:03:01 +0200
Message-ID: <20170915180301.29175-4-wsa+renesas@sang-engineering.com>
References: <20170915180301.29175-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50143 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdIOSDG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Sep 2017 14:03:06 -0400
In-Reply-To: <20170915180301.29175-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

This board is known to have eMMC issues with the default driver type.
Specify a working one.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index de354957144b48..542c447a4c1c67 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -107,3 +107,7 @@
 
 	status = "okay";
 };
+
+&sdhi2 {
+	fixed-emmc-driver-type = <1>;
+};
-- 
2.11.0


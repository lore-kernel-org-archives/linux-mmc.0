From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 3/7] ARM: dts: sabresd: add usdhc4 support
Date: Mon, 21 Oct 2013 22:27:03 +0800
Message-ID: <1382365627-26816-4-git-send-email-b29396@freescale.com>
References: <1382365627-26816-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:51133
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109Ab3JUOoQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2013 10:44:16 -0400
In-Reply-To: <1382365627-26816-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de, ulf.hansson@linaro.org

Add usdhc4 support which has an eMMC card mounted on board.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 39eafc2..76762a3 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -241,3 +241,12 @@
 	wp-gpios = <&gpio2 1 0>;
 	status = "okay";
 };
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4_1>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	status = "okay";
+};
-- 
1.7.2.rc3



From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 12/12] ARM: dts: berlin: Enable eMMC on Sony NSZ-GS7
Date: Fri,  3 Oct 2014 17:55:47 +0200
Message-ID: <1412351747-4188-13-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1412351747-4188-1-git-send-email-sebastian.hesselbarth@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412351747-4188-1-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

With SDHCI for BG2, we can now enable the port and allow to access
Samsung M8G2FA 8GB eMMC on Sony NSZ-GS7.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
index c72bfd468d10..5e5f3a90e465 100644
--- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
+++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
@@ -26,4 +26,11 @@
 	};
 };
 
+/* Samsung M8G2FA 8GB eMMC */
+&sdhci2 {
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
+
 &uart0 { status = "okay"; };
-- 
2.1.1

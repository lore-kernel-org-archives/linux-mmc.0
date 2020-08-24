Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C22C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D072078D
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 15:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YnDu15W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHXPNc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:13:32 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35293 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgHXPLC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 11:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598281862; x=1629817862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXlRuWDsgHzsC/cK9WaU+YzlpcD2wIPLoPF5OvjRa5Y=;
  b=YnDu15W7+DvtKBfO/E0pPe5Ol1gGBBnxy79SGIk3H5pa4x79WixmLiMB
   93kD+Xep07V8xPHKRWIzhbyJ5JPavHFgoiGKmrzhf89M0IASBKZ14+STi
   AQvGGs5I5CO/lY0+j2ynV6V3FxTfXvaewpSiE6UvSZ5NlCj3uibwDbrX0
   Kj4IupjjOO2hlFl4qMToRYPD+Cb1fgiaULxEiuUnyhhb5ergKexBmXcUi
   ZDZrkHs4A1Mf62CYHLLDpGkr72OUY/CHJ3fbOCqNofOoKtOo+sv2sw4Gn
   GuhQHr5oorfXnwFXccnv/JsjL+Q6Tn2nn6g5ftqD5N6dwxBqMNDjPd9b9
   w==;
IronPort-SDR: PmxUI0K/CNdw0HTnb+UnJqMLKUHOHC4uDGfK1xe5XsBTt3eF7HdE+rSAnCMh7lwi/klXSXwgn9
 ezjVX6lapBgBK9SoeRNsVQFvh6RyFxQxvP6Hz+ikktPKj4bpOc38r4qmeGoxYqmRsTlRHN6Re0
 FUAlsYnEDtq5GHTV6bf2J/d9rgOYw97yhqW9VbHHOg9+bZdQ/8zYZMrSw5LfmHq+eolL/Z4ktp
 B3ccMen0n3HgGlGIuH0dan/IThAWmkEH4IFll7PglLi5MuQzJFdJZXwmsz9pfWqDqfqhOh9wZ9
 py0=
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="92912590"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2020 08:11:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 08:10:25 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 24 Aug 2020 08:10:55 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 3/3] arm64: dts: sparx5: Add Sparx5 eMMC support
Date:   Mon, 24 Aug 2020 17:10:35 +0200
Message-ID: <20200824151035.31093-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200824151035.31093-1-lars.povlsen@microchip.com>
References: <20200824151035.31093-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This adds eMMC support to the applicable Sparx5 board configuration
files.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi     | 24 +++++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb125.dts      | 23 ++++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb134_emmc.dts | 23 ++++++++++++++++++
 .../boot/dts/microchip/sparx5_pcb135_emmc.dts | 23 ++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 84bca999420ef..c9dbd1a8b22b6 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/microchip,sparx5.h>
 
 / {
 	compatible = "microchip,sparx5";
@@ -162,6 +163,20 @@ timer1: timer@600105000 {
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		sdhci0: sdhci@600800000 {
+			compatible = "microchip,dw-sparx5-sdhci";
+			status = "disabled";
+			reg = <0x6 0x00800000 0x1000>;
+			pinctrl-0 = <&emmc_pins>;
+			pinctrl-names = "default";
+			clocks = <&clks CLK_ID_AUX1>;
+			clock-names = "core";
+			assigned-clocks = <&clks CLK_ID_AUX1>;
+			assigned-clock-rates = <800000000>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			bus-width = <8>;
+		};
+
 		gpio: pinctrl@6110101e0 {
 			compatible = "microchip,sparx5-pinctrl";
 			reg = <0x6 0x110101e0 0x90>, <0x6 0x10508010 0x100>;
@@ -191,6 +206,15 @@ i2c2_pins: i2c2-pins {
 				pins = "GPIO_28", "GPIO_29";
 				function = "twi2";
 			};
+
+			emmc_pins: emmc-pins {
+				pins = "GPIO_34", "GPIO_35", "GPIO_36",
+					"GPIO_37", "GPIO_38", "GPIO_39",
+					"GPIO_40", "GPIO_41", "GPIO_42",
+					"GPIO_43", "GPIO_44", "GPIO_45",
+					"GPIO_46", "GPIO_47";
+				function = "emmc";
+			};
 		};
 
 		i2c0: i2c@600101000 {
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
index 91ee5b6cfc37a..573309fe45823 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb125.dts
@@ -16,6 +16,29 @@ memory@0 {
 	};
 };
 
+&gpio {
+	emmc_pins: emmc-pins {
+		/* NB: No "GPIO_35", "GPIO_36", "GPIO_37"
+		 * (N/A: CARD_nDETECT, CARD_WP, CARD_LED)
+		 */
+		pins = "GPIO_34", "GPIO_38", "GPIO_39",
+			"GPIO_40", "GPIO_41", "GPIO_42",
+			"GPIO_43", "GPIO_44", "GPIO_45",
+			"GPIO_46", "GPIO_47";
+		drive-strength = <3>;
+		function = "emmc";
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <8>;
+	non-removable;
+	pinctrl-0 = <&emmc_pins>;
+	max-frequency = <8000000>;
+	microchip,clock-delay = <10>;
+};
+
 &i2c1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dts
index 10081a66961bb..bbb9852c1f151 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_emmc.dts
@@ -15,3 +15,26 @@ memory@0 {
 		reg = <0x00000000 0x00000000 0x10000000>;
 	};
 };
+
+&gpio {
+	emmc_pins: emmc-pins {
+		/* NB: No "GPIO_35", "GPIO_36", "GPIO_37"
+		 * (N/A: CARD_nDETECT, CARD_WP, CARD_LED)
+		 */
+		pins = "GPIO_34", "GPIO_38", "GPIO_39",
+			"GPIO_40", "GPIO_41", "GPIO_42",
+			"GPIO_43", "GPIO_44", "GPIO_45",
+			"GPIO_46", "GPIO_47";
+		drive-strength = <3>;
+		function = "emmc";
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	non-removable;
+	max-frequency = <52000000>;
+	bus-width = <8>;
+	microchip,clock-delay = <10>;
+};
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_emmc.dts b/arch/arm64/boot/dts/microchip/sparx5_pcb135_emmc.dts
index 741f0e12260e5..f82266fe2ad49 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_emmc.dts
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_emmc.dts
@@ -15,3 +15,26 @@ memory@0 {
 		reg = <0x00000000 0x00000000 0x10000000>;
 	};
 };
+
+&gpio {
+	emmc_pins: emmc-pins {
+		/* NB: No "GPIO_35", "GPIO_36", "GPIO_37"
+		 * (N/A: CARD_nDETECT, CARD_WP, CARD_LED)
+		 */
+		pins = "GPIO_34", "GPIO_38", "GPIO_39",
+			"GPIO_40", "GPIO_41", "GPIO_42",
+			"GPIO_43", "GPIO_44", "GPIO_45",
+			"GPIO_46", "GPIO_47";
+		drive-strength = <3>;
+		function = "emmc";
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	non-removable;
+	max-frequency = <52000000>;
+	bus-width = <8>;
+	microchip,clock-delay = <10>;
+};
-- 
2.27.0


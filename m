Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD25C433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13FC4207ED
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pcGpADbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgFIKVI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:21:08 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:33885 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgFIKU7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2020 06:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591698059; x=1623234059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uvdZLOXtOi7wg26h02hvchuYt3RHS4ijlXKYSpYjb/A=;
  b=pcGpADbzfKjMF7ZeN1FWSAPr1rvFtfn60uZxKv+fhG0/kolZ0jPFoD98
   9186fIkhXRwCRdtJ7X7UfDDeEzaQBNaUbYIN1tC1wsYX7sGHAQI9S04Oe
   lXktQRizowNRfyF+1JzAS2zNKbjLkVSt1NyQYdPNsqr5hlEbBdwu1zjej
   dl/qWdYZGGI36XTqWnm78U0PO9FpHq0FA/e+tIKVVgceigunb04JCyE3g
   006XBQXGadTc1oHy/Fj6an6n+zYnE6IaSVu1zWC3C3jSzp9xTYCC/4AFV
   5hQyFkU5oYY5Gj8IXj2b43mtD8UD+osW7hmYEnJ7lBFIxZPBEQZk1l6SY
   w==;
IronPort-SDR: CM/5mcfFvrCYnghsesSfofyMLt2nraWxG8jpg7ehNtqeAxUsrwXav3Pwwc+whY2PVa27Fa71hI
 vaN3+YeUUU7ryT+w5wl6aUfBQsTZJ1B13PsfsmOD5xYKdVzeDXy7qaB4OfHRJhpobN30uOIGYf
 F8a8TfEn9uDgkmcvlyRGW/cvesaQJsmxh+O3Mmo7q7MKpHSxBo7zup/C1OmTjWaRT1UQ0nIC49
 dGdLkVzptnrvm1bqyD6J1DVJoTbmB55+TItq+GGHmBdNW9p51rULWwnKUvVw0LcQ4MyPRw0yhB
 zCY=
X-IronPort-AV: E=Sophos;i="5.73,491,1583218800"; 
   d="scan'208";a="75959632"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 03:20:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 03:20:55 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 9 Jun 2020 03:20:52 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] arm64: dts: sparx5: Add Sparx5 eMMC support
Date:   Tue, 9 Jun 2020 12:20:08 +0200
Message-ID: <20200609102008.10530-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609102008.10530-1-lars.povlsen@microchip.com>
References: <20200609102008.10530-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This adds eMMC support to the applicable Sparx5 board configuration
files.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

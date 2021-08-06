Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC08C432BE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B1361050
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 11:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbhHFLdX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:33:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1563 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245541AbhHFLdW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 07:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628249588; x=1659785588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQOYpWS7Qrcgkx+VH2ts2v8g+61j0yRDKNU96qalLg4=;
  b=Rnm9vVU5D4m8Qf489qC5xnKgVPQshdxz7UuHBE3QzbqHh7BpcQxGsmT/
   LX0kev5uJVJXtqM130zGBvBOQWqPEQvZX+4eB3Rxwk+6wh5caAlPJ1DLZ
   HRrn1+OVaFouaCr9z5KK2YUDBKImECLEatD9aIqxYVq6MlmOcdb2goE99
   QrIyttTcnxdeF6Wf8o3fZT2m5wrKT4I7NllzEyVlrmRG2fEfltnivv6XT
   94Oy7UCSnUXroBSAwfYOrsUWel4xS5zil3oSMFw+9sQbfZ2ZqwaXi2w/J
   7+O3QebU6nRwJpkEJpA6VVGKGp4rWGd8UkyBBgF6BBSSrt5q12OegLgYG
   A==;
IronPort-SDR: N9C65RxcqZ5RibRA/eC5z1L/pV/gBDNOXlTzOYwpwpNylUaCJ3ylAAuoEdKVouZqPp4Vselt0P
 MJ6I92rqREF/8FpbNcqfE42jxt/mf/g/8SXuASVY0le5hSmWoblXXybnPCXG+IR8FCp8e3aEta
 mu7+SBZssYCxwVfwV/bOnOYuecFjhWjmfMJR3rBUyKFa5EF1StPR42VxSPfA9+qmk4jyC8C2ua
 dfWeoKyUFvVflXXwDZTSYMvTq2r6B8MbWGbZNCUZWcmwJneYD8YaxqoE+xYCXmjfdm3i17Wr49
 ATbysUABDpGKTeuoQyDN7edy
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="131292938"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2021 04:33:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 04:33:04 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 6 Aug 2021 04:32:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/4] ARM: dts: at91: sama5d27_wlsom1: add wifi device
Date:   Fri, 6 Aug 2021 14:30:01 +0300
Message-ID: <20210806113001.821660-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806113001.821660-1-claudiu.beznea@microchip.com>
References: <20210806113001.821660-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

SAMA5D27 WLSOM1 boards has a WILC3000 device soldered. Add proper
device tree nodes for this.

[eugen.hristev: original author of this code]
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[nicolas.ferre: original author of this code]
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[claudiu.beznea: adapt for mmc-pwrseq-sd8787, commit message]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 72 +++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index 025a78310e3a..de8bb3439aef 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -30,6 +30,16 @@ main_xtal {
 			clock-frequency = <24000000>;
 		};
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-sd8787";
+		reset-gpios = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
+		powerdown-gpios = <&pioA PIN_PA29 GPIO_ACTIVE_HIGH>;
+		reset-power-delay-ms = <5>;
+		pinctrl-0 = <&pinctrl_wilc_pwrseq>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
 };
 
 &flx1 {
@@ -310,5 +320,67 @@ pinctrl_qspi1_default: qspi1_default {
 			 <PIN_PB10__QSPI1_IO3>;
 		bias-pull-up;
 	};
+
+	pinctrl_sdmmc1_default: sdmmc1_default {
+		cmd-data {
+			pinmux = <PIN_PA28__SDMMC1_CMD>,
+				 <PIN_PA18__SDMMC1_DAT0>,
+				 <PIN_PA19__SDMMC1_DAT1>,
+				 <PIN_PA20__SDMMC1_DAT2>,
+				 <PIN_PA21__SDMMC1_DAT3>;
+			bias-disable;
+		};
+
+		conf-ck {
+			pinmux = <PIN_PA22__SDMMC1_CK>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_wilc_default: wilc_default {
+		conf-irq {
+			pinmux = <PIN_PB25__GPIO>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_wilc_pwrseq: wilc_pwrseq {
+		conf-ce-nrst {
+			pinmux = <PIN_PA27__GPIO>,
+				 <PIN_PA29__GPIO>;
+			bias-disable;
+		};
+
+		conf-rtcclk {
+			pinmux = <PIN_PB13__PCK1>;
+			bias-disable;
+		};
+	};
+};
+
+&sdmmc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc1_default>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	no-1-8-v;
+	non-removable;
+	status = "okay";
+
+	wilc: wilc@0 {
+		reg = <0>;
+		bus-width = <4>;
+		compatible = "microchip,wilc3000", "microchip,wilc1000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wilc_default>;
+		irq-gpios = <&pioA PIN_PB25 GPIO_ACTIVE_LOW>;
+		clocks = <&pmc PMC_TYPE_SYSTEM 9>;
+		clock-names = "rtc";
+		assigned-clocks = <&pmc PMC_TYPE_SYSTEM 9>;
+		assigned-clock-rates = <32768>;
+		status = "okay";
+	};
 };
 
-- 
2.25.1


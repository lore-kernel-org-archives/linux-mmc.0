Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C4C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE8361B4F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 08:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhHPI60 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 04:58:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3412 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhHPI60 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 04:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629104274; x=1660640274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zEDBcUygp2aN/sqFtPomk6+2LN5nut6ZU9LjTMWFbOE=;
  b=kwf18lMCa1cRX7tEhSItB45kjTw743Gb1CxsFntRSG4Po9OKFDxiIZRH
   OefaEbNgJPhfyd/Y6bwIg4KBg/ulnW6/y1Mr+cn9vSRJ584vx50uHI4pS
   injjBGpFbpJvF3STJDIr4qLGhk6h3XW5QAJ2fkko1XtohFrRP7j3WkZl0
   0lb95VhSOhcjnoGjOXV1hhBhvfEx7koJtoI4HaSFMWOldn/TVCXQCNV3H
   ak2FZU6z1A2AbzY9RunfApQPlEOl2ziyjtAnucv5t4f2PC8LiTx7agFmT
   7e7kB5y1AkafiHcsiUZWTCTz9kX8rjsJ2vC5V2CbkM6rXcP4ax79n+ZmN
   w==;
IronPort-SDR: VsR9HM+Nezc1WKHqp8MLq767UdOk5xzwJ3Ywhc4Q62xrR99pE1wOuO30Voh4zEKCEPWWpjIwEd
 /zmHhx9Bii/m2qqrkH8T2S0EEa1LrJY+Lhi6yWh3Aq3ieVzwMjT1Hqb9bz/BS6LdLfhfw9v8EP
 HH2gCWYmdC4seh/fFfcxne2xDlvpef1R038kkhzUc3pX6eLC5Rx+S0oXBqvXPHgzuWiSmJQoZh
 I7Jr9momL+/dCr10q9N/FYRty1dRy3/PbWAZr8oIdpVnrMMP01VUy3czlJgLxeRiwtgaokvjy0
 4Pg6+qZ/MRDLz1ra4+ohsAIf
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="132933807"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2021 01:57:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 16 Aug 2021 01:57:54 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 16 Aug 2021 01:57:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ajay.kathat@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 4/4] ARM: dts: at91: sama5d27_wlsom1: add wifi device
Date:   Mon, 16 Aug 2021 11:55:30 +0300
Message-ID: <20210816085530.1723402-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
References: <20210816085530.1723402-1-claudiu.beznea@microchip.com>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 71 +++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index 025a78310e3a..c7bcfd3ce91d 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -30,6 +30,15 @@ main_xtal {
 			clock-frequency = <24000000>;
 		};
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-wilc1000";
+		reset-gpios = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
+		powerdown-gpios = <&pioA PIN_PA29 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_wilc_pwrseq>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
 };
 
 &flx1 {
@@ -310,5 +319,67 @@ pinctrl_qspi1_default: qspi1_default {
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


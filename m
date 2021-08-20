Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E866C4338F
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FD060E0B
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Aug 2021 09:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhHTJb2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:31:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:34105 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbhHTJb1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2021 05:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629451849; x=1660987849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zEDBcUygp2aN/sqFtPomk6+2LN5nut6ZU9LjTMWFbOE=;
  b=HwqX9Oy2zKEcmH57+34OLDLAy6Lurg9/pHAN6Mg7NWfMJWw247fhkgPJ
   fyyme6wGi7QVc+g0DvIo3WHco0T1vRFUUcgPofZhrj9OL8ZriAhC8xQm6
   jWvEAKCqdfxhYVP6PPmPjCJ8+rkTxaQXSUfo683ehg8185nE7U2I88h3G
   lkGAslQsW7YfdMxekyhpZ+zfnBY/ddanW8ch5F8gefP3mx71zGWBZcYxo
   C4lJUmG7S27WvxQKPt5eh6o2QZ5kWtc8sYWY9a5A1umxF/U7s/YUwCzpf
   6209xnAVry1IiD6YqlRjBzQcSBwh1FD/lfrobLyHXdCAVLeeRav+uV6SN
   g==;
IronPort-SDR: X3p2akZV+Q3EsvY0CV7gI0moZCw2Xl1VkqzlucHpKyArs8HzOtG8SJnAXMunmVl1IQuIZZbwol
 v6YoK1hJQN7kjf24CPuxlXw4DJOZ3uCaZKcNY3erHA4fquVJpCInUz03HExZKmGl/Y2dQGhMvl
 2L01b/KP/OpDmdpvIUKtIVV6AJ0EZYcZYfUIi4Lwcx6rF1kzJyIpGc/WsQQOU9dwVUxDLlCp7t
 UHw0036aVFd2CnvuHHjdXayQvOtlJ/4lfkmu7XtpSm6OgS3RcWZASY148UFaoyp3wSeYfJ+5TF
 K4yzE4oLp9PO1xkBMdzdCSyQ
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="66535171"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2021 02:30:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 20 Aug 2021 02:30:48 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 20 Aug 2021 02:30:43 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 4/4] ARM: dts: at91: sama5d27_wlsom1: add wifi device
Date:   Fri, 20 Aug 2021 12:28:03 +0300
Message-ID: <20210820092803.78523-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820092803.78523-1-claudiu.beznea@microchip.com>
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
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


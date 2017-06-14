From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 21/21] arm64: dts: hi3660-hikey960: add nodes for WiFi
Date: Wed, 14 Jun 2017 16:23:38 +0800
Message-ID: <20170614082338.15673-22-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33264 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbdFNI0K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2017 04:26:10 -0400
Received: by mail-pg0-f44.google.com with SMTP id f185so72609986pgc.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2017 01:26:05 -0700 (PDT)
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>

Add nodes for WiFi. HiKey960 is using TI WL1837MOD module.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index cec0b60..6609b0f 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -145,6 +145,20 @@
 			};
 		};
 	};
+
+	wlan_en: wlan-en-1-8v {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		/* GPIO_051_WIFI_EN */
+		gpio = <&gpio6 3 0>;
+
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &i2c0 {
@@ -208,3 +222,22 @@
 	vqmmc-supply = <&ldo9>;
 	status = "okay";
 };
+
+&dwmmc2 { /* WIFI */
+	broken-cd;
+	/* WL_EN */
+	vmmc-supply = <&wlan_en>;
+	ti,non-removable;
+	non-removable;
+	#address-cells = <0x1>;
+	#size-cells = <0x0>;
+	status = "ok";
+
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1837";
+		reg = <2>;      /* sdio func num */
+		/* WL_IRQ, GPIO_179_WL_WAKEUP_AP */
+		interrupt-parent = <&gpio22>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+	};
+};
-- 
2.10.2


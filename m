From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 08/21] arm64: dts: hikey960: add WL1837 Bluetooth device node
Date: Wed, 14 Jun 2017 16:23:25 +0800
Message-ID: <20170614082338.15673-9-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34332 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754343AbdFNIYr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2017 04:24:47 -0400
Received: by mail-pg0-f44.google.com with SMTP id v18so72587920pgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2017 01:24:42 -0700 (PDT)
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>

This adds the serial slave device for the WL1837 Bluetooth interface.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 0a3f2e0..c25fff9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -9,6 +9,7 @@
 
 #include "hi3660.dtsi"
 #include "hikey960-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "HiKey960";
@@ -63,6 +64,16 @@
 	status = "okay";
 };
 
+&uart4 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1837-st";
+		enable-gpios = <&gpio15 6 GPIO_ACTIVE_HIGH>;
+		max-speed = <921600>;
+	};
+};
+
 &uart6 {
 	/* On Low speed expansion */
 	label = "LS-UART1";
-- 
2.10.2


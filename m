From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 11/21] arm64: dts: hikey960: add LED nodes
Date: Wed, 14 Jun 2017 16:23:28 +0800
Message-ID: <20170614082338.15673-12-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32991 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754638AbdFNIZB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2017 04:25:01 -0400
Received: by mail-pg0-f49.google.com with SMTP id f185so72597092pgc.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2017 01:25:01 -0700 (PDT)
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>

HiKey960 has four user LEDs, and two special purpose LEDs: WiFi and BT
respectively.

All of them are implemented as GPIO.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 7aac35b..9ecf6c6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -49,6 +49,54 @@
 			linux,code = <KEY_POWER>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user_led1 {
+			label = "user_led1";
+			/* gpio_150_user_led1 */
+			gpios = <&gpio18 6 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "user_led2";
+			/* gpio_151_user_led2 */
+			gpios = <&gpio18 7 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "user_led3";
+			/* gpio_189_user_led3 */
+			gpios = <&gpio23 5 0>;
+			default-state = "off";
+		};
+
+		user_led4 {
+			label = "user_led4";
+			/* gpio_190_user_led4 */
+			gpios = <&gpio23 6 0>;
+			linux,default-trigger = "cpu0";
+		};
+
+		wlan_active_led {
+			label = "wifi_active";
+			/* gpio_205_wifi_active */
+			gpios = <&gpio25 5 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "bt_active";
+			gpios = <&gpio25 7 0>;
+			/* gpio_207_user_led1 */
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
 };
 
 &i2c0 {
-- 
2.10.2


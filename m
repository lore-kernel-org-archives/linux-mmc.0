Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27882C432BE
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D92161075
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhHGLHq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhHGLHp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:45 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mr8vG-1mxCNC1BZO-00oIwV; Sat, 07 Aug 2021 13:07:12 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 08/10] ARM: dts: Add Raspberry Pi Compute Module 4
Date:   Sat,  7 Aug 2021 13:06:39 +0200
Message-Id: <1628334401-6577-9-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:z1mZouUGj1KSLt6JG7gJ6hCAzcPRyIuKEXT/vaWCB1Y2RqyjMSe
 nCkZq6aoa+rVcFvYWAG4Bd+653W4gmCMxr0YdOa1P3qyJFd2Lin192aiaJSRDP2trBnovur
 OyMU4ZT/4cxazGwzR/7pc+sRq/PDOft3DAT6eOu3TF8GEVGJiOaOFb4mR5oyI1cBLtmZrts
 lhX2Z8CJj7+f6IzjMEN9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PeNqOCBnRQk=:95qt8Y95AMUofADrOZlbdz
 wdIi9Y9WY3OMKbU57QWzJrxaOV54mAnH4yeV8Cqd+SI6amQl7FC/s+lqRUehopNZD7PT8sGbd
 EmeHfL0+/s4kuMEkXPvm+5uWpmtq3whDAUB+RIeDu7M4phnou4bNiWODx+V2iVcZOUq3yG0sg
 /0vsfXfQuAis684xJ4tGs5UzzkEkKqTRsP7PNXlW5EJtJWTbSdk52MZI9lVuUOR4/KJ5zHtXc
 mJ4BkAaeVUu5fgtUImR9Ls1P54rTpYF2//qYALjD5vvido8KVJTC0ANxpgGNqMxkl7WE/vjNi
 e5VlvcI564JmO6Z5BoDT8UGpi6zlyHnPqXHTpMrNl4Kl+KO/mwVSHaVyerEmg9sMt5eBJo/Bz
 YdFSxAAtNbQ2XPKNAgrv4bZU187/y/Cw6vf0XioSi3thAUnSFzuexcxJIt+UH9cvWLwmM+osp
 z/VYE1KJGW6Z3TM1rCnkgxOeFhR/EhVtriyUpcwap68SRkLN9uvzHPRS6SG7DdcRfZIYc5qsX
 qj7NDnYArxvSXlxbQhfD7U5Iw4na/m2aSecNTIWpyxE4W3KWLfT3t11jb6HEs1jSOkElWhECC
 7d6csQqhbIkmnuMRcQAOolUBpONcOZaqgICri7p4u8/TPNLaDieXVRGlSNSxE4KkNVbwzZgIB
 gqJh/am9G+i/E/Qe8XiVzwcpQhOlyFYRZuuwW1QLjBhDCFhUmRS0wioY5WLXlXSM1mm046rXT
 8V56tVheJfVfNVSwyHxyNBrWCoGp0Per+KX3d9hlgMKQcwjhfxXqAg9qk9PjCQYP+BpgHAJyF
 KWN48ns7E3KZWGsViPo3uJeRXQhV+j499awR7CXEEgAoXMeVCAAYBO0qWduTFOAtPqtMxH8xQ
 pnBTgE/99uoNHg8RyU4Q==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Raspberry Pi Compute Module 4 (CM4) are SoMs which contain the
following:
  * BCM2711 quad core processor
  * up to 8 GB RAM
  * up to 32 GB eMMC
  * a GPIO expander
  * Gigabit PHY BCM54210PE
  * Wifi/BT module with internal and external antenna

The eMMC and the Wifi/BT module are optional.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi | 113 +++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi

diff --git a/arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi b/arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi
new file mode 100644
index 0000000..a2954d4
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+#include "bcm2711.dtsi"
+#include "bcm2711-rpi.dtsi"
+#include "bcm283x-rpi-wifi-bt.dtsi"
+
+/ {
+	compatible = "raspberrypi,4-compute-module", "brcm,bcm2711";
+
+	chosen {
+		/* 8250 auxiliary UART instead of pl011 */
+		stdout-path = "serial1:115200n8";
+	};
+
+	sd_io_1v8_reg: sd_io_1v8_reg {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-sd-io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-settling-time-us = <5000>;
+		gpios = <&expgpio 4 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+		status = "okay";
+	};
+
+	sd_vcc_reg: sd_vcc_reg {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&expgpio 6 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&bt {
+	shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
+};
+
+/* EMMC2 is used to drive the eMMC */
+&emmc2 {
+	bus-width = <8>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	vmmc-supply = <&sd_vcc_reg>;
+	broken-cd;
+	/* Even the IP block is limited to 100 MHz
+	 * this provides a throughput gain
+	 */
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&expgpio {
+	gpio-line-names = "BT_ON",
+			  "WL_ON",
+			  "PWR_LED_OFF",
+			  "ANT1",
+			  "VDD_SD_IO_SEL",
+			  "CAM_GPIO",
+			  "SD_PWR_ON",
+			  "ANT2";
+
+	ant1: ant1-hog {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_HIGH>;
+		/* internal antenna enabled */
+		output-high;
+		line-name = "ant1";
+	};
+
+	ant2: ant2-hog {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		/* external antenna disabled */
+		output-low;
+		line-name = "ant2";
+	};
+};
+
+&genet {
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-rxid";
+	status = "okay";
+};
+
+&genet_mdio {
+	phy1: ethernet-phy@0 {
+		/* No PHY interrupt */
+		reg = <0x0>;
+	};
+};
+
+/* uart0 communicates with the BT module */
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ctsrts_gpio30 &uart0_gpio32>;
+	uart-has-rtscts;
+};
+
+/* uart1 is mapped to the pin header */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_gpio14>;
+	status = "okay";
+};
+
+&wifi_pwrseq {
+	reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+};
-- 
2.7.4


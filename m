Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0065C43214
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEFA60F38
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhHGLHw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhHGLHr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:47 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmUcL-1muhOb3R9V-00iWJw; Sat, 07 Aug 2021 13:07:12 +0200
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
Subject: [PATCH V2 09/10] ARM: dts: Add Raspberry Pi Compute Module 4 IO Board
Date:   Sat,  7 Aug 2021 13:06:40 +0200
Message-Id: <1628334401-6577-10-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:SuvEoVp7435W5whLYgSE5HM9ejCZP6s+gICbnJcaKFi3dtoja+N
 HrgFmDdjoUj8XUEQOLvOnMRYo5CbaAkexgZxceu4zKH5VOVY0PqD+jGVCIvvJU82U/C4Qcf
 niH9NlOvy6MB8znFyhFxD2Q3LeDljyravZYT8vdDXzV5FC8f+4iQqHzac/6pjYrbYXth7c8
 1QWoy+waSSV7rKQBYdbnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HiXX+88sNd0=:I8sSy+XlbU2In3PgpwfFlc
 Q2CnwXP4aG8Xw0oNbhtNDkhdR5O03M8JIJJa0px7XxOuikaMoEupcUv+JEYDIWHxQxOutyWVp
 LxsAifjMDD+6WGze+bAIR5tF/RwaZHzhC6GBNfMC6eATQ9PP3WJYfyjPnOkPBbb+kV7AKb9ya
 zPFqwQv+JFkehTDlZxJEStV9299uC2bzjVZ0+dN4fG95hVrUO+/vr4NrMsC3NcZarvUW3/EaV
 nrKRxohfdniBXs9CYuvtLuJF2urdDlfn7viPpVrxIMgqcR2zaLhXaj0N06MNYE70XOdqrtVfY
 4O59ozLH9i7CX1FhZbKzZX8wykgZ5lyg167quXGHPUYYfxCHJqsPpV1hWo5R/AgfuKg4SsdTq
 VKsfJZdtmVrQh2RF8K2qHqU9zXGR+xb0BI5abqTjYvsaQFgn2Jxz9TQIe1CzJbsRbrxE1vxur
 +3UMY/Qpae5/MPHn5MFkCalTVhizuSPAKlU06vdunt5yhS8FuuT6wl7+YpDEmExmWPb4Nk5Sd
 IgkPz6jsSDvqmM0ifwpRP2OWF1IgnLF4Fj4kt+8YVfidDWBGkJTOJps08+jY3/AyYGY9mC0F5
 /ZhuYzAI8CCGIbA9xRjBP5eTxqtZBBPfFVy9d30wGgxHMynSw6qcZZvVYHKGkN+XMDzf9IFVL
 u8Vx3/nq2m2zm9RWYM75SyEfPhjt5H3fFrXpZhAArUGdwwhL+AgNsNdqCllSoZTpjYXkckPld
 ifOoqUTTtdo2d985Kmq1lYTRusxCY5Y+Wp2WvmKX5SrFwYrKbAKWFXEQQ29PWJDvVWs/qPNTn
 GSUHiYoLhfT3WJYHC1nctkXlIlfl1EgwUQ74UzZw7n+yXxBEKT4RKQntV1TEncMqoEgLPY8AL
 sf/V7iqtkDfM6M5M4fBw==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This adds the matching carrier for Raspberry Pi Compute Module 4.
Instead of xHCI USB host controller there is just a USB 2.0 interface
connected to the DWC2 controller from the BCM2711. As a result
there is a free PCIe Gen 2 socket. Also there are 2 full-size HDMI 2.0
connectors.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts | 138 +++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 863347b..d3f25b9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -90,6 +90,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2837-rpi-cm3-io3.dtb \
 	bcm2711-rpi-400.dtb \
 	bcm2711-rpi-4-b.dtb \
+	bcm2711-rpi-cm4-io.dtb \
 	bcm2835-rpi-zero.dtb \
 	bcm2835-rpi-zero-w.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
diff --git a/arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts b/arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts
new file mode 100644
index 0000000..19600b6
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+#include "bcm2711-rpi-cm4.dtsi"
+#include "bcm283x-rpi-usb-host.dtsi"
+
+/ {
+	model = "Raspberry Pi Compute Module 4 IO Board";
+
+	leds {
+		led-act {
+			gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-pwr {
+			label = "PWR";
+			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&ddc0 {
+	status = "okay";
+};
+
+&ddc1 {
+	status = "okay";
+};
+
+&gpio {
+	/*
+	 * Parts taken from rpi_SCH_4b_4p0_reduced.pdf and
+	 * the official GPU firmware DT blob.
+	 *
+	 * Legend:
+	 * "FOO" = GPIO line named "FOO" on the schematic
+	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
+	 */
+	gpio-line-names = "ID_SDA",
+			  "ID_SCL",
+			  "SDA1",
+			  "SCL1",
+			  "GPIO_GCLK",
+			  "GPIO5",
+			  "GPIO6",
+			  "SPI_CE1_N",
+			  "SPI_CE0_N",
+			  "SPI_MISO",
+			  "SPI_MOSI",
+			  "SPI_SCLK",
+			  "GPIO12",
+			  "GPIO13",
+			  /* Serial port */
+			  "TXD1",
+			  "RXD1",
+			  "GPIO16",
+			  "GPIO17",
+			  "GPIO18",
+			  "GPIO19",
+			  "GPIO20",
+			  "GPIO21",
+			  "GPIO22",
+			  "GPIO23",
+			  "GPIO24",
+			  "GPIO25",
+			  "GPIO26",
+			  "GPIO27",
+			  "RGMII_MDIO",
+			  "RGMIO_MDC",
+			  /* Used by BT module */
+			  "CTS0",
+			  "RTS0",
+			  "TXD0",
+			  "RXD0",
+			  /* Used by Wifi */
+			  "SD1_CLK",
+			  "SD1_CMD",
+			  "SD1_DATA0",
+			  "SD1_DATA1",
+			  "SD1_DATA2",
+			  "SD1_DATA3",
+			  /* Shared with SPI flash */
+			  "PWM0_MISO",
+			  "PWM1_MOSI",
+			  "STATUS_LED_G_CLK",
+			  "SPIFLASH_CE_N",
+			  "SDA0",
+			  "SCL0",
+			  "RGMII_RXCLK",
+			  "RGMII_RXCTL",
+			  "RGMII_RXD0",
+			  "RGMII_RXD1",
+			  "RGMII_RXD2",
+			  "RGMII_RXD3",
+			  "RGMII_TXCLK",
+			  "RGMII_TXCTL",
+			  "RGMII_TXD0",
+			  "RGMII_TXD1",
+			  "RGMII_TXD2",
+			  "RGMII_TXD3";
+};
+
+&hdmi0 {
+	status = "okay";
+};
+
+&hdmi1 {
+	status = "okay";
+};
+
+&genet {
+	status = "okay";
+};
+
+&pixelvalve0 {
+	status = "okay";
+};
+
+&pixelvalve1 {
+	status = "okay";
+};
+
+&pixelvalve2 {
+	status = "okay";
+};
+
+&pixelvalve4 {
+	status = "okay";
+};
+
+&vc4 {
+	status = "okay";
+};
+
+&vec {
+	status = "disabled";
+};
-- 
2.7.4


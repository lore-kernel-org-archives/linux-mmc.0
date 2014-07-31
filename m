From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 4/4] ARM: dts: mmc slot node gone on rk3288 => no more address / size cells
Date: Thu, 31 Jul 2014 09:13:20 -0700
Message-ID: <1406823200-20911-5-git-send-email-dianders@chromium.org>
References: <1406823200-20911-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f201.google.com ([209.85.160.201]:41607 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbaGaQNX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jul 2014 12:13:23 -0400
Received: by mail-yk0-f201.google.com with SMTP id 142so129015ykq.2
        for <linux-mmc@vger.kernel.org>; Thu, 31 Jul 2014 09:13:23 -0700 (PDT)
In-Reply-To: <1406823200-20911-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Doug Anderson <dianders@chromium.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

We've removed the slot node from all rk3288 device trees, so we no
longer need address-cells or size-cells.

If Jaehoon's (mmc: dw_mmc: Slot quirk "disable-wp" is deprecated)
patch lands before my (ARM: dts: Add emmc and sdmmc to the rk3288
device tree) then this could be squashed into the later patch.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v2:
- Refer to the new title of Jaehoon's patch

 arch/arm/boot/dts/rk3288.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index fd77a65..d2d0086 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -85,8 +85,6 @@
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0c0000 0x4000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 	};
 
 	emmc: dwmmc@ff0f0000 {
@@ -96,8 +94,6 @@
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0f0000 0x4000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 	};
 
 	i2c1: i2c@ff140000 {
-- 
2.0.0.526.g5318336


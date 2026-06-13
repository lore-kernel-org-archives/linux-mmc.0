Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1030E0DC;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343733; cv=none; b=iOCM8YZ/uMgpTwasM1t83yZyJGKyKhwLEyb8aSlYgHITgMD4Gn9Ct1+dcVg9XBaYnfUnDuWhHZwDce95LKq2BN72mYYrIGFTfyjoPsGjhdM04KXWrYQzaJIxYyUAqi3n55MN7asvQxROz6dQuRIn2afDwnrpO2rxG9TRVHD76wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343733; c=relaxed/simple;
	bh=+Xe3LPaABBTt1eEwWotR2Scg+txkKP1t29wlk/lsTp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ORaF8ns/ihIKJuKP8FEOQ1fcCAOdBsdXKfRJjaTQlkwDb33UAbB8hnGd1MjuJA7qCeJI+GE3FVzSBhs/edtaSUVjj38yyYhir+oI1bbUrv3i9sViqwCaGTDRdfc8cY03Y7VxS4G8rctr2HXHKIceUlOamw2/8yAMxBHRCjVDpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP8vligz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP8vligz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E754C4AF0D;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781343733;
	bh=+Xe3LPaABBTt1eEwWotR2Scg+txkKP1t29wlk/lsTp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gP8vligzGpfh5Z52G5TsWRiOnXukJkcLPRsIpMd6vkakcglcErmIbPxeLjtV495Lp
	 Gm9AQMawn1IsLa4k1SoHSd2+gTc+YnFWacCLSlFnAWOgkd02lVJCbPZVbeMqWRINxS
	 o2DwIil4M0OdTSjeq2ETm7MtuNq+nvhxmyEUSfka5X5njr0Tm8m5b4jHngh+U8IXLQ
	 JnA96QuPhsiksJNMpPBi2km0UQN/ZuWslhcSJ0/DvnDHwkvFuqxKB2BK6Fr7fD3uiu
	 U/omWs1aKSQ8tfUyUiLgeMG+DbRf7flsRliKqpqPVzwPQit8aycv/pNbsWhZ3KsZ1Z
	 O891fAoo4RLhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6CECD98DA;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
From: Enzo Adriano via B4 Relay <devnull+enzo.adriano.code.gmail.com@kernel.org>
Date: Sat, 13 Jun 2026 05:42:15 -0400
Subject: [PATCH 3/4] arm64: dts: allwinner: add Allwinner A733 SoC
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-a733-dts-v1-public-ready-v1-3-7787c94681db@gmail.com>
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
In-Reply-To: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Enzo Adriano <enzo.adriano.code@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781343732; l=5731;
 i=enzo.adriano.code@gmail.com; s=a733-cubie-a7s;
 h=from:subject:message-id;
 bh=MDyjVPy/pUO2guRlLlgaSdcvtjZ+Ix+jLr6N5U6+5/0=;
 b=JC7ZHAOkRSVLxxOXG4AOmtfCHMsoRbnr51H0qx4dhrviM9+TcApGxtLQzpRQ6g7O/HhXJpeg8
 xzN7uH3upIwDoUTdP4HyxlLsHKvIo1+xthjUHY1Ed8bJFxdh8g8DwgF
X-Developer-Key: i=enzo.adriano.code@gmail.com; a=ed25519;
 pk=5S3Wmdqa4XfCdeZF/HfeYqnQF8GN9JGt3SE1cxqSX8E=
X-Endpoint-Received: by B4 Relay for
 enzo.adriano.code@gmail.com/a733-cubie-a7s with auth_id=820
X-Original-From: Enzo Adriano <enzo.adriano.code@gmail.com>
Reply-To: enzo.adriano.code@gmail.com

From: Enzo Adriano <enzo.adriano.code@gmail.com>

Add the initial A733 SoC description with CPUs, timers, interrupt
controller, clocks, pinctrl, UART0, and MMC0.

Keep peripherals disabled by default. Board DTS files can enable only the
devices that are proven on their hardware.

Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi | 198 +++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
new file mode 100644
index 000000000000..3721aa9e8573
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun60i-a733-ccu.h>
+#include <dt-bindings/reset/sun60i-a733-ccu.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			reg = <0x000>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+		};
+
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+		};
+
+		cpu2: cpu@200 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			reg = <0x200>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+		};
+
+		cpu3: cpu@300 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			reg = <0x300>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+		};
+
+		cpu4: cpu@400 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			reg = <0x400>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+		};
+
+		cpu5: cpu@500 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			reg = <0x500>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <530>;
+		};
+
+		cpu6: cpu@600 {
+			compatible = "arm,cortex-a76";
+			device_type = "cpu";
+			reg = <0x600>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu7: cpu@700 {
+			compatible = "arm,cortex-a76";
+			device_type = "cpu";
+			reg = <0x700>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+		};
+	};
+
+	osc24M: osc24M-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24M";
+	};
+
+	osc32k: osc32k-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "osc32k";
+	};
+
+	iosc: internal-osc-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <16000000>;
+		clock-output-names = "iosc";
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		arm,no-tick-in-suspend;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x0 0x40000000>;
+
+		pio: pinctrl@2000000 {
+			compatible = "allwinner,sun60i-a733-pinctrl";
+			reg = <0x02000000 0x600>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1>, <&osc24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2",
+				       "PF3", "PF4", "PF5";
+				function = "mmc0";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+		};
+
+		ccu: clock-controller@2002000 {
+			compatible = "allwinner,sun60i-a733-ccu";
+			reg = <0x02002000 0x2000>;
+			clocks = <&osc24M>, <&osc32k>, <&iosc>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		uart0: serial@2500000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x02500000 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@3400000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x03400000 0x10000>,
+			      <0x03460000 0x100000>;
+		};
+
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun60i-a733-mmc",
+				     "allwinner,sun20i-d1-mmc";
+			reg = <0x04020000 0x1000>;
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
+			max-frequency = <200000000>;
+			cap-sd-highspeed;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};

-- 
2.53.0



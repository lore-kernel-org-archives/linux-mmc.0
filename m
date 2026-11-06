Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957615;
	b=ie2pMZDhf5Iug6ZcVuKr2Eb0cpkUnUoJZJx/P6DDvlZoVGGexozf87HQRVS6wbRBRQOb
	 4DFvE51le/giOck+Lb1+t7sDFDODF5IjBkm2eXDx3tRystcrMan8eaZobKZPdWjUDLSXh
	 uXQT+I1AMlMCVLhc70+oQYEYd5Hwoo1mEELQCI9eL914jhF4wxtoY6tIWEB5l1bhSRl2n
	 9iSujXIhvL0pmxsDwGYfaZdRZj1+8xYSi9ZWPB2I+TDpAHqII/9DVZAYghAG+8TM1yTsq
	 zULyVeObM4tWMKyrtKbmEIH+fM8oND1S82JdlFfbPnLzR+PSV/4NcGfcUge+1ej5HzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957615;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=8v2nXWM9acZVitBgv0QvS1fHjlk1wPl9VrCyP3K4JUc=;
	b=jEakuChBgA4UTAUQdGCoIWrT7NyEs31cRSsyBuzhQbDCL4bMMRZ+e+DZWHYkstvQIINw
	 PEW8v3+eMuAJ0BlDU2olzDDrtZc5kpG6K2Coyt5TMAgqvA4k4MFfzxAbMJ0NLeUXWvYnD
	 gauKzF9lm7tyJoxBm3YX9CTKdMfgjOuOrtDWI+k44pQe7KJqmcMqSLgRkJxsrPwJGnKcA
	 tHYNpSBGVYIM/JXR0nQaSD0EBh/ogZKRhw1f/gympH2fvoXfHV1r2qjOkoyF9K0PnZytv
	 jpbjx+IoVfqHxNKejFuePNHURn5s4mxMZTodOjYYUkFVl+w9+EKyzwvzjPr9Fg9zMZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jKw1Xz2M;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9F6082BDC;
	Fri,  6 Nov 2026 09:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A9F6082BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jKw1Xz2M
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2F1301A1350;
	Fri,  6 Nov 2026 09:33:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EEACB5FFBC;
	Fri,  6 Nov 2026 09:33:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68C4D103292CA;
	Fri,  6 Nov 2026 10:33:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957609; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8v2nXWM9acZVitBgv0QvS1fHjlk1wPl9VrCyP3K4JUc=;
	b=jKw1Xz2MvUXksHPjJTP1yk73uoYewzoTb9B9XN5A5McCWsIoycHGGsvZ160KA2VUCsoiMs
	bKtr4bEue/aGGnQtB9haq/BhiWs3PKyrr35KH95LVoz5KUBmOTm3QM7i+zFkmLFs769OJy
	g0F0RhojgBFzq+d/QVVyBc23BueYRGINKy9RT4K5hgOFzPFcuPuNVYV5rYtIIthyxhsysB
	wu+hIqfG65kuRuL31WvEVvbF1SIiZWyOUuu+BNqNv58tY3uVOgR9pOILslv0tEhEtWX1r2
	gakTpxj9loWeMcuR4udMwrSgm7pf1hiYsw0pcsPeP4jMQmwFkYLibiZMAeBoUw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:21 +0100
Subject: [PATCH 24/25] riscv: add Metanoia MT2824 SoC and MT5824 EVB
 support
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
In-Reply-To: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Add the device tree for the Metanoia MT2824, a dual-core Andes
AX45MP-based SoC, and for the MT5824 evaluation board.

The SoC device tree describes the CPUs and their L2 cache, the PLIC,
PLICSW and PLMT, the reset controller, the reboot controller, the
watchdog, two UARTs, the QSPI and eight SPI controllers, the DWC
MSHC MMC controller, and the USB2 controller.

The MT5824 EVB enables the watchdog, the two UARTs, the MMC
controller, the QSPI port with its SPI-NOR flash, the first three SPI
controllers, and the USB controller.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 arch/riscv/boot/dts/Makefile                |   1 +
 arch/riscv/boot/dts/metanoia/Makefile       |   2 +
 arch/riscv/boot/dts/metanoia/mt2824.dtsi    | 330 ++++++++++++++++++++++++++++
 arch/riscv/boot/dts/metanoia/mt5824-evb.dts |  81 +++++++
 4 files changed, 414 insertions(+)

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 69d8751fb17c..8e1e987ea089 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -4,6 +4,7 @@ subdir-y += andes
 subdir-y += anlogic
 subdir-y += canaan
 subdir-y += eswin
+subdir-y += metanoia
 subdir-y += microchip
 subdir-y += renesas
 subdir-y += sifive
diff --git a/arch/riscv/boot/dts/metanoia/Makefile b/arch/riscv/boot/dts/metanoia/Makefile
new file mode 100644
index 000000000000..7a685798d5a4
--- /dev/null
+++ b/arch/riscv/boot/dts/metanoia/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_METANOIA) += mt5824-evb.dtb
diff --git a/arch/riscv/boot/dts/metanoia/mt2824.dtsi b/arch/riscv/boot/dts/metanoia/mt2824.dtsi
new file mode 100644
index 000000000000..5f73c6d3760b
--- /dev/null
+++ b/arch/riscv/boot/dts/metanoia/mt2824.dtsi
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Metanoia Communications Inc.. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
+	compatible = "metanoia,mt2824";
+
+	cpus: cpus {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		timebase-frequency = <20000000>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			reg = <0x00>;
+			compatible = "andestech,ax45mp", "riscv";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm", "xandespmu";
+			mmu-type = "riscv,sv39";
+			clock-frequency = <900000000>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <0x100>;
+			i-cache-line-size = <0x40>;
+			i-cache-block-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <0x80>;
+			d-cache-line-size = <0x40>;
+			d-cache-block-size = <0x40>;
+			next-level-cache = <&l2_cache>;
+
+			cpu0intc: interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "andestech,cpu-intc", "riscv,cpu-intc";
+			};
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			reg = <0x01>;
+			compatible = "andestech,ax45mp", "riscv";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm", "xandespmu";
+			mmu-type = "riscv,sv39";
+			clock-frequency = <900000000>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <0x100>;
+			i-cache-line-size = <0x40>;
+			i-cache-block-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <0x80>;
+			d-cache-line-size = <0x40>;
+			d-cache-block-size = <0x40>;
+			next-level-cache = <&l2_cache>;
+
+			cpu1intc: interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "andestech,cpu-intc", "riscv,cpu-intc";
+			};
+		};
+	};
+
+	clocks {
+		ext_clk: ext-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <20000000>;
+			clock-output-names = "ext-clk";
+		};
+
+		pclk_div4: platform-clock-div4 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <225000000>;
+			clock-output-names = "platform-clock-div4";
+		};
+
+		pll_soc_out3: pll-soc-out3 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <180000000>;
+			clock-output-names = "pll-soc-out3";
+		};
+
+		usb_otg_ahb_clk: clock-usb-otg-ahb {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <60000000>;
+			clock-output-names = "otg";
+		};
+	};
+
+	soc: soc {
+		#address-cells = <0x02>;
+		#size-cells = <0x02>;
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		ranges;
+
+		usb0: usb@4000000 {
+			compatible = "metanoia,mt2824-usb", "snps,dwc2";
+			reg = <0x0 0x04000000 0x0 0x100000>;
+			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&usb_otg_ahb_clk>;
+			clock-names = "otg";
+			dr_mode = "host";
+			resets = <&rst 19>, <&rst 20>;
+			reset-names = "dwc2", "dwc2-ecc";
+			phys = <&usb2phy>;
+			phy-names = "usb2-phy";
+			hnp-disable;
+			srp-disable;
+			disable-over-current;
+			status = "disabled";
+		};
+
+		mmcsd: mmc@4100000 {
+			compatible = "metanoia,mt2824-dwcmshc";
+			clocks = <&pll_soc_out3>;
+			clock-names = "core";
+			reg = <0x0 0x04100000 0x0 0x00100000>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		l2_cache: cache-controller@a000000 {
+			compatible = "metanoia,mt2824-ax45mp-cache",
+				     "andestech,ax45mp-cache", "cache";
+			reg = <0x0 0x0a000000 0x0 0x40000>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+			cache-line-size = <64>;
+			cache-level = <2>;
+			cache-sets = <1024>;
+			cache-size = <0x40000>;
+			cache-unified;
+		};
+
+		plic: interrupt-controller@c000000 {
+			compatible = "metanoia,mt2824-plic", "andestech,nceplic100";
+			reg = <0x0 0x0c000000 0x0 0x400000>;
+			interrupts-extended = <&cpu0intc 0x0b>, <&cpu0intc 0x09>,
+					      <&cpu1intc 0x0b>, <&cpu1intc 0x09>;
+			interrupt-controller;
+			#address-cells = <0x00>;
+			#interrupt-cells = <0x02>;
+			riscv,ndev = <0x47>;
+		};
+
+		plmt: timer@c400000 {
+			compatible = "metanoia,mt2824-plmt", "andestech,plmt0";
+			reg = <0x0 0x0c400000 0x0 0x00400000>;
+			interrupts-extended = <&cpu0intc 0x07>,
+					      <&cpu1intc 0x07>;
+		};
+
+		plicsw: interrupt-controller@c800000 {
+			compatible = "metanoia,mt2824-plicsw", "andestech,plicsw";
+			reg = <0x0 0x0c800000 0x0 0x400000>;
+			interrupts-extended = <&cpu0intc 0x03>,
+					      <&cpu1intc 0x03>;
+		};
+
+		reboot: reboot@10000004 {
+			compatible = "metanoia,mt2824-reboot";
+			reg = <0x0 0x10000004 0x0 0x08>;
+		};
+
+		rst: reset-controller@1000000c {
+			#reset-cells = <1>;
+			compatible = "metanoia,mt2824-reset";
+			reg = <0x0 0x1000000c 0x0 0x04>;
+		};
+
+		watchdog: watchdog@10090000 {
+			compatible = "metanoia,mt2824-wdt", "andestech,ae350-wdt";
+			reg = <0x0 0x10090000 0x0 0x10000>;
+			clocks = <&ext_clk>;
+			andestech,clock-source = <0>;
+			timeout-sec = <10>;
+			status = "disabled";
+		};
+
+		serial0: serial@100e0000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x100e0000 0x0 0x1000>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pclk_div4>;
+			current-speed = <115200>;
+			reg-shift = <0x02>;
+			reg-offset = <0x20>;
+			reg-io-width = <0x04>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		serial1: serial@100f0000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x100f0000 0x0 0x1000>;
+			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pclk_div4>;
+			current-speed = <115200>;
+			reg-shift = <0x02>;
+			reg-offset = <0x20>;
+			reg-io-width = <0x04>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		qspi: spi@10120000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x10120000 0x0 0x10000>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+
+		spi0: spi@10130000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x10130000 0x0 0x10000>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+
+		spi1: spi@10140000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x10140000 0x0 0x10000>;
+			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+
+		spi2: spi@10150000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x10150000 0x0 0x10000>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+
+		spi3: spi@10160000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x10160000 0x0 0x10000>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+
+		spi4: spi@10170000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x10170000 0x0 0x10000>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+
+		spi5: spi@10180000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x10180000 0x0 0x10000>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+
+		spi6: spi@10190000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x10190000 0x0 0x10000>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+
+		spi7: spi@101a0000 {
+			compatible = "metanoia,mt2824-spi", "andestech,ae350-spi";
+			reg = <0x0 0x101a0000 0x0 0x10000>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x01>;
+			clocks = <&pll_soc_out3>;
+			status = "disabled";
+		};
+	};
+
+	usb2phy: usb2-phy {
+		compatible = "metanoia,mt2824-usb2-phy";
+		#phy-cells = <0>;
+		resets = <&rst 18>;
+		reset-names = "usb2-phy";
+	};
+
+	reserved-memory {
+		#address-cells = <0x2>;
+		#size-cells = <0x2>;
+		ranges;
+
+		/* for the DSPs, configured as non-cacheable in openSBI */
+		rsc_table: rsc-table@81000000 {
+			reg = <0x0 0x81000000 0x0 0x10000>;
+			no-map;
+		};
+	};
+};
diff --git a/arch/riscv/boot/dts/metanoia/mt5824-evb.dts b/arch/riscv/boot/dts/metanoia/mt5824-evb.dts
new file mode 100644
index 000000000000..d0e8eb0a49a4
--- /dev/null
+++ b/arch/riscv/boot/dts/metanoia/mt5824-evb.dts
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2026 Metanoia Communications Inc.. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "mt2824.dtsi"
+
+/ {
+	model = "Metanoia MT5824 EVB";
+	compatible = "metanoia,mt5824-evb", "metanoia,mt2824";
+
+	aliases {
+		uart0 = &serial0;
+		uart1 = &serial1;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+	};
+
+	chosen {
+		stdout-path = "uart0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>,
+		      <0x1 0x00000000 0x0 0x80000000>;
+	};
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&mmcsd {
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	no-sdio;
+	disable-wp;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-rx-bus-width = <0x4>;
+		spi-tx-bus-width = <0x4>;
+		spi-max-frequency = <100000000>;
+		reg = <0x0>;
+	};
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&spi2 {
+	status = "okay";
+};

-- 
2.56.0


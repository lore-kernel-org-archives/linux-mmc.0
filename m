Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095217109B
	for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351733; cv=none; b=Rv5niNFjmkIb4SMW7sU3IdzgBFP8hSBrlG5aaQLsgXMGMAwIZerrzRBzIgxrjwIZ6N6pI/lVkzMolpRlhbjTj/X6WypGvt3mDp0LceEMN50TKx2Vpx++HPGBjLTgXrcbsSaJozPZ93PqwViEaGffxYJgUwK7ydJRgwTAlV5ivNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351733; c=relaxed/simple;
	bh=a/Zm1aOtoF6fTgbVv22pEtGFt0o9J0gPOzdoRW/np7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSIprJJqkXQk4vpn7VjtNaixTb1C6Tuo/gLstenwSOskvk/9uFtHjbq0TNCx3kkTjX+6jkJzTchBY6AreS639Ct7MIruGzHjYPzcRAC8yhqq3YaTWe1na6lSE4Am8XhHPW6fxqALbEFkctBIk2Eo6XkIXsizgos2qRa/nsRuKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ppm33PYA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ppm33PYA"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59b58fe083so508812166b.0
        for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715351729; x=1715956529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj/cLDfzxXevCwWbwB3QfsabvjhH4BWkNchBa5h63Sc=;
        b=Ppm33PYAUhtE0jpwWC2Lp2OEyzjllzZ6qyTJRDGBjxQnHjleXBah1j51OWQId1f8+q
         h3Umz0yg70XKeVD71qysdj67UHFRn17NCyQ6KKDMdMwKBn+bEcIBp/F2t4aH+lcLUcTn
         7+ft1lzYEHzWBFZs6ZY/5Evy9TsD1LGdBFGhI44ItiHO5YhYlpFJjMJIecQYogMzugN+
         uDA9BfKMmEL26RU720VGtFWpSCKG7O5TybqpIEviBDIcRYMGgdQQkVXEAfgHcnKUkYt5
         62bx3CpF9uodqFOmGaGB4/iaw6K78wLElANQ74KLxnufLRUFbXsYTtq+lzrZZjVGMbg/
         B9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351729; x=1715956529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj/cLDfzxXevCwWbwB3QfsabvjhH4BWkNchBa5h63Sc=;
        b=nuF8puNfdrO4UMmBhhPZm96WTTWqVdKhnjqpIeMTGEs6pXIjvfhVO7PI3YjigsyMPr
         TO7saOPkzC/1VZb3ZhVB33UpZJyV9LlDPssekWtLQhse9idAzks14Dq8CIBH5Y1QS28Q
         Smd6BfNbIDfVEAr6NyKVht5n6/Sq+I/X2D+ZR0fIKnfctylI7+QXs3CD2DYd1wfKepNK
         qA2AtN2G74Do1HfqFHv/Rj54iQxLe8txdnURSZmWb6bi85n2Oai3aymzFZ0iWvSXl1ni
         wGJPJ4EPd0zifAfuVXMmMtKi6GaOUJspluGBictpVS6zCdzapEIYt5+/MpPz4i3WFAFg
         fCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHeF66IVjhkFY7vxMd2rrk05ItguOK37flMVaDT+VviX/IizlxMVbFNWZmakdL4+F6VxqM2KHjJLaYtKtDix7kGaQWZclES46y
X-Gm-Message-State: AOJu0YyuvXWSKIs9hFTo2wIKLWLNQbyPag0QZdCM6zH+PmkDPi8dbEKi
	wyKTFx6e6YR0EYXyOJ768WqKJFlIOj9vv5mSykrogCgBmm/v9mK8niobL2j8JOU=
X-Google-Smtp-Source: AGHT+IHmjCuzjfxjIj9Ldhj8nwcB0t4f8y+uTj99CA3VJX1i4r7PXdGY26CcC0kfylVSjXZC5GzWjA==
X-Received: by 2002:a17:906:7fd6:b0:a59:c7d7:8b18 with SMTP id a640c23a62f3a-a5a2d57a3a6mr174201766b.30.1715351729267;
        Fri, 10 May 2024 07:35:29 -0700 (PDT)
Received: from localhost (host-95-235-217-160.retail.telecomitalia.it. [95.235.217.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c822fsm189865966b.138.2024.05.10.07.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:35:28 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 4/4] arm64: dts: broadcom: Add support for BCM2712
Date: Fri, 10 May 2024 16:35:30 +0200
Message-ID: <59a3015c3a6f2f0b70a38c030274a163773e7757.1715332922.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715332922.git.andrea.porta@suse.com>
References: <cover.1715332922.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 SoC family can be found on Raspberry Pi 5.
Add minimal SoC and board (Rpi5 specific) dts file to be able to
boot from SD card and use console on debug UART.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  62 ++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 302 ++++++++++++++++++
 3 files changed, 365 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 8b4591ddd27c..92565e9781ad 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -6,6 +6,7 @@ DTC_FLAGS := -@
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2711-rpi-4-b.dtb \
 			      bcm2711-rpi-cm4-io.dtb \
+			      bcm2712-rpi-5-b.dtb \
 			      bcm2837-rpi-3-a-plus.dtb \
 			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
new file mode 100644
index 000000000000..b5921437e09f
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "bcm2712.dtsi"
+
+/ {
+	compatible = "raspberrypi,5-model-b", "brcm,bcm2712";
+	model = "Raspberry Pi 5";
+
+	aliases {
+		serial10 = &uart0;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial10:115200n8";
+	};
+
+	/* Will be filled by the bootloader */
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0 0x28000000>;
+	};
+
+	sd_io_1v8_reg: sd-io-1v8-reg {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-sd-io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-settling-time-us = <5000>;
+		gpios = <&gio_aon 3 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+	};
+
+	sd_vcc_reg: sd-vcc-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpios = <&gio_aon 4 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* The system UART */
+&uart0 {
+	status = "okay";
+};
+
+/* SDIO1 is used to drive the SD card */
+&sdio1 {
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	vmmc-supply = <&sd_vcc_reg>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+	sd-uhs-sdr104;
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
new file mode 100644
index 000000000000..398df13148bd
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "brcm,bcm2712";
+
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	interrupt-parent = <&gicv2>;
+
+	axi: axi {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		sdio1: mmc@1000fff000 {
+			compatible = "brcm,bcm2712-sdhci",
+				     "brcm,sdhci-brcmstb";
+			reg = <0x10 0x00fff000  0x260>,
+			      <0x10 0x00fff400  0x200>;
+			reg-names = "host", "cfg";
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_emmc2>;
+			clock-names = "sw_sdio";
+			mmc-ddr-3_3v;
+		};
+
+		gicv2: interrupt-controller@107fff9000 {
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			compatible = "arm,gic-400";
+			reg = <0x10 0x7fff9000  0x1000>,
+			      <0x10 0x7fffa000  0x2000>,
+			      <0x10 0x7fffc000  0x2000>,
+			      <0x10 0x7fffe000  0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+				      IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+
+	clocks {
+		/* The oscillator is the root of the clock tree. */
+		clk_osc: clk-osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "osc";
+			clock-frequency = <54000000>;
+		};
+
+		clk_vpu: clk-vpu {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <750000000>;
+			clock-output-names = "vpu-clock";
+		};
+
+		clk_uart: clk-uart {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <9216000>;
+			clock-output-names = "uart-clock";
+		};
+
+		clk_emmc2: clk-emmc2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+			clock-output-names = "emmc2-clock";
+		};
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Source for d/i cache-line-size, cache-sets, cache-size
+		 * https://developer.arm.com/documentation/100798/0401
+		 * /L1-memory-system/About-the-L1-memory-system?lang=en
+		 */
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x000>;
+			enable-method = "psci";
+			d-cache-size = <0x10000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			i-cache-size = <0x10000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			next-level-cache = <&l2_cache_l0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x100>;
+			enable-method = "psci";
+			d-cache-size = <0x10000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			i-cache-size = <0x10000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			next-level-cache = <&l2_cache_l1>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x200>;
+			enable-method = "psci";
+			d-cache-size = <0x10000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			i-cache-size = <0x10000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			next-level-cache = <&l2_cache_l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x300>;
+			enable-method = "psci";
+			d-cache-size = <0x10000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			i-cache-size = <0x10000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
+			next-level-cache = <&l2_cache_l3>;
+		};
+
+		/* Source for cache-line-size and cache-sets:
+		 * https://developer.arm.com/documentation/100798/0401
+		 * /L2-memory-system/About-the-L2-memory-system?lang=en
+		 * and for cache-size:
+		 * https://www.raspberrypi.com/documentation/computers
+		 * /processors.html#bcm2712
+		 */
+		l2_cache_l0: l2-cache-l0 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <128>;
+			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l1: l2-cache-l1 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <128>;
+			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l2: l2-cache-l2 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <128>;
+			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2_cache_l3: l2-cache-l3 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <128>;
+			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
+			cache-level = <2>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		/* Source for cache-line-size and cache-sets:
+		 * https://developer.arm.com/documentation/100453/0401/L3-cache?lang=en
+		 * Source for cache-size:
+		 * https://www.raspberrypi.com/documentation/computers/processors.html#bcm2712
+		 */
+		l3_cache: l3-cache {
+			compatible = "cache";
+			cache-size = <0x200000>;
+			cache-line-size = <64>;
+			cache-sets = <2048>; // 2MiB(size)/64(line-size)=32768ways/16-way set
+			cache-level = <3>;
+			cache-unified;
+		};
+	};
+
+	psci {
+		method = "smc";
+		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
+		cpu_on = <0xc4000003>;
+		cpu_suspend = <0xc4000001>;
+		cpu_off = <0x84000002>;
+	};
+
+	rmem: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		atf@0 {
+			reg = <0x0 0x0 0x80000>;
+			no-map;
+		};
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x4000000>; /* 64MB */
+			reusable;
+			linux,cma-default;
+			alloc-ranges = <0x0 0x00000000 0x40000000>;
+		};
+	};
+
+	soc: soc@107c000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ranges     = <0x7c000000  0x10 0x7c000000  0x04000000>;
+		/* Emulate a contiguous 30-bit address range for DMA */
+		dma-ranges = <0xc0000000  0x00 0x00000000  0x40000000>,
+			     <0x7c000000  0x10 0x7c000000  0x04000000>;
+
+		system_timer: timer@7c003000 {
+			compatible = "brcm,bcm2835-system-timer";
+			reg = <0x7c003000 0x1000>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <1000000>;
+		};
+
+		mailbox: mailbox@7c013880 {
+			compatible = "brcm,bcm2835-mbox";
+			reg = <0x7c013880 0x40>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <0>;
+		};
+
+		local_intc: local-intc@7cd00000 {
+			compatible = "brcm,bcm2836-l1-intc";
+			reg = <0x7cd00000 0x100>;
+		};
+
+		uart0: serial@7d001000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x7d001000 0x200>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_uart>, <&clk_vpu>;
+			clock-names = "uartclk", "apb_pclk";
+			arm,primecell-periphid = <0x00241011>;
+			status = "disabled";
+		};
+
+		interrupt-controller@7d517000 {
+			compatible = "brcm,bcm7271-l2-intc";
+			reg = <0x7d517000 0x10>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			status = "disabled";
+		};
+
+		gio_aon: gpio@7d517c00 {
+			compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+			reg = <0x7d517c00 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			// Don't use GIO_AON as an interrupt controller because it will
+			// clash with the firmware monitoring the PMIC interrupt via the VPU.
+			brcm,gpio-bank-widths = <17 6>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+		/* This only applies to the ARMv7 stub */
+		arm,cpu-registers-not-fw-configured;
+	};
+};
-- 
2.35.3


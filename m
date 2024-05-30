Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B920176ACC
	for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063919; cv=none; b=UEIXjs7WdhYbSYFikHEFD3MuSz03qV/tZ/m6NTXL8v7dlkbIY0E2CmHMbPZ6+zxkBKwAWZiWSoFDzHuWt79u0g8mOzK2Z93cIXSA4JSy2URDGGrhoRn2K3ER9NL1x8qwij8wZPU9yV9E2JCIA3OCG3QA6kax+lmdoSszkBoe3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063919; c=relaxed/simple;
	bh=RgdrAQWJTPjrTTyPMge3YMIeIyeYD68WYtq0PwIpTCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzwzJp1i8Z7mQLDn06AcEmXLBjo153RD1dSzjg+J+vRJO6dXU3dvLFeHbrL3NHkqzJKBfKjM2lq8G9OJlPxFnq5kweWOZ86vMRAlCNmAKWE38p+swuSQOkWrc7nj9hraHhfrUUl8Xek/V47KYidSk+2XN1D+LfoyiB8QydFMACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UDKDkzdq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UDKDkzdq"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a633ec1cecdso59232966b.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 03:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717063916; x=1717668716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTw3IRZEjtj9X2tzd7G8IPucKzFK90zRS9yH1RupvFc=;
        b=UDKDkzdqXC+SQ1qxbEG1GTjisx4YeaolMozd+DcJQ6hI3Ui96rbANRFL6pZy2zlOc9
         +oPj4atTwmLYBsFw3ExE95u1IkKYM2m+2lYdcgeeURTRy3HlyxLzN0cvMJqaVFCk6wAr
         q2Fz2ubEG3ktXX35IVwNmabi6HK/yRNlmRgA6Effpz/UZ0h6jpmdKIOemJmY9C1+2Y7E
         5EpHYjJxqCAuVku668IwvsQy/RquUM5HMKa5JzKqbI7gqUlHdXRv1IBQm95EH0O0qjAr
         GE+tFlBGu3+0z+t2TVdiWiPg8Azw2VpgMrZhvur8gamUdI3F6vGJUBJKz+2wS8Lu3H5v
         8vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717063916; x=1717668716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTw3IRZEjtj9X2tzd7G8IPucKzFK90zRS9yH1RupvFc=;
        b=xQsvhv9419CF4yT5Mf6uRVtQwLf4Aryu38RbxEAdB5EPq6QOjPs56baf4T5mUyBwxj
         uIElXDNm+ahsNRWxv0xNNMHvW+rbNMECS5DII25kLQqMAWJX9XEBW1nWfsJsBcV00NKo
         oMBf5FQ118CwPnnRLTdLzdCLgFu6a6F8lv+oAEm9S/N7BgFgqmJi8aYs87zsEYZ8WXrp
         MNW7sXTqwY6almfTiv1kiRRBYeZt9Kb4bwTWiBqzrWZoSynjriz7+EKDx7t4PRNgVvz9
         fkwnpQ16t8niaLNXrbrK9JOI/iBGsBQZUezhnSo67zcKWuOJ52JZR6Vn+hvQIiWwTieK
         N02w==
X-Forwarded-Encrypted: i=1; AJvYcCUahOOjL7Vm2tU1w44qim0juIBxnA+68SuEzRVRxCO8T42qw+noAl/Dj04njhy+44ZI6CmlMZrDDW+yZs15oL/Xq0Scnj0U4IiF
X-Gm-Message-State: AOJu0YwFYDzOQX4e79BMD1hQOVjD0ZPZ6DZGLHXWldiOoPvaFrz4wCeM
	ZYglmuq4WzxSiLsUhQEDU7i6J9/r1s0SI51ePMkciXfQ9pXTfhGLix4luS3sc1k=
X-Google-Smtp-Source: AGHT+IGfd02sPfoD2nHto0/+98rMdUOtDd+kXq4ityc75IOcyDbJ04Gttkzd5fJAys86Uj9NOEIipA==
X-Received: by 2002:a17:906:32cf:b0:a59:cff:2cfa with SMTP id a640c23a62f3a-a65e923ef00mr110889666b.67.1717063915791;
        Thu, 30 May 2024 03:11:55 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda4151sm801020466b.197.2024.05.30.03.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:11:55 -0700 (PDT)
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
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v5 4/4] arm64: dts: broadcom: Add minimal support for Raspberry Pi 5
Date: Thu, 30 May 2024 12:12:01 +0200
Message-ID: <874589f6c621036620cca944986e5be7238b4784.1717061147.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717061147.git.andrea.porta@suse.com>
References: <cover.1717061147.git.andrea.porta@suse.com>
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
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  64 ++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 283 ++++++++++++++++++
 3 files changed, 348 insertions(+)
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
index 000000000000..2bdbb6780242
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
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
+		serial10 = &uart10;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial10:115200n8";
+	};
+
+	/* Will be filled by the bootloader */
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0 0 0x28000000>;
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
+		states = <1800000 1>,
+			 <3300000 0>;
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
+/* The Debug UART, on Rpi5 it's on JST-SH 1.0mm 3-pin connector
+ * labeled "UART", i.e. the interface with the system console.
+ */
+&uart10 {
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
index 000000000000..bccb7318ce7e
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "brcm,bcm2712";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	interrupt-parent = <&gicv2>;
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
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <750000000>;
+			clock-output-names = "vpu-clock";
+		};
+
+		clk_uart: clk-uart {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <9216000>;
+			clock-output-names = "uart-clock";
+		};
+
+		clk_emmc2: clk-emmc2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+			clock-output-names = "emmc2-clock";
+		};
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Source for L1 d/i cache-line-size, cache-sets, cache-size
+		 * https://developer.arm.com/documentation/100798/0401/L1-memory-system/About-the-L1-memory-system?lang=en
+		 * Source for L2 cache-line-size and cache-sets:
+		 * https://developer.arm.com/documentation/100798/0401/L2-memory-system/About-the-L2-memory-system?lang=en
+		 * and for cache-size:
+		 * https://www.raspberrypi.com/documentation/computers/processors.html#bcm2712
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
+
+			l2_cache_l0: l2-cache-l0 {
+				compatible = "cache";
+				cache-size = <0x80000>;
+				cache-line-size = <128>;
+				cache-sets = <1024>; //512KiB(size)/64(line-size)=8192ways/8-way set
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_cache>;
+			};
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
+
+			l2_cache_l1: l2-cache-l1 {
+				compatible = "cache";
+				cache-size = <0x80000>;
+				cache-line-size = <128>;
+				cache-sets = <1024>; //512KiB(size)/64(line-size)=8192ways/8-way set
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_cache>;
+			};
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
+
+			l2_cache_l2: l2-cache-l2 {
+				compatible = "cache";
+				cache-size = <0x80000>;
+				cache-line-size = <128>;
+				cache-sets = <1024>; //512KiB(size)/64(line-size)=8192ways/8-way set
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_cache>;
+			};
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
+
+			l2_cache_l3: l2-cache-l3 {
+				compatible = "cache";
+				cache-size = <0x80000>;
+				cache-line-size = <128>;
+				cache-sets = <1024>; //512KiB(size)/64(line-size)=8192ways/8-way set
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_cache>;
+			};
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
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+	};
+
+	rmem: reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		atf@0 {
+			reg = <0x0 0x0 0x0 0x80000>;
+			no-map;
+		};
+
+		cma: linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x4000000>; /* 64MB */
+			reusable;
+			linux,cma-default;
+			alloc-ranges = <0x0 0x00000000 0x0 0x40000000>;
+		};
+	};
+
+	soc: soc@107c000000 {
+		compatible = "simple-bus";
+		ranges = <0x00000000  0x10 0x00000000  0x80000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sdio1: mmc@fff000 {
+			compatible = "brcm,bcm2712-sdhci",
+				     "brcm,sdhci-brcmstb";
+			reg = <0x00fff000 0x260>,
+			      <0x00fff400 0x200>;
+			reg-names = "host", "cfg";
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_emmc2>;
+			clock-names = "sw_sdio";
+			mmc-ddr-3_3v;
+		};
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
+		uart10: serial@7d001000 {
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
+		};
+
+		gio_aon: gpio@7d517c00 {
+			compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+			reg = <0x7d517c00 0x40>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			brcm,gpio-bank-widths = <17 6>;
+			/* The lack of 'interrupt-controller' property here is intended:
+			 * don't use GIO_AON as an interrupt controller because it will
+			 * clash with the firmware monitoring the PMIC interrupt via the VPU.
+			 */
+		};
+
+		gicv2: interrupt-controller@7fff9000 {
+			compatible = "arm,gic-400";
+			reg = <0x7fff9000 0x1000>,
+			      <0x7fffa000 0x2000>,
+			      <0x7fffc000 0x2000>,
+			      <0x7fffe000 0x2000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
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
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
2.35.3


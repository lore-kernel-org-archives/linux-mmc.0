Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774430;
	b=2NL3/bsuHyVciYHudgFcnap12kGjdaOfWjQsUFdntvM/W82u6OtKuOTTV9oyPp56cewc
	 C3mUN8w+ZvMirp083Ab3gQClyYh5g38npzF007BsSDtVZEmv57DX4z2We2vzeUDcr2BRy
	 i7SpaFxNaaexJX8gKoCtC1Zd7uK5WpdZX/3P7yQ21zhHr1ePnNSqmRVZtzrpwxZkFwgv2
	 oJs5Oisu4/8/fR6rbQq2XwSOIvJr8zQ8U4VC8uDxz1tSw845vm+x6z9G8XmacwBPtkrSf
	 RUhlErrV7nvBUWC0x8n0FPY2aoRO0rU8Bn2YmFK1s9YaEBwscykLUG/QNFD8vCHdTvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774430;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ljKyg28qQ/WcmQgZfI4TeJvr5pB8EnQj+0JdpvK7SYE=;
	b=j4/XGbnCwNRdbbjWX6ZqIBBN85sr+R2+6O5bhTQrjypxNiUzEQ0lOBVWuaZz0xFGZqNa
	 jk5XfOUNm2+VZ/EXyHnsx26yKthKETa0lGiAfN8/EnmlELR+QTdq3yNmYkcyOfATANWIh
	 dcOiPGqtgh671crb0QziIC/T7DZDPDCJl/KgEbPJTawuznHjiuCrkDUyjYnbKIsDrb6+8
	 CNjbh8NRxJpWOclntIAKgCKUC/8Roy/iSA4Lpeszw+p08J+tFeM+j340EYUKQ2KBOyw8Q
	 aB2/W50iH/5fbyZ+WgAgMYsrSW37ZkrovL3y5++E0VIcg0IrBsPzhQKvt9a4F0++VLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzQlRzOK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E6606A69F;
	Fri, 27 Nov 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzQlRzOK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795774430;
	b=ELe2BMZj4e7Q6DFZtfMzmJM9he0LJcWcf4TJRDJtKFuGZ3EQ+yeggLz7MV2QD6v6Wavs
	 10qevf6GyHc6JYa3ST4GbeYmd6ldX3UD3yOJowbQNWYaDjKCyT6rOCS90e/0TQJfEcZeU
	 Cgtr1smixAGNWC19ZziNa6Hjv5lWT36V3PlfkM25A/pzaCbNMaLg25v96P4RafuHUCiYq
	 iDK5z+4gzMW2GTqSRqOwT1F5MJRceTNZlIa++GCXA3x/ODhavfvfEZWO0hFOsWPwNMzBW
	 oe5NU9H0D7S5k4FoZ+OKLrxCLXuSliTFUEZTlz+M/Te8LleBgNUNqStcTZ/wwsapcbQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774430;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ljKyg28qQ/WcmQgZfI4TeJvr5pB8EnQj+0JdpvK7SYE=;
	b=UqWN7YefODuWmGuYXnpNZrUNL28splwDmILlXPwP7nEsQImuTYKzYEjLRmbuStvI1yXf
	 +uWADlGLFsPMUTAhnsJ4jeaJsQHOcXOyFP9pCQj/mLd0WS68cEiFecMIz88boI3vgVATF
	 Q5YP4KtiubJwlj5dVQstbgwwCedLnM37NauP3unvXox/2qlUNrxWi/YksRlcdIXTGDGWv
	 6E0DWxivWS9Zg56K+iFPn+2EiHSsqFARd0i3WRYlDY8e/HE403hXNBl23EntL8s5jtAUW
	 StOOmJWnLcBcNlLq0pANj7ueuLIOGW3nzJ0iaI0ALwXFIhgTjqoRH+XnbWz03v59pSA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DD8911F0092B;
	Fri, 27 Nov 2026 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774430;
	bh=ljKyg28qQ/WcmQgZfI4TeJvr5pB8EnQj+0JdpvK7SYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LzQlRzOKXD2dkFJnNfD5JLiitkq3BH+yQPYWQ/DMhymXvtCVsXA0wQci+OurfjbmG
	 I/AJmNn0jLvrdCONzmJblTXpDVMDGNziG/insVgDEtAGPQ8ca45QgPSr+89/slhnhd
	 BhrE6oZ1bEK3PUfPLRMMkCPqBxv5Uy894DmaxgZ4GepHYkow3PIixYNVVktMO4NjaM
	 /ULeNjdx17bN73j0T/Qaqb1PCLCXxHMAXF0VN/vzvQLesmwVraSts22LsAE0eJh923
	 jG2ltTOvdMued54A9yrQPZ6kQ/y+Y2gFo12a7BdsdEGEhc71yvHKfUIAZqSLz4JniK
	 Z26+UCVt0LBVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5203A4B71B;
	Fri, 27 Nov 2026 10:13:23 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:13:13 +0900
Subject: [PATCH RFC v3 12/13] ARM: dts: sirf: add SiRF AT550 SoC and
 Yupiteru YPL514si board
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
Message-Id: <20261127-at550-rfc-v1-v3-12-f2221008912b@gmail.com>
References: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
In-Reply-To: <20261127-at550-rfc-v1-v3-0-f2221008912b@gmail.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev, 
 Yuugo Yoneda <yogo.0917.sabu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795774399; l=5087;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=kGHk9Marf5iU666/HWzBlN0H+fFM7mcgXprl/EQFvkQ=;
 b=Sdf6hCsbTPED5T6Ib4NKJ8xMbROwAOUQr6NkEbUfe1xlEtoGmfOeHJLIaOkXm4EzwrkY1yJXF
 dAjrnV6eMq5A3c18cE+ABfXM3ypMSZvVTjQtkJoF1sjvyscfCYtfhrk
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com
Content-Transfer-Encoding: 7bit

From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

Add the SiRF AT550 SoC device tree include and the Yupiteru YPL514si
board device tree.

The bootloader fills in the Linux-owned RAM range and post-divider
counter clock frequency at boot, enables only handed-over peripherals,
and enables simple-framebuffer once display geometry is verified. The
framebuffer range is reserved via a no-map reserved-memory node so
simplefb ioremap_wc() does not alias the ARM linear mapping.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
 MAINTAINERS                               |  1 +
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/sirf/Makefile           |  2 +
 arch/arm/boot/dts/sirf/at550-ypl514si.dts | 63 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sirf/at550.dtsi         | 69 +++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f9c8c08b..c6f0f3fb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25856,6 +25856,7 @@ F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-intc.yaml
 F:	Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
 F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
+F:	arch/arm/boot/dts/sirf/at550*
 F:	arch/arm/mach-at550/
 F:	drivers/clocksource/timer-at550.c
 F:	drivers/input/touchscreen/at550-ts.c
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 28fba538d..d28c8eb01 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -30,6 +30,7 @@ subdir-y += renesas
 subdir-y += rockchip
 subdir-y += samsung
 subdir-y += sigmastar
+subdir-y += sirf
 subdir-y += socionext
 subdir-y += st
 subdir-y += sunplus
diff --git a/arch/arm/boot/dts/sirf/Makefile b/arch/arm/boot/dts/sirf/Makefile
new file mode 100644
index 000000000..d1d3d5bfe
--- /dev/null
+++ b/arch/arm/boot/dts/sirf/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dtb-$(CONFIG_ARCH_AT550) += at550-ypl514si.dtb
diff --git a/arch/arm/boot/dts/sirf/at550-ypl514si.dts b/arch/arm/boot/dts/sirf/at550-ypl514si.dts
new file mode 100644
index 000000000..d34019858
--- /dev/null
+++ b/arch/arm/boot/dts/sirf/at550-ypl514si.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+#include "at550.dtsi"
+
+/ {
+	model = "Yupiteru YPL514si";
+	compatible = "yupiteru,ypl514si", "sirf,at550";
+
+	chosen {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		framebuffer@c0100000 {
+			compatible = "simple-framebuffer";
+			reg = <0xc0100000 0x3fc00>;
+			width = <480>;
+			height = <272>;
+			stride = <960>;
+			format = "r5g6b5";
+
+			status = "disabled";
+		};
+	};
+
+	memory@c0000000 {
+		device_type = "memory";
+		/* The bootloader supplies the region allocated for Linux. */
+		reg = <0xc0000000 0>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		framebuffer@c0100000 {
+			reg = <0xc0100000 0x40000>;
+			no-map;
+		};
+	};
+};
+
+&sd0 {
+	bus-width = <4>;
+	max-frequency = <25000000>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+};
+
+&sd2 {
+	bus-width = <4>;
+	max-frequency = <25000000>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+};
+
+&touchscreen {
+	touchscreen-size-x = <4096>;
+	touchscreen-size-y = <4096>;
+};
diff --git a/arch/arm/boot/dts/sirf/at550.dtsi b/arch/arm/boot/dts/sirf/at550.dtsi
new file mode 100644
index 000000000..0daf05eca
--- /dev/null
+++ b/arch/arm/boot/dts/sirf/at550.dtsi
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	counter_clk: clock-counter {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* Boot firmware supplies the rate after the hardware divider. */
+		clock-frequency = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,arm1136jf-s";
+			reg = <0>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sd0: mmc@56000000 {
+			compatible = "sirf,at550-sdhci";
+			reg = <0x56000000 0x1000>;
+			interrupts = <36>;
+
+			status = "disabled";
+		};
+
+		sd2: mmc@56200000 {
+			compatible = "sirf,at550-sdhci";
+			reg = <0x56200000 0x1000>;
+			interrupts = <20>;
+
+			status = "disabled";
+		};
+
+		touchscreen: touchscreen@80120000 {
+			compatible = "sirf,at550-ts";
+			reg = <0x80120000 0x1000>;
+
+			status = "disabled";
+		};
+
+		intc: interrupt-controller@90020000 {
+			compatible = "sirf,at550-intc";
+			reg = <0x90020000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+		};
+
+		timer@90050000 {
+			compatible = "sirf,at550-timer";
+			reg = <0x90050000 0x1000>;
+			interrupts = <0>;
+			clocks = <&counter_clk>;
+		};
+	};
+};

-- 
2.56.1



Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4BD3126B9
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386936; cv=none; b=tgbGAOp/bCL325aaUcnIWt1AikttaMJPT8HF45Jj/7oBKCVdm+707T5PD1TKNa4BuB4whtJMsFHJ643MnC44MHqI/IE/r0XDwbHOEzEfMGev/PjMdgTbgX5O4Dsv8L7OQQxlMJ+hXdgH/CvnDqBFzLIxzqId2PC1xeidyrpxIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386936; c=relaxed/simple;
	bh=jR61Jx/L34YpSRYWBi9qFXxWLcHX8m1CNNA0rxY9loI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuYaK66pSanrXKmycdE+I65Dak/XAcG/n/co3VzlV5G6O7Q8t51F7oH6b4fBVIl0ZZGKhSOAoIndveeR23C10+My6l6y1ybPgc7D35MovCKrH05F8ZIRRVskuWGX7YY3LuCHp8G9KXPILCCPb/12DM2kq4MpxI1IMfKOF3EyUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X0agNB8g; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X0agNB8g"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso1566319a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386932; x=1756991732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDbzDzint4NdSMjZoYKjKWKdFOvKafCGzOB2IyJMsjI=;
        b=X0agNB8g5Ohhj+Z2Z+0KH53Z/TcldlKIVLf9BVGE77h/511K8TD6CVUVBLSeqR3bTO
         QnP7kfJHeii49Lb+rOrtStHGc3wkiqlQ2dbIlJEHP922JJLr41PmAViSpJyspWb8lYAv
         CHF4pT/tTsiTAZ8r2bd7E47Rb4ObEbuLU0uBjhzHtpJI911VJx/RCx9NXZHgdVv4BKBu
         0rYhJ486SHa0F28Nv9yzyK9DyP8VrFu+VLWmQexiq8QMa2KPB54jZCxaati/JvuhfeJD
         VISCGEfNo7ucTWGAWScRYv9Ra58C/XrGndQXkqSMzISz7n0giRStpZjetuFnjJkOBjjY
         54yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386932; x=1756991732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDbzDzint4NdSMjZoYKjKWKdFOvKafCGzOB2IyJMsjI=;
        b=iP80I94Xbm7ZT6BdJKynTSdL0ZXrQd3UeKqUxe+AjIhyuPKaLK6RjchKd17rYDcZNk
         xrvbbpTRNeEIJv0svelPrL/ZYXUfp3CTsg4lN9vZTWmms9RI8wwJLcLGfVCKyCR0BYf8
         wOKOhOzNl3kuIycIpO+PXQ5SXyTwbdwxagk5/Q3YYoEJObn2V6wD6NSSw6ki2SgmcHjC
         HMeO8+jeh2SLJTzbi4cdjKJuuppa3L6WCC/8nXyRLrpkoFhm43mvfV3HAHczPrlntMvs
         +0x+dRnFzyQfxAPcqQMF5yNCnHDCT7W7tWjm2qNoVR9sS49JhoVeYKD8tnzx6MKRMBS0
         EHjw==
X-Forwarded-Encrypted: i=1; AJvYcCVe0h1ZOPfA/jWE/egg+3/rqx4KqnIsMXL02zBaHhNYRUm3E4bsdIiYFzTA+LHs6Z8FRu/Bht5h6xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMza/7K5WRnhVFAV7UlZLbQnIGN/2Sh2HjNDV6VBVxZu2iT+B5
	66IFKaPkn9J7cRgcSrgRc8QEbwjwO/GSwkbrpyDoMiMwrodVAZPqPmhe8gY+vFEeJn8=
X-Gm-Gg: ASbGncudjE6FQ7PjKtfiC8CpXX5Vhodgkl5vbR+vIZDCsXRTrqCubFXoMbY85nVzqkv
	ebbnLAqbX8E4Kze/odAXRy4zkjkwMKNNO1hFsTRSmwVKtcn0M0fvpldJ9/cS44TsqPZjOcFftZX
	3+tFMZ4P9FGbHbh1O0Ylt5pBb+ulo5E37q2uJ4C4bMndWP0hN4ts/b6QGmAYm1vYmZguoJU726+
	D7ZFc28PR+a73ct2qwy6UUk8oMdWiQepHn0LomXQyfsU36VjM1HaPyHHbgjQvqYo5eSaJQBg+Tv
	fxQzH2Np2Uj0FBYjru5RrVNMRdN9kt6C1/pz9tkWeCKD5UUCzbNwwMj6Ic5ugzlv3P7WFT7fIZC
	AieCr8DWIJWHCmLLMzk7TJp64ysJ4VKMIpUP/hnOUsHdr611YD537QNj/tH3FvXemT5w0oseW8W
	GWKm0D586aSqfifBDs
X-Google-Smtp-Source: AGHT+IH9+QbGR9aSDPrFBVItl1A1m4Ivh6TYBQXMoc7xdFCVadOMpEbe4v00/Pyx674AUhPZjWsNLA==
X-Received: by 2002:a05:6402:52c4:b0:607:28c9:c3c9 with SMTP id 4fb4d7f45d1cf-61c1b453182mr21153103a12.6.1756386931753;
        Thu, 28 Aug 2025 06:15:31 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cd8ce1cc9sm1302435a12.42.2025.08.28.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:15:31 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 5/5] arm64: dts: broadcom: bcm2712: Add UARTA controller node
Date: Thu, 28 Aug 2025 15:17:14 +0200
Message-ID: <35c0da6a741019efefc3c8e405e210a3a8156830.1756386531.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756386531.git.andrea.porta@suse.com>
References: <cover.1756386531.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ivan T. Ivanov" <iivanov@suse.de>

On RPi5 device Bluetooth chips is connected to UARTA
port. Add Bluetooth chips and related pin definitions.

With this and firmware already provided by distributions,
at least on openSUSE Tumbleweed, this is sufficient to make
Bluetooth operational on RPi5 \o/.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 42 +++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 18 ++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index 411b58c1dddf..04738bf281eb 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -81,6 +81,11 @@ wl_on_reg: wl-on-reg {
 };
 
 &pinctrl {
+	bt_shutdown_default: bt-shutdown-default-state {
+		function = "gpio";
+		pins = "gpio29";
+	};
+
 	emmc_sd_default: emmc-sd-default-state {
 		pins = "emmc_cmd", "emmc_dat0", "emmc_dat1", "emmc_dat2", "emmc_dat3";
 		bias-pull-up;
@@ -110,6 +115,29 @@ dat-pins {
 		};
 	};
 
+	uarta_24_default: uarta-24-default-state {
+		rts-pins {
+			function = "uart0";
+			pins = "gpio24";
+			bias-disable;
+		};
+		cts-pins {
+			function = "uart0";
+			pins = "gpio25";
+			bias-pull-up;
+		};
+		txd-pins {
+			function = "uart0";
+			pins = "gpio26";
+			bias-disable;
+		};
+		rxd-pins {
+			function = "uart0";
+			pins = "gpio27";
+			bias-pull-up;
+		};
+	};
+
 	wl_on_default: wl-on-default-state {
 		function = "gpio";
 		pins = "gpio28";
@@ -188,6 +216,20 @@ power: power {
 	};
 };
 
+/* uarta communicates with the BT module */
+&uarta {
+	uart-has-rtscts;
+	pinctrl-0 = <&uarta_24_default &bt_shutdown_default>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+		shutdown-gpios = <&gio 29 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &hvs {
 	clocks = <&firmware_clocks 4>, <&firmware_clocks 16>;
 	clock-names = "core", "disp";
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 871537366e96..8ff254c35b0c 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -38,6 +38,13 @@ clk_emmc2: clk-emmc2 {
 			clock-frequency = <200000000>;
 			clock-output-names = "emmc2-clock";
 		};
+
+		clk_sw_baud: clk-sw-baud {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <96000000>;
+			clock-output-names = "sw-baud";
+		};
 	};
 
 	cpus: cpus {
@@ -260,6 +267,17 @@ gio: gpio@7d508500 {
 			brcm,gpio-bank-widths = <32 22>;
 		};
 
+		uarta: serial@7d50c000 {
+			compatible = "brcm,bcm7271-uart";
+			reg = <0x7d50c000 0x20>;
+			reg-names = "uart";
+			clocks = <&clk_sw_baud>;
+			clock-names = "sw_baud";
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart";
+			status = "disabled";
+		};
+
 		pinctrl_aon: pinctrl@7d510700 {
 			compatible = "brcm,bcm2712c0-aon-pinctrl";
 			reg = <0x7d510700 0x20>;
-- 
2.35.3


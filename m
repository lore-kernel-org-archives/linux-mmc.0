Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663953A7F60
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067375; cv=none; b=UQav4DG2JzVG8Zhg+UhtQW4OsFkgqPPU8FzQXABuZW2ZeDwcZZsugOuOhUPG4KjDACDtVN7oRUKKL+UaGMRlgLHNn1wurpINlYfB+SvSozIvDeuLjJZjBPnDabGAwkD914HWhiCuKI6yctOEJRG6gPGso1mBbN5AEGuRsRExVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067375; c=relaxed/simple;
	bh=hxs3OSpNzHQmcxvHvXpddESvsaNDoOgB9L1Rmxo+7a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJBSYIDeEuVW9gnrUcpdeLPf4iy9l2vdMguL/LCFf46FFr7GAbCtCQMSe0DjCfW84P2amhDnAwjI4OF3ExRB/Ih1YIIf2rjGT4MWQk+Ga7IroGA42c1y62PHKJvrogWwY1bnbP5NiW0UaK3IP/a7bxqyL6gYvFIQFJlasHQBI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCIR4x29; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCIR4x29"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671ae79e617so88941a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067373; x=1776672173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPuO322us0uZuJ4hizKSGfFjcUXHsAzG0IoitERG8vY=;
        b=pCIR4x29n3VXokr1EVW/X59x84NswrGgRbM4JhU73UU6KM71VGMQ9cSS9HRvptJBcy
         dFHHhS3umBDNPYQi+pXqqrLDDgXrJTaEfRDqaxKdhMxYuD6x1jf3DKvAJlfaPyC++wfK
         gDFhX9un4V4K2+c52GTJAsa66bOhOZQj3S4YOfUJ24sin52pY0UsECqAaBcduzWwiXFq
         JQOTZHPTeBYhVCNyiYrEHEvA4eyUvBYjs3KzlloZdd02A2jkk/xmHtGF2FruTgwNfxi4
         9YnMoYwuz4hu1ZunHE4Nv8hQqKU2KM1E06C7R/778eBormExBChG3SMQGC+gfkQOYYP5
         Ysqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067373; x=1776672173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rPuO322us0uZuJ4hizKSGfFjcUXHsAzG0IoitERG8vY=;
        b=FXggKtCOvY2uD5N5OiB8+Uqz6sSJsboNeYGx9UVjORylPimECo9YnqHZVl6AkPP40S
         SZnDHB3rxP9XSZrsw5oS7Po82nMGBHjW50R8zSHaSHykZYTP4pi00ggd/3G9qP8TecHh
         lxmHU03iqkR7TigAGLRDqs76xuiyoR2zFX//MvVFym8VkbmTpxabT7bUeyc3rVVmEwsS
         DYlta10PGY+CVCtuclHExY4AbLG3PX39H9aSa3KPKbQORARY0PlExatRVRchZRtHni4W
         WWFhdmVeW1sGDACJiLoCKqEdy6ZLXbE6b0i9XZYvonXbAehHtuMAFzBPkF/aywBd3++6
         oR1g==
X-Forwarded-Encrypted: i=1; AFNElJ9mMC/Ak7pKCS1WTF224J8jgYOseIaH+x1fH/tXAn3gbmR/qvp1mwCD3US/qjHFMe3PVO+/AVQe510=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQsEGZi6J2sOqUSFJFNcAMU01A8yaXipLOmB2Gx1X1nZp3Mbc
	4q/hELA0qb3Kh1f/+O/SilVWmp1GAqPKwZ01JUllVW+UeYqvKKJ8i3bv
X-Gm-Gg: AeBDievtGHdKvq7WzcKCsnLEYy3A/IA+ExsRJZnrkFwL9nhLza3TsV6YYxYRTWBBe5+
	oWymhOEWZLK7ScxHSLFFIKy/1rYcI2sW0utbJiI/RYKNUkm4HF91zp4FlU0y14NC7gh9sB9bnUT
	qxldQSJdfFruBfxP6xwLd0c3XNErD+KSK7q6ZgEU/fOsXBfW/qgdjlGuBcHhFx87k2ktoeT/Oa2
	VpM+/nZJejUkwCgkbhlVwsl739g3bBW0O08wcqqJV9z+psx58NkOAhrZg5q+iOM+uLLYPjIYJb9
	U3u7Lt6j53aCquh1Q+y1wAGyrAZ5GWNa+mmGfWarQYJNSCiPT39QeuKUqUN9Y4+ukP46ln9yKRu
	yNQ6rzKDyb+g0U1xG+RsjBL1b15DVvv5rY1tYmDkvWIQ7+dv5bshbkynozb4ZFy/yuCdCG6iZBT
	l5x8ZhGX1v09d/WNTAr+mZVmlDOPWwz/ZCEakT7wCCJptU2T72p06EwVed2m+hv/1d
X-Received: by 2002:a17:907:788:b0:b9c:b682:83ba with SMTP id a640c23a62f3a-b9d7277c7admr701543166b.4.1776067372290;
        Mon, 13 Apr 2026 01:02:52 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:51 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 13 Apr 2026 10:02:18 +0200
Subject: [PATCH v8 9/9] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-orangepi-sd-card-uhs-v8-9-c21c40ec16d0@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.3

From: Trevor Gamblin <tgamblin@baylibre.com>

Update the Muse Pi Pro devicetree with SD card support to match what
was done for the OrangePi RV2 in [1]. More precisely:

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with inversion
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes

[1] https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
index 29e333b670cf..774a4640f065 100644
--- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -18,6 +18,24 @@ aliases {
 		ethernet0 = &eth0;
 		serial0 = &uart0;
 	};
+	reg_dc_in: dc-in-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_in_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_vcc_4v: vcc-4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_4v";
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 
 	chosen {
 		stdout-path = "serial0";
@@ -77,3 +95,51 @@ &uart0 {
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c8_cfg>;
+	status = "okay";
+
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		interrupts = <64>;
+		vin-supply = <&reg_vcc_4v>;
+
+		regulators {
+			buck4: buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1: aldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.53.0


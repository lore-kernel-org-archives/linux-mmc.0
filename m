Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09083B4E8B
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859922; cv=none; b=RYBhYY0j67+0VP8dWO9dHE+A4Ud57dN0+kgqFCsJvKJoSND4E5AgxghuhHrgA8QfppH07zZN5YeglYVwXeN13Dgydr2rjVC6o62AYpqEzyymgAstA6OAop3C2c3RNFrqLuJRy/AiysESVU9JGjDni2IIDaDgMTIjK+ysf0hAc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859922; c=relaxed/simple;
	bh=/XgektwUTyrRiqcljig24LQcihgwiimxLKBfjjRqYQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vg7r4Md2Z/Ge32u/0pmVOnuLP8wTH86j6GMpe8TJ3DFuV1pRV28oULPEU7FTWuj1/SOOoVW7PiSVVa4T70i7ppBJqU3PoOCNtK+zL1Vw7w8NnCtI1TtaXfQNh4+67Tjrx5LfiZyDeSz0pQkR2+xFNR3uyOzj69jRNabPtnCJQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3bpww4r; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3bpww4r"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48541edecf9so52652905e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859919; x=1775464719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2b3A5VlJa4lpM7E2GeEDRbbHgTsaHKFUASwgrv7Rf4=;
        b=B3bpww4r+iAIW1DBwAxleDS1NAuCP7HdAVba/MMR1FshWcx8oyZLiJ65T6KUb9btem
         CSBPzYlvn5cOqpU4ptzWJunTgPY8f1ZR/oFHe8aRBuH4Gimr6Ah9zANQ2Fntvx9nxCLM
         x1cJGfx3ko3Bw48f7UTsxutW5F8MGDxbP4c2KREHXZH4XovAeY/SLhP8kyNiBFDqR+y7
         M9sCGi7HYhUSx75mXOVHxYZitnRznSer/71t5nwnJKXB3ZAjh4dVQYiPlZ21BeyW8ngk
         whqnF3Yc2F/07o7vBvXx7G4Pbp0tWYbFDAmZNS0hVCMUCcUhtO/YjjYWgZys+L4cJJ8F
         ohVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859919; x=1775464719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s2b3A5VlJa4lpM7E2GeEDRbbHgTsaHKFUASwgrv7Rf4=;
        b=sTOqsEE072HKY49bzFKyUEU68ehbgdHWKBx1z6e4x1nfbyxQhZZUOAFXEaDbMkJPap
         uVOc1N3tXHw46kPp2WmEmeCadu+W0Ual+51ZT+RuAzqzRikC2iE0E6hzOEbAjvTO6WxD
         4VZDl8Qg0GUzMC+6KoRRA3/z6O+PBQ4hhBewRRj+NIax9O2JdchH5/VcuBSYYhAGMmHn
         uP+yeZrqcVExyTK83ALB3AAHiLwI7/OANZh5x5ghg0wqg6zZGoZYssT9umlIJZQLnt9o
         5pE0k/Z3S7uyc1xRLfEGrn91lRtJtesUElgI+f2MFPg6h0s/qQ5XtAFJ+ZHPkOjK2en6
         SCsw==
X-Forwarded-Encrypted: i=1; AJvYcCXfKVxYvMbJlG7Y5AwfvHRL72250uO2acPW6/yqYOSf7NEtZUqv6uiEZpTO6mxwJFfAespsgXJmR0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzt/z6Gmrj4DRUuezx1Sfqub6NIToZxYfAttfhZkyvzgJQzxbZ
	KPx17xVkFixYGQMW0WU0zzOFJKLh2fWpcscZXwq4tGEfnps9hotXMr7l
X-Gm-Gg: ATEYQzxQQWZoIp/iWoMoWGIJ7EPWqU8SkcVWT0Z6jSIuoF+5pCN20vfkmJz1DARz4tg
	Bwn5CCU1bK014EX24PX7Fc3EJGTLe5XWeQPhMYuhf9ClzEzvIMd5VujaUlCgSL0hAdohD3HafXS
	gTMxYyfJZmNzwWq3uLaSAdy4WL5CQsdDdApfJDfefRx+j6AUze8XZE02LDPq6ZYvl+Nf1qKyzkr
	aue1oRnTf1uED1PNTBUBm7EzlsByYCHkcdkCcKZ2iu1nTMnvrbxU5bpn8gxkWV+NWbz5fF9bjeB
	6z2IFH72lJU9jyOpNZ/TZtH9adTk3cYJuHZBugfQBE3g4vr0FGHKi79vU4f3+ILL8NbMocrHcAb
	4+hCB+KinhVYSnIfKGeUKhvljr9DtgisCxOsJy4ccyyv43VXa5m9nrFPjWu2deXqytF16qQdlmb
	OGK+lXZBRBBKJ+T9P47TZHenqHEwqXsKdVl6fIlqDGX3U0BO27EmODhpxd/hZFMpNT
X-Received: by 2002:a05:600c:4e08:b0:485:363b:fafe with SMTP id 5b1f17b1804b1-48727d5e971mr206919765e9.1.1774859919161;
        Mon, 30 Mar 2026 01:38:39 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712c236sm74063315e9.14.2026.03.30.01.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:38:38 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 30 Mar 2026 10:38:10 +0200
Subject: [PATCH v5 9/9] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-orangepi-sd-card-uhs-v5-9-bd853604322d@gmail.com>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.2

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
index 29e333b670cf0a5c4ed852668460db475b9c44cb..b63723978a4b5317c506c6df6ad410d23b0f0ea0 100644
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
+	pinctrl-names = "default", "state_uhs";
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


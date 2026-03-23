Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9138C2A9
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261189; cv=none; b=S5+doTHgwhzeXKhfJwBCpplOhIC8+R9ONDNO5tFCgYCQAODUOW1FJ9o22hF9LKsLwcnmTL3zPxYE056lImVRlpLN74NgpZPTrXT6LuULdrws8IYnKaZdPmA0MHC3OB4oYfn6QU6kXWLiAPyD4sqJxvZW5yvb5UAozK8uJBDkA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261189; c=relaxed/simple;
	bh=/XgektwUTyrRiqcljig24LQcihgwiimxLKBfjjRqYQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enV7qiXYu/Cefvf6USAyvUgsMezl4SddZ+rat0cEcVxp6hGXr58T0EVoA4y1EW1cc7fYek13u2rc/EwIyK7CngNJDMbPEb5PaQoyRKz6u4KZbqCMoLBkEDxF0H604Wzw9E5v+4Bzkvle8/PFgd7j3SxsmhjgD4Lpgz3Uz/QDQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjyfM1n3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjyfM1n3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48704db565eso16547015e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261186; x=1774865986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2b3A5VlJa4lpM7E2GeEDRbbHgTsaHKFUASwgrv7Rf4=;
        b=OjyfM1n381+bRIfGnSEEbH15/JpjKQ4GDiXPlPCDKuRy+9m88P2+7EsfWG+7YHFpgB
         Js6UgJ63gf8LvWaPEcniqIEupqSulDILCz6SFnxuknswhXpIoFFeDrjeTJ8WQVGaxWkz
         99gqM5NcUX/yCOS5J2xMivHTHVC0tny+Hd9gk593QHu4A2gRHol4a3OjOjKsw7dSS18v
         F3LQLq7guNABhlxNmUhNvL1cjBlRwEGCqwt8fkfqprHWwJNNi3QhMY2LzI0DSUA7s/ZK
         76eH7SP6Eua9gk1KJlkS2LVJ5wbAFXLLjZCBTpIqiS6Cv7eikZLlgXxPnxEOkjSst/kj
         nxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261186; x=1774865986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s2b3A5VlJa4lpM7E2GeEDRbbHgTsaHKFUASwgrv7Rf4=;
        b=XYWH/WtV9oYI5x6R7BbX9PjbIAFiqlTOuAIHnT4Tt5W4u0IC4b7LIhPNBt0whGnBXo
         X3gslULC1XIXW4lwBnpQGGrjbQaIi0CB+heiQxwAiXSUcCTi0UnTk2k0gUaPRW87cRFz
         kHReXrm+L2di9r2hUyr52x/LJXu44+VpufD5a45Vd1CLHg3bYcWHxakNCRiC8CgrycaV
         uTTnOMBj0ap2OYQZXqWO4LlSy4mgepjk6c/k68sFC82wVJebKSYSId7hrVBp3PLv73QU
         RhXr7utzjS0PtGppFb7KMVqvqAHIQFK5/lIDcLK/em/YPx4QbaSBpAHY7GUwOi5zsaXa
         CkZg==
X-Forwarded-Encrypted: i=1; AJvYcCVGtJXr0mTJKcoRTgwv22euTFV8+qPR6b9xqfxs7krxf8TeoidTPyj83cQo2V4cYh8Nm56AA5iG3KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/Cyp/ZLPirdE5qSchC9Ky2BgAvUQmPrHr9TlQYhiWS8gm+Py
	ryLEXHZNsBYt2/7WycRIWyvs/zD8j2aOx7eOUQugQpRK1BGBE3x0n5AI
X-Gm-Gg: ATEYQzwPmDWooYJsmPZ7V5dtVvc+kvdpCneIC9HDBZtj4Kvt+9QUYHsnT3TkbOfBk7S
	ofqNG6lSja5C8+twFai+KCQ0fN4yPZxDGqmIyZ7s4TWNTCCG9I/iJ2yp0uuLuiaNag3044edby+
	DRinQ6DBJdmja2vNKOk5xGmNxHpWJyVmI3ZREz8nyy8U7Z43SRKeIhOhmDT7i1dkLxMCOn6H06M
	8RZ29TMDBVX7YXe0cF47GCga1m0QUZC3QXv1RK6J+bbhCsEvNvuHJZDnyaSgfOP3lBLr9G/6DWS
	Dnbbh2GHKmhIsTs+ISpxN+KLUjyMgppmmAbLseR1WlgB2iTZlncKQESza+NABtM0ccHk8cwweKU
	jcVcDrjM3sPgmXW9qQx8k+sfxzqfyKfimLwNAF4Ql20bR6Eiz81CyUPFXTsRfr7fxgVun3IY423
	t5t7ulQNiEn0kU2kSkN/dGURX0q9NamsqfhQiLuwjfgWXTb/SfYOLmCY4iMP8hyAur
X-Received: by 2002:a05:600c:530f:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-486febb455dmr171394665e9.4.1774261185644;
        Mon, 23 Mar 2026 03:19:45 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe86acb0sm78755445e9.6.2026.03.23.03.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:19:44 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 23 Mar 2026 11:19:11 +0100
Subject: [PATCH v4 8/8] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-orangepi-sd-card-uhs-v4-8-567c9775fd0e@gmail.com>
References: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
In-Reply-To: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
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


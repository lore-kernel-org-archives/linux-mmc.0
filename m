Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B61D45EF;
	Sat,  4 Jan 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009017; cv=none; b=Jf2VsqY4H5yt233GrljzgqKL6A/XNspRJqU/0nTejI75b//ZmxafUopdLibQvModQDMTYDcKXfoaQMvudIl3rWvrQ80NXeeReGWQfxy53by5TcBPgb+hUM+wxAPGYeZVd2f53kvoK0Tav6CCcwaPRhlr6j9wK5+jyejkn9Xn+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009017; c=relaxed/simple;
	bh=MoG1sMK59thFnpAoDfcxIXy37Vob3WnUripHg04FWmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwYryHRNPO0CLf+76IBkk6YwkD76WwRtZyP7Ma1QjKHg1TPR32SuDSA9uegfCsKYwSLhHryqFNiU/7K41WY/NNr2SIM3s5BCyG4Bzqn1SSrKurT2lm50qJlh0Tf5CnGwNpZoLV7dqNnL+Qt4X828kdlo0Uod5VWClS1Ek2CHrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/FjKBRY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/FjKBRY"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-386329da1d9so6007232f8f.1;
        Sat, 04 Jan 2025 08:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736009014; x=1736613814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+Mh3aTaCcP+5QY8RX9wcAwubgCOuVuuCWZcKrT8SyY=;
        b=A/FjKBRYeJP0kqV0CzN5VVaWDl4dBulMvBixrpe/oVMM6RY9tLeUOAz+BSqU1jIBR0
         1h7lzxyuznhncIrWmYba9zwkB6cXr6Gu4QuIGF1bCN4mqjoyPnwASv3t0eZ5Yz8I2/xW
         TMvbjQaOGlKTu49WF8eKtEk9CMgP1Fv5RfcdSgnFuy1RD+pSE9PL1FzTza+iUgAHlilr
         PFm7n6D/Yrm0dgEZ+2nUFfi+l5V+9OKJPSY2kJvXJ9vXaemQ0Em9bgFR7CC4niJO3Nyw
         4rInk4Dj0LvwB4GGfpa5nCFLvyqTkX/ST2x2wWmKHrwb0KA7I3KwXJNrXYFE2lR2w2u7
         5IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736009014; x=1736613814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+Mh3aTaCcP+5QY8RX9wcAwubgCOuVuuCWZcKrT8SyY=;
        b=lhPhiYwfSc3a5hnv4oCtWrys+F4UZX2+muj3ufbXVwoajUFksL5L3xJBxUkLmsMkN7
         PBPzyUqUdXezJYz+Q5WJcaK2I5RzdISpjgojV519x4tD0sO9yZneSqjbLpqF81UhxbK3
         oBLNemmdi4LjfFKziF1SuN4vVw+qr37Z4Ikv4QwaHUD/JiMVjWB3u0TAeXflDX0fDttU
         cJVbT/RCKb4OejJZrcTWhFle9Abl73c1QN88hOH3gRCkaEKVuwzGIV7VqCZRsdoF2YOE
         T/QJKuPpr/JB5EMiU0KC98TSEBwkoQkC4TQfFFbxhzDMBworW+sdAGBTHRSwi9DiCXQT
         Zsow==
X-Forwarded-Encrypted: i=1; AJvYcCUHUFado5mmK5ZU6PUY3xEI88cVQhzEAx9eRv3CLxPh/SPAnXZHjbWMmN0hqWSWnaCKzUxJRtmGIeLnfIKA@vger.kernel.org, AJvYcCW14mmchu7mqBClLMSzWEwqvTbKMvp5XpTKXCR8d4uSJceOG/dGm7y4+p3QMq9P4Bc+ycdy2sWEUVj2Gq3nY0EZoHs=@vger.kernel.org, AJvYcCXBIVtodLJqFmkRSf1v0K/ljMVBYFMWjB3TbDKvL+6C+I9pdJeG/CnpJxGxlbYaSZ+bXkInTBlUaZQj@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKQQeQQNxaBq10/HWqx1E7gVA8fG4Z6ZJfcAROnodDFWKNFgP
	HJ9bcuqtnyVgcdmDIQxHPD9xAaCihQydfSdWEFetk14dw8buYufI
X-Gm-Gg: ASbGncuKMpFEvf6kDBTWPrZhmgLdauLTqgO6Z7JyOnReB5kOlhO4HpkCSj0KU4CjBnA
	J/M4ABcii/4NXlkWUM7Tf9lIeIG97jzBrHDogNNg/qmIbHMXjtuIZkD1pQ8ht9Wybz3tPIUNxjq
	VOboZiY7f9laF6Z7Kcn065KMY4sJRz9GwDXvq9IkwPDJwO03vzMh00w07/gZ/u3Db8x3QdiR8a2
	PQyS8M3ajRlN/km0ZHhXSZJD8oHWPCBQKR7ac7GM5vNBJ3IbEFcWsWQ6MhGgZcaSlO4Khs=
X-Google-Smtp-Source: AGHT+IGVyo1OKwPQhJDAQ+1vJHH1lkygpP9pytkfgJ0oMMtcQZBmktlNJMzxUHttbVIZzvBivDCxnw==
X-Received: by 2002:a5d:5f88:0:b0:385:f69a:7e5f with SMTP id ffacd0b85a97d-38a223ff3cbmr39539122f8f.38.1736009013886;
        Sat, 04 Jan 2025 08:43:33 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm513321455e9.24.2025.01.04.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:43:33 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: exynos: exynos8895-dreamlte: enable support for the touchscreen
Date: Sat,  4 Jan 2025 18:43:21 +0200
Message-ID: <20250104164321.333669-7-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Samsung Galaxy S8 uses a Samsung s6sy761 touchscreen over hsi2c23.
Add a node for it in order to allow using the touchscreen as long as
the previous bootloader has enabled the required regulators because
there's no support for PMIC yet.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../boot/dts/exynos/exynos8895-dreamlte.dts   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
index 6c4f8d4a9..d9b51d884 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/soc/samsung,exynos-usi.h>
 
 / {
 	model = "Samsung Galaxy S8 (SM-G950F)";
@@ -93,6 +94,33 @@ wink-key {
 			wakeup-source;
 		};
 	};
+
+	/* TODO: Remove once PMIC is implemented  */
+	reg_placeholder: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "reg-placeholder";
+	};
+};
+
+&hsi2c_23 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		reg = <0x48>;
+
+		/* TODO: Update once PMIC is implemented */
+		avdd-supply = <&reg_placeholder>;
+		vdd-supply = <&reg_placeholder>;
+
+		interrupt-parent = <&gpa1>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ts_int>;
+		pinctrl-names = "default";
+	};
 };
 
 &oscclk {
@@ -155,4 +183,16 @@ sd2_cd: sd2-cd-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
 	};
+
+	ts_int: ts-int-pins {
+		samsung,pins = "gpa1-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
+	};
+};
+
+&usi9 {
+	samsung,mode = <USI_V1_I2C0_1>;
+	status = "okay";
 };
-- 
2.43.0


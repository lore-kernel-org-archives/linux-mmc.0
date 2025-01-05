Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455D1C07EE;
	Sun,  5 Jan 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093640; cv=none; b=URQpCb0W3MdqNX+zz88rbUOYwXtLvWlzldCLx0sBVHh8+5jMIIW+MzQpDklmVyhW0Q6wPDTylmVskIECTycRp1/Ek5gDnQV8Avy507JiUnZfE6jkMriwKwg+GTmyfuvhDmR38eVpK1CuULwiqourZtlMfioG5d+HmxKcv3ayqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093640; c=relaxed/simple;
	bh=dPKQ833edyEcVdeRaMAPYGGBsf88WVzIzfOKhY2RE2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVU+EZ/gmZaW0gScWN66VZW4DWKm6IBMkHkNYfKHMAOqkSoe5vTGxwsyPIg59uuvUj3K4P3i4oH4hZMT0gqWduZFkttLLbHhR79DInUQ2N/YbS7UyuegGSmRf4khN+km9z8gB7Hcm+vzOz4azjsan4y2zMuMfLZ3aSALAZcq0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POwWXbli; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POwWXbli"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361815b96cso90139135e9.1;
        Sun, 05 Jan 2025 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736093637; x=1736698437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpWoGBpI5JjtqZNRK0ytQyJ2WYZd1lAvc/QlVyBoHrY=;
        b=POwWXbliYKk1hWXSCIfcaSGUfeHdHnGwWGoHzfzG7jlvb6FqSeLpuWCl/YutjKhpQH
         LOGY2nBlLkJhv+Yjf3a6FMAy4cUrjZpweq1FKRiaLz0KFwG2b31sC6Hglx7sHlpPWoFs
         4mxzMlB1MraD+REOFvYirh0L0nvZnh0G6aJ1s68fnSCHWkYy6KQ5fzGWhz0KF6cs8ns0
         lKm+D6d1RnvqlLyHqpvllWpyJModCJAIwMML8HSgYqlPkl62AwgY1DvrTlgbC/vYk4hS
         ID60wIPYl2Ugu+w1LEMbXEvLHLSSiKHQvSDfYI7RK+oh2bsvY9MaoK5S2M9f+4Eeh7+F
         8Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736093637; x=1736698437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpWoGBpI5JjtqZNRK0ytQyJ2WYZd1lAvc/QlVyBoHrY=;
        b=MASFUW4zwTlPTs/cktsp8MUb5b6nCM7EFWrnu83dlwzjhWUJ3Q4ITRJYWb9unwEbp0
         1M3Vq2+HVwIArry1b48f4R3B+KQaTKpkqtuoKb32r3pXlMjVa0CLveqb0lTgI++SGQJF
         4/Trx8jcVzJxdL8FJ9yurdDtoNgYQEkhTGY8OAgTYOtEf/NhRAnVlwKCgv85ndc3sqQb
         fVbHdq4Bs4Gu3YcBOU/uReW/haISOQdyVtSjXQrE4SP8bVuZH7JkyRE2rktGzEBWgxAP
         edHXlMODepdxxaNLJFWEcSMBh3URXYqyuAbC7Vu2eUrT8Y8+jpcGJy14MfAjaUIaVQec
         7UjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8kQE8tix5Rj3JSHd5cjDZ85G6nPbGgWMg+Ex61qrsjP1BcbZqSnt/MjFaO0sonMo4Acd3z0QrnLyqG4R/@vger.kernel.org, AJvYcCVjcNzwvl7HwZ67oLa64TXHTDrxFPk+J8EK6yK0ZceIdT92leHkQCPv/D+m5y8ufafjlDQiypBCj4XV@vger.kernel.org, AJvYcCVpKpIdvZILQ1Zz3bmv5qGc1Wt0EhjcvV4AH7b6l8g4AIrPNcgtV+1gd90KmuLXGxLLXMdqOcIiQ2x4VG8ZfDI9WYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxg13Yu1onFH1AN3QLUu0D++P4xUCgWbKm7WFWVCprFYmJUD5/
	lFd9dPWERwceaZD4PMcAicehzy4gjygiRG5JNWuS0BlSruFvLlWp
X-Gm-Gg: ASbGncu74/x2RLaWfZTC3I1Da37LFM9XKubncWSrpJ+aeAK1u6O/Rpdxa/jy9AwXXHI
	v0H+JxHwVClta3ngSyVsFY6F9P8AxNyuyHNcWrmz51ySxmserpTFBjjA1VrWwFuu85RB4KpnNIG
	EC+AHwnSdBMz4e1TSD/OLeUAuXVx69O+jzVAimVJrkdHPFtp4/Y7a42wss1C6iYMMOjx32aq7ve
	wz4iNAoaCStT3/T/1F+afIAMJK5KQjWWSGpWoWCX2wgpfq5uygpD9HK4hp3AdO20Xj+yEM=
X-Google-Smtp-Source: AGHT+IEIahAIdxXweRtn/KVasdlzqOJYFx1e5QhZ6PEatCcqDd10ca2+6lURrpEXAyef4HXhqfrY2A==
X-Received: by 2002:a5d:6c65:0:b0:386:1cf9:b993 with SMTP id ffacd0b85a97d-38a221fff31mr46175844f8f.26.1736093636843;
        Sun, 05 Jan 2025 08:13:56 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4274csm578250565e9.38.2025.01.05.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:13:56 -0800 (PST)
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
Subject: [PATCH v3 5/6] arm64: dts: exynos: exynos8895-dreamlte: enable support for microSD storage
Date: Sun,  5 Jan 2025 18:13:43 +0200
Message-ID: <20250105161344.420749-6-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable MMC for the Samsung Galaxy S8, used as external microSD card
storage. Since the main PMIC is currently not supported, assume the
required regulators are enabled by the previous bootloader.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../boot/dts/exynos/exynos8895-dreamlte.dts   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
index 3a376ab2b..6c4f8d4a9 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
@@ -16,6 +16,10 @@ / {
 	compatible = "samsung,dreamlte", "samsung,exynos8895";
 	chassis-type = "handset";
 
+	aliases {
+		mmc0 = &mmc;
+	};
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <1>;
@@ -95,6 +99,27 @@ &oscclk {
 	clock-frequency = <26000000>;
 };
 
+&mmc {
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus1 &sd2_bus4 &sd2_cd>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	card-detect-delay = <200>;
+	cd-gpios = <&gpa1 5 GPIO_ACTIVE_LOW>;
+	clock-frequency = <800000000>;
+	disable-wp;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+
+	/* TODO: Add regulators once PMIC is implemented */
+
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <0 3>;
+
+	status = "okay";
+};
+
 &pinctrl_alive {
 	key_power: key-power-pins {
 		samsung,pins = "gpa2-4";
@@ -123,4 +148,11 @@ key_wink: key-wink-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
+
+	sd2_cd: sd2-cd-pins {
+		samsung,pins = "gpa1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
+	};
 };
-- 
2.43.0


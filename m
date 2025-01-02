Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD681BD517;
	Thu,  2 Jan 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851551; cv=none; b=sxCX9iBuyBZUk+N3Qt8nCVVWc6OE7mCZW2TdifLYZzRrqYwKffntyT87St2YeuPUpqAf+4TEpoQnpHwg+9y5fN+i04xBIfqwScKK0GW9lTJcE4JnjEwe6YAZw+xYJ1tmeFOR/+ggShNsIuNbeLVDgvqMZ83iJhVi7I4YrckZTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851551; c=relaxed/simple;
	bh=El6oZPYP9raNBx64p7bNSOLOYIgZnqdc+g0mtZU9hNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5md/Re3ibBJhQRzhIVbjF5giLLc1A2uNV8wxkZNfmkexok5rXWeOdEfiMlDKDKFWt8YDGCu1bEt8WA0YGFLw3PH576Lt6/xTSjxOfqDolbhFmKu20wouhnGjjEc64DA/S3aQLAb4BjsdBMPIwDn8DgHLKNrrN2QI0npd5SW3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASl02YyT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASl02YyT"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so502507a12.3;
        Thu, 02 Jan 2025 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735851548; x=1736456348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y73nUcbBkfcVEEE7f2hhwMMuuJMYtvWJsQ+Bwiwlis=;
        b=ASl02YyTR8r7Owxw5p8Ao5Bk2jV0FOktRThMBcKBWgk/qihlKxUum8nsYsff5twPul
         eb47mEAA5lRfCVPj5QOlGkkiLx1aq84W1FUUKksqmqFM3hxIWQPZkpf49+WBNklp8Wwb
         dZOb+5nqoLV063YwxCp2dssLRaBA+Jp4lDiu7PlbcuOL5AI+N7EgN9WcrDVydm0d+BOm
         cCM9akxlW5jTg33uBKA58Dog8llTwQ/upzXw0Bfznx7N7UPt7cSA4JJ3khHO3UEeJ+0E
         7kITtt461IJsa6ope4dBN4So1QCmB4nW+NLS6uwpENnhYTohfJCtBMogiQIVYLQ7l/EQ
         H6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735851548; x=1736456348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y73nUcbBkfcVEEE7f2hhwMMuuJMYtvWJsQ+Bwiwlis=;
        b=MZ306jtyazVTdijdrJ0UrT/ZxTUKYxAkuHZPlO2AqvKCBORsEOiEEa3IyaZVno0QIb
         RqoMLhxVLW0E94oLssnZtIVVMJwcvari64EJJdixbF8tRQDt6x30eXowP4JcKkqCBbv7
         kuOcQidJ33reu12zlC0WYfan4qAXS2oDhvH2b8ipXGMIkhpCTWJu6oopaO9sVApAQo1D
         kwtQ9d5NHI5h2ZpQOv/wpVc5r7Tx0khC+a5x5vrD/xaJ/sYQr7BvZaPXDXk2r3e4eUVf
         MG7Qesyg2ZSUVWqGv5DYYaHkx5K4I/EOORAk3+MNYTeGf460qwfMCyO/slZ4XEbMS2tA
         5yAQ==
X-Forwarded-Encrypted: i=1; AJvYcCURce6Kp9ZFDiYh3IsJlo9I2nvipd+SD/Er/mH6MSJSTa6r0PiexXswrtrVbyznvoc/sk2eXvdihO9e@vger.kernel.org, AJvYcCWFfrh/JcwgeUdcGsSwCFY0pIlpVqO66AuLLxB7wTpvNptrRIyMCucP4ZrE1nyVu2dgG1EJR7p4lJKm+JxC@vger.kernel.org, AJvYcCWk2HHaFFczj1jnMrgYikfAvolINQD7eRqFWWB166ishkF7u7QhlVOQg4/nCel3Yu0js0JKjfkBInSixy6qjAXRl5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOPnQftt+cSJxG9Iuc4GC+fyAfeNTIkAL7EUgjBWk8aJdNt7h
	lYL3aNNANz2B7ydA+R8YGa2P/Kh2CEcrKTfU9dhRFyFjLv+0hmUU
X-Gm-Gg: ASbGnctlBZw3+Y+EF4Xy8wjeHlrm6Yqr+CumxyN0hQOFwlnulHrYHjmgcwpab1so6vr
	2LR7ggn9k7tHzMUBoBag06QrRs7As/EhOMTs+GqmpCiV+an6xjSC70lDnfgBcqlduILqJsHAmBT
	yeXhjClnnZcjuSvcyrzWcHYrblEMN93cEyRhAlqb8Fkb0DO2+Z59Tr/2DQ1Lp5FCVUEoAediWwK
	sSShReA2+PKOirb0puNISAcSixRgNyfgN5e1pqBrkCuKOtL+5ABXjoUWX9d4oUwe5OG5aQGs80j
	HGbFFejh7gQ=
X-Google-Smtp-Source: AGHT+IEqlGR7cLKfiAb4iCKtSruswOwU1yNrvzRiMPDUKtmOOlw4jmo4JyXYCEib8UgWqzIe5UpKDQ==
X-Received: by 2002:a05:6402:518f:b0:5d0:b51c:8478 with SMTP id 4fb4d7f45d1cf-5d81dd7f300mr40558577a12.12.1735851547982;
        Thu, 02 Jan 2025 12:59:07 -0800 (PST)
Received: from ivaylo-T580.. (85-118-76-61.mtel.net. [85.118.76.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f397sm19231026a12.22.2025.01.02.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 12:59:07 -0800 (PST)
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
Subject: [PATCH v1 5/5] arm64: dts: exynos: exynos8895-dreamlte: enable support for microSD storage
Date: Thu,  2 Jan 2025 22:58:46 +0200
Message-ID: <20250102205846.223955-6-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
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
 .../boot/dts/exynos/exynos8895-dreamlte.dts   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
index 3a376ab2b..11aed89a3 100644
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
@@ -89,12 +93,47 @@ wink-key {
 			wakeup-source;
 		};
 	};
+
+	reg_sd_vmmc: regulator-1 {
+		compatible = "regulator-fixed";
+		gpio = <&gpb1 1 GPIO_ACTIVE_HIGH>;
+		regulator-name = "sdcard-vmmc";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-boot-on;
+		enable-active-high;
+	};
 };
 
 &oscclk {
 	clock-frequency = <26000000>;
 };
 
+&mmc {
+	assigned-clocks = <&cmu_top CLK_MOUT_CMU_FSYS1_MMC_CARD>;
+	assigned-clock-parents = <&cmu_top CLK_FOUT_SHARED4_PLL>;
+
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus1 &sd2_bus4>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	card-detect-delay = <200>;
+	cd-gpios = <&gpa1 5 GPIO_ACTIVE_LOW>;
+	clock-frequency = <50000000>;
+	disable-wp;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+
+	/* TODO: Update once PMIC is implemented */
+	vmmc-supply = <&reg_sd_vmmc>;
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
-- 
2.43.0


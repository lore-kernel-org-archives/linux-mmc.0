Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EF1885A5;
	Sun,  5 Jan 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093637; cv=none; b=nFjOYEbe6UkP6ejVd6QzAFz5siyQ+f9SD+UAS3Pixd1g1QKRmx9FCRU2itHUAuqSd96yyj+e89g9PTfWHH9GHmDSc5+OMIuQLMvWp1np647EtwK72nwREJQATXi5LT6cIYXtbj3oSzH9MJD6xhMcAySW+r6/FHnB5RMQB4oXpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093637; c=relaxed/simple;
	bh=i5/KvKI2CDcQ04c2/FN8ZK6aT5dYQi8qJWFnIAhvUf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR+cXYsWMS0jHcf3KTSjyyEcLmh0WQItgVk1sYibaXq/ZNRaF3uUBtF3dNOeHRAnrLLt8KiZN4NtL4nN2VQFUaMmPOULNNp+a7jfPScGojndCyhUA5z7QD1/2rLetwFi2w6WT/qAiAs9hzz2EoBrnBudMtWyd8b8CqZ0g0C0bfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2VX54Bb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2VX54Bb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso98400915e9.2;
        Sun, 05 Jan 2025 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736093633; x=1736698433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aSfIFzwdZwRCYajc/07D+HcMX4CUsoB7oVw0dcWS5c=;
        b=K2VX54Bb0+JNxYcGxSNI0dPJqi50EFGaO2oYJ+0v1LSqh5qez3PujQLnzq0fzhms4V
         +jqmkaBbx3y4AtaFLeze4Q0JFkbpm6Ju+02euNudOdWEtsuSwma9AE59jSnU9a5mjSec
         erQR090syybodOsShFhQXAOK49lBCIOy0g/q66AnwD400XVPCRmUW14OHt5ZSav8rhub
         DMVDqBM2icMx9Ghj8TFOrGas656qsFz2Wcz4DMP2M1jFfodQKbbi2dKXMlBugxdnF7Ee
         35WFZS9BXvrrojn/OKOLPwdslpBQM/YHQXZ1fwI0d9gNX782CM8g/xGqrB7HEGboU3Es
         xN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736093633; x=1736698433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aSfIFzwdZwRCYajc/07D+HcMX4CUsoB7oVw0dcWS5c=;
        b=Cz0p93xCaEASz1qcgJvIfu029XhkhrSYH2JHa/xUoDdaoyITcqkeT5DslkJPSysHgc
         XhA3eW5r36g6NrliYOvSft2XH/VikU04YzPfiN7qd1LSztHxO5WHWrsc8V47cE+dhcmJ
         HFhM92CNZshvZRm7d1pqkBNA09SKbOZPX/XXJsicSIDAOxt3y2+h6LkLiwikx9yz5JRi
         ed2k3008SGCDQ9VKyNu4WTgyOV7LwGEthvHRm+IUiiQM4yptkphhsd/rya6uibzBwAJB
         78RJ/5Tqsn/wN0YW5QtG9P27/rBsORUAk0eaL7/v87WpvvXuyF3nsyYn71IaI6xKXGYu
         QOLA==
X-Forwarded-Encrypted: i=1; AJvYcCViH88WNim4xNOYK+eCW0Ool0g3gPGyAUCZ5M4YLuTENm4SMM99sVZd8gMmIDSFAwhCw3yYi/Xeoe4rlMgzKRccZHY=@vger.kernel.org, AJvYcCW4CNUCioh6EFBhdi5/qI7b7n6uM6vqioUa7Ge2skii/S9t7kyyxAw2HFXWNA8MU/VWT3hnwyj8Zp8+xSbU@vger.kernel.org, AJvYcCWW9EIBGiCVTHu2p+yZiEmfqONa3EaAGU9SFJVc3eGMwaXsKkXaBLtmK+Yy0EUE+bjUk6H+1LSsdz9a@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvlt5o0GaOmLIAdgkw7SzDqD3OCkWjCE5kOLbva7CrYdWVlDg5
	8wQzfgVU6wpHldOkWoEQjWvr5LmBQIf0Jz/1OFuRy4KsWaFXi19u
X-Gm-Gg: ASbGncvyfFKkuDHTKYlqbPFn4uOD2E9JUdyU1y0rgrQ3E0xSN8c+3oaL9rpYJt/Umn/
	nqsxdLT4HIhxP1JV1xLPuBLgVTo1HJbTteXR7doIoy0Z0t3sHjmYsAwCPYyEZp++KSOofBC3so1
	uHzi5jL0lKIcw2+2pWAsE0qMQyD0ySDuSdxzaKVLjDnzTqfDMNqwZtNkCKH9Eo9Sm1mIwA9vY4R
	9kckOd4yUuW6CvrG81MdDbe89J+wRk5H1u5JfzfzgSc1RXD4RqAdclX+gYYzkHzU8eqtfU=
X-Google-Smtp-Source: AGHT+IH03gyrW3SRNWYEPERNRT1Eo+qFrDrc5wkazjHk4OtdUiT7hM4gFcAiXcrQjg7ITA9AzD9gsA==
X-Received: by 2002:a05:600c:3554:b0:434:9934:575 with SMTP id 5b1f17b1804b1-436686461d6mr485739985e9.16.1736093632925;
        Sun, 05 Jan 2025 08:13:52 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4274csm578250565e9.38.2025.01.05.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:13:52 -0800 (PST)
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
Subject: [PATCH v3 3/6] arm64: dts: exynos8895: define all usi nodes
Date: Sun,  5 Jan 2025 18:13:41 +0200
Message-ID: <20250105161344.420749-4-ivo.ivanov.ivanov1@gmail.com>
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

Universal Serial Interface (USI) supports three types of serial
interface such as UART, SPI and I2C. USIv1 can be configured to enable
either one or two of these protocols simultaneously in select combinations.
Define all the USI nodes from the PERIC blocks (USI0-13), in all their
possible configurations.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 868 +++++++++++++++++++++
 1 file changed, 868 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index 5302a8c1b..eedbd1728 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -247,6 +247,254 @@ serial_0: serial@10430000 {
 			status = "disabled";
 		};
 
+		usi0: usi@10440000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10440000 0x11000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI00_I_PCLK>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_USI00_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric0 0x1000>;
+			status = "disabled";
+
+			hsi2c_5: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI00_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c5_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_2: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI00_I_PCLK>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_USI00_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart2_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_2: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI00_I_PCLK>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_USI00_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi2_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_6: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI00_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c6_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi1: usi@10460000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10460000 0x11000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI01_I_PCLK>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_USI01_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric0 0x1004>;
+			status = "disabled";
+
+			hsi2c_7: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI01_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c5_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_3: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI01_I_PCLK>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_USI01_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart3_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_3: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI01_I_PCLK>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_USI01_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi3_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_8: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI01_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c8_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi2: usi@10480000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10480000 0x11000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI02_I_PCLK>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_USI02_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric0 0x1008>;
+			status = "disabled";
+
+			hsi2c_9: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI02_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c9_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_4: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI02_I_PCLK>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_USI02_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart4_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_4: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI02_I_PCLK>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_USI02_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi4_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_10: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI02_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c10_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi3: usi@104a0000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x104a0000 0x11000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI03_I_PCLK>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_USI03_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric0 0x100c>;
+			status = "disabled";
+
+			hsi2c_11: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI03_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c11_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_5: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI03_I_PCLK>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_USI03_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart5_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_5: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI03_I_PCLK>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_USI03_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi5_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_12: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_USI03_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c12_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
 		pinctrl_peric0: pinctrl@104d0000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x104d0000 0x1000>;
@@ -298,6 +546,626 @@ serial_1: serial@10830000 {
 			status = "disabled";
 		};
 
+		usi4: usi@10840000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10840000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI04_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI04_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x1008>;
+			status = "disabled";
+
+			hsi2c_13: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI04_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c13_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_6: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI04_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI04_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart6_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_6: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI04_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI04_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi6_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_14: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI04_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c14_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi5: usi@10860000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10860000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI05_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI05_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x100c>;
+			status = "disabled";
+
+			hsi2c_15: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI05_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c15_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_7: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI05_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI05_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart7_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_7: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI05_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI05_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi7_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_16: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI05_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c16_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi6: usi@10880000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10880000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI06_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI06_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x1010>;
+			status = "disabled";
+
+			hsi2c_17: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI06_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c17_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_8: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI06_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI06_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart8_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_8: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI06_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI06_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi8_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_18: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI06_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c18_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi7: usi@108a0000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x108a0000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI07_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI07_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x1014>;
+			status = "disabled";
+
+			hsi2c_19: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI07_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c19_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_9: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI07_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI07_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart9_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_9: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI07_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI07_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi9_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_20: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI07_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c20_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi8: usi@108c0000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x108c0000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI08_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI08_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x1018>;
+			status = "disabled";
+
+			hsi2c_21: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI08_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c21_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_10: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI08_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI08_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart10_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_10: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0x0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI08_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI08_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi10_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_22: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI08_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c22_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi9: usi@108e0000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x108e0000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI09_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI09_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x101c>;
+			status = "disabled";
+
+			hsi2c_23: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI09_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c23_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_11: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI09_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI09_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart11_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_11: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI09_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI09_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi11_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_24: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI09_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c24_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi10: usi@10900000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10900000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI10_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI10_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x1020>;
+			status = "disabled";
+
+			hsi2c_25: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI10_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c25_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_12: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI10_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI10_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart12_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_12: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI10_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI10_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi12_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_26: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI10_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c26_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi11: usi@10920000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10920000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI11_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI11_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x1024>;
+			status = "disabled";
+
+			hsi2c_27: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI11_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c27_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_13: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI11_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI11_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart13_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_13: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI11_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI11_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi13_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_28: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI11_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c28_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi12: usi@10940000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10940000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI12_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI12_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x1028>;
+			status = "disabled";
+
+			hsi2c_29: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI12_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c29_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_14: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI12_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI12_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart14_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_14: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI12_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI12_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi14_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_30: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI12_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c30_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usi13: usi@10960000 {
+			compatible = "samsung,exynos8895-usi";
+			ranges = <0x0 0x10960000 0x11000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI13_I_PCLK>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_USI13_I_SCLK_USI>;
+			clock-names = "pclk", "ipclk";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			samsung,sysreg = <&syscon_peric1 0x102c>;
+			status = "disabled";
+
+			hsi2c_31: i2c@0 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x0 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI13_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c31_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+
+			serial_15: serial@0 {
+				compatible = "samsung,exynos8895-uart";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI13_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI13_I_SCLK_USI>;
+				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&uart15_bus>;
+				pinctrl-names = "default";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_15: spi@0 {
+				compatible = "samsung,exynos8895-spi",
+					     "samsung,exynos850-spi";
+				reg = <0 0x100>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI13_I_PCLK>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_USI13_I_SCLK_USI>;
+				clock-names = "spi", "spi_busclk0";
+				interrupts = <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi15_bus>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			hsi2c_32: i2c@10000 {
+				compatible = "samsung,exynos8895-hsi2c";
+				reg = <0x10000 0x1000>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_USI13_I_PCLK>;
+				clock-names = "hsi2c";
+				interrupts = <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&hsi2c32_bus>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
 		pinctrl_peric1: pinctrl@10980000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x10980000 0x1000>;
-- 
2.43.0


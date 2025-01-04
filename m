Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674D51CF5CE;
	Sat,  4 Jan 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009014; cv=none; b=ppQFvFy78QGlZVgwHGrNLx9V9MFemmUNqo0U9fkk28aq/YzBHA65PiuU2YA+k2hcpfXgzoqKXMjGd0AlQh370zOTm6wJlAVr8A5NkMDIUwnEu+gQfFDR4TiqWUPeAt2Xo+z/VQBiDFX4kblW6WBe0sqkaxpjbSsCsu/qalKlbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009014; c=relaxed/simple;
	bh=i5/KvKI2CDcQ04c2/FN8ZK6aT5dYQi8qJWFnIAhvUf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCAXi247q1ZAwFOu8AKrCtz1CGdVEw7vdouyEi35J7/2aDnYAF3R8wmyKpZmRSlCEqdL5uvf3FctHXzL8T8ZGhkx+DxR/TQInrH3orN3ZkCqeCdcYe7FOrOH4p5BIYHT0LRUAAr9f1OwFVO7JY1gla2zrdfLSnRVD6zxFHMeylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK4bcqrx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK4bcqrx"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862f32a33eso5985527f8f.3;
        Sat, 04 Jan 2025 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736009010; x=1736613810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aSfIFzwdZwRCYajc/07D+HcMX4CUsoB7oVw0dcWS5c=;
        b=WK4bcqrxfQtnkeuIG56eR+Wz08DoEiNsz6jNd6jfFJKZxSuSNUrCblbVY36w9hGaqh
         fH6La53qyKDuoYzfuI0YzQzoB/nP173umDXLBd3979CKh3Sz/bAv9k/rV1BJ57y1Dx6/
         s2bgAAhf/gpswy+xfjJiMMmbdWlzPwvnU6FcI6NGaBNVsJpgTuEfRuOT2HWEw/YSYkvg
         OfvTIhauW8yOyZ/4dC3nMn02Zb8Z7ZnTeGV7tJzFsT7+voJqm/7AM+hfKw0DgYBrcelc
         x7IIe3Ryok4Gy5J6jVu+zuwKJon3pl3ZKC/jWAsXmk7HtJ9R0/ptebxq7mmdDnnJ6tIw
         16GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736009010; x=1736613810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aSfIFzwdZwRCYajc/07D+HcMX4CUsoB7oVw0dcWS5c=;
        b=agNErSw3fVD6z3BglIkVB3+/6ZxqNk84IWeUQe9rD1s82ntLmNjChHapZfZlZE9DZw
         EVly5tlqJ8syo377aYfluLRQ8N2+FaBInVhN7oURz7dQyV6bDTGkPHQkrvUpgVQq/tgw
         aAH4xOrnzHdWSZOa3iqmVWWmFR1iILkUeNRXsNfnz4vDDLEW2WKrO3l24kMTTVFpRKsF
         3mbcLR8WJ2w8iASx4+TovHLR7U94OytXsIMXhrZTABlgW65YMKAF7sAcyxCzleT5wcUg
         tvw8+SX7mrQIZ8d2xAwGb17tj/5SaMDjolHkhk565KmavfueMuFqHILdMLpvaoHeWoJS
         ThuA==
X-Forwarded-Encrypted: i=1; AJvYcCV+g3gUzj3duYfsFZ7EG5HhIiQVxOuMKf0wFEKOs/JzufoiiCOJUXZ2eC3yNCdKLQLA1lQ3KKgByktTm1UIu/wAC54=@vger.kernel.org, AJvYcCVz/wvm9ezW0E2VkOPa2eLSnVSC8/uVEMYzm1pGi7kh8sZ0mMoephmA9goAcPlAmagWPZKB7oTsXL0N@vger.kernel.org, AJvYcCXRKE2/aJX6+51aoXOW41CR4n2KWEeiXBzVdL58meR8T9LtixTBf3RrE7sopVOhTs2Ry7xKHsU/ioaa48bF@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOZFWg4H0eBDsW1KClrCEc3gukom0VJzVDgnGpwRyGKpwklOE
	U2Y5glkaUHJ1qrA3gyVFXSKrAKk4PP36OuDJJOKp7PA/L0fKP7GH
X-Gm-Gg: ASbGncsFcE5FhTIK2oms8C7NpS8MFsKfPgjvT2/5iRWQ4d4kCHoP/CfIhw9YSp8eBTo
	xM6lILJ8p7JYajbWp0Z1sxylkM9sFyOOdeTcOGQNu+ulpQHL6meAPMA0cVXHXFZq0m0DpWhK8ky
	eYPn91Mt0JTiU1cSGk378Ow0onlwDwpZaEBJtYU5yE4EVRH+8/k+rJgKqG3KrsZridrqKDyAxkQ
	0UqDvj4pQpHBzYDU5MBnUKCR4cMlti+tiD1tq5ZiaIS7EMrh8ioA1fnePvj3lcsmmKuzxI=
X-Google-Smtp-Source: AGHT+IGOjXldB97Kk59ZJu4Xu80VTqwMrTVFEvRQDdUho3sAqD3ti1l30eww3h15SuArqO9932ZZyQ==
X-Received: by 2002:a05:6000:1f8d:b0:38a:5a37:4a46 with SMTP id ffacd0b85a97d-38a5a374a51mr15730970f8f.17.1736009009595;
        Sat, 04 Jan 2025 08:43:29 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm513321455e9.24.2025.01.04.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:43:28 -0800 (PST)
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
Subject: [PATCH v2 3/6] arm64: dts: exynos8895: define all usi nodes
Date: Sat,  4 Jan 2025 18:43:18 +0200
Message-ID: <20250104164321.333669-4-ivo.ivanov.ivanov1@gmail.com>
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


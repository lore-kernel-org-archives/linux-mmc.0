Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2515165F13;
	Sun,  5 Jan 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093655; cv=none; b=pJS2KMZvbuf6L3/P7ssIpVnnJk7Dctp7Etr6izZ4nMPNLNmXpZxMplpKGigG1fFT9sHPCAq9F4Wlgsq8rBg+0OtovqFtYCu6ZX38emPlj2Al46FfNzJuSLNEgl8ApFbwa1MlzcHemqqdNmwDZzBmwFbq2rq45mymu049D/FR55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093655; c=relaxed/simple;
	bh=Fy1C5rmX7BtaHWAWlfbpoCLIKCiNrHUVoyd8rzcg+/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJQ8bG/KMuCTZ/1AHjYQjA4MX3oh00Pr2dEyqJsAIzvYooiEG9gB6BNXab1uGHl8csq0AsdL5Hfx8fhGNn12KZyLpAmS7bCHJcpVodTB6+cT1sYKGTn1MmRjaCFJr4u4P2lYb/PUtc7KQmAwamk+CNCtRRXe/yY5kXG5wCa4sjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azHeSu9Q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azHeSu9Q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so11852685e9.1;
        Sun, 05 Jan 2025 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736093652; x=1736698452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOSez2kZNKPIr6/43vKUa8IfzgzZcFJWYi+Gr+NykBo=;
        b=azHeSu9QUv0JGPbWUK5ypGQZMWSBqetdtoFemz56M79mF1EaNeaEbwaCOwcQ2a6yuW
         SvP5HxLBnaj9ARjDlbobCWYU0rOcF/EIQo2xspCtH9UOUv6Jaf4GwcNs0KyMG7e0w7vY
         bXYgwhWVBhHaxxnE+5AQWVJGvnj48mmPDNFxwt8aH+gKsQRQXAIDo/fsLgVmdu3ZNzVo
         xYey2tEWBrTaSb92uVahFqmImq3eMGuJxyNQgHsAzs42KuMZl/wuvamGmmdofo4GdlUe
         d2cLkjiobQqPHB6G3HnOFHWNGjDLk5kc6yee5KR43BZ+8/cPcu10SQpxtoRrvSpvh98Z
         VMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736093652; x=1736698452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOSez2kZNKPIr6/43vKUa8IfzgzZcFJWYi+Gr+NykBo=;
        b=vgp3G81wdRnEn4QEr9jQg6LL0kwvw2aq5qfsLQ9fTvSya31S1md7eIrYfYEggNCSLR
         ysJqt/XEm3dlc/yaHlTNSGe3qHvfbZPETMAx/IkkwU8Jaeeo0iBOdsGmddkxcj9v2R8q
         mbNAAr8AZrNrMytGvXAc2jogM6THTTJKAbDoGm6+j7oRRHkiWyZBkUSYPizaGKecISr+
         Zi6gqj8M0+T76lvbiyTOaUND+ZHu4qgbuDAHPXBBsL0xEOqEbH7DThb/8fXl7hMeRBOx
         PV+4DYkOWfvKOAlioW3p3Rv6utO68kxSMEey2oMNgmJHqjjZr5O7mpego/affcJj6gaQ
         V+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1gsVEqefeS/5zEQcCWuPNtD3dlOcUhxBlDZ+XSyy5fEY9+USiA2EI4EbQz0W/8jhryDXLXExN+lNTAHC2@vger.kernel.org, AJvYcCU9T76eVjQ2bP2dcHMAxWVr16Wf5SysLY3LQ4E/ZIha59VlTZ069WDQJ04CjiaZTkbK4gwtyPZXp0ZZ85G8rXjBvAA=@vger.kernel.org, AJvYcCW7GIEQ8nx6m6JXUJyM7BdpH45a0oXnFRHKPLO/8nHr3ApcpHZ0Y+2L6FU9T8aDSGOKjWG3nXrIg1EI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy31ghSICCaDxEOX5iM4b0oW0K1BIuSBOO/hvmWqc/ltzMGVCy
	9WpXnNoG71jtX47hIFiasxZ8fjG+jU1dwIo6pMnmMpo2AsO+jX0WuvSLgA==
X-Gm-Gg: ASbGncvfSPrqcPzihI067FR+HMewB+Wu4WrTlqbj2l7I5Yoo3o7DqBFhS5eeNh1iKgx
	+ewI3SgLRslE5XzSLqNFVeOl35KhJAYOSo8jm2dzCtrzIOLlNaXRoQ/Cy6RsBJsNZeuDtZJAtnE
	4xmv8Q8bn4pRPDOnFsABuVEREvqXeXCjmtXte0NCOc45w77y/FTuKuDo3KQB3P79gyy7l217zEt
	2qImmDFaEstLTGWMLD/bP7B7v5V9mz2RB4Cd4HmmbK4hqEa6rkXnOL6y4zrWpuWWu8Jx2M=
X-Google-Smtp-Source: AGHT+IGGn0UJF9DyGx4oUCveH4zyPEgOigjYmBULy/W6t7z/jQh21cbV2kifxL+XEIbanKLa1PZEkw==
X-Received: by 2002:a05:600c:3b23:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-43668b49950mr412180845e9.25.1736093652049;
        Sun, 05 Jan 2025 08:14:12 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4274csm578250565e9.38.2025.01.05.08.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:14:11 -0800 (PST)
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
Subject: [PATCH v3 6/6] arm64: dts: exynos: exynos8895-dreamlte: enable support for the touchscreen
Date: Sun,  5 Jan 2025 18:13:44 +0200
Message-ID: <20250105161344.420749-7-ivo.ivanov.ivanov1@gmail.com>
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

The Samsung Galaxy S8 uses a Samsung s6sy761 touchscreen over hsi2c23.
Add a node for it in order to allow using the touchscreen as long as
the previous bootloader has enabled the required regulators because
there's no support for PMIC yet.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../boot/dts/exynos/exynos8895-dreamlte.dts   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
index 6c4f8d4a9..61e064af3 100644
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
+	samsung,mode = <USI_MODE_I2C0_1>;
+	status = "okay";
 };
-- 
2.43.0


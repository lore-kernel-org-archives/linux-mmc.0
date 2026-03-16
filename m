Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AD39C64D
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669884; cv=none; b=E7GIL4wy5r/IpeLLdB81p1Y+d8Hq9gW+vZ5c6VyOX9bqdL6Q+Ky4o7wS1XwKdsPm0uIvuZMgMLbrB3ra21Tk+0i6iyn6SKX6VQN7xSMTKQJ209q/k3FTAkFIJa4oeiBj+a/8hLjT44EX72w82IQHu7cvc1l+uQo/B5BRZ+u4WwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669884; c=relaxed/simple;
	bh=fx2qLZcY5f16CxHdcoO1htYJobmi8onTWzwMAk9DhnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkgFt3wwcCN/OyUF3C6jk3rrH+xd85NLLxNAa5L8rUc6hs3ljaWD+V2AKZdOaXULpsyvuNXvokpePfvdr7nuNo1HCsTfeF6gBDYBncca4gvzE1d4e5COrUeRQotFTFOGNq2qtXCF7CSeeCczXj6Q1ribnjrhm6CK6iQX2SLAPBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2+5KxeT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2+5KxeT"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439bcec8613so3505791f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669881; x=1774274681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGku/l9FNPrwiqABN5hj0gv51qaKMC4DWzEN52XfCG0=;
        b=k2+5KxeT5DmooyN4GmYiPjtdRtxC5ZfRHpJIdl/sAo9ksryCsDTVEyaZttF53OgOCX
         jDNWjQVf4jAYzC2iEZABAvxo4PrkgLwvc0q/SBeX5mZ6VxJj2WpccgRtooc7W8jqQO14
         AWT5Zy1CJgvJAornghvIxwkhUOeSQZY+AoJH2ueQuiT7mJtJHoUdhQvk2Ktp/h1IdfVv
         ovFPV1OdTafe/qYpBJ1gwKKXVwIBtO2OolBZcjJn9IIIdZjWuFwnDCwAP/QzkzCwr/iH
         8wuFv1esBkAGafkspkqvpj+bk1Tl2pYcSEL7y/+dF96wMMNHLbQPliqSzU+3UkdEIZ4U
         x9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669881; x=1774274681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TGku/l9FNPrwiqABN5hj0gv51qaKMC4DWzEN52XfCG0=;
        b=Thwi6TVnOZKYMj+iQavmFrVC4E4CQK4b2s2wWbywEaxIv9z7KT0w2g8Fn8o9XlgMAc
         eT+4T4fdTwk/23/EU/z1qfnM+r2vkagdHo0oCjlinUD38gPXz6OIVeypsiMCDXu0XIM8
         2TlQ2uf7pUYHPHtW806Y2fERtW/R13ELfgjY5+AnnINZqJwWFvbuFZr4vRYHISNfKnd0
         +YwVOsIrQkXBK5DJR2Gu3WM0QWkEno2lwstmFT5EAOny4BuA01dqa5GkSyj8GakPINAY
         Rdfp4w1fYDyACPZI3tqAVQDV4J/k/tYlefcIUeY260rb5riGc59eLemwK/KwhTmx0CBH
         9TSg==
X-Forwarded-Encrypted: i=1; AJvYcCUwJ5BHVrC+jQm/WN3mIhd10nDh0XF4pS7hg7ztTYw/TuZ2ZJPFxexh635FlCvCXAm/5sTpv1QRq4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBWtglucyAZzQSIfBtA/pPRNEzKUeMLEYsdGVyoHtke1lOGCd
	DcXanuXpRTBYBl2E9F+KZ9WmsreEoLjN9Cbn/IhLUd8ELQcB6Um3uRyx
X-Gm-Gg: ATEYQzzEpOHC09mb2/FbiqZYTMUbuiA2JCV/6inc6YGWtO5l8H9hsuMheHgzcG/PLps
	LuyYUl4PmX4/IMRoH5V6qbi/JIzxnaqOKNIDFEFTGC9SIwyVVfCUsm55+bOXG5BQdwYMrR1Owvt
	RV2MhfTI+oIkJHvGWANVr0IExWog/v8Lyhjp2JOYJBEDFtuVQa9PfaAcQ34JyRIiCU5UxF9MJDi
	8SlP8TpPpOaj8+VwZo5uirN8uJVNl3xDmxfVU7EM0//F1Le6LPzZIj8ZxhsxL0sBqYI2wNAbK6Y
	+/yyYIjfPgzKfdkgzQ9p+GUXpyVBYNcl7KwOVnbEOC562udqMVXDJB8Nk8rVheHntnMn5EehFrY
	WdAl88BsiLsO+OfX838ET5ntYjPl5MigPthLI8qzI3UuqRqdYKABYl7Io5/Tuc+K3+XJsMB3i5L
	Nx6aoiLja5niDpA08GJdIRD0R4FgU1ISLJGIndQPPR3qeK+LhFJALYmDG7WeThvbi6
X-Received: by 2002:a05:6000:2889:b0:43b:4153:c2a6 with SMTP id ffacd0b85a97d-43b4153c45fmr7601207f8f.36.1773669880512;
        Mon, 16 Mar 2026 07:04:40 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm20698725f8f.0.2026.03.16.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:04:39 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 16 Mar 2026 15:03:35 +0100
Subject: [PATCH v3 7/7] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-orangepi-sd-card-uhs-v3-7-aefd3b7832df@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>
X-Mailer: b4 0.14.2

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with inversion
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 404b69c47b91f8c37d74a3031dbad0d94a28d1b4..a7d480d01ccc0439dbf456ed5a81f467af68056a 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -222,7 +222,7 @@ buck3_1v8: buck3 {
 				regulator-always-on;
 			};
 
-			buck4 {
+			buck4: buck4 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <5000>;
@@ -243,7 +243,7 @@ buck6 {
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -369,3 +369,22 @@ hub_3_0: hub@2 {
 		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
 	};
 };
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


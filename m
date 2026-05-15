Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B5477E53
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842163; cv=none; b=GylDyQD5ubV7veZ4dsC7o91GNOorCP1CiD+RINRbbpXDlmzH6rOhz59WvfKky+P/+0WWRfyssiKouHVdk4UfjOxJ8g1bmZq+aZyJV2D3rVkoiaxY5fLy3hvf/gkJBYePZrDPQdzQrgf4HYSMGm2mNfp5Dq5rgapqJeEUt6RLbaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842163; c=relaxed/simple;
	bh=ljxUsigqx79h/ONm6GNMgplDs+bMqcAhgwy6ceKWN2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBlJBu7yn3+ICzh4rr2RNvhWgalyn9Tex8HlITiDlrankoHSXqjzWSmZFtYnXcZTCuUtnLWFfkWLj45dMDQkhMbxstBeo/uYbo5WhhYMZHrO1C0K+vrjocSb2IYLhivBW1LLdejymEensjj2AaBLr7sWNMVLyX9DWW5R6yp8kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjmmgUI5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjmmgUI5"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so8351489f8f.2
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778842160; x=1779446960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdO1zzlLKkykrIptdTOfySnlGfDlrWt09hUBxB4Iamw=;
        b=ZjmmgUI5aDUQEHHMnHbQ9Iqq3qrh/pd4hJW/Q1Zg1TlFQ/zyaSi+FbuQhsNpkQtPQW
         LmtXRFh3g7jlJbqINz1kmOM538lv3+Xo3pVkZvAXRn9eVTcukTwgso1a8LYRLczvAVWB
         UTwCgL4ILlAa6zHC3We6/pglOnVnL3dwFmSqwgPtaIe54Lf+VPjSHCwzXpLOSo66vtoG
         HpoOElViq3WIbGxO7UAvhRq9KGeHQdXrmBaFbHT0rObyVffjfYf0N5oPNbXSUyF4Xxba
         FiSergq2oxQabWLisjlL10LYMrSB6Xzyq+Lu6xAtnJjQuUspAXJ61gQXrZn4RIVkktsk
         3Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842160; x=1779446960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cdO1zzlLKkykrIptdTOfySnlGfDlrWt09hUBxB4Iamw=;
        b=iN7RZr123x2jh6U8ddaQeHDVJ87vL2IoMMBWLSINAE/0a17WRKDiOeZMFUz1zEs0ZN
         9ram+OSlAydp13/ODeKCqJv46AMPrqqXcUKz+WFDj1kPvqGU9Bm8nBKPp6PSInU/vT5G
         +QRlfLr2hp2wOJh9Cs2yVrojOrTSU6yeb9jn6Wtsf/55cYYztQwa9rxNLcVFPuiUTeHD
         CzQkG3yUQteJIUmEbMqrKg4hmi53xN7ljSP1pMXN5420HgL5Y4h86r54FdV3I+ZEd/Pr
         21flVF76ReX2fFaR7pHEW8c601ZlpFuHaoe2eZ6uWBR4AzbVljZLV0oM/WE4PRoMy8Zm
         VnRg==
X-Forwarded-Encrypted: i=1; AFNElJ+ubS6b4RQeeUxGFNIPDKbuxU9fC0lPqoBgar3eg8UDmQw8hAZVtADtmnQNdom1JZeHoLR/QlkUFLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ELIdskcvLjkD1P5Tv+R0Gtuy/UhsvX/J5Ny0qaRYZ9OHthhl
	bmwbO5R1Z9k5zbBA/zpJWvnsErwQTF8PeNuCUZ+Tdzy73gJrCO2S539ZXVMxmA==
X-Gm-Gg: Acq92OGS3b9IIIVrnSVycn/x1x6ZZob4s2ed5wvnMj9dlwFhGTaaVjMPnMsLmFYtN8/
	qRhUvPx1BUIIvYYxFZkv1knsthk/qlm/hv0Ody9YO37RZjidae1HvRFSJrUYCriLU7cK9aRN8tZ
	zlVMQzng7MlQLNqHl/2S1lG9bMQd6qXrWfm4Q9vfUDGIo3T0RUJly2zUdM+HOYJTAvrNVN8Bf+0
	cPbLG5ntlR2gwNQJYf8TLArlcK5GedJsojYv1ss4/FlblXpLnlJiOiv7bEFtinpm0Nle3v/wdJP
	5saz/EOjsRbvzCRZdcJ3p/9EXsqX2IVqcaZJo5RNOvLJGTpaaNuzVr6wTBCCBx8eW8XHYm+J8D1
	pN5farXomQTwsFwyNjknrQRsw73zmker9RVmWqAidmQlqsXnzkI+7suJB97wj+Xhk+6Z5cQBmqd
	ZxFVivlP8ZfJTYFfVfzU1EYcZuZVr61s+uj78UdGTIOXrcPdAobCjAlYrQK0qhB2mFtg==
X-Received: by 2002:a5d:5d10:0:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-45e5c5951f9mr4409926f8f.31.1778842159282;
        Fri, 15 May 2026 03:49:19 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm13975602f8f.14.2026.05.15.03.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:49:18 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 15 May 2026 12:49:01 +0200
Subject: [PATCH v10 3/4] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-orangepi-sd-card-uhs-v10-3-094af27e310d@gmail.com>
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
In-Reply-To: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>
X-Mailer: b4 0.14.3

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with GPIO_ACTIVE_LOW and internal pull-up
  support
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index e20daa50a152..72f77e9edd63 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -17,6 +17,8 @@ aliases {
 		spi3 = &spi3;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -221,7 +223,7 @@ buck3_1v8: buck3 {
 				regulator-always-on;
 			};
 
-			buck4 {
+			buck4: buck4 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <5000>;
@@ -242,7 +244,7 @@ buck6 {
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -374,3 +376,21 @@ hub_3_0: hub@2 {
 		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
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
2.54.0


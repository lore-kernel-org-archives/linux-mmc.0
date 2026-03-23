Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79F38CFF1
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261182; cv=none; b=Q1qtWppW8E5j4xWxvX32d6AVJlEhLSa5IB5tZYFw+qJAOk6SEmQ3Yf2+A3a7WRzRD0Ch16hBAKqT3M8DLxO68ru7Df/pW82tyN62M2TIt08pLK+XsVGP5Apy6/74jRFrrTjRMYYhH2WcDB2ZY/GnTdsT8DeDK6/I7afZjasKrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261182; c=relaxed/simple;
	bh=0EFZ53q2XAEQCbsr9UzobauZinI9NCe/+PQ0fxu05PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0syEO2c6dcoPNsRolyOnpwLc/g+AfZqlN4sn3jz8WjOIxRFWwoBOSfD87vyjxXPnr5WlcXq11N3meEtViZ8T2vBlubv/jQqVZZklWBzcDD4O5A89MMzp+6RsjRhxEmI3kq3pN3QYIBKhKm7i2USiv2vY+eMUoyRBK0FLwjDBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwu0s2ZY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwu0s2ZY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4870206f73bso14550145e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261179; x=1774865979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LbwR62Ox4pP35TzcC1/kMlb8rYdhZytDukagY2Rkq4=;
        b=Nwu0s2ZY/knPKoV2DbY2Ix0Z2HfVDabyX1TIpnJM9RHD1pztUSRKMtgHj2GMO/yqQy
         OrKzUbvxfk8RuFv91Loth6yTguuPNpADyxzOtocdIkOgU3WFKRHlfbm483GBJyY7Zvg8
         mUOaALGPj+4aeFyBSyD0A3c76+UDEGQFe4dIMfN4CM7JxKDvXS1bZVsvbRbWkdxVma2h
         8rvd2zGuylzT2OHBQ/GxBVacr++346pUCFTrusbxPDXIuvGPR9dOddY0Ik2GNqtHzYiB
         XqOZlZmoPdBuTzfemz7EbBnakbLIUXQwcRYxgRGw1lYBuMBIOhS3oHlDzLZ6wle9NGM6
         ieJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261179; x=1774865979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1LbwR62Ox4pP35TzcC1/kMlb8rYdhZytDukagY2Rkq4=;
        b=AU2vRFkYeaDa9+mN+aFx9Y1nNCSZI3eR9zqMu+Lk2BN2nYo1VdzIRXCtsMiYwgLKRD
         sYcHUWnxdqtxhYBiG00mOX8CRtjzu2VEnPXd7dv37nHaujpQOV2zpMwLblz66NL6tWZX
         ac0nZPtXhoQpFEy7p09CxduIkJMC1diFoiXTgzFSnCyJNbtWLIl7VU7OUAcZW8QzZV6s
         2wydG3yNZeNIbd/cR+4B3NgyDIza3LJ6s1SZu//f41nATnIh8AJUDf+LMFWfMblDtiRZ
         gesbSJzIbL3bRjtV3Eij01IrIEPMK7Tru6/68Hna36hjyY6lfTC+V3uJWWRBe6yJWWGz
         22Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUDBXQJyQwpqZQZWj4T+AMa+Qf6HAUVl56W0/sfPgX0RDe1XlNFnb7mMe9shRJqGdPGAWTViZVd2Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4YKV7ZneCkvysoBNtc9pPhDi9Y5Cbpdokl+s+JiJ0kcxsgz0
	OY6UaE/rJRap82E0OI79LIZlLgJkMQwabSYtccUZREusLDVB1N/pzbns
X-Gm-Gg: ATEYQzxJEzmWtuSuX3iUtFCS4Po9i5gdOF1/KmHgR+ONN0llw/4h0jPuHfdfN2Lem7S
	aUto+tALTt2hRak1UFWV/HeMtAx/rECwF2vmpQi6JMJa9ozEq+mGsU8+eCOAswLcDQO9SKj4Zp9
	0R2aWOC0QwICXMQiHOCWuCBoelzUBD+OlGIXoXUGiqtuG3OyMHrLmX/31NRJXiYkl7dvQTXSSBb
	wXXHuT5JGCKUmCiZAhFv+op6MZm0ZmlOCWNqt28IFM3kLcGMs5E5y8pgCQpvmPHwjOxynf+viNq
	Lp8I6TDZyjKt4lbtDsane3Kef1c53NOVdvwZAr62cFFZ5GtHlvU1+R9S43p6XlAsM2mkDUFeLH0
	Ka0iAKWbHf6FaxslqLPtTeRoTqBtkviv3h7oZ5POF+NQsN3VddCDNW9FxhZgijBSLlXceu28UWl
	586afj4HAi1Zl8B1o45cVN4/IJAKx1nj+W5P8bDWB46BiG97ahTS4wqKHVPxrXeFT+zrfjSN2Ch
	EE=
X-Received: by 2002:a05:600c:3b07:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-486febb59acmr153371395e9.5.1774261179356;
        Mon, 23 Mar 2026 03:19:39 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe86acb0sm78755445e9.6.2026.03.23.03.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:19:39 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 23 Mar 2026 11:19:09 +0100
Subject: [PATCH v4 6/8] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-orangepi-sd-card-uhs-v4-6-567c9775fd0e@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
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

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 9c417a483f6bad6e60617cf8d5400ca079588726..5f823611c969eb0e15546862228ae4f65375675a 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -140,3 +140,22 @@ aldo1: aldo1 {
 		};
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


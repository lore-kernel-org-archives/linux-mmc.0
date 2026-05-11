Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1773D1704
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489682; cv=none; b=J0iSWk6fwGPlBcftuwTAy5f2T7dKGU4AfSrn9L0i7tbfI2FOELvmbyeZmIvTWXW74e2wRGmFzU+XBfmpguAPQ0nPeKOxhu3cOP87XXovOwcRcYn0fbl1HXWTjc/UuRj9dUw+XXHy7VLZ9oxlD2zWUALLVmp83v+GibjxHweM0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489682; c=relaxed/simple;
	bh=MIH0ATHC+38xHlXDPli/E7afDZIgbzPqgBozK7mYzwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naS5s+1kSR9QRRyY+wX+RCaHNvycgoD5GrZwDUJHCrHUdAyodqBSROtLA5NizKi8KRE+xA3BhMQZcCWZSch9XPB2kQKmhpHPb4Mjk2pxtib9Q7NwCgOQBDNzlDxN1xDZRExQsJdy2ZES1Wg8fGm+l5w4g5aIgWOYwin3JAZXfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBO9Rexq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBO9Rexq"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe608cb92so2476399f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489678; x=1779094478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxFL8JcBleXAhQJnczy/XDAFmLI/O3K8Gh9JfAxOPq4=;
        b=gBO9RexqhK3OdEDLTgPD03SPCo5K8HalLCyscvbTNbWLEqxJlIZJBquAgC5UTKjSXv
         A2TmzfzWV4vAdLTeQUCD84D9TUyOzA9bbGf9eGo7a2vpe2poOuBxOc66GC/kHFV7UhPR
         1575UjevTPnhxI/756xRgmARA9z3fkiDftRPHgxAz70fIwd1LxhN3pamE+ZPvQVO6Gub
         33H2WNtxzjOp7OwthCIFxWkaWcU4t/+pOl27BTZqChonEfYKLm/0WCS7enOyJ3WydJjI
         gB0ABd5Jqk/fYYugMBQvypkg5UuuOfX8xn8FUHz4dWEq8SbfzDB8v29tD1ID3Ajbmp8N
         88+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489678; x=1779094478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TxFL8JcBleXAhQJnczy/XDAFmLI/O3K8Gh9JfAxOPq4=;
        b=tOsSQNn4xyiIy5Ie+i848godP38x0PBIr/aRBDpNteBlbFJCjyUADf6GTdh/EYO6TV
         /BDq5dEMM8Xw45F9GL1cuedU8WPsjh+i+DBKWhAWcd+FtekbXxwT17UwRLpJ7RKdLchU
         EvolBhGWnIGb1eayADWnSjTXydDrk79MjMCgE+cRxfr1xjmH8zdEOK3JDYIh9c+ZrOni
         5ZDvbhqOZYbsGVqdVM942Pa0xxc3h4NBChkQdSUNoFDeU6BaIaV9xzug/ToYLdQw5uXG
         pm12l++bFN9uy6jELwrL6afyDEwdXO65bUT7M7HVbZOtSpFCoZS3qMPHpsTCfdIUQrbE
         S8Cw==
X-Forwarded-Encrypted: i=1; AFNElJ883Yr2P+1CQf7iJbOSdkM+OP0N8PufIEINAiAsfYKIH0l2S3GtK6Y6W1vNxvkJczW/iYeaQaNhbCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9UEjhBrjZq9NBjRLhCHUOi4Qt6PigAVd4QZZcy30kmwX3x17L
	3JRZa/SOK/5pNEKMIQGgaAMJn69p8R2n3ao+oXKyS0jlX/7AxPwOIVBgFbPcKg==
X-Gm-Gg: Acq92OFiUr7bOu4CKQlcWQX2C9F0AlpKyVvMk5GJk5Jy9jqNFAzPQoEe0PAGqaU6Hqb
	rWeoRXQH19LNb5DBdMNNTfuLCwqtf5pbuO5IKjNA8cOm36Cbfav+EbEzmFt8bsVI7EwOL7zt7RQ
	RX6zY44m/q9mlVub8Fj9c3/u0HCNfmu1T5cwz6oOFuXI038QhI9ZScxD0iPQenT7Ir2dOa1AYjg
	4B7gyEQebBJNpVqoDLSuN4KstWpunh0UprAF3S1nn1hzv5y4Qpe1z+nZlb9vw5PCAPwuFkuc63W
	k+L/9pG8PAI29EK6MMl3VgZZK7ZNUKMS/hxzkGfa+ICCxR0KeC03KPqvFJmjZUt+8fJibrbwR/4
	mAHbEKKuRr7PeGZs3ETNGcAR8UHKCiHNdUWmGssAnBs7yTGNHwERwG32blgjIkPY/NHF3NmH1sG
	qk/idGKQlwiRrwOordVd+BZ4TVEjyFIxNPL4pb7dvnuHUfXigPIrgOrbcWiay0WrfGzQ==
X-Received: by 2002:a05:6000:178d:b0:44a:b3c4:a04c with SMTP id ffacd0b85a97d-4546310a50dmr19851770f8f.30.1778489677417;
        Mon, 11 May 2026 01:54:37 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.237.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm24944189f8f.30.2026.05.11.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:37 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 11 May 2026 10:54:01 +0200
Subject: [PATCH v9 6/8] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-orangepi-sd-card-uhs-v9-6-ae48c0b2b2cf@gmail.com>
References: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
In-Reply-To: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
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
 Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
X-Mailer: b4 0.14.3

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
Tested-by: Vincent Legoll <legoll@online.fr>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index c95ca38e3d4a..1ed76e0ff806 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -202,7 +202,7 @@ buck6 {
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -319,3 +319,22 @@ hub_3_0: hub@2 {
 		vdd-supply = <&vcc_5v0>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4_3v3>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.54.0


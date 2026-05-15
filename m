Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC7478E45
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842164; cv=none; b=O6f9jF+wdV0woJ4idRPglL4WW+F8Np1/9UK9eVx9mvpVtv1NhJexvdlUVIQKzErNxDPOm7dR/K6XbgNftfPYOMgsW4Y4Hz43ps42VBlkwi86YasInf0mU1VidYR/21pCIFb59JNuXIZs+9fvbH1ctVHvEjYplc2IWuDHLQKXNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842164; c=relaxed/simple;
	bh=KB3wuZH2F9JZumML32p8FdbQDAbgo6ZpTAdn08jmQIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSjL+n3R0s4BK+rMoUQOhglUmQJmQm7SNv08XQlCaIrU0/7dPlp0UZ0TuhbEqqlGVOHjjQYya7HBU3UUh2QZnuOITIlSCEeUwVd+am8UMi5fzyCHraN4oMw3Vnh33cHgCgNckCVErFQ7+rk1ven1Ho7cYjZrfKVlmXMvTt2EORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfUav5F0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfUav5F0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-459bf19e87bso3405824f8f.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778842161; x=1779446961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iB8eoQBD1gDe3NlGs/goqrqIf498nPGYBfRez10qXig=;
        b=hfUav5F0oQ/hSN3NO+WKWCGQQ/4OiJhA5kJ4lgqlsNUzfK8UKpJirfqYwnUIuIEdoD
         wHdbLReS+kS3JKufFaWL3sA3D2VbhjeIBQybijIOVY32Vxp7426yuSkaQnzCGh5y0KPZ
         u1PLVvnsx7oPSIJdJacBHPsvlxPqt8kEOpqipiXmKQCYnUok+CksxepWSoImvl2UWh6b
         ymnJeFzGyOt3INVG59NJ5pcCvPntvQWCQ7z5Yn9G4swICZ7el6BFgnmScOb9LiOlTYIf
         0mdIThyyGScHg2ieYlBGcQfEvbtnZaOyprwmVW0c0zW2WV9P+TLfHohqAaJL452VJuz+
         YR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842161; x=1779446961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iB8eoQBD1gDe3NlGs/goqrqIf498nPGYBfRez10qXig=;
        b=W/Wm84Sx54wb5c1IilhTxLwhV1Ww5ybpUE2AMmuDgRzp1A2jdIJR1MwxSi0BZWuqkK
         GjpEcsUVgYJpNgM8M3tOaatVE7eLJzEX7fAQ2tIgaVbHX2X1mWln1WDYMCnKvYI15GO4
         UqXzZ7HP+P9Vsb1NAntePqKKE0FVvUpBfg8brzJhcFJx4TzhhKS9jr+mC5ZfpN+kub+Q
         5SpV1mnU9uyXTvV1wQoqRmXaZunpIQPj00RgDPFxWXq4NwGnnBK6KGLq1rI0Y8YqeYoo
         3O3v7XMP/y4d7VegPHxqg2EoKf2CeJ8fKZvl8LjUJhd7eECJVWmbFFqO3lF93SDbhodp
         MulA==
X-Forwarded-Encrypted: i=1; AFNElJ96jRFqU4STihGWaLdDjgnLVjw0cP8/XsppcKXpmzZBy7KR5MZzLfYWGSXzBDKMGiSKVf2dl0T2qag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQXjIZ72dkTVfMy/k++5kejVknF/JRf/PbUlnP3xbsNe2sPAm
	GaP/1sLfiRXlws51Tj0wnsX9NZ3yPW54XFnshngRJWcPHwwlgCDv2cYK3YlICQ==
X-Gm-Gg: Acq92OF+Nyk+tha6+Rgls6Gv/77eRZ1Nk9QdtdDSPczJ1JHYkKzw9DFCjGdmGpSciSs
	Q1z0ChJlWRNatyBLU/8pEDjvyR6w4csXmNiyTw2JSs5/LSvt0Mmd56yoGtxIH/LrSUQpYpkZM/F
	tx8tOYQ5Jz9H7BjShhbp3yvVXUWbraFkTF0gsz4PFkKXjHYUP6TtJbiVBNUCwjBrpv+QZPm34xn
	VzgZRTYb75CLIvlrydKcz6XgQyHnzBNOege8eR+kfHAzsg55ESPhPcZgzqjtOIOB4oAprgKx76r
	8cpYQq0N+GNFz6/Bo0qwzgJbnq6JSPRNcPqcAOfm1VzfgYwPr9Jh4JdiNdV88x6IyekRF7eooKs
	e5xE2dA/AiT4dMAF9pIWOWuGhMCVtxBasDnTbcX89NeWoYpzBQbMWyAaJ92Hq6aU1vqgdNccLZY
	EgV2g9+yjovcuaSibsy1N/hVPx1duwyPU5g+5qijpl4Cq/JisddfkSvh1rCoze9xWzlw==
X-Received: by 2002:a05:6000:26cf:b0:43d:7a97:78b5 with SMTP id ffacd0b85a97d-45e5c5ccbe0mr4405213f8f.33.1778842161362;
        Fri, 15 May 2026 03:49:21 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm13975602f8f.14.2026.05.15.03.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:49:20 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 15 May 2026 12:49:02 +0200
Subject: [PATCH v10 4/4] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-orangepi-sd-card-uhs-v10-4-094af27e310d@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, Andre Heider <a.heider@gmail.com>
X-Mailer: b4 0.14.3

From: Trevor Gamblin <tgamblin@baylibre.com>

Update the Muse Pi Pro devicetree with SD card support to match what
was done for the OrangePi RV2 in [1]. More precisely:

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with internal pull-up support
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)
- Update PMIC configuration to use per-regulator supply properties

[1] https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#

Tested-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
index 29e333b670cf..81d3ce85d460 100644
--- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -17,8 +17,20 @@ / {
 	aliases {
 		ethernet0 = &eth0;
 		serial0 = &uart0;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
+	reg_vcc_4v: vcc-4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_4v";
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+
 	chosen {
 		stdout-path = "serial0";
 	};
@@ -77,3 +89,51 @@ &uart0 {
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c8_cfg>;
+	status = "okay";
+
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		interrupts = <64>;
+		vin4-supply = <&reg_vcc_4v>;
+		aldoin-supply = <&reg_vcc_4v>;
+
+		regulators {
+			buck4: buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1: aldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>;
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


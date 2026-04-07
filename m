Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165973A5E7F
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550380; cv=none; b=aiDsY5bjGe/vz0anfB/l4OkSRDPCJZ9bg7J4qZIh+s6KiI87JyfC3aa2OSK2kZx8jEYv1J/ViG3P0E+BKUGDiTNIikwHD3Z1QCnk7uO2lrRpQezyzwzk8WN/e2+elmIdR4xfkQhig0LxoGVebEeiGcIh4cD+J0JRMtPLa85BTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550380; c=relaxed/simple;
	bh=yFIoW1VgE9eos0drC7//IWDtDDzHIJ65CgsEt+Mqivs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BrvpryaD+fLdnlIHC5A+IvSS3Qfd09ED67EzV1YZFJmNs0NdxUcvbD3SadczmGgRSsTvrZqMydmzeufPRqMjyQSaLlNa/W0QHkr+QC9fixcsCX/NTKssp0OqXJ1HV6Pvd9GNDZPWKSuwHrQL98oBZHbVKTuSls5zecPqPIYx6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKu1HGC3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKu1HGC3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b949bf4easo3681715f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550376; x=1776155176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kN3bcWaJsQHhIwZ8SKksLHpWgkJwI9t6gAAiBuFLbmI=;
        b=VKu1HGC3OAH15O8CsrURvx9Mu3TOHcbLL4dwTo16iznbNCbrFv/7avKMYMGqXzcxwp
         BKT+TiEu2rtaxuP/coCJNkKndTN5Osg+cJYpi71deQH+p7YARXAFyj58L7g3ZrLuQzwV
         wgkW6MMzgzqhAac24xw7szhGjfW95n7IOrqLJNPzVGaTCghkgzDoEo8oVCdHPxinjujf
         va5/24B+JDJhrW//mP1zfwtdrWm2OwhJdCIopGdSozW8M+lJWxjRfa7UZOmv/z7MRsG4
         DdGpf0Osj+rts48AuY/IPo/6bDAPgHzXNFi44jRBFlTQ/5Wz8Rf+0wIKGCB7th5XYG+J
         r1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550376; x=1776155176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kN3bcWaJsQHhIwZ8SKksLHpWgkJwI9t6gAAiBuFLbmI=;
        b=LPeKAyW5BMz37fBArBzEDq2GxxOjH3wh4ymY0YAe6lQdftpdpRRKwmR13gbN4VuW9N
         FNXd5VFV/MxQxrP4TxI9Bp8qrjwmb4Sxd+k5d/w8e3ZvA2Njr+NhJODnbDqRWusEwj3u
         0th5DSoTAP7TnJUqppXCfe2Xj9RxoSRXrKDeeXLLZMgj7oJAL2gYMdx74P7WSL8PsIJD
         CdOjIcFNAKNzwsTf0qTUo4x6C213YHHw1GTPd7p2IqQgNRrsckBdelFmC4eWAWkDNI8c
         ez17bMf4qykWFOnB3yiDnpwyVJfvc3ZMib0boWVywAoxuwdM5w4UbPfOxolbHBWnf1QG
         iDvA==
X-Forwarded-Encrypted: i=1; AJvYcCVP+uyi3mkptrjHCxWj5eNG69WHSY4skfqXibCPQ4PONtifbB3IK/qjO6cYUrk4CDUtf1Sb8LuQKck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjztMHgLenPJOvwS6Fx1tRiAa6OBsEAsSsyYqd5rmrtYSkyux4
	6afUSSVlOvxlNSsiI/DuyPkaLqppSKTm41C4olzmchQ28esrJF5VfXxz
X-Gm-Gg: AeBDieuQFZ0nA9D8T8U+IRxhnsup5fgzCMptSg9u/hphzZzoSaRG1a3VR6YgEJXIpQc
	s73i/AOOmhnqWcyfHlCDmGnxrHyNN0qiYgY79G/bj39Ws8ByBX0AxCxGq933NK+g5PRwIMsR2US
	w0JwC0lN3rSXUzER5Ucr4NxGEws8q6hHO2PoKNewJtTbGy1NWmik2+2MKFiiaQMUfNKOaxHum8L
	3aIdV6ouXzKn8KeIys1H/97ohIiaEzSciNo7cchM8pz3DiYCoOqvZkbD758iPCVYHjFYDTyNztV
	fFYCKL6bpJqcFGmG6ZWCdkZC8t/q/w0J//C1tBB+U23jcrLfgW2OqGwc3Y7t9lLVcUOWEup8d9I
	51V0nEiHmAzV9SAb7ncOVcLjIzzxKdZeVnnNG8r6begvRq4Qk+7iKX69qr+tF4GP8z9DiOVqNSA
	4ckEPb4gDmYW1PuQGBVoHyhZ4N9TDDNEUVqKEG4b4HSPUufi1YpIIH9IKYy15rCeNs
X-Received: by 2002:a05:6000:2908:b0:43b:9d69:43a with SMTP id ffacd0b85a97d-43d21171c88mr28578084f8f.8.1775550376299;
        Tue, 07 Apr 2026 01:26:16 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm48669958f8f.21.2026.04.07.01.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:26:15 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 07 Apr 2026 10:25:29 +0200
Subject: [PATCH v6 9/9] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-orangepi-sd-card-uhs-v6-9-b5b8a1b2bfc8@gmail.com>
References: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
In-Reply-To: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.2

From: Trevor Gamblin <tgamblin@baylibre.com>

Update the Muse Pi Pro devicetree with SD card support to match what
was done for the OrangePi RV2 in [1]. More precisely:

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with inversion
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes

[1] https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
index 29e333b670cf0a5c4ed852668460db475b9c44cb..774a4640f06562b5632c510e8961e3d8f60a3b81 100644
--- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -18,6 +18,24 @@ aliases {
 		ethernet0 = &eth0;
 		serial0 = &uart0;
 	};
+	reg_dc_in: dc-in-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_in_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_vcc_4v: vcc-4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_4v";
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 
 	chosen {
 		stdout-path = "serial0";
@@ -77,3 +95,51 @@ &uart0 {
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
+		vin-supply = <&reg_vcc_4v>;
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


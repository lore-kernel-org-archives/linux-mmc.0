Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2D3A6B9B
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550374; cv=none; b=VY2R5ONBVwH87mtiTiga6v4s4iN39OE3pevLpLmUgT2DKcPneauwFvw+wnwitsEeyTlZbSnVCmQ67Fce0hMLNtDLDPVvzR0YOn1t94M/EYlLYjw/Ik7UrEl6CLzVctNEc3JpH84yyssLtXHFz7aMhgjHFqR5DByUZ5la0cTppPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550374; c=relaxed/simple;
	bh=mH1spPeTCHz8roINYMnma7FI82vi0r8vKKTb06yrJYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fr8xsq0Dn+ku5YXOYATdqCnKwx+qZQVOSYwLPlkX5JIFbLz+9X72HoER5rotqxiSr+3jfBWwQlhdiYqkF3bZSEutqm0NLmvvycd2VG0J70WTM8/szqYVNQVxhqW090QRjQAAsoO0K0dLByO/vMwmFRxaTqH56Utg9S9nqobzVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4QI29SF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4QI29SF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so3832985f8f.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 01:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550371; x=1776155171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MilkKS52ju+/z2QrTRIvbE7nHZSA0fcfW7w+lU+2hFc=;
        b=V4QI29SFk1uzpQ7JvU9GYVVyOvC/8gjwaqaRttcTapoLEeojT4FSsh7KPLLtLmjHeh
         KfT1vj57p3aAG7hg4uslDg2tPjjBxT/osppeGJD+NKdBdcfP3TXi7I0pCpopzZb/9tKM
         EAX6/aLDdDIlAAnTge/FwROFXfgqvj5OPqKFxM/+9Ssh/z1OrqOhgReatJhBdDGaSiwm
         ScAZXIRziyMWHhS279ZNxw9hS57e6eyVaLcpxbOasiR9EdDhJUQnwZP0+i0DILQCMd2j
         qLgkrIQqC4ksiH6B3IyOoyJ//CFfMfZRDErksIvYBWExVRw4xYJzewTWR/3x6EC85+J2
         D5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550371; x=1776155171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MilkKS52ju+/z2QrTRIvbE7nHZSA0fcfW7w+lU+2hFc=;
        b=DbqBp3F97+u4eX1q3/VPkKbcrSRGAdp7GScUjxxTKHRBFmF9rqPS/ro9P3vEF1q8G2
         96IfH6cW8uEwv0i3WRHlts8tCq/OxUTJM81sPYH21Bc0x99V1xeCynLwW/j1ysdnchHp
         RkY1bJcSGpIh8mTZ1qaOdibXD4WjVEbU7gQlubzVFqpxGM47jhgTdjG9K03BS1t5fvE1
         vYFzUNrpQUQn+zlMYXWOM1xs8IclWGhbA3q8mXX7TnmBdbaHLLrEsCGl1n0gam5shKnI
         zCLuHXuUsXh6IRskfKF67NqDnfD84Q5RLkiyAwTCijsQMYAi/ECk3CP/YvamdTOTQRDE
         X6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuk7zK01RKKeHo/bbMPVNKmohp1HfHeSWq6hxp2Xa4241QG7CtzcMkFaEWbi5tnNDUX/wHzuHXdhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzvRgg6YMHCaCr+yVbLqjwDUS0Qw6OanbIEwKI22m1R23vwdi
	8RoA7a9ZJ1FZhC2DxT/sO41yzgvKrCmYzK3v4cQS29sa/SCetgNteKsy
X-Gm-Gg: AeBDietJxBQofpIly1HDePW95YXXnGtpszvJtnvnDkUBTLSE3flZ1BCYiySQjtCUpyH
	BHFN3i552q7NTBz+e5aJCeHhymOaDe7CYuCTtkADuOWboYIpRx7r9D7r9WN0+FJv8xPKlxr2nEC
	VmWaUL1is10SIr1hfv+kOQboO2WE+gO4N9AGc4txWOToj/R3f5d4wApECobtCeRMWZY5pjOyCef
	loayFyGkARTjmvHOZA1CS/ZgJxnwHZvFcmMHRCN/NxxNkDdTe9RF5HUMc1zaVE5UzUHQFrQbBKU
	DfXeIHvXPeOk3R2Wzy+wOspnNqxnbesdFvn2hh7LavlLFSjKe41XO84yXIK2d6S9k0isCriGbGN
	uNbq+7hm5KaKljwR8FXFGBGwuQcVCFSA/uwL8AiINsO4wGanJ/JuXCazl6N/U5W1Oo6Mc9G4LsL
	nhDiGmBFTy4EGmrGognAY8SoYq35G24U/Em2SR3HO2C2OkZ2JqReRSxzE1wNv1G6ye
X-Received: by 2002:a5d:5d0a:0:b0:43c:fac5:d382 with SMTP id ffacd0b85a97d-43d2118dc50mr29229253f8f.12.1775550370963;
        Tue, 07 Apr 2026 01:26:10 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm48669958f8f.21.2026.04.07.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:26:10 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 07 Apr 2026 10:25:26 +0200
Subject: [PATCH v6 6/9] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and
 power infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-orangepi-sd-card-uhs-v6-6-b5b8a1b2bfc8@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.2

Add Spacemit P1 PMIC configuration and board power infrastructure for
voltage regulation support.

- Add board power regulators (5V input, 4V rail)
- Enable I2C8 for PMIC communication
- Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
- Set up regulator constraints for SD card operation

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..9c417a483f6bad6e60617cf8d5400ca079588726 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -19,6 +19,25 @@ aliases {
 		ethernet1 = &eth1;
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
+		vin-supply = <&reg_dc_in>;
+	};
+
 	chosen {
 		stdout-path = "serial0";
 	};
@@ -92,3 +111,32 @@ &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
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

-- 
2.53.0


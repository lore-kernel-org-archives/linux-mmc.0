Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF8392C28
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065197; cv=none; b=RpDKduJyg1B58sKL79jPE/Hd0fVt0/fBpd13gxoxoW4jXpXWHUeFphm7Deoh06kWuSMVeckVo7tDxEKPVRhITThYQ/WteO3rbTsfqR2B+y+6CKa+jHpN6n8ivCTZZPNcJFvxRsh61z8qvU8gbroKLHFpqYajkqcWgVWj++x3TN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065197; c=relaxed/simple;
	bh=jzMsWwDIkxOKSax6gl1IICe0yAnfuQo2yxPv0AT8qsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pU+XJ4p8pass6Z33hon+zpXV5iBtxjms59PykWoHuJx7rPWS44ZcpZtLHf8IYBjL6veNemd1QNuVtsP5kwxaYQfDT/8U+0ARNkqKvIg/SbaoJjKqAAzQ42ernY/rE0kgSwp2BS/L0yGyp+kZ1GqnFZEuaA7WeMopqcyRuHJyHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py5swLtd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py5swLtd"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d73422431so731857f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776065194; x=1776669994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bt7k0zpH6EPz3nKG6vw5G/jzVLlNuWcFiRyZwuaAKY=;
        b=Py5swLtddjk0NJwBd2afBCDerDrJtH3ZdcDMdNahLTVUFzVFebjaGAOTGSkXFfUKrI
         G/kVPfkUkhuGilXIk8lIsscLKsi/lzpPJrQt4CG9jTd5AyuouiRSuzhsrOm1IpqlHjEa
         v8gZqdpvGFfJDQ+kGtKYZ28EHEKmJJPBOP7lTcc64eSsn0SOmpTXNWIKTWjMmFznpJtR
         /tbao0WhqNzKQznQazRARxeZ3AlgBAJy4rqCoHTiHeyl0bMdZuZXxzdZT3pi7tvS6iqK
         3fVtHFur2lfRbB88wifASm/denQGFKo6Iipa14ANRZTph9Plxl8Jfjw4qgK/ETkZTq2g
         aMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065194; x=1776669994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Bt7k0zpH6EPz3nKG6vw5G/jzVLlNuWcFiRyZwuaAKY=;
        b=F3Vic31LpGLy4uKLattSIwEMT/PcocOyB+kKOibqWG8dBRyofz9Rmsp9OrZJ922Pjs
         XCuJdhbapAXqFX2XIQ5qezTsv+6oGncXxOD/Ec/w2co75I7a+iw5x7xzZc/kD7PVzZ0r
         pVGXXor1DJs3U626ObDlbyKHufr6TqtMpMXHuG6jUqIiOTiZWJ4B2PKyauJM/r8cG769
         iUZfK61XFdoF6zcENpLYOcl8CRpapsdRS3JEgvknDi81so2MzozK/FUx6zqSmlf7onzP
         3Sh041ulf7oJiCIW4/G16aMiiyvS/qOjON+11LLavZYzLdzzAVrFshhSe64E6cmomKqD
         ymhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Q7MwG9n8AiG+z2noaX6VC5n6FnKza49oXxA0fy9d+pBBuRtpQ8mTLcmYU5MzEGaiJvsTY2wXMAms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+1dHJea6kNGRZCtpa0DleKCiJ1ok01z0VjPPS1un/6S+3UUe
	/pwZfXcyiFQY6MqsgH3dZ5GGEAG96DJ1tP55qysShQJkkbx2zc35zeZR
X-Gm-Gg: AeBDietvotF+KiKz0VtfV+uwCMLshauWVyURzwI3h9zEIHb7vYmizwL0ZWP5dTTD6bT
	farLGzx8KuEiCI8pNsalfZnXAfFajebXSIuBPZIAAb12LTxBnKY0B8BPGy0ncUoiA5PkgRLkqRb
	FiKvTD6DUxYI8b+bI2LSYixnjngAgcHoRaJU2XB0Ww8KiCL0bkYeY0hoTybIKDoiy5mqBNYWXV+
	LrD8vYVjSCRKqlzDKz3ov9d3vc9zJv8PHBqsKhgbVmNnaUCc/kyM+efadt6fVFH9uffxOyNk9QQ
	+va9cENixVBT7yE/Mcm4No/pdxnjZYoiRqjXu71FWcRzypRf5HETooPYF04oExoLkarZfhPHfRN
	b8PyjUyB3rSy5FjTlRapgHHO0Ife2dbA9AioWt6KjGo9JM7Y+6d5+b7efK0BT9doZOQfh2zBa//
	Ztnwcm0HZNmPhSuDFffQ6Z4iCMvPRGnoCChjYB/5/TGt6He+N7vWvhhqOFys5sSG8E
X-Received: by 2002:a05:6000:1788:b0:439:ccd7:cdb6 with SMTP id ffacd0b85a97d-43d642a4dd9mr19113605f8f.14.1776065194020;
        Mon, 13 Apr 2026 00:26:34 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec27fsm29788453f8f.11.2026.04.13.00.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:26:33 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Vincent Legoll <legoll@online.fr>
Subject: [PATCH v7 6/9] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and power infrastructure
Date: Mon, 13 Apr 2026 09:24:48 +0200
Message-ID: <20260413-orangepi-sd-card-uhs-v7-6-16650f49c022@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit

Add Spacemit P1 PMIC configuration and board power infrastructure for
voltage regulation support.

- Add board power regulators (5V input, 4V rail)
- Enable I2C8 for PMIC communication
- Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
- Set up regulator constraints for SD card operation

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Tested-by: Vincent Legoll <legoll@online.fr>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 7b7331cb3c72..9c417a483f6b 100644
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


Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7AA3AF64D
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859916; cv=none; b=W7p6F788hEt4fXIUHOHm+jlHia6IORaEsFnDi0AR3HiplRH5JkW72255RTnJVEXRZAzThz8lnITNcdQh+FQ23poyL9DlEZFc4KzP24DCID7OZkhpWGjFjJJbaeV6fIp2MT1YEJ/KIbG5+UX5VWw9jONopdYmbF8j9TZlu+3reWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859916; c=relaxed/simple;
	bh=mH1spPeTCHz8roINYMnma7FI82vi0r8vKKTb06yrJYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKZVOtkIBEsZsU9i/LUlMYHiJZARplH8cpgNLE6FSOdfS6E9xK/Ru2/RG/fIdlfDzXE8FECiWLUQdMRhJA3UlFG+72U4WsbMb0ynd/prEY6QQDP/ksE8+LEnMyusH5yZymxrBLnUazBdnR/SCgnxLlOys4o9RgrRzSPNb2k5EM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWp9y1gB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWp9y1gB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so55856675e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859914; x=1775464714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MilkKS52ju+/z2QrTRIvbE7nHZSA0fcfW7w+lU+2hFc=;
        b=BWp9y1gBR0vUXczfdwqM6oZYjFfqwFLDtgoPuWsm4cRtJShRNK5baZXU2azoGshp1O
         4cQTJ+K/6VujOLCY99aKST9OcvutQqDn+qac+aKpFoMJO6kMFYwuiz+xVfkCpRptFC1D
         DWg72jgwEvwvaN7Hnih8366y4UpXLMkmSGOxhEMObN0ISv2I89g+sb+mMHASKvYuWDWe
         b0X4s+2MMIfcaSSHz5hqXfvrC1bw4AUv0BfuYN3gpzIy/3MOxuBip+8CJ1Nj3O8N65JJ
         +B71FtZ5TWnMa8aaAZIAJzRJE99mTmZGBdDP2XNnlpWfQLCeEhrsBNV66bk1Bzdw/fEX
         incQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859914; x=1775464714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MilkKS52ju+/z2QrTRIvbE7nHZSA0fcfW7w+lU+2hFc=;
        b=FG/utjoUPg8KFkdK5cdq28txFMV2t4oFNrcU9Bu/OPy6t5I44HWRq5+Rei7FHf4KY+
         NXPxMRDCrw1UUZkhZ3gHtrFkz6oqu/L5KVdS5RpHNHQmWCf8eYaABRtfOT8vMd+tUMzN
         XftRb1TjibRDUr319sKxIW5Az+HlefakHiZNp0pAtFY2Lb03rOETmJC186r7b5Ext9mP
         Q3swVGOgOtSxgeJSldvdHS+5aIXOQsTo6/qheo9WgTNz9u43spGf5R+wmpcucNx72aEE
         b0g1IFCqr7SeF6LBAoJHD6NgIugZ/mobFOz6ecXaIOgbTJXMiDo9jdBU6jGLwVPD/oyD
         xt2g==
X-Forwarded-Encrypted: i=1; AJvYcCWyE01Obp8AIYrMwK1me4R+tR5hIREwyemKCMCHseGMckvkMJY6tRcFm+sQCHYhKESpprSDeCSY0Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFuz9WeKK2Y1SNqw0uW8Mn3kdQtAT3hT295msyhKXnHUXHtGS
	VA1ZoGFNJ/Hgtq9zvduWheYPMDO8FyCqFjEhBHSb57tU0Hw5WGpCqrKl
X-Gm-Gg: ATEYQzwVNmY4TFHxTMJpiZgljAva6H9xXzOSg7m8A3tDmMqEYhd6LmUwEsVaRiSS1If
	2kI8fkcbjgY0USW5vd0NtNLImdtvgOY5yPVWqDEzbVpx9RfuV30pN+wRjX2ff2O7DOQB8ZDmS4H
	jqt4816j82CgP9dIMjVN5D8KRqbMyvLg7agRzvt44jAQOTh1m1OpAFL0NlAsuN2h1HPjOYR4vul
	oNoJht1Q64UOb2CMLst9vYrKi9nd1218+TI/kzEANKzJBhGiFm46ZB3j2QRBFHz9K/YTQuVciH6
	XaeKWhuFTy3PLXzqiC7DhfiiREn0S7k13qMK6/chojEZBrLrsva4p3EOVsOMG0otjaBFYSOP7Tv
	mSOIaw2ASVXNIMAhKEtXGm1d0RiNlZt7LzHjsMfIj+dA1spYlyWz2A0mZFeRQh4phTYn/Pnxyxu
	B7lf+CyXJY0VRQMjS1W7eLtWKbN3h2hjrVojqfTDvxCWO9/Iinsyw5urkJykCIIHd3
X-Received: by 2002:a05:600c:c109:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-48727ec776bmr146972035e9.18.1774859913716;
        Mon, 30 Mar 2026 01:38:33 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712c236sm74063315e9.14.2026.03.30.01.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:38:33 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 30 Mar 2026 10:38:07 +0200
Subject: [PATCH v5 6/9] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and
 power infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-orangepi-sd-card-uhs-v5-6-bd853604322d@gmail.com>
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
In-Reply-To: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
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


Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB743A8727
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056442; cv=none; b=sbLTMmt/wF5XoYI0KF7si9KELDiDSq37BacYvzDea6BNS0kc5gLuBWRepg5oHrleZToDlOTrBiQQfyXe9tZ1bxSOHODEtWcxVKoPAQOp1BZWTcs4KvNu2g+rnU+pU/XOyWSuESCJDcmDnEI30z1hRPKNe6L0RDbMY+j+QZcbO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056442; c=relaxed/simple;
	bh=70rfTlR2IAWuKF6gWYOHTAy0yzzcBoXO6BwKFGm1+do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8vejVF16i6DQOWCTYJ4AUpDTXcteVG5uwPLqlb9ceM5udHupLILn26KwNRXiMgS7RnPtG+mt6JbiysOvIK0CG2n9Vu3Z6d1BGOGQVX9J1Ah0XNLVBRnVLrOxhNdP2JMcADWb6sJZRBZaeiEOj5b281fY2nEJdZ4pa5qwH++0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAVWuHyL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAVWuHyL"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439c4bde55cso3939818f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056439; x=1773661239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiI3b1wOWntFX27ERmDlj5qmTKTz44jgUTrCNSLGaQE=;
        b=AAVWuHyLLmfrtEVjOCtkclg1QcokC9MoiaMcoW1ZxweqX3Q1pxgdc6H4dTVS39yj07
         TBuv+0an4vN1oYej1j6ofNlG8HeAzzGJ2PIp3kRkTBQZ0bdtMaJ1mzHZOGV442KjvKZ7
         cORcOI9W5Chpj3undbDQwNmpNkhWEfRplJ3a2O2GG+iEKFhgrvv7GE+IQlz6qWVDZGH3
         WybKzXzL/NMcoemX9zWD8QYgHCg8wGM6H5BJKCd1q/b7YIAQDTxlP2iw9A6lk9A2ur5q
         5WcI9iyt2Cyt7jXwM5+t+mPQWOURxHY24bWb3oCif3M/wr2Qz6YLGopAnmTWnTZVrqkJ
         jTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056439; x=1773661239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fiI3b1wOWntFX27ERmDlj5qmTKTz44jgUTrCNSLGaQE=;
        b=V1lY7dfONYrRutHFMr/dd0uUWU4U3P+GN+crej3T+xeFrQVltX4KjYc8ULNsPXy8Ux
         ta7f0FHIOa0s5ON3yaGMRETcKhDdP0A0tQv8hRud98WNgSnXyU1qI1yZYFUtyP8ZpTkF
         PF5210wghCeegPxu2uUk+yIJ78W9oXXQ4w1HH4qJmgguR0N8L49MERUq4e/qJq2UUJB2
         5gjKQ/1+WhGnHkV7VdT0p4aFMyOWPL6Q901yCPLJL+c3IGZWOjMP0ym1LAQSZ3TybyNB
         8DiPt2A9bE+q/XWdfMqj/OTkgOGnW38UCLRqVfyokMVwN+Y/rLo5rRhiQKnN7xXQ/tn+
         zCaw==
X-Forwarded-Encrypted: i=1; AJvYcCWNklzIHEWUCglpDdQnhTs6K3hIRG5oAquMc2lqBWr4P3yoGjQl9Jhvo4srwaMZEURkUoJrPjsnTRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7GtDzXdczJvtS6t+efbw2F5yPAmVlFMIkzbHhsae5qzmUpFo
	gNZaqMNecfoOpK7mwPKvu4dkvJ5X90E4BjdPH3tjsjxeJwaDG1+pG1Jueonvcw==
X-Gm-Gg: ATEYQzx9EA1ayZ1v3A1L0bSGkU9fAAoD1xpI9M2ytUYVWb763G8AM/el36O5NcrsrDx
	wgnjWBhKEAC7vPmpIDw45tn4i1mip7eGtod+WbX+uJ8EUbX4aegNzO7fkigLxpyk2eV+1vlih6m
	R1Eucya6D8IkBlaLv8LDGsajdivtouWtnH6fyq+zgCbDEhRJmTqVL5Wgl/ttgAYqy3vQdSyAPcE
	iysRKlJsGnS8RriTdFDP01gVb0oIp0clLMTmGfdzAyop5GrM6nzhSmQM/+aZg0/49QFCc8tISPZ
	t6tlUIEN7Jq+0F+AMC0aQoqYDPu+EW3+IGmqv3JcaxFySIrl+S2TgL7dzqr1+YLtlwkGyJaLAgA
	YjvjQeZwrPD4UbHkhhctwtaW80UW9W1B204OR6FuVMtFPWoCQYjBGsr00cXJZbH8VhWMjENJcd9
	iitp+Qe8lQr1amknt9/eT2+BH48A42mdY7jGi6YL+JPPJzf1xatmQh15lY2+pcGUcB
X-Received: by 2002:a5d:5d84:0:b0:439:bc0a:4164 with SMTP id ffacd0b85a97d-439da330b92mr19644526f8f.19.1773056439050;
        Mon, 09 Mar 2026 04:40:39 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.236.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8ec97sm28471699f8f.5.2026.03.09.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:40:38 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 09 Mar 2026 12:40:16 +0100
Subject: [PATCH v2 6/7] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and
 power infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-orangepi-sd-card-uhs-v2-6-5bb2b574df5d@gmail.com>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Add Spacemit P1 PMIC configuration and board power infrastructure for
voltage regulation support.

- Add board power regulators (12V input, 4V rail)
- Enable I2C8 for PMIC communication
- Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
- Set up regulator constraints for SD card operation

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..414b03f5e6480f05f5d7eeaaa0afb4e86425ae36 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -19,6 +19,25 @@ aliases {
 		ethernet1 = &eth1;
 	};
 
+	reg_dc_in: dc-in-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_in_12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
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
+			sd_vmmc: buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			sd_vqmmc: aldo1 {
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


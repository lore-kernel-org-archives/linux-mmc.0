Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765C41C0D9
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464451; cv=none; b=hcA8ucu9SoGwVIRmcpmGaMODig38HleogxgHu8u/0vuw+MUVrEYUwC0yksCH/UED1mZ8UImx9ChHdvCSUPvkq+qbfH3mPgyYcSVw3DqXR2gs6q5vODhIcoaEvDB/IRiAJ8KRy72GoNakXPnWDgLLfOAZzGGxMif3hISwBjSGAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464451; c=relaxed/simple;
	bh=70rfTlR2IAWuKF6gWYOHTAy0yzzcBoXO6BwKFGm1+do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNSGqS0ZHZviwrM+EuT2DPZYjbOY8IUSopUV2rgOghKcUKMu3yqD5X71DviwPBr1KyPeO9sJbO5BFNRBfgNBVRs5dWCbT9W9vDlfQSSkCW2zxv1ltpMYRJN4cQR+w50Y3MU5jbBHEFcExtD4sYTO8DdS7JHq+YZ7xD6CbkTMgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV3h1mBD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV3h1mBD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4837907f535so39913845e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464445; x=1773069245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiI3b1wOWntFX27ERmDlj5qmTKTz44jgUTrCNSLGaQE=;
        b=TV3h1mBD/9PJeyH6glKCbC7JSf9l/+gI49GDAZzHTR242hp1AaO235XLy/tCNqDi+s
         YzNZgnArkLPLLShyK9hL0VIzgXn5ZflHQDu6wON7fGmgoyRbV/xxS0Ui2j/fQKUHALmM
         wpwIePtanVt//lbTl8vDf1pMQH5EMRJI7ANRFLLi8Tv9EKfXHyGTbngiR4Sq6sqKE5hv
         2JiznmWfbRhuBSnhg3OEnSA4gtfCvLDEdvZUv3J9zqjDwx2h1mIocGP6eRzMAJ9DkHh+
         H05ST3zUtJyR7xdvgV9iufFz4XN1QWWsqH/phDFLDai4ZQ7LsgZ5cXckZ5b6l9w6bxQG
         lrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464445; x=1773069245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fiI3b1wOWntFX27ERmDlj5qmTKTz44jgUTrCNSLGaQE=;
        b=GqdEZCQ5Fll9ATBO306bASkv4InN6lXN6MLLz7yJVha6KGrzykHD8+o8XY0bjr5U1g
         FqsR7kaYBDWs5r5ukwuJ9A7Lc8WPpNHKDysm0weXjXiOhVRyBBVXiObD+07uV45I7fVq
         jYaZ1QuO/1pDJap5aTha6kOaN1xWGx/5EmjbEnwR1tXoUHvQxZkjY/9PItXRg1n7P0z7
         WUPrqFVjxIaAYKbJkX1gxUR6nJoKlclCAG8hCZTsdMHNR27ZeGM2k9oo5pIbXrRZ3jQ8
         ipnn+GLcJ1ReG08fXU10+R4vY/fRj+F75Bn98ZUI2jnSexPg2XK0egLEsDPemXHwwXGt
         XSlA==
X-Forwarded-Encrypted: i=1; AJvYcCWW6sRfxxeMj0WNIIG4TR44ICKVVXbH/mNIkMgru1ixT7ny2iC/YsbsgB5wiGDtmsuCbdd3nDsUwRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs1EQ2yfAZJbuvQuXZujnHCz4D9GJ6fer5Qi6QmBa3hZGwMb8F
	nSIAJaqKMq+b4+ljUFsMigAMXBgUIsaCy37YQQT+8aRfz+mypny1rUHo
X-Gm-Gg: ATEYQzywVQIvjR5FyYloNUGaryzYTpjX9zfyCp5dvFOOZDbmNtb3+XSHeqx+iRbB/Dp
	SYmLwDNiIfGPhedaDwVZaHRIdhb2dc5Gut4VocPA8ruObXvzTrgvuxVrF6V2OjhvEdCGJgvdlrC
	OQnrIjNh99110SfQ2Nnd/DLaXa/mOKbbhfTaUCF1ZzCgRYg7JnItrxwCRqGfi+FhVQAoW98ua7G
	J4nmxqodYf81phN16kpFtW8OsiL6p/MaRilV0p7GgjAJSmrDZJ5ohV66TvdUj1slxu8KRIJFOwM
	uEvftYRu2CHP7IwBEQGRfrowSfGDu2tCa+gnfGlTzhgcCa93meGTtw77GKxKbasF5DR+AJ6KSOp
	LGili/kZQcx3Vd7EYFkaMNDjshl9BN0MeHyvRzGxe2MHqaxMVxsx39LHU2V9Y+kZbeTBOcUuFEp
	ePWcv31Y7z344rP9KD+6L2hJq1FTo7s/NZxM76KqVrDWHVcnTWceJlaRCXShJuTnB2+w==
X-Received: by 2002:a05:600c:a085:b0:483:badb:618f with SMTP id 5b1f17b1804b1-483c9bc5b7dmr211763895e9.25.1772464444896;
        Mon, 02 Mar 2026 07:14:04 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:14:04 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:30 +0100
Subject: [PATCH 09/10] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and
 power infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-9-89c219973c0c@gmail.com>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
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


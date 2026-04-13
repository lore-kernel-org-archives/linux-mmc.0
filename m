Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FC3A6B6E
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067370; cv=none; b=kxbszf9wpj06997/oxxwXj0i1itd4rYdwBhSCAGIdZp36t0zkiaPFlpkCMRvsFEGseplr6+veftis5GwM0UBpKcPkQS35MyKRuDSVS4rGDU3nPEAl4pvCPZU+fYUz8vyOLSWfjyfSl5wwhFljDa3VDIiuCpbSFOMZkqv3XV0gnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067370; c=relaxed/simple;
	bh=jzMsWwDIkxOKSax6gl1IICe0yAnfuQo2yxPv0AT8qsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pS0VeAupXq9HTRoyDoQCzIVNdqi0Stzf3qANVjhNf+PYbIzAV1hOQ9g8mctnPH8kVjgXi3uMyMrXOI+dVv1Ilid4TbuGW7eKQdhstsPjwdx1wO/FRzUE/W8p5AKs2mjONfrdI4SbqxFnqkV0EIDHAP5x34AwMkgpgQnXiqpLrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxvTbPLS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxvTbPLS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso3983131f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067367; x=1776672167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Bt7k0zpH6EPz3nKG6vw5G/jzVLlNuWcFiRyZwuaAKY=;
        b=jxvTbPLS1ArVU1BVZmapt9GH0VIK+MMk2M5c3unJoTou9fswUZbAyLN6q75qcOLrBk
         u+fENFwoVreo4/GYTAoq4zXDq7oOz5ux+e2z3uBUDcS7y9F40k4AxVaDQjYXoOPtn6Rv
         d7J69qnwBm8BYUb5x1Hq/EJCirQMRxGFBIWjZo3vPK4QWlj5MU7l1G1dU3womoxRvAUm
         RpAtklNB+2vrB0MGPNgPPw0PrLY6woe+uCdpPXslSoHNIYbGposADRJBa4UFpzf0SKJX
         I/Hja0fFKWAlzpghCHIiEbxanNyInSOoslF7wK+sWU8Q+wdbkxd1i2VRnAaLOlxkrlt8
         3K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067367; x=1776672167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Bt7k0zpH6EPz3nKG6vw5G/jzVLlNuWcFiRyZwuaAKY=;
        b=TZnjR2SvLfTHeffJCg4yAvetIFwCaQirDf7FzuhGgqRhyDQL4Cktg/gmrtZ2wy3XJF
         w8bx7j2LxH3P+zEC52prEelTk07CG8EcFaNSLsAkNPYgOBl0iXGuPqM9usJ1o+UUVZRf
         dFx5J4KQ3qPkgD32JmMuYz6sAtlZA3uByn69hd6oQa0I9QWa/50A6m2XGW5RFjoYe5wr
         QHzIABX79EwqosaZqmGcBoZ3Y4H1hIll4jKh/ZWQJayWVSRnhv4Eh8USNEEL1YyRpQM2
         xn1uZj4UdOt5X+ECZli4lV9RGHVwSGiPdXe5UJwO21TQFf4w5n31dDGlpOIPJxFzdJBs
         +M6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8PvBqU+YQXjwoxBOcbp0v4slWJsVnXBy3CkOGmF4RGpKlDD3ZFQtr1fOOBCDzRMmGdjaPDezc0E9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsl/kElka1A1WBqTmTsilIf2oFHq+6YI859sxcxBJx0k1xXlw
	Hz3de8C7szIy5+IyZP8FMimdp3xBCnTwD+ODYR8w9MFG3LN5p8Lrt/tl
X-Gm-Gg: AeBDietJoO9n+SoW6bRIBY66CreCcn79UNHQah0bquHJBvnddWKwDhcOPyIb0+eiSkU
	rhUq7b7urW0oQmWpBZxs0DhdMm3ZQoDQPGi+MRTlvHi1IypJzfIbtAzpWbBtsH72f7WI5Wx+A/j
	UByI7AT8xSvI9+q6YF+HZBNE6wFJ2PQMVVaf6c+9gRYCI6hLtdvK3lf+7Iw6Bi4q9qyR+othp+n
	T5T8AGgZBWt7Zj3ScSgRmCgrrOKJr/HkkMqk5Jn5i72qm/MhNfWM5tUir29u43QssCk3QtVM7Tk
	zIsN3YW+6iArazM6OwQGIiBtUHg/qvUKpxYkcBa/WfkHa0ZSz0kSKNrFBpl1tbwIIdHPnTjR0hR
	PMwuzd8pEo9txwxVmk577iBEBxBUQBWTClvaApibj8tzoLUGShVaMQGqLSJv/B6sreM1ArUn7YE
	mO1MGCeCvC5OWrBCrWyXFUpbUQu0RNyeApDhuwS8+dq0Cu+GzvdthMazeItndx//n3
X-Received: by 2002:a05:6000:4021:b0:43d:7854:32ec with SMTP id ffacd0b85a97d-43d785433bcmr4066398f8f.17.1776067366337;
        Mon, 13 Apr 2026 01:02:46 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:45 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 13 Apr 2026 10:02:15 +0200
Subject: [PATCH v8 6/9] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and
 power infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-orangepi-sd-card-uhs-v8-6-c21c40ec16d0@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
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
 Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
X-Mailer: b4 0.14.3

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


Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D339B97E
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669879; cv=none; b=uYavnMpc+t12iH0PlLKU+5CDxf7nyWqmfZAkumQ70cB6yZkKZSH9/uEbXGVPU1rNV4+3zBFLI+/O4gejHskryVGJptEpssoZpd/QTM/Uiu3eeW+Y5QwZ6+NC30A/7tKQrjLSQN6ku6dP+g8IpVyphRiaQwjpbIZGEZZLw1+FlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669879; c=relaxed/simple;
	bh=TMuC+r//YMxau2/SdiPrZPIigFg5514fOWLlzC/iIWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0ilcPn8YFAvwYVHG9+XD7HdO5I6wgA0nQYCVXQRJqAHKBttjCUANZOtKBO1mljV1j9yGN2Jnz9i9iezqA0tyYa/xyJWOc9rHSKBGVeRvnzkci8TkHU6Bc3NSpQ1EujhEThCJEthEAlyesstgeOeCYDhD+Q7aUCRd7Bey7jX9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzp0BIFN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzp0BIFN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b3cfc38edso1952424f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669876; x=1774274676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzdLQZF+g4qVulg9JsUgV+5Hi9wiigjRN7QwVdQTPwc=;
        b=kzp0BIFNW+Sa/Gg0mi0HWEjvXDz6jcddOa0znTSZrp1qM0adeY2OE84Zd+EiDy9V3n
         8Lt7SGiMFTWwSZPvExojX8G7bC9LwwShEFtBOKC8N4rezn/kzrPLT6vUBbwOuiJuksT6
         OfheNZ7uBd8lvYOGTGKjYm3iHYJFEDI8jqGzVnP7V4nElkrdaqu3DtvnwcYFzM12Z1c1
         UPjdlGys+bQVpwcPtcPQt7fCIJCMUhzje5Yle5FJcORThhyCZAaWcjh28Dq/B0da5eLh
         IqeRAq6HKEeX45PCuCnQfWD2dTlMJ1d53AAa2F2K3XcajkZBqLsVt4FPS+OFbbt4Uc8g
         S/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669876; x=1774274676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bzdLQZF+g4qVulg9JsUgV+5Hi9wiigjRN7QwVdQTPwc=;
        b=oPt9Y32/QTrt8BPyMY2BfzrVYTArosL8+/2KK70VKqaq1E+syvGCrOSrxtm5j4POwO
         zE9ccEBbB0HQ4xq6PDYRhzVK+1zhCTLt7R4YFY4dM0A2tsq9TBwQWFHtOLmiswFIdJfh
         XqMPzqtCXeZAiuN28SIpgiQ62Zo7lOB8TaAkMdrGgVvxfLq84BfxbwvDYy4QjP//9ZPu
         Lk2us2yCyHmfA4zWHr9NJoMZAVMG3wCCiWneXjGGAuj9kC5w5CBRFH8f/JPl8zShx0HJ
         GyzYq/dO1wTzJQvQ3iAfTbui5vdCmPIiXEdhmGSkj7Ku4JkH5K380sr7ktwpr6Pos8JO
         /ufA==
X-Forwarded-Encrypted: i=1; AJvYcCVb011/AwCE3aRR8DTtrMKKaCn37O+BgkL5oONOgOJWIseEpKdpBKrRSHu6KiE9+ywxkw1dNVDDBLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykrYF4cTRkdGvRwp6xf9xnN8BDu6VNjBC+MB8g/Lrgq1h6J/LH
	2gEEyXAtE/MDXfXcsxutFHk370+UnBhjWWNVrXjKwZYNCXvuEnXP+5hM
X-Gm-Gg: ATEYQzy4YKF6E7F+bRGoK1O915cZSd1VixgxUN15HPUrnUiwuCecVv8E/wCercK6rEv
	b3QKATpwSjLSlLTj5aNBToWVFSrhdmVhK3lZIdjPXiZnxhQuo2B2PtQ1scbMhp1nR6jHZVb5Gty
	Pnrch+Kd0/YA1PVz5+D+xDWH1NYS8vp3UMRc6MiCgoZg1poaQDxK6k47DUTdlcYtWusLDzDZPMJ
	vhH8QxWD8j1Fg2VQjhJGmoo1g/NfjNT6fDFEWLsM762HWUlCmPM1Z8g3KDQmszu3Gjf98sOZKN+
	FBw+QN07P3RWDoMlzYUE1kZs5ACj5Tl6OSPCAjOPvDzryDhZrE8ypFGN37Ipi8MmO8XhyAsbIIu
	WrDGMx4g8mHMX7G3B82GKWrAP8Vmyx5ObPD7YdzSxaa18OO3cUVRDhAjszcvVwg503NjpSZOhxc
	PvibVoIVq9iuVFrXN+FJyQ4mNdxKFsFdriuTkuy3dWLlNdDWWED0UCdZCpx5tzl0COWOZpGwg0v
	Zo=
X-Received: by 2002:a05:6000:250c:b0:439:cbcb:5723 with SMTP id ffacd0b85a97d-43a04dc083emr24515986f8f.42.1773669875968;
        Mon, 16 Mar 2026 07:04:35 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm20698725f8f.0.2026.03.16.07.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:04:35 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 16 Mar 2026 15:03:33 +0100
Subject: [PATCH v3 5/7] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and
 power infrastructure
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-orangepi-sd-card-uhs-v3-5-aefd3b7832df@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>
X-Mailer: b4 0.14.2

Add Spacemit P1 PMIC configuration and board power infrastructure for
voltage regulation support.

- Add board power regulators (12V input, 4V rail)
- Enable I2C8 for PMIC communication
- Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
- Set up regulator constraints for SD card operation

Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 ++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..f1533c99881dbf38e16cff5e91e33253cfa7a56d 100644
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


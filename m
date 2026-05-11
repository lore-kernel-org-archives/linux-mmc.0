Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98663D332A
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489684; cv=none; b=MdwuS3mbeGpBzWiEnJfo/TOIIypYP/VdhLYQWmN1iJO1G6ZoapJ5tYRoZG5qjtFe0gMaYvBLjxFbFxAj1SyxBiGpAbQc6Ir5vMlvXYDZYQda3vWIpA9vDfzNt3FwR0ZyrhbKFKZNzMZxRs0Nb3Oem6cqJQcLV3/C2wsakAWwwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489684; c=relaxed/simple;
	bh=qWfPi3P6okakNMl35wSrQSu4TCMbhk88UU7A4K+g+ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H84VCcsqw98kFnh6q71VEgaQxWkWLl82ODl0Db3QdW56wKsIwZ6yfuDNmVE9gc6zAW+kgQq68boS7HhhSuiKFc88SITv5DUQbbmKrliEgEB9nY/KC/R4Q1W/PBPWvuqI4yKBp2S1Co6Q7lA0l0fEzaXYdFvwnw6tvEWWO4kV2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jE8WCAEQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE8WCAEQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2146486f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489681; x=1779094481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4H6GewK9XOsCgFQsCNGKQNCNtvjUJJHPrHSaFKR1jE=;
        b=jE8WCAEQE66Suo1iloriX1rSTwmUMx06NqKSiaVkP6Gc6YAJ6uS+FOBTuaZOTEMpIM
         HtFbYbD6FuBR4xPVqumo+fdOHAXQxR+LQhxr9hqC6yxWvnkQ1S00pbCqM2jnbNoYgnL1
         9Jk3x+715mHUh2s9EdBVY9oujPuBAGuQxu2Dj/V/nEiehHeLpL9b4I7ciiMZbRtyB7SE
         qnxw0uwxNw1u7Khz0jiDPdqDyxxJLK3C35Yaf8sbF4PiknY+Ot330dMH8z+THbFFAvLc
         0sesyBnwKfzb4yVCPhDdxBIMG8rayAoP92UpA2PEuLYb7NeFgd7QX1dhy9Hgaj7BtWTx
         Ih/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489681; x=1779094481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f4H6GewK9XOsCgFQsCNGKQNCNtvjUJJHPrHSaFKR1jE=;
        b=FTjoCbf3RAYV0nQtYT5jGilWdMP4aDvzucGvJuNytANWXtDPF2+2um0x8Rhz9a3Qoq
         0ar9hv1oFivNiwLHJxHnDuEg2FO0/3V/Ad9GpcQ+EtqWFgghT1PDi1ohcbmLkCBv3xb3
         JHuak+AdZdXbvk4zeWUR7QepCEiw51yQSXvGmMLbcoeUa42USf8b3BB6Bf+ctaYvHZla
         +Pn+KWZPDFn3nh3S17g1zr/Q7m4eIyoI645xggIZ8bGS+PeQiy97CUSEH2L/mOUxN+b8
         7QCcLClpTj8pujcXlMn5IMKUNFtZTTDiiaO8DxzRLSfy6AVemlKB53PcsIVeUUV5LkMO
         1jJw==
X-Forwarded-Encrypted: i=1; AFNElJ+/uKL1bp1TDpwDTU944ENx0RJ1/GKYZsjzFrEz0VLc/fHnLEWonhoWDlGccQrYm+IINW7H5mWdeD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtX+7iqB4VyKW5Y4INJbiBLB3wPSQjJyNa1Wf3V/sexBhwfrH
	Rz3kSgPyRivIxytd7vIHg42g4Z8yyYH8rl8zUmTz0otThQxmihfv1a6W
X-Gm-Gg: Acq92OG/FIax941GSaPls3ghbWwbfnpD31bXyURtzeCaz3HKl0hEeaxxAPfM/zuqGOn
	H9R/f3trD1L9gzxGFnlC43/SqIaMtmfJQ/XhIq+v1aFEKscSWtmKHc7IyE02AT8hmkv9m/dtIjZ
	wRJJnDFzNNO/xlurDzvwL4mjCB/U9wvHaPJmnpvFRrGuMKrnPs/IMyHEd2RuBvbgt+jrdUHFc2Z
	tvHD/X6wVtX9omKDKSLqsCVKBiB4A3lUz2A+ft6XQEboAIdKcHwM2mB0jz9TXUUL5l24UrQqWPE
	Fqrv8OSrTMeJTvOY6j+bksqDxtvZk6boA04RilSy+14KcvhVF+radewJVsElseIEs9Jx8dV2TES
	P1F5dAutE6FCeKvndKDz17PmULdBAN6hg1odT7a6ZphfO/7/hvvB5m/QfN8YU691XkfPE+Qg/eC
	+l1v0svvWvpTdgxOtn254yjgyrFIZL+/IOdsWg0wSxDiYQutD6qVO7ssXNHBe6SdpP6w==
X-Received: by 2002:a05:6000:22c4:b0:44f:d9da:2c40 with SMTP id ffacd0b85a97d-4515cf125d1mr36512294f8f.21.1778489680789;
        Mon, 11 May 2026 01:54:40 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.237.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm24944189f8f.30.2026.05.11.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:40 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 11 May 2026 10:54:03 +0200
Subject: [PATCH v9 8/8] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-orangepi-sd-card-uhs-v9-8-ae48c0b2b2cf@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.3

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
index 29e333b670cf..774a4640f065 100644
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
2.54.0


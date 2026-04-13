Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A43932CE
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065224; cv=none; b=JRmgQPZKHF+YGolLo44IRbm9hwEPYLDockTuBjX6mGYlcfGcmCjjUCr31FGlo2UTn4w+Blg3b2t4w1cMf8UswN3vGA765L+eAqJAuw7Ffu6BZ5VV/hP4LKQjedAudveAxF9S8pBo89Bl7AkvZg3BGu60MRMlyYGKIYsdRsJjA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065224; c=relaxed/simple;
	bh=hxs3OSpNzHQmcxvHvXpddESvsaNDoOgB9L1Rmxo+7a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqSXDXOyMbrKRtTegwteewFyk3YshHnfCPyfe1MHiY8p+RQJCHq14xlp7uabbuZR4CpYI0PI7rZJagspg5vXfAuxM9Aac6gzRVdzPsYixLsPuc2mbb5oX1UWIf1a7mn97wM1I5nKOkE0MGDd668/WDSjRLRbUPh5wCjw4ktbVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyEHqKsl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyEHqKsl"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f6092eso444009f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 00:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776065221; x=1776670021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPuO322us0uZuJ4hizKSGfFjcUXHsAzG0IoitERG8vY=;
        b=NyEHqKslNLLhVcx+gy2sAoLollD9YPZSmuzL0+RZnVohFa8DlwfcQMzZgvGXQwQwWY
         XK/9nilXihdRgXu25oAztg2HPLDHGS3mg+XupcgpqZiknn80NGLA8Ta7HcLDEvsALhAe
         75ionI8wqQglnqiKsqPm+kq+bi800KaBgDk74QH832LmAWjX0YToBCXZaoK54Y/3dWzP
         W02K9sMunrIkPxBGupW2iJQ94D1gzTlLmS6N4GJ3NLEq4t+unkqcEhLxtnxkl/MiFoev
         X33swvYbMKDNbqiYqhvB75wq5QXFAXuLkgHFXAxLt7lx7KLEeDfqS2nFC6MxM7dbC4H/
         EAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065221; x=1776670021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPuO322us0uZuJ4hizKSGfFjcUXHsAzG0IoitERG8vY=;
        b=pJ449+AKd+iZyTliN4hn7s4QLTMXnLWtpKxAhM+QZtMnVQwANbWJ6ElcYi74RSlae/
         NK7ahrg8suFmwDEAiOeWnwgYWX/ajD5rl7IyY4y1hi+851zM4qhMa7/hDDlbhG8n7a1L
         omj8cJZUmI+BJ/f6BKEHNTQ7AzOyX0H6wMxaqvvjvoWfMQMKVDypukQRhqCnEFElVES6
         HWcwmznGQmPIvybE3KF0/miZF40lFR7XfvNB+gggDqjEacbNA2mVekXJP7W3rzJWWaYn
         czZ7UrZHw4C7R2b3DM3TL2WLQiQbkOeWobFJMb/L2E3nzlqU5oi3bxQ5sQvZS8L6fVaX
         X0+w==
X-Forwarded-Encrypted: i=1; AFNElJ8M+DkzbuSpb8mb/gFsD0O2NR1M7aIKhtEpO4t0zDbklarUxhV0gLqRqOXizpIjiS90PIQ0ZAfmCAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUGaFZpHyFnv6hm26iFb5bAC5EJ0bDscbrbPB0BxQ+abEUscXM
	mhBRKBlfZRDPT+CxcZEzLKYVk03UbsCxPcbHBytLbeXn5UxFaPRqP1aj
X-Gm-Gg: AeBDietfGKHmzKHHgXKAv8IzBkJuwgI9UnI+pIvdvrmWLe7C7F+M7a5chGuGMjMAKGQ
	2kjtRPIuyankiiDMQMAdrEkDZwUgFm7ziQI56EdP0WhtRhlR4okvr+Mng8b9qUaydr8Wod29NVe
	1dE3WELWau57bvL8OtVQTUR1FzUl+wrTj0bL2xleKK9GS6I4quav6O+dyyttLyStlv/CrTdetzo
	ihUPwmfiLGAGNpbI2wWarapn+TfG693aANQZfWZv7LFgj+8ZJX8wtHa35icfDjeSCgLM2VjDd8y
	wJbLh5YD+PnPTGR/Oa44KwdoNToR6ri3c+llBkKDLtFlHBfOEEOTHGyxnl6tGes0BoVo6fA9B6V
	kdUCaGvG621UdauNaH05VNEseCjPJX9hjdblda4wEE+vfZnd9DjNxtNUcFQhIix/Qv3CjROT9dS
	oz0QCgMBZNYnVFZOA9HwyUUWNLiwWTo6rI4JsRpdx1vRvghY67mISNJzylKYkanN4R
X-Received: by 2002:a05:6000:3109:b0:43d:1c21:eb14 with SMTP id ffacd0b85a97d-43d6429bcbbmr18388161f8f.21.1776065221249;
        Mon, 13 Apr 2026 00:27:01 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d73b44b3esm13045692f8f.13.2026.04.13.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:27:00 -0700 (PDT)
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
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v7 9/9] riscv: dts: spacemit: k1-musepi-pro: add SD card support with UHS modes
Date: Mon, 13 Apr 2026 09:24:51 +0200
Message-ID: <20260413-orangepi-sd-card-uhs-v7-9-16650f49c022@gmail.com>
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
2.53.0


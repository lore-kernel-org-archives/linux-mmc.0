Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDF392C25
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065207; cv=none; b=ZYSnx7wGU7jAmV3mr7Chd2ZAgEenm6EJXKZ9bYqu3Jv6A9H5UsTsUqDrX+QlNLp9H4nxRI2NQZL/ChgWX46jbp74rJ2ZS1ZNDQWhk7l3N1g7YLTzBqW6ESAvhbUydpsOdzoySsmUPIhjbolBytNL0lepO0HzMevmMshZ02PFsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065207; c=relaxed/simple;
	bh=1HbIW6/OtwG0nzFhm8AN7DBXkGaNxAyxn8jiZchQifc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQHefG8rpR69ygO+/XM9UhlYL+r0D1lTjtpuxAFgE+Y7n0oatAeYD5kdtvGgy5/VRmxNWgEnabhQ1iIWbe1vMAjA2n5010E8WIa332HZSpy3U/ASrPY5gpAKkDgCFWgD4zrCywKiM65zynU1oUF+6J0myB/nUmKviMIYe4Ibfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4Uem63c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4Uem63c"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso49954355e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776065203; x=1776670003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgUUdQtr/fVKD3Ff4J9UbF4I4wxaToLEFfaMYOrzMgY=;
        b=l4Uem63cxpZXFh7drjEKIzpx5hPVVTJSeLb7DdQs3E0OMPl3PuZVvJG9yrlQUH7fCL
         nF440n+yKZndVgayHykkLg4Gkthz3twEDv4p0+6EKfoz9ivc/VhSvrbz3CsTPPN4CzeW
         GDpxRciJ5vxVfnTNhkmep3Aeqt0ErqnZkh2yym5mPvv9E+zksWz+g4DjXl8Vvpb3OKok
         W6ljZWhhJlrahoKobNAUHxFqrUV4EiFKeiyXgSmkfiw03n7ZQmkV/BeOr2q2uh6/4EMJ
         0P3iEgx7K7yHuGOXFKwN/xhAT/E6VdnuksBN98dygRNmaqobLPSNvaM+3dj2cN7bPh82
         91uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065203; x=1776670003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgUUdQtr/fVKD3Ff4J9UbF4I4wxaToLEFfaMYOrzMgY=;
        b=gNpF1ugUcjyP4veJIe/kQbQJti3QDMGHfoU5H6n10MTrXZJVzdYVfkK6gQcLz9+J24
         d0TUIQdVV2XhbmmDLVN6ZrXyJ3GDaxnAfrr4ECR41k3dy+Q1eVd7qNH9mxvbgZ4A8WWZ
         wGlmronMyIrJygmojLPFJEp9c8leJqCdkS9GvG0Hd9MWfaPoz+yE9zvjTgnkmILRiDNy
         siFKOGF3U47fVaSWb7qopBu2jxljl4xwnmpht30VQ4FXJ8gtY9F6EIghCgJ3TrSiY+YL
         T4u2FrEka7hcLxNTOK8nCl4DuWTh0e0sUkajOUBIjtcwL1dafBMzUp9HRbAajz7x+gX9
         ouug==
X-Forwarded-Encrypted: i=1; AFNElJ8b22Z7tGy6UBa0l9ANUESZLgOoJUA/dADeSjJSeN9RHIkXZ1rjmIKeAciDFkINyaXL7r3VA5HOrRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAPSLjVFjBk6wNdmyyl4ektabe+vYYMVL/cr8v+ks+NI+VCFe
	zIwwO3S15nRY5WmWkJqNYmrz99VZk75qVtaxrnPd2TuaxhpGJa0xlopY
X-Gm-Gg: AeBDieug/w1+KE9mR+NAO7kXRbeAWrC3xBht6eUfO0pnR//C09XJM0HxetEPXkKVSKX
	nyROKFoF4Gl5Wc8qUQwEZREIe6BCFD69ryHt+Bbc6tXv11Eais397L4l6ThRk+UVTjSn8vJo1Qu
	mu1FIJuBpPDJppUZBu7whY0wWhmbpebMvg/xOVwW6NJ6Z4auugzWX1jdbRi2AqgyVmtdlj8XUg7
	7mDA467WxfGt1e1JZNjcJG3BO1fgM8Y/W6vIXW4MZ9cXzGVuHyNNHZI4L5KyCQR6GWdVRbPFXSg
	j+P4iC2EabihqvgiXY7kiciPQGrwrXXcL0xugb+PT2Fr+6LRt6oXK+s0bLklv+y4BKR1r8JIoyM
	El2NNIe1Qdgt9z9gXfJq+KwQxn454PM3TGzqXaioGlerGDB5Ba7Vwt1KZ95qqBuiMI65IoHOFfE
	XQWB6DHetTS5IY63fIWQHbN45HJQloRRd07WZ/tZUijI4oV6XkVornpRfvFgV8xxYl
X-Received: by 2002:a05:600c:609a:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-488d68a10d7mr175221425e9.31.1776065203465;
        Mon, 13 Apr 2026 00:26:43 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488e4d0ed99sm85734235e9.12.2026.04.13.00.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:26:43 -0700 (PDT)
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
Subject: [PATCH v7 7/9] riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
Date: Mon, 13 Apr 2026 09:24:49 +0200
Message-ID: <20260413-orangepi-sd-card-uhs-v7-7-16650f49c022@gmail.com>
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

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with inversion
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Tested-by: Vincent Legoll <legoll@online.fr>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index 9c417a483f6b..95cfb4681ced 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -140,3 +140,22 @@ aldo1: aldo1 {
 		};
 	};
 };
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


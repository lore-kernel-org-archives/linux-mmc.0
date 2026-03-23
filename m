Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42A38F255
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261185; cv=none; b=uFv9X1Ni5xOHCQk2DI4QozBqLcfVRZSV9rYGP4F9diRyQPC9tVTZ1Xc9tk8zThiFNxq54Q1ud/ru21rE50CO5gqr9OuakNN8RghD8AwocGsFQMp9SRriGJJiZoSAfslNZZOzWrjKwGEZmYOF73LE2JQ11vu1wWFseSCFPPX4A0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261185; c=relaxed/simple;
	bh=9/EPlwM6vznVUXBNNDHgVNiJdTMefP764Y35mcPkq4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oPOG2rauj+mIfsBTj/NdNubXTSsKZ08a1w6viTTQ97PP0h+Mamdr4tOOlhWR29fALcePwJWV/FFiXzDyMNXeftF/oXChCqkomcyw0D2i/q/DFUEV/7nnju5S1ZzNYF5os7UhgU1MmWbqJqyldOz2jCFy7nvqGpbvJ4PHx6bpG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0gkhf4X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0gkhf4X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fda2a389so21390265e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 03:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261183; x=1774865983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Zbg7NdVFVfV/LiASAwN6OwVtEgN5JVFcgTwCKtL1AE=;
        b=S0gkhf4Xl0vbIDjVI6H3W4Df+X0NEwD7U5XNgwReSB0xdV0CxlYab7SgeflPWou1Nd
         HoQWL9YGuknK92aIwbc28ujIIz0G6t/pfGLo4fwSsq5dyx+WkbcMrVkYTqN64Uq7PIA0
         I1Z9oYD/WoOil9mWZwNUI6Mvi8TWfKOqwNf0VBxgmo4OUDzfTMCFRV3ZOb+ZGXuJ1Aqh
         AnqC/txJxfn/Ys04zJUMXa0SbVcPWxoyhP6SqfqGQIfDB2jd+OtdSZUGNn0W8CSJH0wk
         BKmrZB+zTfHaAkOGMNiYuYuigCQI4FQIeIxbPz4xD4g2hEfgR9L8qEJHAytiLDd4iLC/
         LhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261183; x=1774865983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Zbg7NdVFVfV/LiASAwN6OwVtEgN5JVFcgTwCKtL1AE=;
        b=Dv9kEezg8uL/7oNAzLzLc8tKRWHLqtW0hW1JfEhVtREcrSDq6jiTBQOZlDeyh2OH+w
         yiR1EgC+Z3sG2tYLLpcxlvkWphdCWRlANtdVI8JcCcVfBwa/voJt4Z7EnWY/Nnqqaela
         7I3Z7XOTDQ+SaIj9RXadowkDSPJT7enWZlG8XFZmizKv0aNunr0vqnwQnaxFosqDjPfA
         qWog4f4xfKXmrOeIeGYj0wsRjdAJpnU8WPzYx0o/7Sqjy340c8uVLH6LLTHpAqqHqvFx
         xU3QgxTdF6GoA22CvPUdhbPKs++ydQOLYSElomrw1ZaPaZLQct1v4YZKtAufgXEpvt3A
         RZFw==
X-Forwarded-Encrypted: i=1; AJvYcCUGoGdni2GbCfRIpCtbz9Ips1Zb9Xoz8hZ3SmwOC3w7tD0eqZtjpZjPJLiuGVPV8DRyH5jEAk8T3yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq7cz0DwPbPPhLkGRAorbmzPS/L7YqdVUKzPQ1fPPxt+xYvoaT
	Cba2lByDiuQ2nqq7MxMj7AKXpwcObFeYxGoqoI+C+TXFjXWWMQ8Qbb+Q
X-Gm-Gg: ATEYQzzFqUz4ZlfgsGd3GinsQic2S5QymDvzCD6v8eJ4Njcg0lGLK1VSH3AQWINzeZQ
	CeDkXl2xOHDotagURXmb4UQn/SvFz1EXcMHJ2+8ymcYM03hujZSLpbj6YPCFRigTQJq0SLvW7/H
	VZfK+/WYrwkuunnVTQhLHUaN35EIuxspevmdEkzTAH35NIIVOisKZsNc7jBwWe2IVRah9reJ06O
	8Xq89gIodDJFt98wT6FKjJOumEEalUnhfN4Uv7WLlzJ21aAL9191NUDIzXnXvTUnpr1k3AhPuSl
	AXYcLuWKwYi4cCYzYp+/x00CGUs86gg69XGb8L+I1u3T5YO6ozzn91hsfUcTs2nG6bK0xk4CNkw
	kkKI3SyqSLQwwsbi7BcFzOWPszfL+3YmZHwmATwec4IFpPjGhugbiY5XPnKMy7g152Ht7t5ree9
	39LgKUPYZ7hoGaOhwqa7fQkAZhqXK0jdddFqZi36FkQZw9TM8F3HVhdsgq150o3OOU
X-Received: by 2002:a05:600c:45c7:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-486fede721amr149755185e9.5.1774261182461;
        Mon, 23 Mar 2026 03:19:42 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe86acb0sm78755445e9.6.2026.03.23.03.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:19:41 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 23 Mar 2026 11:19:10 +0100
Subject: [PATCH v4 7/8] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-orangepi-sd-card-uhs-v4-7-567c9775fd0e@gmail.com>
References: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
In-Reply-To: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
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

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with inversion
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 404b69c47b91f8c37d74a3031dbad0d94a28d1b4..6d042f905d233bde2e29d1366bd177b41915ce4b 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -222,7 +222,7 @@ buck3_1v8: buck3 {
 				regulator-always-on;
 			};
 
-			buck4 {
+			buck4: buck4 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <5000>;
@@ -243,7 +243,7 @@ buck6 {
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -369,3 +369,23 @@ hub_3_0: hub@2 {
 		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	broken-cd;
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


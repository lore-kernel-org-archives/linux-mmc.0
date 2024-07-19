Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456C6FBF;
	Fri, 19 Jul 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378852; cv=none; b=KfAgtl+OlJF0EYPKv53J4mfY1uLx1XgycGsEPZydvFX5jPE6IxUAm2hXmf27tmCXP6Sky9x4wzdAwO1EgOB+JLF+KvUs5FO/Iy2cErRYzm8Z+8Yw9a+x/Fqwg5MNS0lZghB2iSNA8scUxcKSLAjHam59FyuEzB2AuieMiYJ4C4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378852; c=relaxed/simple;
	bh=ur96rq80GCqWEEGPOe07D5I6M8/jJEAz8vJsv+ZU/1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e79eRrLK3U3kqOSGZ6mXjKwW3sFvtZUUE+z6gU9T0y8dqQz5/11P0hm6rVBAXB+8fyT+cUHGEIGGJbYpIoC8zsYISHffjCAaL0aOTVgkqz0LZsUILmGCOK6grcQiAQAl5kOo0EoIsWnP9KwxiT1pk9NByb9eg+uLKwKmM7cTj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ4m2sUw; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ4m2sUw"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d9400a1ad9so970676b6e.1;
        Fri, 19 Jul 2024 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378850; x=1721983650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8010fnFp4bSW28SSmXx92MpzvQhq7D5Mg6hXVKiJ92g=;
        b=hQ4m2sUwr5DB7ceBJ0BbAjNc56CwkUBVvIIirHnS2Cm6ZEa75MHX/h+PXiOP63iwn+
         KtkA4UivsYX2euTRcWU7DLqKzUOkY+J298Cb3lIQP9pydO+4wS9ojY9A1cCjXsUBkok1
         +EtzTatNhpy4aXwoANp7pMS4kc9W8U/E6R3p9pjluIqQgJjDl/4scW/Y10Vpv7db4z6p
         O3g+7kgQ1PsKKVwFfkyyS2Epds+F/8ww9Fbl8QJk44dcBBf/4R3EnWrd3nlMaHAfbncc
         MsRXJNgfXgTWWQmw3W7dw9Htp9rCrROP6DDV9yvR8eliec8f4DeGy38L2TmixEIiARg1
         HJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378850; x=1721983650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8010fnFp4bSW28SSmXx92MpzvQhq7D5Mg6hXVKiJ92g=;
        b=dOdRqBWv7NJFTPquqoqDALjECRQah+BIn+NkCYoV6A9RZi6uz+6jMn28xzXyvC8+3L
         3uBzIdZPIixPHmNjusHTxnKQNoDecJRdHyyMw22Mij2n+7oslgmsnbGAhDX0RgK/h1Tk
         mLo2Q1P7yFH6TNfXmYK8kH0+0f8TskFMAVGl61kfyv6nhp8Kfwc4LqJS0bl+Z4DlaxlP
         i0WPuLWdEIATYKBgT9iQk+sh/a2ytP3LmgSNVjf4CwCVj2a7TQ5qGULWSMkMVUQWIXth
         D6a+Xd09aP2/IBKWbwYvxH/qiow3dzx0SQTqaHFvZCrDZgGd97aWuvdQf8dPdq4cZ5IP
         AoZg==
X-Forwarded-Encrypted: i=1; AJvYcCWk3Zz1JsKMlYiGzQ8SLre6s3a+6j69EeE0oK4LDUskfl52+mPC5goHpSLy3R1C+/NH1OxkfCng/MxH+Y5fHC/o8xDl6wxZRpr1XjjE30NWKB1ZwLfP1JAEYDwqR5kzQuSwsR7VVk0qbm9K7TrZUIXICcbVQHaiyOLJOPYUvpVC2C+r8g==
X-Gm-Message-State: AOJu0Yywk4AWgnB/mV5uRMow8LN7pKEJth/6IsxfzNRzNdkrkVDiBvGQ
	ikuyq1t2PoWygd5+RZd4GLVLXjghpy9mUYcXShmXV/jBEm5Bf4zgaeERhwOxxZw=
X-Google-Smtp-Source: AGHT+IEcrcICdMO2BQR9SZdf8B1sqIfILWJsv2xAN22U15n04nucXVZlzWKnOPIkj7CAFhyibZvnWA==
X-Received: by 2002:a05:6808:14cc:b0:3da:bc74:e9c6 with SMTP id 5614622812f47-3dad5271b67mr8796899b6e.37.1721378849865;
        Fri, 19 Jul 2024 01:47:29 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae09d5fa7sm209479b6e.48.2024.07.19.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:47:29 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 8/8] riscv: sophgo: dts: add mmc controllers for SG2042 SoC
Date: Fri, 19 Jul 2024 16:47:22 +0800
Message-Id: <5110a64d513390c01daf3b4a6a6fc5560baf77a8.1721377374.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

SG2042 has two MMC controller, one for emmc, another for sd-card.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 17 +++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 28 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 49b4b9c2c101..164db23586e0 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -14,6 +14,23 @@ chosen {
 	};
 };
 
+&emmc {
+	bus-width = <4>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	wp-inverted;
+	status = "okay";
+};
+
+&sd {
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	wp-inverted;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 81fda312f988..e3194f147d13 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -346,5 +346,33 @@ uart0: serial@7040000000 {
 			resets = <&rstgen RST_UART0>;
 			status = "disabled";
 		};
+
+		emmc: mmc@704002a000 {
+			compatible = "sophgo,sg2042-dwcmshc";
+			reg = <0x70 0x4002a000 0x0 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <134 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkgen GATE_CLK_EMMC_100M>,
+				 <&clkgen GATE_CLK_AXI_EMMC>,
+				 <&clkgen GATE_CLK_100K_EMMC>;
+			clock-names = "core",
+				      "bus",
+				      "timer";
+			status = "disabled";
+		};
+
+		sd: mmc@704002b000 {
+			compatible = "sophgo,sg2042-dwcmshc";
+			reg = <0x70 0x4002b000 0x0 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkgen GATE_CLK_SD_100M>,
+				 <&clkgen GATE_CLK_AXI_SD>,
+				 <&clkgen GATE_CLK_100K_SD>;
+			clock-names = "core",
+				      "bus",
+				      "timer";
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1


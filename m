Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22281BF38;
	Tue, 18 Jun 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699972; cv=none; b=VZOanuChLmHO7HWKZvdK+sAY3rCrbTMg1I6b4ukTt5cwzemaFVi6Fjb4r9w+EXkzSU5+BLKzMJj67MMV+lK7MDrgWwNfIHg6rSMkQESDGHgYiTuSN4D53R9RKpp6hNz82lm7NA69qKPSo4MxrKJiePK5qU8kjYpJMmQTpqJ/qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699972; c=relaxed/simple;
	bh=WYq2OHBK0AdgEaVT9jkh0Es0lUwnAC4FuwB4yD1Lrnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/nsrS7OT60kuBMH/OB8rHJTtvFKm8Bowq31lX1qzN4f+dWR/O8819HVBqgSRveU3DZypktqfmuwvLr3ImFdFgO7ykK7QE7ERjWnxtO6m50zz6dpQ6FFKlblr6ZdVDpb8ppiq+y20Nehpebo+awSwXDkVbqldYkKsWI1PqjIL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPJk9Yyx; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPJk9Yyx"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f986b92acaso2973853a34.2;
        Tue, 18 Jun 2024 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718699970; x=1719304770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcoMCm+enNSGbUuJXoL2d96+fYWSHPTojOmLTIxiMc4=;
        b=PPJk9YyxdrgzyAPjoaudZS4nn30J56Yip3AZP7FPaPpJ3IZGpqxfzi5aWCNK/byuQI
         kaBzBxTH/TIyLtQiAnVgc8r0LTkAaGi6a70jt6anabW6AVmnY/Z7+KxQQeCrL5nlSx7B
         IwwQB9m8XNqX7zBT4O1miL/yToYXwFMtX3AKzq5mS1uS2sxZV/j0u7v4bNVtNOb5vwPW
         5O2pW7AnYaUpH358eO9YfZbJB4bYeJQoWYU9Bu4gBICFglkxnNwh9HDy0S5OdfXj7DOR
         qEIRsFQfluiAN64IAoKpjv/iebNVHbobvZ01k93DqaGboB92lzPwN6PuuAnHQMIMI890
         uOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699970; x=1719304770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcoMCm+enNSGbUuJXoL2d96+fYWSHPTojOmLTIxiMc4=;
        b=qtqxz4rVEZVvCa01wWRVFVbNtvo8tLJh3wbC/Itu0cZIvB2IXXHSbWt5h4M3zyWxqz
         XOfncTvQhWVwEJq0sEPly8ZCR2byY0eTPkQAhVSaD9YXG4hwXE9/nzUNaLoXDIySjYgX
         zoaOqFyNoAcIXWPrs/XcdG+6GFyctTBzzrpoTdZ5gnh5LvGnhCIGY0UqlU9Qym631wf2
         iknDETBsIDzXqaQ9Oa44G1hO4niefIl3cjXgUC6PHGhyMgx/RWPCQW9bu2+5GM/vSS1p
         HwGXm7/NcScNhjXq3uZWTvhqICsqt9wmcX6IEZhbeJLaeLjHY7iyAvVqr66qgSWnrzt7
         VbUw==
X-Forwarded-Encrypted: i=1; AJvYcCWNnkasyr37sjBu4Z9gzfoKOvS8TLzxCJJihv2vkhl2aOpFGzJSIr+5wCRWb/ZRqwCMXhz9KMw21U1IJPdDLshtQKvI3gm7+veLY9zEIB0mGxDom2CNFyTKVP9i3JbIuWCb0SlJxajZByhWga6MNJZtUuR2RRBVIwiAh/yEVD/kM7EhuA==
X-Gm-Message-State: AOJu0YxG8mo6WPIYVxL66ivhTG2rlA7VuCBL/hx8+F4VLjeoaKUQ21KN
	EqPO8MQp8Rc768NsL0Kco1cChdbuGhUw45492HYYBQsARU5rewC6
X-Google-Smtp-Source: AGHT+IFcy1nbT2issyZB1cEgm/lfGKAVteBPOb6Fg8eo1DnNX6U9jgGHQwHqqALGVpgz4hatJydTPA==
X-Received: by 2002:a05:6830:43a9:b0:6f9:90ba:6646 with SMTP id 46e09a7af769-6fb939f328bmr15303711a34.26.1718699969712;
        Tue, 18 Jun 2024 01:39:29 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b75563csm1770804a34.66.2024.06.18.01.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:39:28 -0700 (PDT)
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
Subject: [PATCH v4 4/4] riscv: dts: add mmc controllers for Sophgo SG2042 SoC
Date: Tue, 18 Jun 2024 16:39:20 +0800
Message-Id: <e2d3b19e06fa29116b8032addc70c8dc1ec3866e.1718697954.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718697954.git.unicorn_wang@outlook.com>
References: <cover.1718697954.git.unicorn_wang@outlook.com>
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
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 17 ++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 32 +++++++++++++++++++
 2 files changed, 49 insertions(+)

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
index 81fda312f988..bfdfd6f32912 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -346,5 +346,37 @@ uart0: serial@7040000000 {
 			resets = <&rstgen RST_UART0>;
 			status = "disabled";
 		};
+
+		emmc: mmc@704002a000 {
+			compatible = "sophgo,sg2042-dwcmshc";
+			reg = <0x70 0x4002A000 0x0 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <134 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =
+				<&clkgen GATE_CLK_AXI_EMMC>,
+				<&clkgen GATE_CLK_100K_EMMC>,
+				<&clkgen GATE_CLK_EMMC_100M>;
+			clock-names =
+				"core",
+				"timer",
+				"card";
+			status = "disabled";
+		};
+
+		sd: mmc@704002b000 {
+			compatible = "sophgo,sg2042-dwcmshc";
+			reg = <0x70 0x4002B000 0x0 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =
+				<&clkgen GATE_CLK_AXI_SD>,
+				<&clkgen GATE_CLK_100K_SD>,
+				<&clkgen GATE_CLK_SD_100M>;
+			clock-names =
+				"core",
+				"timer",
+				"card";
+			status = "disabled";
+		};
 	};
 };
-- 
2.25.1


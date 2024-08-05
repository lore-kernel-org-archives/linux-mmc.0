Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA114F9D4;
	Mon,  5 Aug 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849593; cv=none; b=WeN7uRJYWKkVbuWnG62PIIpoG7GbF0rQLvIDZrtmGCdXq5vbr+w4TNO5Ez0sH0IbIGXqwCB9ZqR2T+Nufa05t2Y/c7Bbh79wtoMJRpd1/ESDQuTkh9n3axByYUrbA/z6cIZW+TL5CwKI6DtwRBSb0e2fTgPaQPmhWPCCKocOsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849593; c=relaxed/simple;
	bh=OcG6l4XKFmePQVwp6PRs5BvS9biFtJr4B9ey1kRGDJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hkXhaaTC055lYDjbp4167NXRtEoeO+eXoXRZW9xmze1qui+n7dI29KuIWK+z5A59ERDOmfyhkLmHfOr352ZHr0oIqWDnkGVFONg3BRVaknO0ApKdITOJBSzBmNm/VUAQHEFD9nT8dSBdJ0iEqSuhMpvml8LMwrvvX3ZLGzq/2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SssipjaT; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SssipjaT"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db23a6085aso2822304b6e.1;
        Mon, 05 Aug 2024 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849591; x=1723454391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTqIbxxugoDxIZS+wlCgd6QZms9qOuPLg9XDgZyFHpw=;
        b=SssipjaTpZrFOUr+LFu4fKqMFowycrrS71523oY8hu721SgiLmO+lUPc3Bb1QngE4I
         EQuAhX6zEHICvE1/T8X1IGBWO7cUSJlRq77xoICFcUV0yItFvZHW+eiEsgp9lVo5FnkU
         23RKLWB6o1R/Zgge9KUQd8TkcB94QK7Tnk75nSntcYl3zopKmg4FCOLcE2PQ+2kGHL2Y
         gPl9LKe0oBn6pS/t6/fXL0kOlvx9KOqSaLBZffs6Zf9KAxA1JsNgbeNNWGG6fhJIuGo+
         azvc9RvsrQSnX0Ny8eRUr2iJD+n1vyni/bZnTaNv5RVJPHxNelMtumJYJOawAXJiIjVj
         v7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849591; x=1723454391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTqIbxxugoDxIZS+wlCgd6QZms9qOuPLg9XDgZyFHpw=;
        b=C6Tl3+0XZBT7k2zitxoxrop9k07KYTsmdATc4kCH1xJ2lvY/8jdwWcQ7YXmzKzj+9x
         p2i8ftUcfEdzepC40rc44YLFeiwI8h05a9jdd/foVI34LwM01u8xUfjpatMwmAqIKhAi
         LvMoygkDSQkIP7h5AkR9ZDhlO07oDN6WFMzI/nmfps6EwSsNtkrSL2WLn4Y1kvce9Ltu
         ecJneDC2NWnnWvhRjnGYxkVBh/CXBF4DhXucsdaKFTN+FhuNq0ZGm34JtUgILRICoSGp
         orRBROSEtOjRRp1UDIo+ZGfW69SCBgyKDZrQYnlAZXTc8CUyVdVJ2HtjRonGOu7K8EJV
         vKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAqgoLeT8y8sze8vH7U1uKr1aKBTkPSNTRpOP0dDHrJmjGezja5IZN9lvPEIIpc0CqmQaHGi3arEQHUDAe+8sE7qsud93J4t0oj470YM6ujytErd9U+zJqqBNvjo/Mjz7QBimm238M/hwQltHeJ4PaZVgJJ6Rpi/8IPGuQEhak22ct0w==
X-Gm-Message-State: AOJu0YwicMTB6JDc8SR5EScVhWQuTTqZaedEZhGH9ArbkZAtitv4IjCO
	rvZ0c5YblbvDED6wF/b0fz/8L9/v1DlS30Cr0UD6YZIKUwmiFz7C
X-Google-Smtp-Source: AGHT+IGQn28apZPLjY/cEqCd5i6fKpWv0taDd9wpuFCfINNuy5KX2wH7As+1leEZiltafu5WJpLcAA==
X-Received: by 2002:a05:6808:f0a:b0:3d2:95f:da8c with SMTP id 5614622812f47-3db5381638dmr5222260b6e.18.1722849590714;
        Mon, 05 Aug 2024 02:19:50 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a31d9dd1asm2875838a34.9.2024.08.05.02.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:19:50 -0700 (PDT)
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
Subject: [PATCH v6 8/8] riscv: sophgo: dts: add mmc controllers for SG2042 SoC
Date: Mon,  5 Aug 2024 17:19:43 +0800
Message-Id: <03ac9ec9c23bbe4c3b30271e76537bdbe5638665.1722847198.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722847198.git.unicorn_wang@outlook.com>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
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
index 80cb017974d8..da6596e9192e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -26,6 +26,23 @@ &cgi_dpll1 {
 	clock-frequency = <25000000>;
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
index 34c802bd3f9b..f0ccefecc9c3 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -399,5 +399,33 @@ uart0: serial@7040000000 {
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


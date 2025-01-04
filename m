Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41081D2B11;
	Sat,  4 Jan 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009014; cv=none; b=Oj+KB+oT4dKgDL83Fl8BVtqn5isuZadNmujrOZe0kDgENo0HAkrGzL1/B7FAvZRjxJ77fTiVomZ5mdWTM4BZhr+2YHIcVw48EKSz4klRIjkqmuZRSXjCwcWSN9jvvUU8JbWKfT5W8lbkFMiq3BrX8/FIrDeEYIWuQMKl3ETx1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009014; c=relaxed/simple;
	bh=xz9TkS8fZcmJTgdNAmHnREeigZQ5G/rApRQFHj9HL8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG/uVqwjkwLu0Qk+okwryQh4U6BEaC89nyjwKASKW2VLUDejZHX41SHu0rItNy/vkovVVN7eQ09o6FH9r/OYbF0sJJWfvTpg8W5dJl4Ag+OzRw9GSLFdJGCGFQJnVc9RDIt7HVAuJnKwgFL9co3Ni2U4IAS+gMPm9o95prrTqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSkGTF2P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSkGTF2P"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso89616765e9.3;
        Sat, 04 Jan 2025 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736009011; x=1736613811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMcuEJIoEyeliFcoiN1rN1Xlq33F+vpylS/RXg2R5T8=;
        b=eSkGTF2PTS6HhZek3kH9pfVmSPafGH0bxTovKBesh7S/XoioRlwoz3xxf8AhyMNtYm
         YdxhpqSpkSsq91OQsFs9ouVda/G/7h82iJtE8rpzgeB6r8jeVmz0CPp2nOxD35jC3Evz
         qlDEzKFvw1idtyEldnyiiRIJGWd0n3klWd1cdGP4b8P17cTpF1O0Z410BZOTLVWV0nZo
         6meVlDjmrJK2C+TdWlqjXckK5HVmiX631tpnwszQL3dcMSYqUBlssGniaWlbJnUlYXh1
         1Brfhojwk79SvYl6cTlWnHxA8YTldRBWlTeshBKq75ZhADQsK6HE/5YBfxxW5Aq1ofts
         vPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736009011; x=1736613811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMcuEJIoEyeliFcoiN1rN1Xlq33F+vpylS/RXg2R5T8=;
        b=VAH730MeGTXQzX4KkIgFQMwPPm9JN487HlN+6QVjGFR8k18XcbhlKLUXeTglt9dccq
         HiedDszpeJ9PP6jqeoQdXxcpkr6UOFPV3QGPRGuOLpyEZSB9vPyS11Celwdn+tRXuwQl
         VH8+gC6CXoqBuVWMo1WY1anmi3c6Xipo/nnBU0wJk1hAk+8ZXgnP3KVn6fnfwF9GEAzG
         FbKo9SAvBr/GF2b+mhb0M9siZe47Vr3S0r6Ra8TxUedloPm8A5oGwXqYPbX4NpEbofx/
         a9JZkKuRVHek9vtL78YzZJR0RQXCZwlQZVzAavItlyjvbxJl3UL/LWY8ZvtJ2F7Wz0Gt
         AgOg==
X-Forwarded-Encrypted: i=1; AJvYcCVxyYVpjpxJaGPU00wUUFe21viV8LHjynfCLxyzCxSXUjz/zdfKj/5aBMzNg62i2u7tBZt6q12coAQncRyx@vger.kernel.org, AJvYcCWhRyIgGhAHHgPYPcshaUOhcZTBO8KgjATq69h/NlWsOTndTYQUK9QqBYm3BaGS55tGlYpFeFF6Arde@vger.kernel.org, AJvYcCXsyXcVmyOebrrGLTGaPcY8RPUv74vJdZIcrpkFvFe46DNzTZ92eeuOSTbsJzxe9Pno8LRHPOvqpNDefK61F10tlI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dNv8DOHgGlFZElo+uB+51cWkDy355L9Wh2zYYKVb8oJKeRCT
	z5aJB8PCWjCDOKmWcPZJQdKVhpehWKmIivM22r1mdB4WX4rT+wG2
X-Gm-Gg: ASbGnctkuGCDgRCw4hfGCWu88PefSdzrYokczN1U7lcPQcuGhdy2XkZ/hAYpY8zGMnl
	ORlBoYBjbpcOAi/RtW3mmppMcYDBn2hllL8uGIVheifzKsz5N3FwYk+ZQdRjTX9eXPv8ooR+Un0
	UT7hNcsTmq5mb+VzGPFyIlMaTP0Fpg1zmlNtHtGXKHbJimNc9k5JGlQmaNGZl6R1UwAPAJZWgmo
	6ixTjS8Rs7GdY0eUDqetXrCv5BRCsUOmD6G0Ll5yrh25w4+eNkwjOJWILSyWk+zxmkuoBc=
X-Google-Smtp-Source: AGHT+IFEd9TA8dblUcRj2G2e/O+u7WmpkbdkPiQNrDMG23a+47JqngNVM0VhHsKcr0jkNu1yUvtlHg==
X-Received: by 2002:a05:600c:3b23:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-43668b49950mr393455515e9.25.1736009011200;
        Sat, 04 Jan 2025 08:43:31 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm513321455e9.24.2025.01.04.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:43:30 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: dts: exynos8895: add a node for mmc
Date: Sat,  4 Jan 2025 18:43:19 +0200
Message-ID: <20250104164321.333669-5-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an MMC node in order to allow devices with that SoC to make use of
it. It's typically used as a secondary storage option for SD cards. In
the vendor kernels, it's labelled as mmc_2, but since there don't seem to
be any other blocks, treat it as the only MMC.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index eedbd1728..f92d2a8a2 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -1296,6 +1296,22 @@ pinctrl_fsys1: pinctrl@11430000 {
 			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		mmc: mmc@11500000 {
+			compatible = "samsung,exynos8895-dw-mshc-smu",
+				     "samsung,exynos7-dw-mshc-smu";
+			reg = <0x11500000 0x2000>;
+			assigned-clocks = <&cmu_top CLK_MOUT_CMU_FSYS1_MMC_CARD>;
+			assigned-clock-parents = <&cmu_top CLK_FOUT_SHARED4_PLL>;
+			clocks = <&cmu_fsys1 CLK_GOUT_FSYS1_MMC_CARD_I_ACLK>,
+				 <&cmu_fsys1 CLK_GOUT_FSYS1_MMC_CARD_SDCLKIN>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <64>;
+			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pinctrl_abox: pinctrl@13e60000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x13e60000 0x1000>;
-- 
2.43.0


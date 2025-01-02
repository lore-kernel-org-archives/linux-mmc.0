Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D11B85C2;
	Thu,  2 Jan 2025 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851549; cv=none; b=mPqL1mWrrnyIEvkbGF1I2DsJMqSf8LlTotRrv8FZSusQboL3E56PDz4NCNmlTtzvZggHJ/wxWpPka8glqT6DILust4Vj16kwj7mgQ0llz3Dwb4Ftz0UI+BVtGyh97i2dwcoTCBMfz97Qa6KgdnhWOQdywY/Z93H2BMKc+TGmlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851549; c=relaxed/simple;
	bh=5oBeA63bMtgvAF9jDfxcZaQhEOXDLSwpI3wleR10eTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTzbpAdjbfaYmQ0IWCcX8kAt2yujnm0drvzGDQlHAGE8LxoLZevu5gcxjQEVvnWgqJJNAYna6t1KqJjNkVC0RZywOsjhDUGwyLGGdWto6aXgO18khYIriUYOnVaSkxkwLER7EwJdw2I3kPdL2cn5cW4BrRh+Fja752RRyGj1kM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyLO9/nM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyLO9/nM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so23451700a12.2;
        Thu, 02 Jan 2025 12:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735851546; x=1736456346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud7PsJsut6RiZUie7gXQBvGk8UPj/heMFBlNIkw2jkE=;
        b=XyLO9/nMrLnGnR/s5U84FMYKd2zRqPUOwRyBlM8ZvroHrbS6dUiimN6Y2+ney6z0F/
         6RVNpZgQ/MaiF+YnruTsKEnvNxyFrovM+rkz2WEXEIvPCDGkQtXfXFpSibWYTpD+vyD6
         WcVZGizayrigrDtQdd3si+ESrks275gM+0ef8/rCVxTHWIzT2iDlC5u/MmUNRNEYifzp
         cKyhv2xHQzMOllgZ2KzmwumfgM+/88aV6uBh5X3kUhmD4p292wc/SMI44Nq+LFhEGIHF
         Rxv+OCFaDHft+E0mGdPaIZ8DhpkkbaVW8vlOhBKKbtxMhGyBzcy5eWds7rgj2DEKucOg
         L7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735851546; x=1736456346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud7PsJsut6RiZUie7gXQBvGk8UPj/heMFBlNIkw2jkE=;
        b=d3g2r4ytqOmTvQgf6qRpOdghsS0Z+9bK0Zmnftx4keqHiNXPLP3Bq08gkm6wQmFiik
         3cV7Yk7Tr+2csZ4jziS1mHo779I/RtNcauWq3A3A2vs3r+V1/oGZygQD4b/z/PDu0Jil
         kBp8IM1feQDndmkFzmoML5YyTj7zX/DXX6OiRB3KsmiLGUkDMHixVPHicySAyJQN64ml
         mZPjyLBq5u7DnO395xQGnGxP+OPEqXwmqWHCRZc1pAW0prPnJkx9dIl5vA8OxkWHFYxZ
         AR1BrauAwlKfMXj4Ln+mH5Ckpl/CBFDA2qvJZ5LeAgmYp1sQ1umeopbMjibDlvJcWpS9
         LPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdfBpBTKJFm/Qaiqq6beQUd74Ar/6dAvbz9owOm1E+EfQFqnhKEmj90n1XRrgeTEBqvldCIt6hJ4M+crc2@vger.kernel.org, AJvYcCX1ex+vwbj5WBnLvLUz/EgHb6HqAqX8ahjlVrxgqT4aCa/z3+jF7UZfUeRHwoGVne8bF3yqHVRkKcftkDNUEqgOyog=@vger.kernel.org, AJvYcCXtzKJxPgn0Pv1by/GtGdDgJqBXwYREMhYqzhJoJ5hDJfV4Xo8AYOI06ZTRh8awZhBBcv2/WH8+oFr0@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUM7zggMHqsfsviDNuCpPOgZfO4UXGAlo2RhS0eeHMwYH4v3L
	siEngdnfCRH1HK+lpDD3gt08YHv1Oabaut9rjGNlRbYK6vobU7r2
X-Gm-Gg: ASbGncvOjh7Wmp0blTUb97/NO4M/eO3CE2G+9PKRmQ1ZVpu5r+aysUatq12B8pZaCGr
	rNajAjPYPCOuuSQAf8qSISrujbYIx0vbKMLUjYJdo52ZIeujZV1ldTgAM6Mzz/1+HPouP20GVQw
	AK5OMf3TrqzehZrHLNbiO604Lu3hlOwdT/WigP38l2VRT/MGc02ZQ9zbVkTcDP/vW0vkYvrragE
	Wgi59bRjLjIbeDrbcXGb/9KKTm4zcE8skBWBUzY3rRyWKsAfjESMl9oA6DYgC4+Wgu6fy2DbUDq
	M2e0Lw+mLRQ=
X-Google-Smtp-Source: AGHT+IE4jMJcKrz5vfMV9R5af6veXwOvNy+Ggg5xTG8Bq48eb3GvnXf01/g7KbEfw7Z1ZhMWSK9TUA==
X-Received: by 2002:a05:6402:354b:b0:5d3:cfd0:8d3f with SMTP id 4fb4d7f45d1cf-5d81ddfd82bmr40759079a12.24.1735851546217;
        Thu, 02 Jan 2025 12:59:06 -0800 (PST)
Received: from ivaylo-T580.. (85-118-76-61.mtel.net. [85.118.76.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f397sm19231026a12.22.2025.01.02.12.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 12:59:05 -0800 (PST)
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
Subject: [PATCH v1 4/5] arm64: dts: exynos8895: add a node for mmc
Date: Thu,  2 Jan 2025 22:58:45 +0200
Message-ID: <20250102205846.223955-5-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
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
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index f5551832a..537d3eae0 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -1296,6 +1296,20 @@ pinctrl_fsys1: pinctrl@11430000 {
 			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		mmc: mmc@11500000 {
+			compatible = "samsung,exynos8895-dw-mshc-smu",
+				     "samsung,exynos7-dw-mshc-smu";
+			reg = <0x11500000 0x2000>;
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


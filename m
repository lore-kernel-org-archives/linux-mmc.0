Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDE15886C;
	Sun,  5 Jan 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093635; cv=none; b=QnV3s/e+3TF7cqZ/l2LI/BRcXNPINGctoR5kkeXlnWv36XMiY1S2wiCipQw5GlSwzt/HcPWlOJRUAKBbhsqiTzb1FfhU2ge7trCzTLLuB+zJI0hMx0j000pPrasc0+dxNQHvCg+a0scQc03fG1D/gJo67DPTsQL7CwmsYqlvDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093635; c=relaxed/simple;
	bh=mcpMOgTXufd6BmfbvFw4DDSbcLG53qyUtL75A+s6dz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnwxBXYwWpiNM1yz5csRKwWAVtsBrtpdCUErkt2UptsA+iuIhPfn4DxZb24k0oaQseU4DHWRuPExb1qOZ975KOoJ/DZoAmAz7te/tu5KeVhIccyAFV+E5iy2cpxzrdgUttyAYKmzsw2091vOHU7pVPUp8DvUmRFpAB1dhY4SdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB+WsMBQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB+WsMBQ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso10434798f8f.0;
        Sun, 05 Jan 2025 08:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736093631; x=1736698431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCu8j5qgaYDYPnaPdDgFFNsAqlm/hMgJljoqnUl2UNc=;
        b=VB+WsMBQaiYdjGLFfSY23O+84/H3z2yOb4u1Pfkfwq/3c/NCLvquxNeglsvbe61505
         Q2thbYcFJWdRDwW5ZLBPCY1dqccoxxvK9BashwgV02CBXM6dw9QAv7Y0TrFRZiIdmIYC
         zYbmwHetXf/1ELP4OrTbdgjf3nQBAjuoN1S7P4aeGKZw3GIJRTwey6kgqAV0TRf6CYkF
         v8+JVifLCnRzdoOIUK/N+0RakQlL13a45xJrBBaHVMKI6sEX2Nmk9Nw1rYjE230KY1F7
         el3T3AWHMEj7eb1Zb6Jy/PWdoFuSlwh7nFvn9qcPxYTDnRPTS+mkkZB/bzxVohIUNY9y
         shUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736093631; x=1736698431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCu8j5qgaYDYPnaPdDgFFNsAqlm/hMgJljoqnUl2UNc=;
        b=wpwdoBF2bY8H0AyiLfshFSWHSgZYUq537q7vdi+FrjS70DMlezakZ+/AfGyALsiw+m
         7H5NhOBtZo/jUNoQRBvROgpW8nAyiWgiWz4GGrTIjxHjHfuL8V/F6va0ijRjYcXKtCLO
         haJcEE2LPxGqvxQvzLxMZGDXcNx6ejXa47vOtR+Bhowr4/3ZFVHj8VPMqcZF1DvF36wn
         UVN4xGBwY6uef4DOWrEywA60verLSJ5szfgZozpQIGoXyortDgW6UgpvFWDxwfp6FccB
         jDeoH/Xmw3lrmbMd2NToKz2rrYKYeg138Nqr7srGlRpxBgXFu1NxTLclxXa8yu7CET8f
         QVIw==
X-Forwarded-Encrypted: i=1; AJvYcCURhJNeRGiqpdtwmVVgFWYJ70s+wbIgJ4PhyPERWkeFzz6+esBezqDqSLa1ftcTsfHY+4ycMrZr8gtg@vger.kernel.org, AJvYcCUTfokpkhDGe1Wl0CbJRJI4GvA4FEjynve/8fER6hwVaET4INDgbGmtPuIJT+g7IOTw1ELOaFPx0kCjRRx6zjrN4Mw=@vger.kernel.org, AJvYcCUvZnm6jNWOE7WgtayWM330rGApYonvB5xusoQdHjH/SRMmsUywks5/an0X83OG0wlvgO9MlC8vNGTvQiaL@vger.kernel.org
X-Gm-Message-State: AOJu0YzfaADKz71wwZqaLZWL7Jthy8f5FukEbp+y/ptgn7HmFSbqlzFk
	6rz0xCdpL7grrQSY7HOEOyGpn/ESvrIuWtO9106Bqo8z+e+N5X7L
X-Gm-Gg: ASbGncty2sfs0tLGND1vIJPUKWb1d5zufXnTIK1t2lenZrUbNevZ9NVMMIHDPGY1YoD
	6V5sAr91YGNXx1+bDDSSXXhGwEE6Rlp40TxebOSCDT9yKpe1rw7++PjZiGEcwAc77facIzx6B3O
	YnuuRiBxkxGOHOp/yacqzgItCdF9gZX0VNmYoVwE8IuHUYXI3WspIomBBOoZc9j7TAW2ae1/EZC
	0IXfK2cEO4Sqir8sw+HK0C3wb3aqQjGBNhS127JVu5JbvtDfstC4I3SzOsDgyjP8VKAZds=
X-Google-Smtp-Source: AGHT+IElWpw8jxQDyyiJxo1dY4VhDLw3/bf2P58k7qgXzAV2/4jbTT0bokTdMmSCUOaDdN+EYIHAEA==
X-Received: by 2002:a05:6000:4028:b0:385:ded5:86ee with SMTP id ffacd0b85a97d-38a224069b1mr47329933f8f.57.1736093631481;
        Sun, 05 Jan 2025 08:13:51 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4274csm578250565e9.38.2025.01.05.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:13:50 -0800 (PST)
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
Subject: [PATCH v3 2/6] arm64: dts: exynos8895: add syscon nodes for peric0/1 and fsys0/1
Date: Sun,  5 Jan 2025 18:13:40 +0200
Message-ID: <20250105161344.420749-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add syscon nodes for peric0/1, typically used for USI, and fsys0/1,
typically used for PCI.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index 4fb9be850..5302a8c1b 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -228,6 +228,12 @@ cmu_peric0: clock-controller@10400000 {
 				      "usi1", "usi2", "usi3";
 		};
 
+		syscon_peric0: syscon@10420000 {
+			compatible = "samsung,exynos8895-peric0-sysreg", "syscon";
+			reg = <0x10420000 0x2000>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK>;
+		};
+
 		serial_0: serial@10430000 {
 			compatible = "samsung,exynos8895-uart";
 			reg = <0x10430000 0x100>;
@@ -273,6 +279,12 @@ cmu_peric1: clock-controller@10800000 {
 				      "usi10", "usi11", "usi12", "usi13";
 		};
 
+		syscon_peric1: syscon@10820000 {
+			compatible = "samsung,exynos8895-peric1-sysreg", "syscon";
+			reg = <0x10820000 0x2000>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK>;
+		};
+
 		serial_1: serial@10830000 {
 			compatible = "samsung,exynos8895-uart";
 			reg = <0x10830000 0x100>;
@@ -380,6 +392,12 @@ cmu_fsys0: clock-controller@11000000 {
 				      "ufs", "usbdrd30";
 		};
 
+		syscon_fsys0: syscon@11020000 {
+			compatible = "samsung,exynos8895-fsys0-sysreg", "syscon";
+			reg = <0x11020000 0x2000>;
+			clocks = <&cmu_fsys0 CLK_GOUT_FSYS0_SYSREG_FSYS0_PCLK>;
+		};
+
 		pinctrl_fsys0: pinctrl@11050000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x11050000 0x1000>;
@@ -398,6 +416,12 @@ cmu_fsys1: clock-controller@11400000 {
 			clock-names = "oscclk", "bus", "pcie", "ufs", "mmc";
 		};
 
+		syscon_fsys1: syscon@11420000 {
+			compatible = "samsung,exynos8895-fsys1-sysreg", "syscon";
+			reg = <0x11420000 0x2000>;
+			clocks = <&cmu_fsys1 CLK_GOUT_FSYS1_SYSREG_FSYS1_PCLK>;
+		};
+
 		pinctrl_fsys1: pinctrl@11430000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x11430000 0x1000>;
-- 
2.43.0


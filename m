Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7E1CD215;
	Sat,  4 Jan 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009011; cv=none; b=ZLy3jn5y9+K7Qla5AviTnfIvrKR+AZt7LSdBOUDnbh0paexMc2+cLf19ZsqpB4z/Xt9qGYuCYlUnW3MO6qDt62tqVuPO5fML2dSEYzaLHXwKY0FnJZpkHI/OgPl58yaxbJyWuz4FLQgnVVErqCFNK+tRtLzzEljC8LvMHPWRBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009011; c=relaxed/simple;
	bh=mcpMOgTXufd6BmfbvFw4DDSbcLG53qyUtL75A+s6dz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa7OMWTyO0eWbRJPUNA5G0DBOg+yebBHGxq0bjuX6SGcr44hDXwZnNS3p1otCfOH61MQaUJbNuOYJ4sgDgq8R3DsgEAzzg00GZX+oAyyxDz9UWSaAinLWNPlgKP9dtLQfvpdArBJmxVVOQuo/YoFsCSXNf0eh24z7qBowvFf+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH1SHWO1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH1SHWO1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43675b1155bso120939045e9.2;
        Sat, 04 Jan 2025 08:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736009008; x=1736613808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCu8j5qgaYDYPnaPdDgFFNsAqlm/hMgJljoqnUl2UNc=;
        b=bH1SHWO1L7ZJ9CBuq7BHZlBl8PbEXl4MoTJCh+SiGnm4vg9q1jugLPRG6CL1aEGZYh
         1jTp9aLIdmPsnsu8XJ3/J9544qSoBPe5gzdhjmsGyUAv8DQ1C+C9wPaAQaUuSqVk+XEC
         Ls/lr/1Osyu4/BWmi+Qy42pBQtkVqPQskw6PaT6PNKB4UtH3m4woJOmhamS0Q8t3cOKA
         fvCporJYOK4LgD+t+8bfsLsMvS6X34+iPfIYzwFNJRdKMXlJygS1t3lx1UG0gV/9rl17
         Qy4jQ9oBY1+TPLV2JrwoPK9uu6BkkeU9m5JzAKtWnd5zqWZoI7HpshsHTePirLlla37E
         EaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736009008; x=1736613808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCu8j5qgaYDYPnaPdDgFFNsAqlm/hMgJljoqnUl2UNc=;
        b=wQxU3wntQH6VKiP81EPTYbBuJjYDYkOhbxHtHitijYODhAZ1xmfDz94eqlfG1C1Rdt
         tN5rReNCJRRlZNdcBdWzRjlfpwq1DY2i4PByKpVdS0NeSQ/sLclPoYNSFZK0H5j4dqek
         Jag6MZiPiRUwlNBmtUMmFJJFDRTu5aSejG3dfn15Eg4b6IeRcchJkjk3IgOddgW/R5oK
         SqxgFOg/1qBwm6/G148bL0IKzrvru3gdYa/OwsAzyaUvPumKhbPwBTDvnR8gXcZaoYDl
         lKv8zfswejG4Pj+25T0Ufzhl2NWAgDaQ8OpQEHGzj+U8C8MESEwvKOtFsMMzLP3s4R4j
         Fmmg==
X-Forwarded-Encrypted: i=1; AJvYcCUMr/pvgj1+NihOKLBDEKjF6iyWIcNYkXLylRDqRRpO5TF2CS4JujSWEzDq3CeQMHU407ZZgyoaouBU@vger.kernel.org, AJvYcCUmA8ixhk+qRG4EHxqzvRTG5aneJbTdka8UTasSkrAHiz2v/uMrDwr2pKJkwtNDPILbMcE6xoML2RZQRSJP3kzJ6dA=@vger.kernel.org, AJvYcCWnK/AQGcsVGfuoGqqA71eulvoJ8KP+wqkImOsc5jl7oj+slQ1ZYw/dDPkqBdBPMbP6lp7tf20NBcNBCTlY@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcP9ZB2I0AwxPmMXYHKw06XfGxH2ZkSEtj0Ooo2AhbJcf0quD
	L41/0z7SarNidEminiOxlABxZPoXITJWzTQHCdMdZEBdhUY3rKaC
X-Gm-Gg: ASbGncuirmi8B39OA2jzfxPES34mGzxFkwk25dGhva5pZNjcER9ks7dAdyu/O5UMaCi
	54Jg44bhO7VHuga/h8xpYA+fnTUJni4tCVpNO1YcxdZ0453pRRThUe12EPbd3DOJTFbBVfE6ca1
	iqMQw1NDTDP+IC6j7IyJ/UXv40CJItUrXL3onlgOdwvhavrbbjYY89oqrSCg4ipJhcOhd3W4S6c
	LcqmHXIukul2pIYVUNljN8vU7Mo16p5NqVUC6OQa0vadqk4mKC+cFNVX0UeIOv+2+L4LXE=
X-Google-Smtp-Source: AGHT+IFdsIXpWhtVBKBADkN2xim5hg9rIrv0ODPLKZhGU0lkrGOTgVqV2MCfi/6pnaxRSohjyT+i5Q==
X-Received: by 2002:a05:600c:468f:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-43668b785ddmr413028385e9.24.1736009007850;
        Sat, 04 Jan 2025 08:43:27 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm513321455e9.24.2025.01.04.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:43:27 -0800 (PST)
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
Subject: [PATCH v2 2/6] arm64: dts: exynos8895: add syscon nodes for peric0/1 and fsys0/1
Date: Sat,  4 Jan 2025 18:43:17 +0200
Message-ID: <20250104164321.333669-3-ivo.ivanov.ivanov1@gmail.com>
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


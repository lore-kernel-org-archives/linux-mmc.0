Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70712252906;
	Tue,  6 May 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523448; cv=none; b=IAYsmm+r+oBedWtOoU9plC/Z7mx4m04IzU5KtItipLi9AQ9iJ8KRABp9ZJXyegXlFzB4rOYK4LHafq7fQ4AbjZyimopIbx3L+Cmk/AU1efjoqI4JDQnFc+i7Glr0l8ojY1EPgzpjR6vd+BTPzkhJqVVIifq2/zMkMdWzaglkw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523448; c=relaxed/simple;
	bh=xtGjxpvg2s2+1GJS7uN6GHrJzJA+KGuj9U8MlOvZXZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMn7OOBe+swTaiq3SBMne1gBAcE6Wc9d9prHUYWKbJzdb7Ruda/uo87qDUQf79bY/qGvCqScRBEQRRm+oOSOZ3nrWE1L4YSCRC8hWHN9D97mBGkI9WvFhSJi01RNHO9j13kYVIHbu+SdnQwWuXqD+YNUVSBCk08GgqjxUqhJIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VfKoXC2K; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VfKoXC2K"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E418F252CB;
	Tue,  6 May 2025 11:24:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ei8oYB1H29V8; Tue,  6 May 2025 11:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1746523444; bh=xtGjxpvg2s2+1GJS7uN6GHrJzJA+KGuj9U8MlOvZXZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfKoXC2KJOUdDLcYmok2OpZNlK14KLm8h7zpDENUA1khVMIfSPvC2Qwglh4Nqr7CO
	 hiZMi5T6fzxKRY5wmtLexQuFNztnhUhIUa4hiDMgMSi/XqQ004n9tn04nLG/RdU0qu
	 C0E1g0dREOxiiZjnrajmgQ6qF/pHJ39U7xbwH/wKw7dwdpI943QUgVX8rUKKlxcbVL
	 lpDcTydEo9GQYJu+wjAe83wKTIvk9zG7ksxM0CB7QDpCDn03WPORaneg9OGTMEJZ4Y
	 /rWyfk3XbICsp4ledN/w2iOFSgVZoRWlRZ+1UrsPeNGCsHPSNjnAAp34BDylzWIpQJ
	 sjkqn8/vwXYCQ==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v5 4/5] arm64: dts: rockchip: Add SDMMC/SDIO controllers for RK3528
Date: Tue,  6 May 2025 09:22:05 +0000
Message-ID: <20250506092206.46143-5-ziyao@disroot.org>
In-Reply-To: <20250506092206.46143-1-ziyao@disroot.org>
References: <20250506092206.46143-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3528 features two SDIO controllers and one SD/MMC controller, describe
them in devicetree. Since their sample and drive clocks are located in
the VO and VPU GRFs, corresponding syscons are added to make these
clocks available.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 69 ++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 2c9780069af9..68059c7d7e80 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -329,6 +329,16 @@ qos_vpu: qos@ff280400 {
 			reg = <0x0 0xff280400 0x0 0x20>;
 		};
 
+		vpu_grf: syscon@ff340000 {
+			compatible = "rockchip,rk3528-vpu-grf", "syscon";
+			reg = <0x0 0xff340000 0x0 0x8000>;
+		};
+
+		vo_grf: syscon@ff360000 {
+			compatible = "rockchip,rk3528-vo-grf", "syscon";
+			reg = <0x0 0xff360000 0x0 0x10000>;
+		};
+
 		cru: clock-controller@ff4a0000 {
 			compatible = "rockchip,rk3528-cru";
 			reg = <0x0 0xff4a0000 0x0 0x30000>;
@@ -611,6 +621,65 @@ sdhci: mmc@ffbf0000 {
 			status = "disabled";
 		};
 
+		sdio0: mmc@ffc10000 {
+			compatible = "rockchip,rk3528-dw-mshc",
+				     "rockchip,rk3288-dw-mshc";
+			reg = <0x0 0xffc10000 0x0 0x4000>;
+			clocks = <&cru HCLK_SDIO0>,
+				 <&cru CCLK_SRC_SDIO0>,
+				 <&cru SCLK_SDIO0_DRV>,
+				 <&cru SCLK_SDIO0_SAMPLE>;
+			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+			fifo-depth = <0x100>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <200000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>;
+			resets = <&cru SRST_H_SDIO0>;
+			reset-names = "reset";
+			status = "disabled";
+		};
+
+		sdio1: mmc@ffc20000 {
+			compatible = "rockchip,rk3528-dw-mshc",
+				     "rockchip,rk3288-dw-mshc";
+			reg = <0x0 0xffc20000 0x0 0x4000>;
+			clocks = <&cru HCLK_SDIO1>,
+				 <&cru CCLK_SRC_SDIO1>,
+				 <&cru SCLK_SDIO1_DRV>,
+				 <&cru SCLK_SDIO1_SAMPLE>;
+			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+			fifo-depth = <0x100>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <200000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdio1_bus4>, <&sdio1_clk>, <&sdio1_cmd>;
+			resets = <&cru SRST_H_SDIO1>;
+			reset-names = "reset";
+			status = "disabled";
+		};
+
+		sdmmc: mmc@ffc30000 {
+			compatible = "rockchip,rk3528-dw-mshc",
+				     "rockchip,rk3288-dw-mshc";
+			reg = <0x0 0xffc30000 0x0 0x4000>;
+			clocks = <&cru HCLK_SDMMC0>,
+				 <&cru CCLK_SRC_SDMMC0>,
+				 <&cru SCLK_SDMMC_DRV>,
+				 <&cru SCLK_SDMMC_SAMPLE>;
+			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+			fifo-depth = <0x100>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+			max-frequency = <150000000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>,
+				    <&sdmmc_det>;
+			resets = <&cru SRST_H_SDMMC0>;
+			reset-names = "reset";
+			rockchip,default-sample-phase = <90>;
+			status = "disabled";
+		};
+
 		dmac: dma-controller@ffd60000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x0 0xffd60000 0x0 0x4000>;
-- 
2.49.0


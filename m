Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD801D63F9;
	Sat,  1 Mar 2025 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740826099; cv=none; b=CzdSg8zODNlhGvxsr4zupfrxHDEODyoPHYV5qdvlAAO0RWFvZi4Ha9f8uwHgQjypNRSOLGyVKR6uEo1hcSlLfjszPSbLGZRVmBEnd6gvlUrjf8SN4n67ajY4/DimLY2gSCBzMRUbRbcPB1sUygI37y7gUXccw4oAWnRZ664sPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740826099; c=relaxed/simple;
	bh=Mh8Scn9zD0vJo0No7F96OzW9299oqh4mWGc3Vb0A1ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7YqpasqZqCvNOXbEJ8BP8ZDV8y+d17dQgiQPKNlicm5kXQWl5WIDBsglDoTOkFzqx1UK7hxJKMKhdfvgHhbmYA6vZh5nO2Wm53AU84mWS35kW6xgSqMyh0ku7U6HrkR4Wt23+I4G34jWssmcIMK4dXnFhfZKmUWpnuxiTzFPIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gGpS1Q4g; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gGpS1Q4g"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E125825D26;
	Sat,  1 Mar 2025 11:48:16 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABOnEt0LCSoi; Sat,  1 Mar 2025 11:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740826096; bh=Mh8Scn9zD0vJo0No7F96OzW9299oqh4mWGc3Vb0A1ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gGpS1Q4gvX22ZL2StQFcA9v6V4lTov4KyfGyY8SbkgC9NdvsqsBrdONuWfEsXaiPq
	 S8SS/jgo/LMV4d4A4RxetVonl8Tc2kJyugDXHIyZKAPVm2/6Si2Ho6M+TXRySYt2lo
	 r7JHsfKeQUHjrkfsWogYwCf2ImobHxoHgO1ePmw75ZK/5rAF/7vIYaDJWvlCVRpTMh
	 9haiqQkQLrVIekmf6mFYIyU09N95emzVGbUSVgjHLhVKGsjETM284kSaf+uc+j7P10
	 97vvttQ3TCum9mi8xTj1IbF8Dcwm6dizlP+IsWzVLSzvughY7VOkNmi5ZcEAVt1PvT
	 A6ncQ600BvgvQ==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers for RK3528
Date: Sat,  1 Mar 2025 10:47:49 +0000
Message-ID: <20250301104749.36423-1-ziyao@disroot.org>
In-Reply-To: <20250301104250.36295-1-ziyao@disroot.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
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
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 62 ++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 5b334690356a..078c97fa1d9f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/rockchip,rk3528-cru.h>
+#include <dt-bindings/reset/rockchip,rk3528-cru.h>
 
 / {
 	compatible = "rockchip,rk3528";
@@ -122,6 +123,16 @@ gic: interrupt-controller@fed01000 {
 			#interrupt-cells = <3>;
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
@@ -251,5 +262,56 @@ uart7: serial@ffa28000 {
 			reg-shift = <2>;
 			status = "disabled";
 		};
+
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
+			max-frequency = <150000000>;
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
+			max-frequency = <150000000>;
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
+			resets = <&cru SRST_H_SDMMC0>;
+			reset-names = "reset";
+			status = "disabled";
+		};
 	};
 };
-- 
2.48.1


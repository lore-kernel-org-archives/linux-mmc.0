Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67367252906;
	Tue,  6 May 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523454; cv=none; b=s4FN4L9N9mTKSzvK305Kxv1iQe93pWkxsDpWH/PEctvWcacP34LR88QqeePJN35Zg3nrLTvXtj/+A4eDb5OLOCobv4pf2hB/5/5lQCcHlvRZeVIOHrd1VBOIVMqgiNDJNuhwxhaE8wNW8AK5Gp5uTFLKYD70ykUd3uOPn+RGIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523454; c=relaxed/simple;
	bh=6w+tXU7Z8tsTcrJtTb1oifhiSkHhaVbmuA7KCza1/rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmQUVqTO8YUUxKoSvKlUoiOjlM7rxrZtXRp5/ZShqY71i2xWfg1APzhMbuSRK7b9K3KZ5+L+1aZb9ieW+lQ+Zl7GKxOKRk7zsNPlUAjLjhc337fKTAz/1W6rPHOyBUPcwYqpCqdWh/OzQgOMZ1pVHHg6R4fut3x7qGEdV2z9yY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bzbc8dF8; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bzbc8dF8"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C4B0D25A88;
	Tue,  6 May 2025 11:24:11 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKdrIXse09H6; Tue,  6 May 2025 11:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1746523451; bh=6w+tXU7Z8tsTcrJtTb1oifhiSkHhaVbmuA7KCza1/rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzbc8dF8Okg0jQcz0QdqchtwqlD3B9UslylP0fk1n1d5FBGEkvutT0d8W4eJNXQJp
	 xKFKGRt2BSraG+16zvoDmsfHw/0nFYFq1pifYO5yLZtPuiexBZkYhsJOV56Tdquq18
	 oWCheiEZx2zZJipHA3i6NoPNS/2OSsQGklUwWl+Ktj4eiRMqhV69WvJbMWaGSbIZJw
	 mQeKwLFHbrL5e/gEQxW6viSh18SIMd4gae70pV1gJYR5WouacHRjLh0Pf+IDSNpU3G
	 BRq6s47TGxGF2eY9Nsbk+nFGd0yh0AYoElMHoq+No+E5ytm6IjQxBDOvklbi9J77N0
	 N8Rnrktmetqug==
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
Subject: [PATCH v5 5/5] arm64: dts: rockchip: Enable SD-card interface on Radxa E20C
Date: Tue,  6 May 2025 09:22:06 +0000
Message-ID: <20250506092206.46143-6-ziyao@disroot.org>
In-Reply-To: <20250506092206.46143-1-ziyao@disroot.org>
References: <20250506092206.46143-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SD-card is available on Radxa E20C board.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index 6e77f7753ff7..d0b194b7e66e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -17,6 +17,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
 	};
 
 	chosen {
@@ -108,6 +109,18 @@ vcc5v0_sys: regulator-5v0-vcc-sys {
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 	};
+
+	vccio_sd: regulator-vccio-sd {
+		compatible = "regulator-gpio";
+		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
+		regulator-name = "vccio_sd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <1800000 0x0>, <3300000 0x1>;
+		vin-supply = <&vcc5v0_sys>;
+	};
 };
 
 &i2c1 {
@@ -144,6 +157,12 @@ wan_led_g: wan-led-g {
 			rockchip,pins = <4 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	sdmmc {
+		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &saradc {
@@ -162,6 +181,17 @@ &sdhci {
 	status = "okay";
 };
 
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0m0_xfer>;
-- 
2.49.0


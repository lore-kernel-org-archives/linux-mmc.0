Received: from mail-m49237.qiye.163.com (mail-m49237.qiye.163.com [45.254.49.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D77342534;
	Fri, 16 Jan 2026 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768537527; cv=none; b=GAMNs9JwNP+tuB/YCvgc2hglDyEYj4DjfsHSGC66E2+8nyAlxYvUz0OHBE55xhkQwEe6ebSYbhn7pY93kIjac3hYFEawbj9WO33hQO4BmpFb6XSIDbkxAtpQ47hqyhEaKwHtnGuHQd8ww8cm5/dOwEGLITUhdl+ir2LQD36aPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768537527; c=relaxed/simple;
	bh=4S7WoA7MBmTIIGY9gqDjbnyWjT1ZT1YdF9rSymg5qSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n2BkaXpKCII16MPXWZdnT1hAkfa1cQvM/MIRXXIUWCMnf9BMe3TGMxWiZA5fElnBrAMDgAY+QDSRt+tkz0hF0bV+mJOcFflTMCDcbGgFP6AlKXhJmT8P8KeSSwlwhqbiS72VTYVUmBttLw6TnfYjf6LT8jlfTfolC4Fu2xyIDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jnoYFE+6; arc=none smtp.client-ip=45.254.49.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jnoYFE+6"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30d5a76ed;
	Fri, 16 Jan 2026 08:56:10 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	John Clark <inindev@gmail.com>,
	Tianling Shen <cnsztl@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 5/5] arm64: dts: rockchip: Fix SD card support for RK3576 Nanopi R76s
Date: Fri, 16 Jan 2026 08:55:32 +0800
Message-Id: <1768524932-163929-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
References: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9bc44d7abd09cckunm67a197c8691c83
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGklCTVZOGUhMTE9DSEpIHk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jnoYFE+6GIc90VpWQjTFwycbX53cl5iXRvoWJ7lMjoq5Mb3LqWdXogwQC1Mr5wDnWZbX+QagcJdv0bjDQMBXFL3kDuxC2pn1YeYnNgpsMFFTmZ0qqijsMTnIp7uvCFFFdv3Nu1YTHyJS13B37MJkVQE7oV/lbS90OmOzd5mVbvs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=rGhXF5/8uiyG5kkuJJMSCKix8pPHbfQoMwB2LnqjU2c=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

When runtime suspend is enabled, the associated power domain is powered
off, which resets the registers, including the power control bit. As a result,
the card loses power during runtime suspend. The card should still be able
to process I/O with the help of mmc_blk_mq_rw_recovery(), which is suboptimal.
To address this issue, we must use vmmc-supply with a GPIO based method to
maintain power to the card and store valid tuning phases. Also, add cd-gpios
method to make hot-plug work correctly during idle periods.

Fixes: 7fee88882704 ("arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R76S")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>
---

Changes in v3: None
Changes in v2: None

 .../arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
index 31fbefa..7ec27b0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts
@@ -192,6 +192,18 @@
 		regulator-name = "vcc_3v3_s0";
 		vin-supply = <&vcc_3v3_s3>;
 	};
+
+	vcc3v3_sd: regulator-vcc-3v3-sd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwren>;
+		regulator-name = "vcc3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_s0>;
+	};
 };
 
 &combphy0_ps {
@@ -726,6 +738,12 @@
 		};
 	};
 
+	sdmmc {
+		sdmmc_pwren: sdmmc-pwren {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		usb_otg0_pwren_h: usb-otg0-pwren-h {
 			rockchip,pins = <0 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -751,11 +769,14 @@
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	no-mmc;
 	no-sdio;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_det &sdmmc0_bus4>;
 	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_3v3_s3>;
+	vmmc-supply = <&vcc3v3_sd>;
 	vqmmc-supply = <&vccio_sd_s0>;
 	status = "okay";
 };
-- 
2.7.4


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5032B115;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343733; cv=none; b=k2dMDPcmSqywG4ElT7LmQS9nkMeZR1FLvA1ZARmMa98VG1ZpEN2CueQ1ZMIsVD/rbtv0PZaPtpEzuY23S+11Lh22MUp49xA9mjaAoRXkXz3Nk4J9Kmj/Tg9BgNIvxuHF3J7blO81fPQbfvbA/H+BXmcSy9W8DzMt9OA/s5Ks7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343733; c=relaxed/simple;
	bh=K3NSNpo9bYvrRkVd6BA97gap7TGSqpSPnzHzv28qtIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ru2wQDVGEB9/PYWewA+dp+HJu2s5WjrC31noIyFHyy6GYH+0w5bi6VqVzMudsRJ1AZgXV5NQjGytrxCLUQsahSD1gxiufmAWIbexl+8ZZoYxQuw0WxQS06IWtYHOjDiO8vG1Jx+gDCQGInu89bdD70hWAyZlTpi4aYNGB9/wELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf/ZT06/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf/ZT06/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75CE4C4AF13;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781343733;
	bh=K3NSNpo9bYvrRkVd6BA97gap7TGSqpSPnzHzv28qtIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uf/ZT06/TJDVvFRDYnIeJY9enLWXaWv18k/d57YXEQXchFp+XqYpjfjrSHO5TE+AD
	 MLqpphn3Uh/pFFH3u36VRHgxlPoKLPsuoyMjTp9giKQoI6Qo/s7JR+O4c5XDo05sD2
	 wdhvv9pdzPVstpBcuLu+j0mnVyHLXbO1gBzseu8gP+BEkF6Q/pc3a5DGr8Tn/XFvnI
	 6yy0hOwGo6fAFc+th8cVKc5k995VqMPmuyOTjISRwck2HVrKHn6ORh7V7XThbRY5g4
	 4x4uOwCeSzJmDi+4i9RC51bvMUo4DWWpZZZSfLA8LNBeZMI3lo/rXbHLAksSCELBY1
	 9oo0ZipOkLFzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F7CD98D6;
	Sat, 13 Jun 2026 09:42:13 +0000 (UTC)
From: Enzo Adriano via B4 Relay <devnull+enzo.adriano.code.gmail.com@kernel.org>
Date: Sat, 13 Jun 2026 05:42:16 -0400
Subject: [PATCH 4/4] arm64: dts: allwinner: add Radxa Cubie A7S
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-a733-dts-v1-public-ready-v1-4-7787c94681db@gmail.com>
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
In-Reply-To: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Enzo Adriano <enzo.adriano.code@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781343732; l=2364;
 i=enzo.adriano.code@gmail.com; s=a733-cubie-a7s;
 h=from:subject:message-id;
 bh=WglawFMrtY9x8pOjuPdnu6SXc40mYnW0SaPFITAFqtE=;
 b=GbPhqn66Lz40aOjXStKHF233v3bsLzM1ml6LsXpvkrLn92HN/jl3uoeOECLYFwLIOOTvAKgWs
 elncJREMxH/DYHkJnIGC2PGIqP1I/hQiHA0jjrPTsST7XrK6bualNwq
X-Developer-Key: i=enzo.adriano.code@gmail.com; a=ed25519;
 pk=5S3Wmdqa4XfCdeZF/HfeYqnQF8GN9JGt3SE1cxqSX8E=
X-Endpoint-Received: by B4 Relay for
 enzo.adriano.code@gmail.com/a733-cubie-a7s with auth_id=820
X-Original-From: Enzo Adriano <enzo.adriano.code@gmail.com>
Reply-To: enzo.adriano.code@gmail.com

From: Enzo Adriano <enzo.adriano.code@gmail.com>

Add the Radxa Cubie A7S board description with serial console and SD card
boot support.

Ethernet remains disabled until the GMAC210 wrapper, clocks, resets,
MDIO, PHY reset, PHY power, and link behavior are proven.

Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
---
 arch/arm64/boot/dts/allwinner/Makefile             |  1 +
 .../boot/dts/allwinner/sun60i-a733-cubie-a7s.dts   | 48 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index d116864b6c2b..824cc35152db 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-2024.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-h.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h700-anbernic-rg35xx-sp.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun60i-a733-cubie-a7s.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun55i-a527-cubie-a5e.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun55i-h728-x96qpro+.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun55i-t527-avaota-a1.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun60i-a733-cubie-a7s.dts b/arch/arm64/boot/dts/allwinner/sun60i-a733-cubie-a7s.dts
new file mode 100644
index 000000000000..453761a96323
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun60i-a733-cubie-a7s.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+
+/dts-v1/;
+
+#include "sun60i-a733.dtsi"
+
+/ {
+	model = "Radxa Cubie A7S";
+	compatible = "radxa,cubie-a7s", "allwinner,sun60i-a733";
+
+	aliases {
+		serial0 = &uart0;
+		mmc0 = &mmc0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
+
+&pio {
+	uart0_pb9_pb10_pins: uart0-pb9-pb10-pins {
+		pins = "PB9", "PB10";
+		function = "uart0";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb9_pb10_pins>;
+	status = "okay";
+};

-- 
2.53.0



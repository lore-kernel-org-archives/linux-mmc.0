Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C549EC5F
	for <linux-mmc@vger.kernel.org>; Sat,  5 Sep 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622363; cv=none; b=A0H12CEYZ9EQJK2jrsNtQL32cpaUQaV/+nyt0KskMTMWeuzmmA8tDX/8dlg4Gr2C0dSB90l9DHVseCL+LxlQQ4k9nB9WTA54wA0RxOn37PCamGyWUQFa6yRIXUJj5awg0q7x9Ocq126gwKqWLafDIJ/UmzBFUkanZZdJ2+mB9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622363; c=relaxed/simple;
	bh=1vLHCU8lWJSitlPYnCaz7byT5JPQIj0L3X0Yw58PruY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tafkhDyUrSd91DFq5lOHp0WmttNkyXwtHl54MmCz4PJ7i2IN7of3y0dwc/4nM8xvYLNNtj2TDdt1JpR79kep6CNxEWwn7Bs9LkwmEH/kwn4vztTkAVf2uoXzxxHMwHZGEItNytwlWTXwooWfm4xQ+HUyws6oMe4v/u2sDRXy4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d05d51553so3029485e9.2
        for <linux-mmc@vger.kernel.org>; Sat, 05 Sep 2026 08:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788622359; x=1789227159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9Z1qKT7EogtF26L5TwSpOWlLsafa9aGvAtJ1Qh1QBg=;
        b=Uhak5oZDNc+lqXV3R4gShBrcMV8H8kNtpC9UQ0UyS+KFwDodZZWFP7ANajKx7snj6L
         fi1LwwqdPNgoLRsGTEc0g4VoTkvUSeBkV9We4P6hK8V1cVEwjqQJj3JdsaOpzq2vt4dV
         ovDfUQZM246TJUz7AVbj2C1wznW276+7008us2kcTlS98Sx+QUVfZ42tuUHRYEFky2LR
         poszQpBBICfqpNXllXOi6o79pKyfnKkEphNP+esCooMsO7rLIloG3lUy0vq6aX9eRjZy
         g+NkInChZ5W7xqOiNAPbTMkXJpKbrhulUg0yxK0/VPyzXobH3WQu5fXYQ9X+5KDF+Ueq
         ENmw==
X-Forwarded-Encrypted: i=1; AKwUvBx+sDAy4FN1+MgZeqAMmWk5AolLKNJNzk1mlzw0mO+j8AGdNgdMYf/SyXGbexC1SsgBaSJaTpXwh2w=@vger.kernel.org
X-Gm-Message-State: AFuF++nOxK6lcXrWZfU5MOJWAmsen962OCfVOvTCwH0mTn3r4ggwSqL2
	K/+D8BNbiP2C3BIRvvr6kXwK4fL9YvLT8EOLgDu19NJhS01zd/K5zjKp
X-Gm-Gg: AYBFou0m4FmPz/7OAjIEXXqKTiPirmsPhz8OR071iMdI6B4eyhsWA7ruQnFfPVtzP5/
	FHqWR6OuH39kpNI38Me7CqCvhRIuM+dr56jiIY1UvWos0AMOZLEFpnhBi33ZBfl+ONDHpwdJe/s
	gh3lMnudCpUb9CrhUaCt4ozOpa6Ms16XoO1BLhnWiV9opbo13ug7ixzj4BlZ+/6G2uLMR72epLw
	Twx+mtlGNA1383Bqrl5j8j7d8Cv44xvq985jIXbms2FPc8W2Lp7ghHejb5c8Gx2BLYT9esv1sXq
	SSxLpaZslmXNLPcvM1IYkjix97cvA8wTVTu3+3h9ag5irnPTZWb8ZenzSpWZ0E5CseygQ+3fQ/t
	Qt3dlLYdgq88XUykeL1QlK5EUSh/xsDtC0FfF3Up19qy0Xp6se4tsTXUfmR0b4VRuL0/Ny572jk
	AM7QAx8ioi2/6btdCIh1/TMo187EgxNyioUXQAaeU/T9g6zynqzmUv09MYaYfgeRQNH8j+D9xjI
	mjHP0DR9ubHbple01iRR08d/Q==
X-Received: by 2002:a05:600c:a0a:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-49cf820ccdcmr130205405e9.7.1788622358693;
        Sat, 05 Sep 2026 08:32:38 -0700 (PDT)
Received: from threads.localdomain ([84.68.179.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm16691913f8f.25.2026.09.05.08.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:32:38 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney+clk@redhat.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Jian Hu <jian.hu@amlogic.com>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: amlogic: t7: add the pipeline clock to the MMC controllers
Date: Sat,  5 Sep 2026 16:32:33 +0100
Message-ID: <20260905153234.133217-4-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905153234.133217-1-tanure@linux.com>
References: <20260905153234.133217-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SD/eMMC controllers reach the DRAM through a pipeline stage that
the hardware design inserts in the bus path to the NIC_MATRIX fabric,
clocked by CLKID_SYS_AMPIPE_NAND. When that clock is disabled, a
controller that starts a DMA transfer can never complete it.

Reference the clock from the three MMC controller nodes so the driver
keeps it running, instead of relying on the clock being marked critical
in the clock controller.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index c3dc479b137d..dbb4a95652c6 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -730,8 +730,9 @@ sd_emmc_a: mmc@88000 {
 				interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_A>,
 					 <&clkc_periphs CLKID_SD_EMMC_A>,
-					 <&scmi_clk CLKID_FCLK_DIV2>;
-				clock-names = "core", "clkin0", "clkin1";
+					 <&scmi_clk CLKID_FCLK_DIV2>,
+					 <&clkc_periphs CLKID_SYS_AMPIPE_NAND>;
+				clock-names = "core", "clkin0", "clkin1", "pipeline";
 				resets = <&reset RESET_SD_EMMC_A>;
 				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_A_SEL>;
 				assigned-clock-parents = <&xtal>;
@@ -744,8 +745,9 @@ sd_emmc_b: mmc@8a000 {
 				interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_B>,
 					 <&clkc_periphs CLKID_SD_EMMC_B>,
-					 <&scmi_clk CLKID_FCLK_DIV2>;
-				clock-names = "core", "clkin0", "clkin1";
+					 <&scmi_clk CLKID_FCLK_DIV2>,
+					 <&clkc_periphs CLKID_SYS_AMPIPE_NAND>;
+				clock-names = "core", "clkin0", "clkin1", "pipeline";
 				resets = <&reset RESET_SD_EMMC_B>;
 				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_B_SEL>;
 				assigned-clock-parents = <&xtal>;
@@ -758,8 +760,9 @@ sd_emmc_c: mmc@8c000 {
 				interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_C>,
 					 <&clkc_periphs CLKID_SD_EMMC_C>,
-					 <&scmi_clk CLKID_FCLK_DIV2>;
-				clock-names = "core", "clkin0", "clkin1";
+					 <&scmi_clk CLKID_FCLK_DIV2>,
+					 <&clkc_periphs CLKID_SYS_AMPIPE_NAND>;
+				clock-names = "core", "clkin0", "clkin1", "pipeline";
 				resets = <&reset RESET_SD_EMMC_C>;
 				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_C_SEL>;
 				assigned-clock-parents = <&xtal>;
-- 
2.55.0


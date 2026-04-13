Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189593A5459
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067367; cv=none; b=INJX9OS1MM5yWp4BvIbPB8+cilmkX0xrp01upO8VJdFGQhDFv0OU28drX0NQI01ifUs7e3M42VcpRONlEgQYfjD/KMVXJnwJMqhtjnTJWriOVFL46lP4PIGdTTyQjmK03TRAEnF+WG1l+LStlfU/Z3xNHQr608+iDmgKFo4ZezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067367; c=relaxed/simple;
	bh=eVrkEXLP+791DyS5CNA9zSUQG9FyxWIPqUaZlx8PVx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XP3sRa2hhvowroIviWkmODn2I0jBg6z1rUb5qOUcCsvkVpA2uFDuQGBgiT7/k2D5nj4LXslkWcsA5bN5aJRpoKxhJOAtOLulfB45Bd+G5v0hBq51jEYyj7BjBvcH0d0uKntUMmOW2lBhReQcEjTOggeKx2P7K7doUzZ2gq1sY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awIaZizJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awIaZizJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7605ec91so765015f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067364; x=1776672164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1uRceIt6FZHOLqKiVcTKsVGt2IzySijGuQ2Z2k+iYk=;
        b=awIaZizJtCS1nTBSvZeNWP1O43sz0ySsJWcKvGxYvWDqoJ1nfCqkVy47BHaVvy4Wbq
         u6epnqDgYDuj1WXO2uxtdu+KdpZAo8zaazg1G2xVaav4YqQP07bKQu9PO+Y7KZNYmKt3
         J0tImueuHDMasMwz9rf/QcRlhPUE9pzWcj5MnIXLB1x/2xpuZrvqwJdBBJ+sWogXFLZE
         2pfY4kZ7lZTbtnIY0x5dr1iGPCX6kk4KKwmcntATr00+qEnZTm9UjcVeZ3Z+GrJsi7ld
         orM5Y9A+Zeu/xwTyVM/s3mz089KtwHtpC6FYG2xc4c/W94MUjurFmK280zI/7dEKg1ce
         RijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067364; x=1776672164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J1uRceIt6FZHOLqKiVcTKsVGt2IzySijGuQ2Z2k+iYk=;
        b=ev3zeV3HotSHuKX8AHB6tX9TE22LORlO1jnT6SIEwXNVT+lULm19j43HbZ2SpjzTSw
         jZ/7NunIwNp+HL+m4JRtO5pJ4KcbNmmnplg9wsOZTEVJyDZzAAYo7Em1gjQoMWQHMbzB
         Erft+lpMUrldOynM8SG9VV5yTL29n1r0HM9Abhtf9g0As7dmPZ6WWMHNTltXtlNOTaEG
         6Q3AIjVJURQJ+2TQ9Utc8eov//IF0SBHf0JiqdZqScfdYO5bSyWyqdaPryuqaSY0tkq2
         Qub1sLnrSclJ4Fd2XFerMt9J6Ot8/OeWWmIPiINlw6jccBUi6kTF4OAA3w86qQ7rp0ah
         jRuA==
X-Forwarded-Encrypted: i=1; AFNElJ/Hg8kqRIGyuUU0wE4O85SA8nRNMSxa8E0y+4nwpumrXsT0Qh79Oz6M6EvPPG5j1ohje4cw36jeF2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpowFI9Tk0cxkaFrohWjBpaY4Qwsle+Mj9WsZXGmjDHXcyT26
	qmNtpQ4TzBJPmr/WJIDVHBWyqkfU4NK47wYthQIcyZ/EYKltAEMK2QJq
X-Gm-Gg: AeBDieulxCKhWBgMVjnO+XeLjruY0VS7tlRMduNPfyBuMSkp8gu63dRHACYvLJJToaW
	HdKMqfuuyG8TV1shCKZq4MO2By9/R8VgbMydTbKhnVMXSJd3NZ5riaE8ZQDqRZDPMIqI1xMntjH
	uTdCgZxpmlZFKbE3caq4gU6gJw2cHycLRy71QFbh9rcYokldiiX4EmHV+N/0K247nwCL1fL5tCl
	ljdLzM0wsIFSLNi5DYMqj1sCg7QCDUh7JOXyHBnB8kYiOO+fHMqFSY4/sfXb03tQ+hO6yoIGcHS
	u403cNUfWTqrs1YCjadwVfJo3q+AjEaJ7AVIVDISzj5HUcLbH/cSU/6EDa1q1KjTlyS194oByyp
	NfEsByinIsfX1+6NXi6lssLAq4cvRqHvBmXEV6n7BO/IKxXD56eoTVHMDPzaQ9VOstuk0/ayw2r
	tGZ/8308hRdfk+zsAu4PIrE6Oy103M1K+6kCZt6FHsVYAw2pnanRI/WK6/S2RlM8Vh
X-Received: by 2002:a05:6000:40cd:b0:43b:912c:25c7 with SMTP id ffacd0b85a97d-43d642c4f22mr17696379f8f.25.1776067363780;
        Mon, 13 Apr 2026 01:02:43 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:43 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 13 Apr 2026 10:02:14 +0200
Subject: [PATCH v8 5/9] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-orangepi-sd-card-uhs-v8-5-c21c40ec16d0@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
X-Mailer: b4 0.14.3

Add SD card controller infrastructure for SpacemiT K1 SoC with complete
pinctrl support for both standard and UHS modes.

- Add sdhci0 controller definition with clocks, resets and interrupts
- Add mmc1_cfg pinctrl for 3.3V standard SD operation
- Add mmc1_uhs_cfg pinctrl for 1.8V UHS high-speed operation
- Configure appropriate drive strength and power-source properties

This provides complete SD card infrastructure that K1-based boards can
enable.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Tested-by: Vincent Legoll <legoll@online.fr>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 40 ++++++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi         | 13 +++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index b13dcb10f4d6..b3c472a0783b 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -570,4 +570,44 @@ pwm14-1-pins {
 			drive-strength = <32>;
 		};
 	};
+
+	mmc1_cfg: mmc1-cfg {
+		mmc1-data-cmd-pins {
+			pinmux = <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
+				 <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
+				 <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
+				 <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
+				 <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
+			bias-pull-up = <1>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		mmc1-clk-pins {
+			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
+			bias-pull-down = <1>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
+
+	mmc1_uhs_cfg: mmc1-uhs-cfg {
+		mmc1-data-cmd-pins {
+			pinmux = <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
+				 <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
+				 <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
+				 <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
+				 <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
+			bias-pull-up = <1>;
+			drive-strength = <42>;
+			power-source = <1800>;
+		};
+
+		mmc1-clk-pins {
+			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
+			bias-pull-down = <1>;
+			drive-strength = <42>;
+			power-source = <1800>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index f0bad6855c97..28949f804610 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -1211,6 +1211,19 @@ emmc: mmc@d4281000 {
 				interrupts = <101>;
 				status = "disabled";
 			};
+
+			sdhci0: mmc@d4280000 {
+				compatible = "spacemit,k1-sdhci";
+				reg = <0x0 0xd4280000 0x0 0x200>;
+				clocks = <&syscon_apmu CLK_SDH_AXI>,
+					 <&syscon_apmu CLK_SDH0>;
+				clock-names = "core", "io";
+				resets = <&syscon_apmu RESET_SDH_AXI>,
+					 <&syscon_apmu RESET_SDH0>;
+				reset-names = "axi", "sdh";
+				interrupts = <99>;
+				status = "disabled";
+			};
 		};
 	};
 };

-- 
2.53.0


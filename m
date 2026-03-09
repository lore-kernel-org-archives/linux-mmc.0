Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02753A7F54
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056440; cv=none; b=nrU0NDaz05jk/Hf4DI8W0j5bV9LqycynCyoP8Z4f4fzpvKdFPP8LDNR99Hpc7xSgG3aw3kJl/r2cEgqxJfjiqFQo0G0MrnoR48Fp3vErcjYYI3XWd/yNq7LWdssvn+tSzbRVmyrrs9AsvBgeO6gLuKGiqzmdTsUEXyOizM0ladc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056440; c=relaxed/simple;
	bh=dcEFhqPvKdwQuanA4mTY4Hc01u8XbBg6NksC+/+CuBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hU1Lxi7LOmCQ9M9uTtLvBHHYadBLz5lTjHKdpniE5qX41gFfLT1oNONNqK6HNshRA+sGKEMko2x1LRaRGHx6egy9T9qVVHhyhZ+Qaw8ebJFDGI0coY8lIuG13uKd7vKIUPvAHEXYO5WYtC0xeg7ZEP9lauYpZk9esbFgxN6KLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9J5RCd4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9J5RCd4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso3706779f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056437; x=1773661237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz1rwkI02gKLCCAejR8NRcSe9CYDdLI50V/yGcp3k+8=;
        b=W9J5RCd4/AJuQMbvaD3+AxuLgU0BVfBWhuiMEw/DNQiV1xBSBSXmpNjoZDLvKhe1n0
         7cavoBXHtCmLmRaFEZl10JarFpK5JUuqoE4+MK5PzMHWIvCtRpb20rXQS0j+DbQIC7hD
         9bt151fTEr0kvRU3E1vQVLtXuJmPbIAYQ6uojEiPhbFrZwPP6hHe6IWp5/lT0PubirH9
         fdwBJisxg+NH3ufrpbOMZwSBAcg9ern/sqXp4n6OPAI5kzZp/4CSSw6s183gKW+mSsSy
         3cSovexHi+6nqxQ4EEQxxvkCSTfQG00QERGuvai3wPvfiVwXFhZ7bBf+MN42qkutdopF
         x1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056437; x=1773661237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dz1rwkI02gKLCCAejR8NRcSe9CYDdLI50V/yGcp3k+8=;
        b=s7KvYkGdC6SKiQ4raEaTtIrQRfibTMw3HvZOOTKLpjbBa8wLWMOhJYGTctbASc6I9D
         dkis06qk9wNhGIjk/AbdlZ+GINI4vprkhdK5qRAQzpP0ihbhNM9Um7Ff0dYxxW3GbjvB
         Jaw/qJd5rF0Dcy0QMFcxRIxh4mP6D+n6eiko8eFJTSv3cB4YUXVyxjdS3bvagCCoQ93z
         gQz4NZdLJ66E1uybaaDk4+EcsqfhE8uCBG3HAAhvKS8Pu1m3nIy7xa1ygT55yFmqQMzK
         5mtA6qbbKjq/DzRitaa9+Dm8aT/n8AT21X7cNPIiNwSuHTPfIqLM81grXikbunTLQJWC
         dAtw==
X-Forwarded-Encrypted: i=1; AJvYcCXImBh7OXOD60ktirezV0RyZm6GG9XpcGlEmFPzY/L1DCYnK+dXOE99qA9Ie7bPhLdlOXc3iam1rNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rEsH3wksmG+Zx+HQQKdCLOR5K7ntECjLLBnPX0SYXRpIT7Ua
	I9wI7VTkGWOVH7HbJvN2ULUOUsNxcvcTM92/151Z5ti1mYjQY1BFeUJP
X-Gm-Gg: ATEYQzxLs5cNxJWYBDQNqRbme/uVOMwZVAH5yUzf1fuUl+ajtC3ZI+s5fJe9WQB3sgl
	AlL9UCwhKygrdJeTv076c1G1rOYaZfEstNpgCRV1AFNF8GFFQ9NOKzWvU7NNhhs8Qijaa55cOrp
	DjmUE938f85iu+bbrbwbm7sEM+cXNPmyeQ86+K78tEXb1Pf9q6az59wsyBYg6dAY6KEEcqduwra
	hBoEhW/c9bCupF8/KnkjM5Icv9wRfVjwobtkeR6MZn70MxcMT1g0EqzA3lTVBcQO0OBJ8thXV5z
	pX1q/E6lBqQusqdntD31a3i+zHnkZIVANs7Fh8R4sD8KX56/vIkzos4qt3kR7KqrZ9VIXONLWha
	taQlc60vLYvWFQvJ+sb/wIG/ZBh1cuE1x7WP0xdh+VPFnqAUx0/QO2EMOJK0PeA8UTqJqxmChpO
	XqkGwnWxjxfeinD36iCEaI9ecoB62I/QB94+UDIxIlasVh6INgyi/NHbzwJgqd3reagFSj8LIPR
	DU=
X-Received: by 2002:a5d:5d06:0:b0:439:bb14:23ed with SMTP id ffacd0b85a97d-439da6694afmr18775197f8f.24.1773056437144;
        Mon, 09 Mar 2026 04:40:37 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.236.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8ec97sm28471699f8f.5.2026.03.09.04.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:40:36 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 09 Mar 2026 12:40:15 +0100
Subject: [PATCH v2 5/7] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-orangepi-sd-card-uhs-v2-5-5bb2b574df5d@gmail.com>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Add SD card controller infrastructure for SpacemiT K1 SoC with complete
pinctrl support for both standard and UHS modes.

- Add sdhci0 controller definition with clocks, resets and interrupts
- Add mmc1_cfg pinctrl for 3.3V standard SD operation
- Add mmc1_uhs_cfg pinctrl for 1.8V UHS high-speed operation
- Configure appropriate drive strength and power-source properties

This provides complete SD card infrastructure that K1-based boards can
enable.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 40 ++++++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi         | 13 +++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index b13dcb10f4d66022d27307de73a6ea3287e97441..8d82011f1af666fb78c282a2abcc0cb88f962053 100644
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
+			drive-strength = <7>;
+			power-source = <3300>;
+		};
+
+		mmc1-clk-pins {
+			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
+			bias-pull-down = <1>;
+			drive-strength = <7>;
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
+			drive-strength = <13>;
+			power-source = <1800>;
+		};
+
+		mmc1-clk-pins {
+			pinmux = <K1_PADCONF(109, 0)>;   /* mmc1_clk */
+			bias-pull-down = <1>;
+			drive-strength = <13>;
+			power-source = <1800>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 529ec68e9c23eb2a93c04e9ccd3f22a01c4cc4ff..1e9e4f4f41c196326f20c0e5ae6721ea85ea5091 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -1207,6 +1207,19 @@ emmc: mmc@d4281000 {
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


Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C163CE4AC
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489679; cv=none; b=ubMN3cpB92/0w/9gi68tg/juJFh2EdtyH/aHu0ImeMqPy83nJVZDKY1mTsOMNK3Atp4dQOoBOWIcA+mLoKvFJqsBGegXRxP5oI27bXeoh3MAZKJR6Bi97xeCKognLpK/6cdFGh2MrpoIZp5wMQF7UALt968wvEP1j4+ZPpQWOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489679; c=relaxed/simple;
	bh=czyMPdWP53DEucpvLID85A2eMzwRX1rlaHLtT1FWJJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acnovol8MzLePCMgxIk/0KBlbVyYcRV/sm9+lC7rUJRSfPLMoivQ/XZsdELf6X9W9gGDdFz+AcwKjjyTONiOYU1VWa4kGv9pS7bFCVkfff2nf24FO8JoL/OWraEOCDzO6X7UXk1HoO3KnPf5bZkqnRJnAUsrwOJ53SFRHDt63A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSZF1/AF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSZF1/AF"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7e23defbso2266193f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489676; x=1779094476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHZBSgDtUIrOhP/YxIJOEaKWgx2xyCzMyAWUTKPESJY=;
        b=mSZF1/AF2YJK84DdMQX/pPBQH2rBZargXFcdUeDtyNMDMsfUoVEF5Sp3gyESafSNaG
         c7UFCWHFPsnuAmBkSmsVcknzcrxcCo6/078cey2k6Bfw3UdmBFb2+9QR0B57GtsbJJ0Y
         2axtj7fhlM6n6qQv3TorJfdxz/cU/iqtIa8C54wse/5EIz0iwOpKJuq9XGCibZwA8+3h
         dlVhBbKvi1yC5VholRDNBvkwJtuj2UOkOkjFSHtC/auuYcBx/Af4enrLI5h74MEtbFUH
         X0KsW2pkhKqkIi8wcOaCeGadFWDjm8ymUWbTgz0RhcY4F5AyHHQ7qaHKR4CUzwwgoqiq
         ru9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489676; x=1779094476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eHZBSgDtUIrOhP/YxIJOEaKWgx2xyCzMyAWUTKPESJY=;
        b=D1gBBqkRIx3Eh8UqWsKwRHxaj04BFSHf6eG/seQpomB53GDUrM05ErKLttSze3Wz2e
         7meWke4Lf6btQBz9qtp2TiwS6FjdOEX+ihSdNYSIiBv+dhVmKEhaWdmjTqTYYG/NbOrn
         8lVbO4RRUCmMoxoN49aG/mc6WVrAboUSwwiFAjbmsbqPeEWjm5RSrTeIFjpp5him9cj9
         8JwVSV3NIttaWHfLjZsXvxiuq+3wwpCyM9pFygyj6pHBm9vvN53yNM4t3n6RIsORH0YP
         HSpz5FTp+iWMbE+nHfhaNEwCQ6s1scvq3MzgTthoLp1LgN+zzMGvRmlpRaye2N4mAKGs
         5kJA==
X-Forwarded-Encrypted: i=1; AFNElJ9NvtMpyz6b3ujIUxxznQCjHDhp5QlG+UQNLnIvLOl1rKoltEv25joKckumM61nOVIgRGidm1ClbQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0mtBs+d7bCLVFEtHK+eoyplXj1+AMt7uwCrmvzj1DSNptDHW
	mcztjy3/hKZ9UVKydTGQYs/TtHqq4bEfceXYfT1kBQdl9UtS7Pv+PMSt
X-Gm-Gg: Acq92OEJT45uompYyg0syofHmwh6AJnYEXRHgpwRmvteQcfy9GF4uL72DZhSjBAfg7+
	0r7wPxtKCXR5vwfqeX5ZBAm30UJqB3P1xxEDAS+ZO50NWDokQspFRGNHhYOoEMPXL5w6Y9/u8By
	red7EwECfYoxb30oRP8kZGjX8k1H6Nvnl/Nz7HgEqXU2NI6//bkfuOLXfgqpv8zU4aAAgz0Tqcz
	+4H01Rfup1p8GOohhdDsA13nDKYXOib7UDyt4+9e8qDjKlQmtpr7pcwGRUv1ORAkVttDqztDrG+
	mf5yOClnFRMDNVQQXQpLSyW3pzN6y33RF5hYI3Tsj0dOCvnd1jqRNKoB12dAsrBxcZqk4VnfKcI
	yDItrLzyVasRHpR82N0NJYRAXPwcTxm7c0FAbrpHfbo5JTxgVLcqPzdQuSq4hInRaMR2VuYoeLH
	8C7B2uQX/uxJ1IpyfFVtvAOnnfQpOcl5Y0tLjQxJtNNWM3cOuObxnsm7NYFCHCjmRUmg==
X-Received: by 2002:a05:6000:310e:b0:43e:aa88:f1a1 with SMTP id ffacd0b85a97d-4568ca51624mr12522568f8f.30.1778489675606;
        Mon, 11 May 2026 01:54:35 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.237.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm24944189f8f.30.2026.05.11.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:35 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 11 May 2026 10:54:00 +0200
Subject: [PATCH v9 5/8] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-orangepi-sd-card-uhs-v9-5-ae48c0b2b2cf@gmail.com>
References: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
In-Reply-To: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Yixun Lan <dlan@kernel.org>
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
index 34d88334e95e..4e9a62d0e85b 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -590,4 +590,44 @@ ssp3-0-frm-pins {
 			power-source = <3300>;
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
index 24becab4c959..6ded5c06b797 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -1226,6 +1226,19 @@ emmc: mmc@d4281000 {
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
2.54.0


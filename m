Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA55472795
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842159; cv=none; b=KkZ0Oo3yCOhN9t4BBKBtAzwX7gKGlTeaGR8m2qu3vw0AYv9liAge8uW7MhuCQRzqVFUt0JbDxKyplfvGjsrWI1iLEBTg7+1M1AC1C1tQ8fIf8aj58Duahfr4eDDndBH9ISffjqJ29ZAqNWZGj23xnmgImSHLp3nbGze9UVZeAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842159; c=relaxed/simple;
	bh=3aSvx4Io/6wXnKYqIdHAgAeK+8aI7Ki0w9r0gL1YGe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQTuJaAawLKvIlXuKVevIGHG5iuuiY0AayDsgAdMx3UDVZEWBC+H24hgLok2Giuxv6czBHVsN2Qb8ehwXjZCzN2PD9unc4UGl5qpisoPxBiA61WrjrwfsofMQwVKRemk605eg1JZLq6pI1SDar2ALxgf9NpBaxor6w4UdAtsnlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pj0AFU5C; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj0AFU5C"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-444826c16ffso7506993f8f.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778842155; x=1779446955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWgPUQvxpgR7326ne226FMqTKp2lrFwP9NQdMcyNV50=;
        b=pj0AFU5CAAWmpo84yypyC+6BIWQL3q+PbrdSliU8juXM3rnrGUZN7D13nc34keKXUm
         ITQCfslo1KsYjSuGezfoy3Kb0w9lbJm2DwwN45MOpIHuT/o5pkXdwzgzM0JG1IoDe6Ez
         edE/VR+igPmBDZ7IrjhfwjvYa5oBYkKSEK5oxHqDFD7wQihSyzGnAW3M0p/XdM/BgAsQ
         DQNUEHpuKUtER4zQJQxdWeD6n3ObKNs2UdzQxrbprhpTtLYG5ihaIOS0MObvobHnfsMT
         3l5rfUuj2InASfZBS3RUQcrNFF7JYE+N952dSy4pwUo9huTygQy2oFbZ5jB+NRJwOt6r
         hKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842155; x=1779446955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWgPUQvxpgR7326ne226FMqTKp2lrFwP9NQdMcyNV50=;
        b=FS9f3dhtYZq/3PCwVbrZxTCWKjTwHpMBTdLHSJIJ11tmS5QmNH8Wl7sU7mkEwWbWbT
         7d2ZnNnkDPIKa9bQhdFHG/npHjReRVXQjQnET//Gdn9k7mYjJ7caOw7ROCMLBewmDH+k
         n9Be9siFOVz9rkhDjZsRQixDTzK7zsXMIgYh7F0NX3MfBesUHr3Udb37nW0NKBgLE8iG
         COsuhXzsziP3TaKrah18eMY3T5m2+KBWI13HSIHIxs5hwCkdfmbz/r1ZWNeIIS5BJ8Bg
         h7NYi76sATVxJuB2q+DfrXqXumjhAO41M42CIhGRO9Yx7OyJjiGsOkLnt/FnYrH8gmwJ
         lyUA==
X-Forwarded-Encrypted: i=1; AFNElJ/N+SqaAzjguaXiCvDOrZPZktSyBpIUw2/av94BM6CthZ9nKxWj8fUqHKMHKNpbBUeyeu8jrXVwcVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7zrZ44UNmAXMSIP54NtmUAGrtToUiEi1w6V4T3R+csZkbyNk
	jz14Hg9966+W+n1TiCAVWrE6WPvvQzSnPZQeTU3uGeq5kVVQlZRefw/0kLnkzg==
X-Gm-Gg: Acq92OHjpdveOBns2lr71tdbI7f+Nd4PGjUeD5l8S3/p9UoGiU5bIbHVJMbh61VsIFs
	PffewcwWD/hJwUaeg/JrPeuREQ7oHsmqfH0vnR0h28B82WipD13ktjecVITbisZzoD9KTxBHCFQ
	Bg6T0+IfAvB45Z2qn3emO0YCuGx9M3DmGZWMFWAw7VqSQZgLZ9Fjmmhjs0cW1TiRc2eTDiULNpx
	hA/aPAxHOQraEcAKACsMqtlA4tb9ArBeCE3W6E6wGlebXuvp1y2xsUTqRZA94XVKyKCA6NEY0u9
	Y1bjMMQO7eZRHJZ0BYIXuwfexuyokYQFv7ALoUcfbVvSJwvekxRkihSO5MTvKw98gQmI1VfexsU
	bZ3psVzLDtMSDW1nlHnAAScyrsdzKGqcBPwGHmUBhteCLN6OGVkA//fIKXRY4ORCpZu6FsAxwO8
	0cdtSe3h1viWV2PCZCBNAw+8EieangBgSRK6MJPHZ7K0qM1ZlSHP22TXN8Uf9yBSfiNQ==
X-Received: by 2002:a05:6000:220b:b0:45d:d092:ac9c with SMTP id ffacd0b85a97d-45e5c59f691mr4788790f8f.33.1778842155465;
        Fri, 15 May 2026 03:49:15 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3ac86sm13975602f8f.14.2026.05.15.03.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:49:15 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 15 May 2026 12:48:59 +0200
Subject: [PATCH v10 1/4] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-orangepi-sd-card-uhs-v10-1-094af27e310d@gmail.com>
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
In-Reply-To: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
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
index 24becab4c959..06469c364eef 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -1214,6 +1214,19 @@ usb_dwc3: usb@c0a00000 {
 				status = "disabled";
 			};
 
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
+
 			emmc: mmc@d4281000 {
 				compatible = "spacemit,k1-sdhci";
 				reg = <0x0 0xd4281000 0x0 0x200>;

-- 
2.54.0


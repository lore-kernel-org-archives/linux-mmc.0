Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2A324B20
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669879; cv=none; b=eSf0uwMO6MCdl/p9Jqj5xopIapfwc/64TjmZCHPy6YTI76w/BNQ4XrazkXoJ1tG8kCpKfP+GNjxHqBnchP2CWPstyDSrBnNGGXqawyimImOYOlPw3up+q0FV/WzcZUnzBRETfme9zGDCFaI81HK1aTofIdFYgnCZ9qKL/6ZB3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669879; c=relaxed/simple;
	bh=VV6Uc/fQnB1CO6vc4YbToyuLpo7rYuo3u8QPLHi0LME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DP6GMphNIuxd4ntAKBM56ycrqlCHl1YVH+wUYQgpYbW4yQNairctgTIo88Vi2WR9mszx4LE2taEEYPDSDCqX/3fQgm6sOMOssK8XNE+PlypAbHK6HqYOscN2YXzDCe8VSs7hNjYOiWsDZwGNflkkGGsuyQp13OKWaKSvzLgtR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFl0H1UO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFl0H1UO"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so4553294f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669874; x=1774274674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCiQ7r9hHEhSUVh9d7R+U0a5N1ipko9lEeJud3TU6bk=;
        b=hFl0H1UO70v5rzFIl+vpmFU9pGZKT1tze3YuJFp9rNy0KLahvcBlvPs93fIjZFVaCc
         Y9tC8eql64NClqQckpzvL+de+cw6tubNlMffBLGxs7IOzs56KGhtAX/hDLecsyw8wz57
         XiDborgL+JopxGogyrsQ7KeKeXJ41jYHuikUXpZmdpa5Saeg4TZp5xMIpcevZWEe4b4g
         ldzDorvI/UQopK1ugIhbgE+QsZIewvrZCBRazB2POSAkUHAnL/2aAbZLa/EdZah3UlyB
         RHyqhcuWiuHST8WIdAe59gK39CmRzFoo2Ygpr13O8ZvsAWWV400bSwl7JcrVp7rIZ/Z3
         MaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669874; x=1774274674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rCiQ7r9hHEhSUVh9d7R+U0a5N1ipko9lEeJud3TU6bk=;
        b=ixkFyLpzinCsCUeFm87OT7QxhCLRlE5rr1J1XX8Hks8oHTuIqaLdFkQ8jU3OgTH6fw
         XiVlmvjOCVK/sfw1EDbdBZnAne4JF7R1QawxJ2bCwVIcwWTds/4klFgrO/Yo7LoB1H7L
         Bfe7pEwVgeOnSHHg8/dKKxcqqY8epPYwaIlufOAr7yIIJVgCXHPJWdegKBCZTLP2xQfE
         CNtb32rBSjAv3WwrnIXGYUxQ8IlUuyFz93uhb1NgvqJ52heVd1S6IvkRmFCVqn1nuQOQ
         Rwqj+cfEjt3driOzUFxrYuZBD0oN+oPV0OOIFsR3XsczIzMYOshBlmUqJZXLLN+WfIH8
         olzA==
X-Forwarded-Encrypted: i=1; AJvYcCX/jz+U2XuT3B/SoQozLShLgGDVKFFaX/rLdAqrjn9TXUVYeXVtXAVVYwnsdQm6+JBpX+1lcJtQoOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyggVrfQlvG/eIMec/LRLdKgxt27D2E0BFBonyHTVr88kUgKtxX
	QmjW0r7biP5wY7ahb0W04GUC5PplsZYL/oYvUm/RGdVv7oBKvBkxcQBO
X-Gm-Gg: ATEYQzyxvXCZglrrd68KAO+b/gn9xK07v4h+UaY5ZkES6gJJJbQ8mpcLSZuRgIqK9F7
	OU8UYS69h+F0fTY/xqNx3CDWzzawwaRjNxcmGXJBw92kTOldfiOcv79Txf4LqIm1IkTEG+xdsUn
	S4g3RaGdzNtKubGuwBQZ8ndXLQhROztTvgb2na8i7mXQPXZzu5VhWe0ij7DWcLoUyvTvCf8DMK5
	CCp4pmx4aA2/ltfv/CNDWCqpS+NVbElOKK2lc+jJR4E4CHWKi0Eba4vUTA5NTXB0XZNl5NqjXgV
	tjNAb9oPbYblUJfh6YsUJNiUuzOYHVsO+Oxea7w4VSSobDLeNI7DOKTFlNvoQg+eBtWaJFc+Eto
	UZls4UzAuZgd9Od6oL2Cm1Z0COovPykVigPGhflfydkVVGiwJ1uX1EHOdn723Xh3dcaA3uBeJ/M
	5ta2H4dIev9hgQP4T9pKT/2o1u6CrKV98HohtA7hYkwhfLh8Q4u0dyXfXbHhid1RVH
X-Received: by 2002:a05:6000:4012:b0:43b:433f:48a9 with SMTP id ffacd0b85a97d-43b433f4a42mr8024247f8f.15.1773669873688;
        Mon, 16 Mar 2026 07:04:33 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm20698725f8f.0.2026.03.16.07.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:04:32 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 16 Mar 2026 15:03:32 +0100
Subject: [PATCH v3 4/7] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-orangepi-sd-card-uhs-v3-4-aefd3b7832df@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>
X-Mailer: b4 0.14.2

Add SD card controller infrastructure for SpacemiT K1 SoC with complete
pinctrl support for both standard and UHS modes.

- Add sdhci0 controller definition with clocks, resets and interrupts
- Add mmc1_cfg pinctrl for 3.3V standard SD operation
- Add mmc1_uhs_cfg pinctrl for 1.8V UHS high-speed operation
- Configure appropriate drive strength and power-source properties

This provides complete SD card infrastructure that K1-based boards can
enable.

Tested-by: Anand Moon <linux.amoon@gmail.com>
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
index d2015201f8e5adff8bda75712036b8dc2b79bcb5..3952c4d0ecfb26e9d215955ca8791243bbd1dab7 100644
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


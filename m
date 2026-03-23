Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF538C2DF
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261179; cv=none; b=k/qvaMhkho5Qljs6Xl1TD4ZME07BvkHwIMnbcrfTIwinbGQ4hobdCRcgPO6ld4CmBV07ABCRLF2LIvnDqQQjAVSVr8pmto9huNbN1GwA3ut7ybqShwIbOBWcS5fpNMikrzz8IbW939MDBzi2tc8RXnGmIx1MWh4S5HCW1dINO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261179; c=relaxed/simple;
	bh=/gTW2KIO8YWPZZvIgANhTUBFOJqFsbasdAHU7V4LVpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dw8SJ7ntsozq5SdoXK+dyULK0DbaX/pnl8xy8GwUaznyhQMRxEuDZ1T0lqfuWKVXDwoaahotB/xDipw+ufP8cqLWdtlWWxtAWEZOvP17qAdKmaOL+YuaCVH7SvM7ydLAkPB+pFm7rVYXvspArbYmWpO5mszoRe1BRnJIXwIgAEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij9/0Tra; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij9/0Tra"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486b96760easo43142455e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261176; x=1774865976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk6FKFUlfen7jg7q4m1JiKEm7wDVFQJ1+nZHyEziSco=;
        b=Ij9/0TraLyxmhOJPEk+ySNdPybaNFhfLdsqtYYnC8pWkjTTszOvoqYFUGNcPmcZQRC
         LZMp38NIwphmOgv4HlMNolGgy0FTseuftS1Bx/AP4el+kSop17ByMw9H1KXSZuz/fZCc
         qzkgJSZlHSemCGCb3lWocd6LjKAR/bkiRnPvRio519a506ov8rt84/McxcdSNfQjQtHX
         szT+EelOPqixmb7nSLxkWXKLGOGDU0IB1L3UFDmc/v3ZNFtx9tAMq+8OJG5IWQXxZcYg
         Om9eg8UgWTEBa2rAA2SeyMV7XLAZJqPWRCMYsnFbxJYGjDPVj7Elv3O9/Hskj7ZMWOyS
         FiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261176; x=1774865976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qk6FKFUlfen7jg7q4m1JiKEm7wDVFQJ1+nZHyEziSco=;
        b=tUPw6Gg/raAZW3AOm90oByrJG2V02lQuvV6wplQJ0dTSZT/qo7fz1GvTRW3DQUId2d
         TvgJokorxtDFIiYwnpdXL1Ei1YAUDuNS/rrRmwF8pxAyiDm3tSaEnUsHgrBOA6El9xNy
         8PbSRB74N67jpnR6NGtrw64HqEAYYwe9YxTkz0QB7eoUPdf6IgK21IhlZ6QnIOkmHyzm
         izAEYwUERFONr2NI/RAKj4g0DkxYpSFzgculHs0qv/OlWXPOlZNhUvFN9XBxoBn3G+yy
         2CVZO/aO0Ve+XaKjZtiE3ybi/uGRrS8ODJiLX9SEwdeu5/IPJIR2JK0tmsCujh8hx3Rm
         v55A==
X-Forwarded-Encrypted: i=1; AJvYcCUwySQktr/m5D3OTytKPRK6DMN2sLNBS6gT/jJ7j9zZlNymPvCIlaFaa0PmOwf76MDI+fpmecR+bs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrvMGRObzahY3TZDYYlJCNchKyITgNt9upcz/Gie5mZVRHdez
	o/FhyjQv4LcuWaE2YWQHGCWHQ8ebAK4Zg2JR873WGgmqmroZD8XIM8Am
X-Gm-Gg: ATEYQzyqPFOgne84BabUhEvY8L3tdF2tqp/IkEsYW53OzoDIZZLRuKiL6tKxr6vBxuz
	trF/UkroU+oeZXhqPgMY93mkoWVvupiO5+paG9hfzGjyFtEKY4g/PoPOjQWYHSoeYDlNUXcODbW
	/VfIv9QWdO8D/eXihK0Cg58rCz2i/LcpnqVe9ECv6j0HgG0L54/yF+QrKs+g+Rr3YkOlvehK1mb
	/UXediSzyxiZvqdxArrzP4V0R0SyxkSWRZgzrKYTMh+wKg+3/a4TyseJtSyaMQD8u1R34gczkRJ
	NGQrAeVrvKdTAQXPI4PHLzYDq1vYzlrDUPUsFF0gxZ5AddtyivMmiHDZZ2qHyVhDPpxPZlNVoPH
	tatOUcLEPJ6la9it9j7vo9sFy1C2M73a7FsySW21tcK2D7IVD9t3JeLzyVs+8LFwlQ24Tmo0ZLu
	UXOaH0m4+9/topBjbQwBxvFzUwgH2FaTGqSFWZVkXLIYWMUrDa3EjyUDMzg6gKp+ZM
X-Received: by 2002:a05:600c:c167:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-486fedd4143mr159160715e9.14.1774261176024;
        Mon, 23 Mar 2026 03:19:36 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe86acb0sm78755445e9.6.2026.03.23.03.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:19:35 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 23 Mar 2026 11:19:07 +0100
Subject: [PATCH v4 4/8] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-orangepi-sd-card-uhs-v4-4-567c9775fd0e@gmail.com>
References: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
In-Reply-To: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
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
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
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


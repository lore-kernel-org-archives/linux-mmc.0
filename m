Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07A41C0C8
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464450; cv=none; b=ohI31Hzpe2kPvvJl6r0M2VYBeoiM2aohdeeFkYmaToj03OhsPUPnAESUKO/DKvzPEMlLJGzMftdPNFJcR0hMUPxSOW+gFpI0Bn6Qfs9AFYD2AnJI9NTBBmnnm3DVrHzOnBS68RjydKKYchssKVVqqC9QmCDh9iQySqlTRuYaCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464450; c=relaxed/simple;
	bh=dcEFhqPvKdwQuanA4mTY4Hc01u8XbBg6NksC+/+CuBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYalDIEAcyFUdtKh3HmouwhJ+5v46/9Hvsh8umt0aaVuQViXzENVaBUltXgedSQwI40keT0GjPxyW1zr66VAOdiFoyZ/QddM52OarlPYt/SPU1W5ruV7rmVkG2C8m/ZJsvQm3Rd71tbsPDPWk5yVNlqbMlFNA5fnnkKF/fmMAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2nmc/UJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2nmc/UJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so34300525e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464443; x=1773069243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz1rwkI02gKLCCAejR8NRcSe9CYDdLI50V/yGcp3k+8=;
        b=a2nmc/UJNJ2fU4F7yWSUwWs5G0FeY0nAqEfp0qttKLf4N+EKgMrxUZH2RK+8o+iMNJ
         EZMERFdKFb32af7/Ge7Yl/s6NP6Iz+7Kn96czf7DhBEoOqf+E63fF3bj0sX+Iw7ZMrDC
         67SsFMD5SF7M37FtGrSou8RekQmwA88vRMW+kLwvUD9I486hzHg7WVMLsguA9/UKlOid
         /jpm8EoYnzmufNktRPISdPCpUg6LWpW9aY9WMirVUItPQnX24IDXHoJiP/YZTXAcE7I9
         DZYc4Zrvb/cqpqZLoQcAxELcbqmaRwDr+oUYZeGDGvC3Npg62TsyJ085v2SLkF2SnmrJ
         uAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464443; x=1773069243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dz1rwkI02gKLCCAejR8NRcSe9CYDdLI50V/yGcp3k+8=;
        b=ra8DWIm/pBZt6lJqk0JQNlKR2C0GtQ9oW9mwHooLJ+b3A7ReCrGien3QCeb4x+389h
         q00nETuHBTX24fIISpf1ZZMyH4u0TWkJ1NX6ZfPyn0ry42yEGgiqwy5cGL/fq8ZJhfK3
         nw+Z8+1c2YX63Bgy58QRKMhcr27gOm8hHSTrHLmCb4tgrTTbE0dNs3I7K1lIP3YDg3SU
         HC2fmBrdDYCZnJWujSrTGykykWYtMyPvBAeTUqQ5dsQZb6lk6y1l4KJcNde4E/yt6Tng
         dbzX4UjpIzieWDLl+2eh6oV+zsqo2SDkO+nfWGmG8jhFmadLEGSKG01CpCXQG/1h1Vmu
         d70Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvyOt+hzApDjLyHNG1blxTNL5X/HUOsyEnqwvqlzYulkWopzUXtvC9LMzMs6HBYoKHz2NDXXVt0O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIotDvIFepsMtoloK8ZoyF/E+oZgdLrgq+2nFLUxom7GJtLKK
	ZzmfAWbJxWyai8VygiQRp9V87CbeitrzU3+i6RUiQ1btZdYCqNpgbmXd
X-Gm-Gg: ATEYQzw9VKEMQs5ZAf4g8iDu2SV1YvTqLGwAEup5xd3h76Uhq7sSy4a5mv0R5IEngNC
	X95oy5TZzpr3nqF8gaeVURNUX/iJNt1LnMOkb3wb7S05iu0p2M0zOEgrYBsJnedhZui6+y6dB9V
	5M0YpnnhKtGJEaR+KNsrDIOYWWlmhSkQAcNOWn1yO5KsFsomkrrxgW/d/jPHIjy6lsGLNEMaRF0
	pFGQtleDV3wZSxO0nyqqaMZ24qQvPvyZJqCKKTQVsst6KmHJ0j9ptpkWIEfWNu0BFBJr3oKiP8i
	61C46NSxQ9hrO6OiZgJ3sdt4qr00Uen4nb/0tU3soy2dcvH4O3Xu/Nj+yo3maFdGIFEW4ADeqBZ
	66YWkOjxwPnPt4Y+aIA6QWGK5tjCh3nuYbEacNtQK6kJeDSn+tf3ajzGCf8u5p7XeEjsRgtRUdp
	8YvoA4zLBblACZu0PD6LZu5dGsLsxdR+h4/oHJJMLR7XuTJiqr0DgdUnH+fYAjfRMP5Q==
X-Received: by 2002:a05:600c:4e16:b0:47e:e414:b915 with SMTP id 5b1f17b1804b1-483c9bb6564mr218276695e9.2.1772464443134;
        Mon, 02 Mar 2026 07:14:03 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:14:02 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:29 +0100
Subject: [PATCH 08/10] riscv: dts: spacemit: k1: add SD card controller and
 pinctrl support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-8-89c219973c0c@gmail.com>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
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


Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82D3D0908
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367936; cv=none; b=npfHdtMg9TsBw/v3OFepuhNI3nCMDjHXJi1x7gAbeM17IRrobSqngW+wL0WOjUh5L15J1ebAMXA5P3gWlMvxJCA5w3mdEoayIMTR/QBbYFz0m8L5X9bj1fhdN7tdyivcQGRjumNnDyzAf9X81W8hMgNP2anj9ZLaucfGpCJr5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367936; c=relaxed/simple;
	bh=VQRJctfRoIx43q7B8zg+JoEZ2DSkfCYQEsjoCD9AsiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXI6Z2u7qJgsoILrAf3heRvQH74TnCOREPm7jOdD10oxxfWzNC4PKF3liL3Arvkz42S3vTih+H+micx4xa7e/1M9oHhn8niLD0lmgFQsZ26slsLSyaT5RBMXAC7pXNgw9DJj0PiUoIWdXN2h6anr32hw0UFa81H2+pxhRzw+3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fLI7VdWx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fLI7VdWx"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ecd7216cso1463922a34.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783367933; x=1783972733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YlT3WnM+OJST3BZ/4dqDMJmxXkYErU65jgqgDcmWdqE=;
        b=fLI7VdWxmVioG1DzkOAcOiSBU5UPE0uYjVuDNI3h9Q9XAdYjV09FY0Iwe9T5gmFDOM
         rpg9MLdvMrkObb7Vbz1Ph/oSP63fNu3kFrFB51YrFEdCeP90+k8O1p4wUqeD0x6fb5z6
         oNlg583yDuJQNLkRlK6n6XJwqfqnTngCk7CBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367933; x=1783972733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YlT3WnM+OJST3BZ/4dqDMJmxXkYErU65jgqgDcmWdqE=;
        b=YrhHAH5qLVOQlaxECoo0BoJXUx7ZCTfje+zmLJe/MpK5julPv4B1smn6RsJpssXHl7
         MBu7GsM40UU/LsRMs94DBxaniLJumsmzLCB9GWA0d1XJtQqZcmkfyG71vzh+xdff/ckR
         uZfrT8NK7z2kG6jcj/XCEqpQXG/0FRkG+DuA0gT/EMiphq/fAZuxVu22d9Du3FBk2B4M
         D7ukjidS02ktSOwNLrUlw3HRE/uuimJl8izvo/msGriQTy2g7jCz4OKwraze1/Sigt9R
         HVNKlpCbrYgXLW2SwVKa2I1HSdPNTWhyaiqSSdGzpM82zgv4xQAvi6z4ooRGOthh0jp5
         um2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9EXaKEQ7CMJjRiq0IibFLE60iy72i6RhvkWzwplb6FRdcYCTGlWJotzjo2S3p69yRQIrzTviIU1Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9MjOllyG1ZC7LlEunFjW0WC6ZDpHYiVOaAg6JBH/P+B+SVar
	MX0o62xSRyOQX8S2Atnjyf+Jgn0T48wUZyJhvJ7jcjLY7fBv6GprRjati7n0e6lglQ==
X-Gm-Gg: AfdE7ckNo2ksIGwGZFCVwSoB4f5LhTcq1nV/m9hPvyAVNGWs2en2D1gQgLfOAeqyn7+
	TAy+xsSzTfmAOzOjdOtWTjaL1kwju+WtLPSMA3YpiZTFcCLjFE4t12Ocdg5C4w8MQOLnPG7iEMD
	sTu0Vfj/7z/odIUF+JdZO+lBQ7Rpk709XpSUDGnwNMoVo8lL2mKVVwjiVaSlRVpA7Sc1nkj6hUO
	uSTgvCcsX7Sa2A+xUDq5+9Lr4zHcF/KAHlisI98Qs7CpQ/lbyJhBeAY3S3juLEybntI//VLlvCU
	BwBqDDRX3+uhvXWLnZwLoQxAfa5eO1vADShZPVZanwVwK6/UP14Ho5K1pt8UCTwLCHewpo8hor7
	sLB41IXZUfuQT9F0LM3LImhf1tuKGJnH36aKNVQL0nux4jX+z3xI6Dil8I4TL93T7V2gUyzNI3D
	AMFFHcmi0=
X-Received: by 2002:a05:6830:4882:b0:7e9:3765:79c2 with SMTP id 46e09a7af769-7ebb22251dfmr1322732a34.12.1783367933546;
        Mon, 06 Jul 2026 12:58:53 -0700 (PDT)
Received: from chromium.org ([174.51.25.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542d017csm12161834a34.8.2026.07.06.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:58:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>,
	linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	Albert Aribaud <albert.u.boot@aribaud.net>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jamie Iles <jamie@jamieiles.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Michael Riesch <michael.riesch@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Yao Zi <ziyao@disroot.org>,
	huang lin <hl@rock-chips.com>,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 00/12] Add support for the Rockchip RV1106 and RV1103
Date: Mon,  6 Jul 2026 13:57:56 -0600
Message-ID: <20260706195818.3906949-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds initial support for the Rockchip RV1106, a Cortex-A7
SoC aimed at IP cameras, and its RV1103 package variant, together with
the Luckfox Pico Mini B, a small and widely available RV1103 board.

The series follows the structure of the recently merged RV1103B
support. The clock driver is ported from the vendor kernel and is the
work of Elaine Zhang; the pinctrl data also comes from the vendor
kernel. The clock binding header keeps the vendor clock IDs. As with
the RV1103B, no resets are exposed yet and the CPU pvtpll is
initialised but not calibrated.

The devicetrees cover the devices needed for a basic system: UARTs,
SD/eMMC, the SPI flash controller, SARADC, watchdog, GPIO and pinctrl.

The series is tested on the Luckfox Pico Mini B: the kernel boots to
the rootfs wait with a working console on UART2, timers, pinctrl and
GPIO, and an SD card running at high speed. It builds with W=1 without
warnings and dt_binding_check and dtbs_check are clean.


Simon Glass (12):
  dt-bindings: clock: rockchip: Add RV1106 CRU support
  clk: rockchip: Add clock controller for the RV1106
  dt-bindings: pinctrl: rockchip: Add RV1106 compatible
  pinctrl: rockchip: Add RV1106 pinctrl support
  dt-bindings: soc: rockchip: grf: Add RV1106 compatibles
  dt-bindings: serial: snps-dw-apb-uart: Add RV1106 compatible
  dt-bindings: mmc: rockchip-dw-mshc: Add RV1106 compatible
  dt-bindings: watchdog: snps,dw-wdt: Add RV1106 compatible
  dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible
  ARM: dts: rockchip: Add support for RV1106 and RV1103
  dt-bindings: arm: rockchip: Add Luckfox Pico Mini B
  ARM: dts: rockchip: Add Luckfox Pico Mini B

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 .../bindings/clock/rockchip,rv1106-cru.yaml   |   59 +
 .../bindings/iio/adc/rockchip-saradc.yaml     |    3 +
 .../bindings/mmc/rockchip-dw-mshc.yaml        |    1 +
 .../bindings/pinctrl/rockchip,pinctrl.yaml    |    1 +
 .../bindings/serial/snps-dw-apb-uart.yaml     |    1 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |   30 +
 .../bindings/watchdog/snps,dw-wdt.yaml        |    1 +
 arch/arm/boot/dts/rockchip/Makefile           |    1 +
 .../rockchip/rv1103-luckfox-pico-mini-b.dts   |   93 ++
 arch/arm/boot/dts/rockchip/rv1103.dtsi        |   12 +
 .../arm/boot/dts/rockchip/rv1106-pinctrl.dtsi | 1398 +++++++++++++++++
 arch/arm/boot/dts/rockchip/rv1106.dtsi        |  299 ++++
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-rv1106.c             | 1107 +++++++++++++
 drivers/pinctrl/pinctrl-rockchip.c            |  208 +++
 drivers/pinctrl/pinctrl-rockchip.h            |    1 +
 .../dt-bindings/clock/rockchip,rv1106-cru.h   |  301 ++++
 19 files changed, 3529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1106-cru.yaml
 create mode 100644 arch/arm/boot/dts/rockchip/rv1103-luckfox-pico-mini-b.dts
 create mode 100644 arch/arm/boot/dts/rockchip/rv1103.dtsi
 create mode 100644 arch/arm/boot/dts/rockchip/rv1106-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/rockchip/rv1106.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rv1106.c
 create mode 100644 include/dt-bindings/clock/rockchip,rv1106-cru.h

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
branch: rv1106a

-- 
2.43.0


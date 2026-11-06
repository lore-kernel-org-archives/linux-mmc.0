Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957451;
	b=CECUDVNIkSy38Ajqdz/AI1t1wrvG0cHhqPlfGSlZ9/S7dGYY09wZEbrUZe7rqy2Js+Xq
	 t+Jz2ltQdxyhR0Ue0r8fGXO1as5WZfD1UuPIFdrBcmD9LCRLzjZmjDqA5dLStgBEVXqpS
	 vV+zxz2VW9Oo8197AoclwFfP2o80PTEojD3/7/EWkcwQPVO0e2o+Pw/Wcr5CSV6bJzFzA
	 id5Zz+XvE7U2LaiEgZfxJXea1mazmb44+H4l5jTxXneDY5o1v1r4mikTJOUTggDnYs9P0
	 eHAY9dEHraeke6xUhfCObzH5uYxATBpSH5Q3YOjKsgr/W58yWZGPVbb4xbrqZokv6zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957451;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=sS9SQlly2RwS/6KrN94iJowJBr0dXwkGaUXpEOiPodI=;
	b=nPGXoh3A177x6RAgauI2wMlSAv09MYpd6cYeXDaVtGnz4HlXnzTzBviWsW8XqPyZ3T0i
	 +2oA6s0IZffmXigQctzkSVbw6E4tNJExs4ayIr5O1iag3vfcCAOxI9QW4raTN9Xsu6CZ2
	 7ut7ybZZLeHM4x6Ijp2olQUCL0tKBRtE+0TFnxs63fko+/CUf0Xf/aCdwydzX1sSYJTxK
	 VfhU1SeFFHi08Fdl83Iw6KOfOaYSh8YKZLxQG8DUEM7bvmeLwrvyS4IWf0dHt0ZwFCl+R
	 Q5lQoQlyom1czAbko7f91xlFKEkaHfgls3XEyUEiXTvpz8+rOq623/F9E4JTZDlrAXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FYjIfABk;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96075606A328;
	Fri,  6 Nov 2026 09:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96075606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FYjIfABk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6136BC69166;
	Fri,  6 Nov 2026 09:30:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB4D25FFBC;
	Fri,  6 Nov 2026 09:30:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12D0910329258;
	Fri,  6 Nov 2026 10:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957438; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=sS9SQlly2RwS/6KrN94iJowJBr0dXwkGaUXpEOiPodI=;
	b=FYjIfABkowisjeRn+CSvLUTjWLuxx+3kviyjc/anqGF9q9GxCZTgw0wpsJ8FJ8ti6FhDe0
	L/4Js4Usj3Twoh8hMFsbgA2n+iE1ZjjULyXLoUYhOm6r4EYOFHaFPwRWhTMoUIMXkoASI6
	WAtAjtqt4nozRJVg5mQLbG1Rfu4vRJj87hVCTTSHic8EROes+yJaPkLLHiQcJB5zjSIJF9
	s8LPfcfr0EIoXu5LjAaihMo4jqU/8/3yM01epv48Yq8rIYgIH648tUnK7J77TfsUi+L4Y1
	VxGozQieYhe0nmIyWgS+OpgjlDIKTSbs3oztQTFJsFrXy6HYjVT/GK4JwNdv8g==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH 00/25] riscv: add support for the Metanoia MT2824 SoC and
 MT5824 EVB
Date: Fri, 06 Nov 2026 10:29:57 +0100
Message-Id: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABae7WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mz3dwSIwsjE11jo0Rz80QjE0NzSwsloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0ArD81RGoAAAA=
X-Change-ID: 20261016-mt2824-32a77a241798
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

This series adds initial upstream support for the Metanoia MT2824 SoC
and its MT5824 evaluation board.

The MT2824 is a dual-core RISC-V SoC built on Andes AX45MP cores. It
integrates two 8250-compatible UARTs, the Andes PLIC/PLICSW/PLMT interrupt
and timer blocks, the AX45MP L2 cache controller, a simple reset controller
and a system reboot controller, the ATCWDT200 watchdog, one QSPI and eight
ATCSPI200 SPI controllers, a Synopsys DWC MSHC 2.00a eMMC/SD controller,
and a Synopsys DWC2 USB2 host controller with a reset-only USB2 PHY.

The series is organised as:

- patches 1-14 add the device tree bindings, the Metanoia vendor prefix,
  the RISC-V board schema and the SoC block compatibles
- patch 15 adds ARCH_METANOIA and selects the AX45MP errata
- patches 16-23 add the reset, SPI, watchdog, MMC, PHY and USB changes
  needed to build and probe on this SoC
- patch 24 adds the MT2824 SoC and MT5824 EVB device trees
- patch 25 adds the MAINTAINERS entry

The ATCSPI200 driver gains optional interrupt support for PIO transfers:
when the controller IRQ is wired, the FIFOs and the end of transfer
are serviced from the handler, with a fallback to polling when no IRQ
is available.

The DWC MSHC controller on the evaluation board is wired to either an
SD slot or an eMMC through a board jumper that the SoC cannot read. In
the absence of a fixed card type in the device tree, the driver probes
the eMMC first at 1.8 V and falls back to the SD slot at 3.3 V. The
controller also needs custom tuning and HS400 PHY DLL handling, which
is why it has its own sdhci_ops.

The MT2824 SoC contains other controllers not yet exposed (I2C, GPIO,
pinctrl, Ethernet, DSP, ...). This first series allows accessing the
evaluation board via its serial console, and all its storage options
(SPI-NOR, eMMC, SD card). The watchdog and the USB port are also
available.

The driver changes do not depend on the DTS at build time and are gated
on the new compatible strings. For merge ordering, the DTS depends on the
ARCH_METANOIA Kconfig entry (patch 15) and on the binding compatibles
being accepted. The patches can therefore go through their respective
subsystem trees, with the Kconfig, DTS and MAINTAINERS patches going
through the RISC-V tree once the driver and binding patches have landed.

The series is based on v7.4-rc1.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Benoît Monin (25):
      dt-bindings: vendor-prefixes: add Metanoia Communications
      dt-bindings: riscv: add Metanoia SoC-based boards
      dt-bindings: reset: add Metanoia MT2824
      dt-bindings: power: reset: add Metanoia MT2824 reboot
      dt-bindings: phy: add Metanoia USB2 PHY
      dt-bindings: cache: andestech,ax45mp-cache: add MT2824 compatible
      dt-bindings: interrupt-controller: sifive,plic-1.0.0: add Metanoia MT2824
      dt-bindings: interrupt-controller: andestech,plicsw: add Metanoia MT2824
      dt-bindings: timer: andestech,plmt0: add Metanoia MT2824
      dt-bindings: mmc: snps,dwcmshc-sdhci: add Metanoia MT2824
      dt-bindings: spi: andestech,ae350-spi: make DMA and interrupts optional
      dt-bindings: spi: andestech,ae350-spi: add Metanoia MT2824
      dt-bindings: usb: dwc2: add Metanoia MT2824
      dt-bindings: watchdog: andestech,ae350-wdt: add Metanoia MT2824
      riscv: add ARCH_METANOIA Kconfig entry
      reset: simple: add Metanoia MT2824 support
      spi: atcspi200: add optional interrupt support
      spi: atcspi200: allow building for Metanoia SoCs
      watchdog: atcwdt200: allow building for Metanoia SoCs
      mmc: sdhci-of-dwcmshc: add MT2824 support
      mmc: sdhci-of-dwcmshc: add MT2824 tuning and HS400 support
      phy: metanoia: add USB2 PHY driver
      usb: dwc2: add support for Metanoia MT2824
      riscv: add Metanoia MT2824 SoC and MT5824 EVB support
      MAINTAINERS: add RISC-V Metanoia SoC support

 .../bindings/cache/andestech,ax45mp-cache.yaml     |   1 +
 .../interrupt-controller/andestech,plicsw.yaml     |   1 +
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   1 +
 .../devicetree/bindings/phy/metanoia,usb2-phy.yaml |  43 ++
 .../bindings/power/reset/metanoia,reboot.yaml      |  34 +
 .../devicetree/bindings/reset/metanoia,reset.yaml  |  40 ++
 .../devicetree/bindings/riscv/metanoia.yaml        |  25 +
 .../bindings/spi/andestech,ae350-spi.yaml          |   9 +-
 .../devicetree/bindings/timer/andestech,plmt0.yaml |   1 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 .../bindings/watchdog/andestech,ae350-wdt.yaml     |   1 +
 MAINTAINERS                                        |  11 +
 arch/riscv/Kconfig.socs                            |   8 +
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/metanoia/Makefile              |   2 +
 arch/riscv/boot/dts/metanoia/mt2824.dtsi           | 330 ++++++++++
 arch/riscv/boot/dts/metanoia/mt5824-evb.dts        |  81 +++
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 704 +++++++++++++++++++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/metanoia/Kconfig                       |  16 +
 drivers/phy/metanoia/Makefile                      |   3 +
 drivers/phy/metanoia/phy-usb2.c                    |  88 +++
 drivers/reset/Kconfig                              |   2 +-
 drivers/reset/reset-simple.c                       |   1 +
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-atcspi200.c                        | 255 +++++++-
 drivers/usb/dwc2/params.c                          |  13 +
 drivers/watchdog/Kconfig                           |   2 +-
 32 files changed, 1667 insertions(+), 15 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261016-mt2824-32a77a241798

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


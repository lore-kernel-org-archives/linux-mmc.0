Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795264995;
	b=fZ5IMAC8fP7AAn3Ejx6/FZt8b37ku4GRdMsgpdcrB8nUnr8pKSjYUCFNyjk+vrVe6/S8
	 Ly3b661dJCGYE6+zHnCamdrxi+RtGMeEJXcEyY+jqF4LvB4EeYDrlFBzPBLDHHzcgdmro
	 cj03Rsa1AClaMQsnW8uEvCQ434N/GwJxodqUUCvegikAxf0mgjFgn7djr9edRfCsG12BP
	 i3kfAgbk/nXc9qocpOwqa7eF6AfWwqtBgify0Za5geodpn+egI1MemhwLxjUCLdES2V3O
	 lIfYBE+MSVeA+VhXpde8XkRoeBZ65Xu5qFy7bOpI9bCkScVrUdgGhU233PD9ft6bnRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795264995;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=zOb9PEVS2C/1ywcJv9s/XnghjwOtuEyNegUkrQIYfc4=;
	b=ErKeLN0SBQPaFchs3Wmb92N3iHbXC9lXpXmTf42+jAC6eA/2nRlxGewNSsROPJs1iblB
	 wvx1WFcjdbYB8BygchfuZ+7GPnyWr5q+rA3Zjx5SFQFz4/aZkf2E1dxB/yug2x0D8cyZS
	 d7ATVh/vJYkP58B6P4/AQWK07wg267VIHfSVda63+01J1Jp5J9rL+KDg4XVeAo48IkGwV
	 BMsLNqLBLTjCAZu5RUKaRXKkdrJ9X+ZtP7PMCODB9yuYPNiC2H5c8aSEIYbwfLhd7O6CI
	 737TFOc3nhUQXqUCzM3QgpAUC3KobSXnAag3fB4JIvWhomg8HbT/DCrL3gIXmPUTGcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fqu5QvDD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0DE606A68B;
	Sat, 21 Nov 2026 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fqu5QvDD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795264995;
	b=ge8hsu9frv4RBV8qj7vG5Sv6dtuZi4YGmPFh7hpyG6ptOstWAPCHBaZTwIwpSpu7ffKr
	 DOVerw4t3gKMl41SYHLIgbkbHhQVC90F9vciP/yEbQggT0th4nHSgNK4wgJvhmWde1XgT
	 uS65nZXlPWAA5qvVaUx7T1vw0Ikyfu88iGzH6lUkJeFNPtrrpNlVBRaH7MyWZi1syhFdr
	 6Zm8kAscEQVz8oS/20DYSTeRalaZDEhWpxC9DyxspRpbHMntTbvYvn+LF/F143hUPv3qI
	 yhNdzztHp7rCCD7VUH++BGS7qzhRHDeMlEMPtc0kwj9ptg7vyl2NNDegPpRWGI6XyUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264995;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=zOb9PEVS2C/1ywcJv9s/XnghjwOtuEyNegUkrQIYfc4=;
	b=cpBrqK50tnG/O06HuOeLXkBIWJ/OW2RUcRsgq8dJjRrPzemgOVkT82PkAMDqlXYyoGTu
	 5QpKOrmwtsxVwe8+QL26W3R7WAM7NclexEQ2AfES6QNAeDLsyex+wMaS8E5ZRDHM4gfWh
	 PiEbgSUWPoISclZqaFFjpPoSDU5tN6yrdvE5O6Rf/JFoYfEZr2efCg8TEHY3x63Sy6/Dq
	 OPU2itQLhiBllBKjCFBBHmkYxncx6/QDAa1J4qU71r8qPjg9jURSuJWJhjL32daHKDNOT
	 ang+gVbt9O8s6M1E/zUL6rJUNG3MgTFlt25wQTp4PYPOGRy5+FgfacILjNlpVefIUmw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7BDEB1F000C4;
	Sat, 21 Nov 2026 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795264994;
	bh=zOb9PEVS2C/1ywcJv9s/XnghjwOtuEyNegUkrQIYfc4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Fqu5QvDDlIQzQTVRTUVX3MmQFumkh1po4tp2+RKu1b5e3Fk0CAHv8+FE4157aGslj
	 3g4aP3l0euCofpch3h7MQHgVOxitL9zdhW31Vsww2ucRvJYJre+2D8VJZQcbSHO7wd
	 jyDtoJXb+nWtRg+g7T5qViA1p/XZ/P2e0gc3EcvHm55N3LWKPl5zBVs4TJGEgC02Oj
	 +DxCUdNGPbybWcl3iTveRXborsEOqXhjb7814DNVEJChifXqND09fUFPf1l4GGu7tp
	 5henKvkVMVXC86DKr9B2Vb9AqIiGAihQbIVeKHglAvSCG12UxN4ECnF4a07VhkvfTz
	 Zr0Z/Xy6rx0ug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D46284BC36;
	Sat, 21 Nov 2026 12:43:12 +0000 (UTC)
From: Yuugo Yoneda via B4 Relay <devnull+yogo.0917.sabu.gmail.com@kernel.org>
Subject: [PATCH RFC v2 00/13] SiRF AT550 / YPL514si initial RAM-boot
 platform support
Date: Sat, 21 Nov 2026 21:43:10 +0900
Message-Id: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4Xs2Rq2ZqV4MjHxA7waDqUusEbAt
 Eg0hH+34NVkLjOZeTNBYC8c4JBM4HmUIH0Xjd4k4Brb1azkFj3oVO8RMVN2IEqVr5waUWnKEQ1
 ZXbGBOHl6ruS94q5wOZ+g+IXhVd7ZDQtoqTUSht5/1tMR1/J/flSqyGQ5ZTtXGk3HurXy2Lq+h
 WKe5y9/6ZLGvwAAAA==
X-Change-ID: 20261117-at550-rfc-v1-2591185a2fe8
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, soc@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795264991; l=7040;
 i=yogo.0917.sabu@gmail.com; s=ypl514-20261117; h=from:subject:message-id;
 bh=RX37VfLoCCiIU8nvAlDR8InP85JpRvmsUZOfH2oW5E4=;
 b=RA1yZ18WSjpYWWKhdd8WZP4yYiznOBsXKp4L8kdOXyhRFB24pKbIToGbnhcti+HJBtYt02zkW
 O53W3sMfbc+AHLx4f89psz2HNe9jLtQAx7n54yIzZnQcZUK0fyWbEbz
X-Developer-Key: i=yogo.0917.sabu@gmail.com; a=ed25519;
 pk=TIQ8Tk4xQrxyn8rmk3GI2f5qg/kO6g2KZm7YOOyBHeg=
X-Endpoint-Received: by B4 Relay for
 yogo.0917.sabu@gmail.com/ypl514-20261117 with auth_id=1550
X-Original-From: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
Reply-To: yogo.0917.sabu@gmail.com

This RFC adds initial platform support for the SiRF AT550 SoC
(ARM1136 r1p5, MIDR 0x4117b365) and the Yupiteru YPL514si portable
navigation device on top of 7.4-rc3.

The platform boots from RAM via a Windows CE bootloader trampoline using
standard IRQCHIP_DECLARE, TIMER_OF_DECLARE, common clock, polled input,
SDHCI PIO, and simplefb paths. Firmware initializes SDRAM, peripheral
clocks, pin multiplexing, and the LCD before handoff. The bootloader
supplies the Linux-owned RAM range in memory@c0000000 and the
post-divider counter rate in clock-counter, reserves the framebuffer
via a no-map reserved-memory node, and enables only handed-over
peripherals.

Validation status:
- Hardware: I booted both v1 and this v2 series on the YPL514si
  (v2 CE handoff log confirmed a 32 MiB Linux allocation at 0xc1e00000,
  8192 PFNs, 124805090 Hz measured counter clock, and all three gated
  peripherals enabled).
- Local builds/checks for v2: at550_defconfig Image and DTB build (W=1),
  leaf drivers built in-kernel and as modules (W=1), multiplatform
  CONFIG_SMP=y + CONFIG_ARCH_AT550=y object builds (W=1),
  dt_binding_check, scoped dtbs_check, dt-check-style --mode strict,
  ARM32 bootloader DT fixup tests for 16/24/32 MiB, and b4 prep --check.
  (QEMU ARM1136 bring-up tests were run on v1 using GIC/SP804/PL181 and
  synthetic uinput rather than physical AT550 hardware.)

Initial limits:
- Peripheral clock tree control, pinctrl, cold boot, SDHCI DMA
  translation, and suspend/resume are not implemented yet.
- The board DTS restricts SD to 25 MHz PIO, 3.3 V only, no MMC, and no
  SDIO; SD writes and card removal are untested.
- Register layouts were cross-checked against a third-party AT551 draft
  datasheet and observed CE mappings, which is not a complete AT550
  hardware specification.

I would appreciate early feedback on the overall platform split and the
firmware/DT handoff contract before extending clock, pinctrl, or DMA
support.

Signed-off-by: Yuugo Yoneda <yogo.0917.sabu@gmail.com>
---
Changes in v2:
- Use my real name (Yuugo Yoneda) in author headers, MAINTAINERS, DT
  binding maintainers, and Signed-off-by trailers.
- Split the monolithic bindings and platform patches into 13 commits
  following subsystem and SoC conventions, and rewrite commit logs and
  cover letter directly.
- Select CPU_ARM1136R1 instead of CPU_V6 in arch/arm/mach-at550/Kconfig
  (also avoiding !SMP conflicts in multiplatform builds), and disable
  CONFIG_ARCH_MULTI_V7 in at550_defconfig.
- Replace /memreserve/ with a /reserved-memory node using no-map in
  at550-ypl514si.dts so simplefb ioremap_wc() does not alias the ARM
  linear mapping.
- Update DT schemas to describe hardware instead of driver/firmware
  limits (allow optional interrupts/clocks in sirf,at550-ts.yaml and
  optional clocks in sirf,at550-sdhci.yaml, drop no-1-8-v from required
  in sirf,at550-sdhci.yaml, allow 1..6 match interrupts and maxItems: 1
  clock in sirf,at550-timer.yaml, and revise schema descriptions).
- Set IRQ_LEVEL on mapped level interrupts in irq-at550.c.
- Enable the timer clock before MMIO reads, disable the timer before
  reading/updating MATCH0, clear STATUS after writing MATCH0, and
  implement set_state_oneshot_stopped in timer-at550.c.
- Explicitly stop acquisition in at550_ts_close(), clear interrupts
  after mode changes, include mod_devicetable.h and bits.h (dropping
  unused bitfield.h), follow Input error-handling conventions, and fix
  coding style in at550-ts.c.
- Drop redundant ops/remove wrappers and premature caps/version checks,
  and include mod_devicetable.h in sdhci-at550.c.
- Sort subdir-y += sirf alphabetically with a trailing newline in
  arch/arm/boot/dts/Makefile, and fix strict dt-check-style node/property
  ordering and blank lines in at550.dtsi and at550-ypl514si.dts.
- Link to v1: https://patch.msgid.link/20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com

---
Yuugo Yoneda (13):
      dt-bindings: vendor-prefixes: add Yupiteru
      dt-bindings: arm: add SiRF AT550 and Yupiteru YPL514si
      dt-bindings: interrupt-controller: add SiRF AT550 interrupt controller
      irqchip: add SiRF AT550 interrupt controller driver
      dt-bindings: timer: add SiRF AT550 system timer
      clocksource/drivers/timer-at550: add SiRF AT550 counter and match timer
      dt-bindings: input: touchscreen: add SiRF AT550 touchscreen
      Input: add polled SiRF AT550 resistive touchscreen driver
      dt-bindings: mmc: add SiRF AT550 SDHCI host controller
      mmc: sdhci-at550: add SiRF AT550 programmed-I/O host driver
      ARM: at550: add SiRF AT550 platform support
      ARM: dts: sirf: add SiRF AT550 SoC and Yupiteru YPL514si board
      ARM: configs: add at550_defconfig

 Documentation/arch/arm/at550.rst                   |  56 +++++++++
 Documentation/arch/arm/index.rst                   |   1 +
 .../devicetree/bindings/arm/sirf,at550.yaml        |  22 ++++
 .../bindings/input/touchscreen/sirf,at550-ts.yaml  |  40 ++++++
 .../interrupt-controller/sirf,at550-intc.yaml      |  46 +++++++
 .../devicetree/bindings/mmc/sirf,at550-sdhci.yaml  |  50 ++++++++
 .../bindings/timer/sirf,at550-timer.yaml           |  51 ++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  17 +++
 arch/arm/Kconfig                                   |   1 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sirf/Makefile                    |   2 +
 arch/arm/boot/dts/sirf/at550-ypl514si.dts          |  63 ++++++++++
 arch/arm/boot/dts/sirf/at550.dtsi                  |  69 +++++++++++
 arch/arm/configs/at550_defconfig                   |  35 ++++++
 arch/arm/mach-at550/Kconfig                        |  13 ++
 arch/arm/mach-at550/Makefile                       |   2 +
 arch/arm/mach-at550/at550.c                        |  11 ++
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   2 +
 drivers/clocksource/timer-at550.c                  | 136 +++++++++++++++++++++
 drivers/input/touchscreen/Kconfig                  |  10 ++
 drivers/input/touchscreen/Makefile                 |   2 +
 drivers/input/touchscreen/at550-ts.c               | 124 +++++++++++++++++++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-at550.c                        | 111 +++++++++++++++++
 drivers/mmc/host/Kconfig                           |  10 ++
 drivers/mmc/host/Makefile                          |   2 +
 drivers/mmc/host/sdhci-at550.c                     |  51 ++++++++
 31 files changed, 944 insertions(+)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261117-at550-rfc-v1-2591185a2fe8

Best regards,
--  
Yuugo Yoneda <yogo.0917.sabu@gmail.com>



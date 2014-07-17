From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 00/14] clk: sunxi: Improve MMC clocks support
Date: Thu, 17 Jul 2014 11:08:40 +0200
Message-ID: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41365 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754585AbaGQJKK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jul 2014 05:10:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Hi everyone,

Here is an attempt at improving the MMC clock support in the Allwinner
SoCs.

Until now, the MMC clocks were having a custom phase function that was
directly setting an obscure value in the right register, because we
were not really having any idea of what these values were.

Now that we have more informations, we can introduce a common function
call to get and set the phase of a particular clock, and use this in
both our provider and our client.

Another issue we had so far on the A13 was that, out of reset, the
PLL6 driving the MMC was running too high to be working. We can solve
that by adding two new properties in the DT to setup the rate
constraints we might have on a clock.

Thanks,
Maxime

Maxime Ripard (13):
  clk: Introduce new frequency boundaries properties
  clk: sunxi: factors: Implement clock min and max frequencies
  ARM: sunxi: sun5i: Enforce max frequency on PLL6
  clk: Add a function to retrieve phase
  clk: sunxi: factors: Invert the probing logic
  clk: sunxi: Introduce mbus compatible
  ARM: sunxi: dt: Switch to the new mbus compatible
  clk: sunxi: Move mod0 clock to a file of its own
  clk: sunxi: Move mbus to mod0 file
  ARM: sunxi: dt: Add sample and output mmc clocks
  clk: sunxi: mod0: Introduce MMC proper phase handling
  mmc: sunxi: Convert MMC driver to the standard clock phase API
  clk: sunxi: Remove custom phase function

Mike Turquette (1):
  clk: introduce clk_set_phase function & callback

 .../devicetree/bindings/clock/clock-bindings.txt   |   2 +
 Documentation/devicetree/bindings/clock/sunxi.txt  |   3 +
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   8 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 104 +++++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  81 +++++-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  83 +++++-
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 104 +++++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 106 +++++++-
 drivers/clk/clk.c                                  |  95 ++++++-
 drivers/clk/sunxi/Makefile                         |   1 +
 drivers/clk/sunxi/clk-factors.c                    | 129 +++++++++-
 drivers/clk/sunxi/clk-factors.h                    |  18 +-
 drivers/clk/sunxi/clk-mod0.c                       | 283 +++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                      | 189 +-------------
 drivers/mmc/host/sunxi-mmc.c                       |  72 ++++--
 include/linux/clk-private.h                        |   1 +
 include/linux/clk-provider.h                       |  10 +
 include/linux/clk.h                                |  29 +++
 include/linux/clk/sunxi.h                          |  22 --
 19 files changed, 1050 insertions(+), 290 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-mod0.c
 delete mode 100644 include/linux/clk/sunxi.h

-- 
2.0.1


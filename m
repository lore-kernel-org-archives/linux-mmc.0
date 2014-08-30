From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 00/12] clk: sunxi: Improve MMC clocks support
Date: Sat, 30 Aug 2014 22:02:59 +0200
Message-ID: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53592 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751640AbaH3UFF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Aug 2014 16:05:05 -0400
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

Thanks,
Maxime

Changes from v1:
  - Dropped the patches to enforce rate boundaries on the clocks. This
    is partly covered by the Tomeu, and should be based on this
    whenever it will be merged.
  - Fixed a few typos here and there
  - Added a patch to include of.h from clk-provider.h

Maxime Ripard (11):
  clk: Include of.h in clock-provider.h
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

 Documentation/devicetree/bindings/clock/sunxi.txt  |   3 +
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   8 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 104 +++++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  81 +++++-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  82 +++++-
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 104 +++++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 106 +++++++-
 drivers/clk/clk.c                                  |  96 ++++++-
 drivers/clk/sunxi/Makefile                         |   1 +
 drivers/clk/sunxi/clk-factors.c                    | 101 +++++++-
 drivers/clk/sunxi/clk-factors.h                    |  16 +-
 drivers/clk/sunxi/clk-mod0.c                       | 283 +++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                      | 189 +-------------
 drivers/mmc/host/sunxi-mmc.c                       |  72 ++++--
 include/linux/clk-private.h                        |   1 +
 include/linux/clk-provider.h                       |  11 +
 include/linux/clk.h                                |  29 +++
 include/linux/clk/sunxi.h                          |  22 --
 18 files changed, 1019 insertions(+), 290 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-mod0.c
 delete mode 100644 include/linux/clk/sunxi.h

-- 
2.0.2


From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 00/12] clk: sunxi: Improve MMC clocks support
Date: Thu, 11 Sep 2014 22:18:14 +0200
Message-ID: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

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

Changes from v2:
  - Reworked the get_phase operation handling to call it from
    _clk_init instead of the ugly hack
  - Added the clocks to the A23
  - Modified the output and sample clock names to have a consistent
    naming

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
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  78 +++++-
 drivers/clk/clk.c                                  |  95 ++++++-
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
 19 files changed, 1090 insertions(+), 296 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-mod0.c
 delete mode 100644 include/linux/clk/sunxi.h

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

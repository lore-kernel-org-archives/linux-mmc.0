From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 0/7] arm: add basic support for Rockchip Cortex-A9 SoCs
Date: Tue, 11 Jun 2013 13:28:52 +0200
Message-ID: <201306111328.52679.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Third version of basic Rockchip A9 support.

The biggest change is probably the missing pinctrl driver which already found
its way into the pinctrl tree from Linus Walleij as part of the pinconfig
generalisation and should find its way into the mainline kernel from there.
But startup of rk3066-based boards will even suceed without the pinctrl driver
present, as the bootloader sets up the most basic pins like uarts too.


Changes since v2:
- use common (pending review) HIWORD_MASK clock flag from Haojian Zhuang and me
- pinctrl driver is already in the pinctrl tree
- add core-periph clock that supplies the twd
- split "mmc: dw_mmc-pltfm: add Rockchip variant" into move and feature parts
  as suggested by Andy Shevchenko

Changes since v1:
- addressed Linus Walleij's comments to the pinctrl driver, including the
  move to generic pinconfig (hopefully I did catch all)
- renamed the clocks to use the SoC name of the initial user
  as suggested by Olof Johansson
- fixed the uart address, found by Arnd Bergmann
- address Arnd's comments on the board file (use of_clk_init and friends,
  remove map_io, use real soc names)
- removed Makefile.boot as suggested by Thomas Petazzoni


Dependencies:
- the 3 clock changes of "support Hisilicon SoC" from Haojian Zhuang
- "mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA" from Dinh Nguyen that
  moves the SDMMC_CMD_USE_HOLD_REG constant into the common header, which is
  required on these Rockchip SoCs 
- series "dw_apb_timer: osc as sched_clock, clocks and clocksource_of support"


Heiko Stuebner (7):
  clk: divider: add flag to limit possible dividers to even numbers
  mmc: dw_mmc-pltfm: remove static from dw_mci_pltfm_remove
  mmc: dw_mmc-pltfm: move probe and remove below dt match table
  mmc: dw_mmc-pltfm: add Rockchip variant
  clk: add basic Rockchip rk3066a clock support
  arm: add debug uarts for rockchip rk29xx and rk3xxx series
  arm: add basic support for Rockchip RK3066a boards

 arch/arm/Kconfig                        |    2 +
 arch/arm/Kconfig.debug                  |   34 +++
 arch/arm/Makefile                       |    1 +
 arch/arm/boot/dts/rk3066a-clocks.dtsi   |  467 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi          |  390 ++++++++++++++++++++++++++
 arch/arm/include/debug/rockchip.S       |   42 +++
 arch/arm/mach-rockchip/Kconfig          |   16 +
 arch/arm/mach-rockchip/Makefile         |    1 +
 arch/arm/mach-rockchip/rockchip.c       |   54 ++++
 drivers/clk/Makefile                    |    1 +
 drivers/clk/clk-divider.c               |   14 +-
 drivers/clk/rockchip/Makefile           |    6 +
 drivers/clk/rockchip/clk-rockchip-pll.c |  131 +++++++++
 drivers/clk/rockchip/clk-rockchip-pll.h |   19 ++
 drivers/clk/rockchip/clk-rockchip.c     |  330 ++++++++++++++++++++++
 drivers/mmc/host/dw_mmc-pltfm.c         |   47 +++-
 include/linux/clk-provider.h            |    2 +
 17 files changed, 1541 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/rk3066a.dtsi
 create mode 100644 arch/arm/include/debug/rockchip.S
 create mode 100644 arch/arm/mach-rockchip/Kconfig
 create mode 100644 arch/arm/mach-rockchip/Makefile
 create mode 100644 arch/arm/mach-rockchip/rockchip.c
 create mode 100644 drivers/clk/rockchip/Makefile
 create mode 100644 drivers/clk/rockchip/clk-rockchip-pll.c
 create mode 100644 drivers/clk/rockchip/clk-rockchip-pll.h
 create mode 100644 drivers/clk/rockchip/clk-rockchip.c

-- 
1.7.2.3

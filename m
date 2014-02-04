From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/17] amba: PM fixups for amba bus and some amba drivers
Date: Tue,  4 Feb 2014 16:58:41 +0100
Message-ID: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patchset fixes the PM problems you yet when combining CONFIG_PM_SLEEP and
CONFIG_PM_RUNTIME. In principle these drivers did not manage to put it's devices
into low power state at system suspend, which then this patchset intend to fix.

Both the drivers and the amba bus converts to the new SET_PM_RUNTIME_PM_OPS
macro while setting up the runtime PM callbacks, which is intended to be used
for solving these kind of issues.

The fixes for the amba bus needs to be merged prior to the other, thus I think
it could make sense to merge this complete patchset through Russell's tree,
if he and the other maintainers think this is okay.

Ulf Hansson (17):
  amba: Let runtime PM callbacks be available for CONFIG_PM
  amba: Add late and early PM callbacks
  mmc: mmci: Mask IRQs for all variants during runtime suspend
  mmc: mmci: Let runtime PM callbacks be available for CONFIG_PM
  mmc: mmci: Put the device into low power state at system suspend
  spi: pl022: Let runtime PM callbacks be available for CONFIG_PM
  spi: pl022: Don't ignore power domain and amba bus at system suspend
  spi: pl022: Fully gate clocks at request inactivity
  spi: pl022: Simplify clock handling
  spi: pl022: Remove redundant pinctrl to default state in probe
  i2c: nomadik: Convert to devm functions
  i2c: nomadik: Remove redundant call to pm_runtime_disable
  i2c: nomadik: Leave probe with the device in active state
  i2c: nomadik: Fixup deployment of runtime PM
  i2c: nomadik: Convert to late and early system PM callbacks
  i2c: nomadik: Remove busy check for transfers at suspend late
  i2c: nomadik: Fixup system suspend

 drivers/amba/bus.c               |   10 ++-
 drivers/i2c/busses/i2c-nomadik.c |  146 ++++++++++++++++++--------------------
 drivers/mmc/host/mmci.c          |   72 ++++++++++---------
 drivers/spi/spi-pl022.c          |   95 +++++++++++--------------
 4 files changed, 159 insertions(+), 164 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

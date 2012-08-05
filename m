From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 00/25] make *struct of_device_id.data const
Date: Sun, 5 Aug 2012 10:54:34 +0200
Message-ID: <20120805085434.GM2626@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wim Van Sebroeck <wim@iguana.be>, Paul Mackerras <paulus@samba.org>, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Kumar Gala <galak@kernel.crashing.org>, Chris Ball <cjb@laptop.org>, cbe-oss-dev@lists.ozlabs.org, Marc Kleine-Budde <mkl@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, spi-devel-general@lists.sourceforge.net
List-Id: linux-mmc@vger.kernel.org

Hello,

> this is the 2nd version of this series whose goal is to make struct
> of_device_id.data const. Conceptually a driver must not modify the data
> contained there so making it const is the right thing.

I rebased my branch at:

	git://git.pengutronix.de/git/ukl/linux.git ofdeviceiddata

on top of v3.6-rc1 and retested the arm and powerpc defconfigs and a
powerpc allyesconfig. The result is still the same, i.e. a new warning
in drivers/regulator/twl-regulator.c because the probe routine modifies
the of_match table.

The series was contained in next up to next-20120725 (as commit

	100e8f5 (Merge branch 'ofdeviceiddata' of git://git.pengutronix.de/git/ukl=
/linux into late/warnings)

with an encoding error in the commit log btw). Don't know why it was
dropped from next. (late/warnings didn't show up in next-20120725's
arch/arm/arm-soc-for-next-contents.txt, maybe that's the reason?)

Compared to v2 of the series this drops two patches that made it in
during the v3.6 merge window.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git ofdeviceiddata

for you to fetch changes up to e22bd8177efeec9463dc2fc40bd172c717d0bd07:

  can: mpc5xxx_can: make data used as *of_device_id.data const (2012-08-03 =
13:58:41 +0200)

----------------------------------------------------------------
Arnd Bergmann (6):
      watchdog/mpc8xxx: add a const qualifier
      powerpc/fsl_msi: drop unneeded cast to non-const pointer
      mfd/da9052: make i2c_device_id array const
      i2c/mpc: make data used as *of_device_id.data const
      macintosh/mediabay: make data used as *of_device_id.data const
      can: mpc5xxx_can: make data used as *of_device_id.data const

Uwe Kleine-K=F6nig (17):
      spi/imx: make spi_imx_data.devtype_data member point to const data
      spi/spi-omap2-mcspi: add a const qualifier
      serial/imx: make imx_port.devdata member point to const data
      serial/mpc52xx_uart: add a const qualifier
      ARM: cache-l2x0: add a const qualifier
      misc/atmel_tc: make atmel_tc.tcb_config member point to const data
      gpio/gpio-omap.c: add a const qualifier
      gpio/mpc8xxx: add a const qualifier
      i2c/i2c-omap: add a const qualifier
      i2c/mpc: add a const qualifier
      mmc/omap_hsmmc: add a const qualifier
      macintosh/mediabay: add a const qualifier
      powerpc/83xx: add a const qualifier
      powerpc/fsl_msi: add a const qualifier
      powerpc/celleb_pci: add a const qualifier
      of: add const to struct *of_device_id.data
      gpio/gpio-omap: make platformdata used as *of_device_id.data const

 arch/arm/mm/cache-l2x0.c                 |    2 +-
 arch/powerpc/platforms/83xx/suspend.c    |    2 +-
 arch/powerpc/platforms/cell/celleb_pci.c |    2 +-
 arch/powerpc/sysdev/fsl_msi.c            |    8 ++++----
 drivers/gpio/gpio-mpc8xxx.c              |    2 +-
 drivers/gpio/gpio-omap.c                 |    8 ++++----
 drivers/i2c/busses/i2c-mpc.c             |   12 ++++++------
 drivers/i2c/busses/i2c-omap.c            |    3 ++-
 drivers/macintosh/mediabay.c             |    8 ++++----
 drivers/mfd/da9052-i2c.c                 |    4 ++--
 drivers/mmc/host/omap_hsmmc.c            |    2 +-
 drivers/net/can/mscan/mpc5xxx_can.c      |    4 ++--
 drivers/spi/spi-imx.c                    |    2 +-
 drivers/spi/spi-omap2-mcspi.c            |    2 +-
 drivers/tty/serial/imx.c                 |    2 +-
 drivers/tty/serial/mpc52xx_uart.c        |    2 +-
 drivers/watchdog/mpc8xxx_wdt.c           |    2 +-
 include/linux/atmel_tc.h                 |    2 +-
 include/linux/mod_devicetable.h          |    2 +-
 19 files changed, 36 insertions(+), 35 deletions(-)


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

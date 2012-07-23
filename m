From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 00/25] make *struct of_device_id.data const
Date: Mon, 23 Jul 2012 11:13:05 +0200
Message-ID: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36079 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab2GWJOm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jul 2012 05:14:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Ben Dooks <ben-linux@fluff.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, cbe-oss-dev@lists.ozlabs.org, Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>kernel@pengutronix.de, Kevin Hilman <khilman@ti.com>, Kumar Gala <galak@kernel.crashing.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Paul Mackerras <paulus@samba.org>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>, Vinod Koul <vinod.koul@intel.com>, Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <w.sang@pengutronix.de>

Hello,

this is the 2nd version of this series whose goal is to make struct
of_device_id.data const. Conceptually a driver must not modify the data
contained there so making it const is the right thing.

v1 of this series was sent with Message-id:
1342182734-321-1-git-send-email-y. Changes since then are:
 - powerpc fixes
 - several new consts that were found by Arnd that are possible after
   patch 19.
  =20
Arnd suggested to take this series via arm-soc late for 3.6 in one go
because patch 19 depends on the former patches but is a precondition to
the latter and it fixes a few warnings. So getting it in via the
respective maintainer trees would need a much bigger coordination
effort. That means I prefer getting Acks over you taking the patch.

Vinod Koul already took
        dmaengine: at_hdmac: add a few const qualifiers
that is in next-20120723 as 7fd63ccdad72 now. Vinod, I don't follow you=
r
pull requests, but assuming you didn't let it already pull for 3.6 I
suggest you drop it from your queue and I just take your Ack.

This series was build tested for arm (all defconfigs) and powerpc (all
defconfigs and an allyesconfig) and grep didn't find more issues. As
before it introduces a warning in drivers/regulator/twl-regulator.c.
This driver does modify its .of_match_table when a device is bound whic=
h
doesn't fits the concept of independant devices. Arnd noticed another
new warning in drivers/scsi/qlogicpti.c that isn't that easy to resolve=
,
because the pointer to (now) const data is passed as first argument to
scsi_host_alloc. To fix that properly struct Scsi_Host.hostt needs to
get a const, too. Alternatively I could introduce a cast removing the
const, but I don't like that.

This series is also available at:

	git://git.pengutronix.de/git/ukl/linux.git ofdeviceiddata

and I will modify it there for the Acks I'm getting.

Arnd Bergmann (6):
  watchdog/mpc8xxx: add a const qualifier
  powerpc/fsl_msi: drop unneeded cast to non-const pointer
  mfd/da9052: make i2c_device_id array const
  i2c/mpc: make data used as *of_device_id.data const
  macintosh/mediabay: make data used as *of_device_id.data const
  can: mpc5xxx_can: make data used as *of_device_id.data const

Marc Kleine-Budde (1):
  can: mpc5xxx_can: make data in mpc5xxx_can_probe const

Uwe Kleine-K=C3=B6nig (18):
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
  dmaengine: at_hdmac: add a few const qualifiers
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
 drivers/dma/at_hdmac.c                   |    4 ++--
 drivers/gpio/gpio-mpc8xxx.c              |    2 +-
 drivers/gpio/gpio-omap.c                 |    8 ++++----
 drivers/i2c/busses/i2c-mpc.c             |   12 ++++++------
 drivers/i2c/busses/i2c-omap.c            |    3 ++-
 drivers/macintosh/mediabay.c             |    8 ++++----
 drivers/mfd/da9052-i2c.c                 |    4 ++--
 drivers/mmc/host/omap_hsmmc.c            |    2 +-
 drivers/net/can/mscan/mpc5xxx_can.c      |    6 +++---
 drivers/spi/spi-imx.c                    |    2 +-
 drivers/spi/spi-omap2-mcspi.c            |    2 +-
 drivers/tty/serial/imx.c                 |    2 +-
 drivers/tty/serial/mpc52xx_uart.c        |    2 +-
 drivers/watchdog/mpc8xxx_wdt.c           |    2 +-
 include/linux/atmel_tc.h                 |    2 +-
 include/linux/mod_devicetable.h          |    2 +-
 20 files changed, 39 insertions(+), 38 deletions(-)

--=20
1.7.10.4


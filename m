From: Chris Ball <cjb@laptop.org>
Subject: [GIT PULL] MMC fixes for 2.6.37-rc4
Date: Thu, 25 Nov 2010 01:26:47 -0500
Message-ID: <m34ob5ex5k.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38495 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab0KYGWb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2010 01:22:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git for-linus

to fix two regressions in -rc1 (SDIO devices and <8-bit MMC cards), two
longstanding bugs (rmmod race, enable SDIO IRQ wakeups), and some small
device support bugs.  These have been tested in linux-next.  Thanks.

The following changes since commit 151f52f09c5728ecfdd0c289da1a4b30bb41=
6f2c:
  Linus Torvalds (1):
        ipw2x00: remove the right /proc/net entry

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git for-linus

Axel Lin (1):
      mmc: ushc: Return proper error code for ushc_probe()

Daniel Drake (1):
      mmc: sdhci: Properly enable SDIO IRQ wakeups

Eric B=C3=A9nard (2):
      mmc: sdhci-esdhc-imx: fix timeout on i.MX's sdhci
      mmc: sdhci-esdhc-imx: enable QUIRK_NO_MULTIBLOCK only for i.MX25 =
and i.MX35

Guennadi Liakhovetski (1):
      mmc: fix rmmod race for hosts using card-detection polling

Jacob Pan (1):
      mmc: sdhci: Fix crash on boot with C0 stepping Moorestown platfor=
ms

Ohad Ben-Cohen (2):
      mmc: sdio: fix nasty oops in mmc_sdio_detect
      mmc: sdio: fix runtime PM anomalies by introducing MMC_CAP_POWER_=
OFF_CARD

Philip Rakity (2):
      mmc: Fix printing of card DDR type
      mmc: sdhci: 8-bit bus width changes

kishore kadiyala (1):
      mmc: omap4: hsmmc: Fix improper card detection while booting

 arch/arm/plat-pxa/include/plat/sdhci.h |    3 ++
 drivers/mmc/core/core.c                |    2 +-
 drivers/mmc/core/mmc.c                 |    8 +++-
 drivers/mmc/core/sdio.c                |   51 ++++++++++++++++++++----=
-----
 drivers/mmc/core/sdio_bus.c            |   33 +++++++++++++------
 drivers/mmc/host/omap_hsmmc.c          |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c     |   12 +++++--
 drivers/mmc/host/sdhci-pci.c           |   31 +++++++++++++-----
 drivers/mmc/host/sdhci-pxa.c           |    4 ++
 drivers/mmc/host/sdhci.c               |   54 ++++++++++++++++++++++++=
+------
 drivers/mmc/host/sdhci.h               |    9 +++++-
 drivers/mmc/host/ushc.c                |   30 +++++++++++++-----
 include/linux/mmc/host.h               |    1 +
 include/linux/pci_ids.h                |    1 +
 14 files changed, 179 insertions(+), 62 deletions(-)

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

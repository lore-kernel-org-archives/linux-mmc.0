From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 00/14] Remove platform callbacks from mmc_spi, sh_mmcif and sh_mobile_sdhi drivers
Date: Sat, 24 Aug 2013 03:28:30 +0200
Message-ID: <1379845.qhfya0zTYh@avalon>
References: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:43687 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab3HXB1P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 21:27:15 -0400
In-Reply-To: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Hi Chris,

On Thursday 08 August 2013 12:38:30 Laurent Pinchart wrote:
> Hello,
> 
> This patch set replaces callbacks to board code with regulators and GPIOs in
> the mmc_spi, sh_mmcif and sh_mobile_sdhi MMC drivers.
> 
> Most of the required infrastructure is in place already on the drivers side,
> except for CD debouncing support in the MMC core and CD/RO GPIOs support in
> the mmc_spi driver. The series thus starts with patches 01/14 and 02/14
> that add those features to the MMC core and mmc_spi driver.
> 
> Patches 03/14 to 07/14 remove the board callbacks from the ecovec24 and
> vision_ep9307 boards. The code has been compile-tested only as I don't have
> access to those boards.
> 
> Patches 08/14 to 14/14 then proceed to remove the callbacks from the drivers
> themselves and from the platform data structures.
> 
> Compared to v2, the patches have been rebased on the mmc-next branch from
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git. I've also added
> patch 07/14 that removes the .set_pwr() callback from the ag5evm board to
> avoid compilation breakage during bisection.
> 
> The series interleaves patches for drivers and board files. The ep93xx and
> ecovec24 patches have been acked, and the respective ARM subtree maintainers
> have indicated that they are fine with the patches going through the MMC
> tree. The ag5evm patch is new, but as the ag5evm board is going to be
> removed in v3.12, it shouldn't cause any issue.
> 
> Chris, could you take the patches in your tree ? I've pushed them to
> 
> 	git://linuxtv.org/pinchartl/fbdev.git mmc/devel

Ping ?

The following changes since commit 6d1d6b4759112acf4c079eb3a0dd296bdbf61cf5:

  mmc: tmio: fix compiler warning (2013-07-23 15:06:47 -0400)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git mmc/devel

for you to fetch changes up to a3424b35fdfd2d0fe507ef204d4ddebadd1e1157:

  mmc: tmio-mmc: Remove .set_pwr() callback from platform data (2013-08-08 
12:34:33 +0200)

----------------------------------------------------------------
Laurent Pinchart (14):
      mmc: slot-gpio: Add debouncing capability to mmc_gpio_request_cd()
      mmc: mmc_spi: Support CD/RO GPIOs
      ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
      sh: ecovec24: Use MMC/SDHI CD and RO GPIO
      sh: ecovec24: Remove mmcif .down_pwr() callback
      sh: ecovec24: Remove MMCIF and SDHI .set_pwr() callbacks
      ARM: shmobile: ag5evm: Remove SDHI .set_pwr() callback
      mmc: mmc_spi: Remove platform data .get_cd() and .get_ro() callbacks
      mmc: sh_mmcif: Remove .down_pwr() callback from platform data
      mmc: sh_mmcif: Remove .set_pwr() callback from platform data
      mmc: sh_mobile_sdhi: Remove .get_cd() callback from platform data
      mmc: sh_mobile_sdhi: Remove .set_pwr() callback from platform data
      mmc: tmio-mmc: Remove .get_cd() callback from platform data
      mmc: tmio-mmc: Remove .set_pwr() callback from platform data

 arch/arm/mach-ep93xx/vision_ep9307.c  | 57 +++------------------------
 arch/arm/mach-shmobile/board-ag5evm.c | 23 -----------
 arch/sh/boards/mach-ecovec24/setup.c  | 89 +++-------------------------------
 drivers/mmc/core/host.c               |  2 +-
 drivers/mmc/core/slot-gpio.c          | 14 ++++++-
 drivers/mmc/host/jz4740_mmc.c         |  2 +-
 drivers/mmc/host/mmc_spi.c            | 49 +++++++++++-------------
 drivers/mmc/host/mvsdio.c             |  3 +-
 drivers/mmc/host/of_mmc_spi.c         | 46 ++++++----------------
 drivers/mmc/host/sdhci-esdhc-imx.c    |  2 +-
 drivers/mmc/host/sdhci-pxav3.c        |  3 +-
 drivers/mmc/host/sdhci-sirf.c         |  2 +-
 drivers/mmc/host/sh_mmcif.c           |  5 +--
 drivers/mmc/host/sh_mobile_sdhi.c     | 18 ---------
 drivers/mmc/host/tmio_mmc.h           |  1 -
 drivers/mmc/host/tmio_mmc_pio.c       | 25 +-----------
 include/linux/mfd/tmio.h              |  2 -
 include/linux/mmc/sh_mmcif.h          |  2 -
 include/linux/mmc/sh_mobile_sdhi.h    |  2 -
 include/linux/mmc/slot-gpio.h         |  3 +-
 include/linux/spi/mmc_spi.h           | 19 ++++++---
 21 files changed, 86 insertions(+), 283 deletions(-)

> Laurent Pinchart (14):
>   mmc: slot-gpio: Add debouncing capability to mmc_gpio_request_cd()
>   mmc: mmc_spi: Support CD/RO GPIOs
>   ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
>   sh: ecovec24: Use MMC/SDHI CD and RO GPIO
>   sh: ecovec24: Remove mmcif .down_pwr() callback
>   sh: ecovec24: Remove MMCIF and SDHI .set_pwr() callbacks
>   ARM: shmobile: ag5evm: Remove SDHI .set_pwr() callback
>   mmc: mmc_spi: Remove platform data .get_cd() and .get_ro() callbacks
>   mmc: sh_mmcif: Remove .down_pwr() callback from platform data
>   mmc: sh_mmcif: Remove .set_pwr() callback from platform data
>   mmc: sh_mobile_sdhi: Remove .get_cd() callback from platform data
>   mmc: sh_mobile_sdhi: Remove .set_pwr() callback from platform data
>   mmc: tmio-mmc: Remove .get_cd() callback from platform data
>   mmc: tmio-mmc: Remove .set_pwr() callback from platform data
> 
>  arch/arm/mach-ep93xx/vision_ep9307.c  | 57 ++--------------------
>  arch/arm/mach-shmobile/board-ag5evm.c | 23 ---------
>  arch/sh/boards/mach-ecovec24/setup.c  | 89 ++++----------------------------
>  drivers/mmc/core/host.c               |  2 +-
>  drivers/mmc/core/slot-gpio.c          | 14 +++++-
>  drivers/mmc/host/jz4740_mmc.c         |  2 +-
>  drivers/mmc/host/mmc_spi.c            | 49 +++++++++----------
>  drivers/mmc/host/mvsdio.c             |  3 +-
>  drivers/mmc/host/of_mmc_spi.c         | 46 +++++-------------
>  drivers/mmc/host/sdhci-esdhc-imx.c    |  2 +-
>  drivers/mmc/host/sdhci-pxav3.c        |  3 +-
>  drivers/mmc/host/sdhci-sirf.c         |  2 +-
>  drivers/mmc/host/sh_mmcif.c           |  5 +-
>  drivers/mmc/host/sh_mobile_sdhi.c     | 18 -------
>  drivers/mmc/host/tmio_mmc.h           |  1 -
>  drivers/mmc/host/tmio_mmc_pio.c       | 25 +---------
>  include/linux/mfd/tmio.h              |  2 -
>  include/linux/mmc/sh_mmcif.h          |  2 -
>  include/linux/mmc/sh_mobile_sdhi.h    |  2 -
>  include/linux/mmc/slot-gpio.h         |  3 +-
>  include/linux/spi/mmc_spi.h           | 19 +++++---
>  21 files changed, 86 insertions(+), 283 deletions(-)
-- 
Regards,

Laurent Pinchart


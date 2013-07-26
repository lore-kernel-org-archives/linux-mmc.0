From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 00/12] Remove platform callbacks from mmc_spi, sh_mmcif
 and sh_mobile_sdhi drivers
Date: Fri, 26 Jul 2013 09:01:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307260859410.20450@axis700.grange>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Laurent

On Fri, 26 Jul 2013, Laurent Pinchart wrote:

> Hello,
> 
> This patch set replaces callbacks to board code with regulators and GPIOs in
> the mmc_spi, sh_mmcif and sh_mobile_sdhi MMC drivers.
> 
> Most of the required infrastructure is in place already on the drivers side,
> except for CD/RO GPIOs support in the mmc_spi driver. The series thus starts
> with patch 01/12 that adds this feature to the mmc_spi driver.
> 
> Patches 02/12 to 05/12 remove the board callbacks from the ecovec24 and
> vision_ep9307 boards. The code has been compile-tested only as I don't have
> access to those boards.
> 
> Patches 06/12 to 07/12 then proceed to remove the callbacks from the drivers
> themselves and from the platform data structures.
> 
> This will be a bit messy to merge, as the series interleaves patches for
> drivers and board files. Given that the mmc_spi driver is marked as orphan in
> MAINTAINERS and that the vision_ep9307 hasn't seen any board-specific
> modification in the last couple of kernel versions one option would be to
> merge all patches (or at least patches 01/12 to 06/12) through Simon's tree if
> all involved maintainers agree.
> 
> The series is based on tag renesas-devel-20130725 from
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
> 
> Laurent Pinchart (12):
>   mmc: mmc_spi: Support CD/RO GPIOs
>   ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
>   sh: ecovec24: Use MMC/SDHI CD and RO GPIO
>   sh: ecovec24: Remove mmcif .down_pwr() callback
>   sh: ecovec24: Remove MMCIF and SDHI .set_pwr() callbacks
>   mmc: mmc_spi: Remove platform data .get_cd() and .get_ro() callbacks
>   mmc: sh_mmcif: Remove .down_pwr() callback from platform data
>   mmc: sh_mmcif: Remove .set_pwr() callback from platform data
>   mmc: sh_mobile_sdhi: Remove .get_cd() callback from platform data
>   mmc: sh_mobile_sdhi: Remove .set_pwr() callback from platform data
>   mmc: tmio-mmc: Remove .get_cd() callback from platform data
>   mmc: tmio-mmc: Remove .set_pwr() callback from platform data

For #3-5, 7-12

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

>  arch/arm/mach-ep93xx/vision_ep9307.c | 56 ++---------------------
>  arch/sh/boards/mach-ecovec24/setup.c | 89 ++++--------------------------------
>  drivers/mmc/host/mmc_spi.c           | 48 +++++++++----------
>  drivers/mmc/host/of_mmc_spi.c        | 46 +++++--------------
>  drivers/mmc/host/sh_mmcif.c          |  3 --
>  drivers/mmc/host/sh_mobile_sdhi.c    | 18 --------
>  drivers/mmc/host/tmio_mmc.h          |  1 -
>  drivers/mmc/host/tmio_mmc_pio.c      | 23 +---------
>  include/linux/mfd/tmio.h             |  2 -
>  include/linux/mmc/sh_mmcif.h         |  2 -
>  include/linux/mmc/sh_mobile_sdhi.h   |  2 -
>  include/linux/spi/mmc_spi.h          | 18 ++++----
>  12 files changed, 56 insertions(+), 252 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

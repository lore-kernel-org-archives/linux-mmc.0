From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 00/14] Remove platform callbacks from mmc_spi, sh_mmcif and sh_mobile_sdhi drivers
Date: Sun, 25 Aug 2013 22:54:06 +0200
Message-ID: <1591201.avzdVWpxvg@avalon>
References: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <87ob8mqv55.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87ob8mqv55.fsf@octavius.laptop.org>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On Saturday 24 August 2013 23:58:14 Chris Ball wrote:
> On Thu, Aug 08 2013, Laurent Pinchart wrote:
> > This patch set replaces callbacks to board code with regulators and GPIOs
> > in the mmc_spi, sh_mmcif and sh_mobile_sdhi MMC drivers.
> > 
> > Most of the required infrastructure is in place already on the drivers
> > side, except for CD debouncing support in the MMC core and CD/RO GPIOs
> > support in the mmc_spi driver. The series thus starts with patches 01/14
> > and 02/14 that add those features to the MMC core and mmc_spi driver.
> > 
> > Patches 03/14 to 07/14 remove the board callbacks from the ecovec24 and
> > vision_ep9307 boards. The code has been compile-tested only as I don't
> > have
> > access to those boards.
> > 
> > Patches 08/14 to 14/14 then proceed to remove the callbacks from the
> > drivers themselves and from the platform data structures.
> 
> arch/arm/mach-shmobile/board-ag5evm.c has been removed from
> linux-next, so I've dropped patch 7 ("ARM: shmobile: ag5evm: Remove
> SDHI .set_pwr() callback") but taken all of the other patches into
> mmc-next for 3.12.

Patch 7 was only meant to avoid bisection breakages if your tree gets merged 
before the ARM tree. If it gets merged before you can indeed drop it.

-- 
Regards,

Laurent Pinchart


From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 01/13] ARM: davinci: move private EDMA API to
	arm/common
Date: Fri, 21 Sep 2012 10:29:23 +0100
Message-ID: <20120921092923.GA31374@n2100.arm.linux.org.uk>
References: <1348152226-13588-1-git-send-email-mporter@ti.com> <1348152226-13588-2-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348152226-13588-2-git-send-email-mporter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 20, 2012 at 10:43:34AM -0400, Matt Porter wrote:
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx atm) as well. This just moves
> the private EDMA API but does not support OMAP.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/Kconfig                           |    1 +
>  arch/arm/common/Kconfig                    |    3 +
>  arch/arm/common/Makefile                   |    1 +
>  arch/arm/common/edma.c                     | 1588 ++++++++++++++++++++++++++++
>  arch/arm/include/asm/mach/edma.h           |  267 +++++

asm/mach should not be used as a dumping ground for platform header files.
It is there to provide the interfaces between generic ARM architecture
code and platform code.  (At least four files that are there at the
moment need to be moved out of there - patch series to follow...)

From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH v4,03/14] ARM: edma: add AM33XX support to the private EDMA API
Date: Fri, 11 Jan 2013 19:14:27 +0100
Message-ID: <201301111914.27712.poeschel@lemonage.de>
References: <1357883330-5364-4-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357883330-5364-4-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Rob Herring <rob.herring@calxe>
List-Id: linux-mmc@vger.kernel.org

Hi Matt,

On Friday 11 January 2013 at 06:48:39, Matt Porter wrote:

> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index a3d189d..1951d63 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -24,6 +24,13 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/edma.h>
> +#include <linux/err.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>

You add the include linux/of_dma.h here, but maybe you missed to add the file 
itself. It is not in Linus v3.8-rc3 tree, not in the patches yours depend on 
listed and not in your patchset.

Regards,
Lars

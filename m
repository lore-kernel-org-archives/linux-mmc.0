From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 30 Nov 2011 14:06:25 +0000
Message-ID: <4ED63861.7030607@imgtec.com>
References: <1322656585-8363-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:38377 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab1K3OG3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Nov 2011 09:06:29 -0500
In-Reply-To: <1322656585-8363-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi,

*sigh* You haven't actually tried compiling this have you? How do you
know whether it works or not? You really really should at least make
sure it compiles (for simple changes) and works without breaking
anything (for anything non-trivial like adding support for a new bus
like PCI)!

Couple of other minor things below.

On 11/30/2011 12:36 PM, Shashidhar Hiremath wrote:
> Support of PCI mode for the dw_mmc driver. This Patch adds the
> support for the scenario where the Synopsys Designware IP
> is present on the PCI bus. The patch adds the minimal modifications
> necessary for the driver to work on PCI platform. Also added separate
> files for PCI and PLATFORM modes of operation.
> 
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> v2:
> *As per Suggestions by Will Newton and James Hogan
> -Reduced the number of ifdefs
> v3:
> *As per Suggestions by Will Newton and James Hogan
> -Added separate files for PCI and PLATFORM Modes similar to SDHCI driver
> v4:
> *As per Suggestions by James Hogan
> -Fixed Indentation Issue.
> -Added Proper error Handling for probe and remove sequences.
> -Modified location of some code.
> -Added isr_flags to dw_mmc.h and removed the ifdef PCI from driver.
> 
>  drivers/mmc/host/Kconfig        |   23 ++++++
>  drivers/mmc/host/dw_mmc-pci.c   |  158 +++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc-pltfm.c |  134 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.c       |  151 +++++++++++++------------------------
>  drivers/mmc/host/dw_mmc.h       |    7 ++
>  include/linux/mmc/dw_mmc.h      |    6 +-
>  6 files changed, 377 insertions(+), 102 deletions(-)
>  create mode 100644 drivers/mmc/host/dw_mmc-pci.c
>  create mode 100644 drivers/mmc/host/dw_mmc-pltfm.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 87d5067..2d8fad6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -534,6 +534,29 @@ config MMC_DW_IDMAC
>  	  Designware Mobile Storage IP block. This disables the external DMA
>  	  interface.
>  
> +config MMC_DW_PCI
> +	tristate "Synopsys Designware MCI support on PCI bus"
> +	depends on MMC_DW && PCI
> +	help
> +	  This selects the PCI bus for the Synopsys Designware Mobile Storage IP.
> +	  Select this option if the IP is present on PCI platform.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
> +config MMC_DW_PLTFM
> +	tristate "platform driver helper for Synopsys Designware Mobile Storage IP"

It would be nice if this followed the same pattern as MMC_DW_PCI, i.e.
something like "Synopsys DesignWare MCI support as platform device"
(makes it look nicer on the menu :) ).

Presuming this is the more common case, it might make sense for it to be
default y too (the driver cannot be used by default until one or both of
these options has been selected).

> +	depends on MMC_DW
> +	help
> +	  This selects the common helper functions support for Host Controller
> +	  Interface based platform driver.Please select this option if the IP
> +	  is present as a platform device.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SH_MMCIF
>  	tristate "SuperH Internal MMCIF support"
>  	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)

<snip>

> +static int dw_mci_pltfm_probe(struct platform_device *pdev)
> +{
> +	struct dw_mci *host;
> +	struct resource	*regs;
> +	int  ret;
> +
> +	host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
> +	if (!host)
> +		return -ENOMEM;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs) {
> +		ret = -ENXIO;
> +		goto err_free;
> +	}
> +
> +	host->irq = platform_get_irq(pdev, 0);
> +	if (host->irq < 0) {
> +		ret = host->irq;
> +		goto err_free;
> +	}
> +
> +	host->dev = pdev->dev;
> +	host->irq_flags = 0;
> +	host->pdata = pdev->dev.platform_data;
> +	ret = -ENOMEM;
> +	host->regs = ioremap(regs->start, resource_size(regs));
> +	if (!host->regs)
> +		goto err_free;
> +	platform_set_drvdata(pdev, host);
> +	ret = dw_mci_probe(host);
> +	if (ret)
> +		goto err_out;
> +	else
> +		return ret;
> +err_out:
> +		iounmap(host->regs);
> +err_free:
> +		kfree(host);

alignment needs fixing here. There's no need for the else either.

Thanks
James


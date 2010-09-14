From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/7] sdhci: Rework some of the quirk behaviour
Date: Tue, 14 Sep 2010 16:34:37 +0200
Message-ID: <20100914143437.GG2629@pengutronix.de>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
 <20100913173839.20345.27249.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53057 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab0INOej (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2010 10:34:39 -0400
Content-Disposition: inline
In-Reply-To: <20100913173839.20345.27249.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2010 at 06:38:48PM +0100, Alan Cox wrote:
> As the quirks go ever more complex it's getting harder and harder to inte=
grate
> new drivers. The Intel MID devices add a whole further collection of new
> quirks so instead of quirks start moving some stuff to overridable functi=
ons.
>=20
> We also introduce an sdhci_reset_all helper which is told if the reset is
> being done during init (which needs to be avoided by some hw) or on exit
> in which case it doesn't.
>=20
> Arguably the driver wants to be lots of drivers and "libsdhci" but that w=
ould
> be a massive undertaking.
>=20
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>=20
>  drivers/mmc/host/Kconfig           |   11 ++
>  drivers/mmc/host/Makefile          |    1=20
>  drivers/mmc/host/sdhci-intel-mid.c |  163 ++++++++++++++++++++++++++++++=
++++++

Why are those added here and not in patch 3/7?

>  drivers/mmc/host/sdhci-pci.c       |   56 ++++++++++++
>  drivers/mmc/host/sdhci.c           |   61 ++++++++++---
>  drivers/mmc/host/sdhci.h           |   20 ++++
>  include/linux/pci_ids.h            |    2=20
>  7 files changed, 296 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-intel-mid.c

=46rom having a glimpse, there is MID-specific stuff all over the patch.
This makes finding the actual "quirk rework" harder.

>=20
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index ce099c4..ffa40f1 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -81,6 +81,17 @@ config MMC_RICOH_MMC
> =20
>  	  If unsure, say Y.
> =20
> +config MMC_SDHCI_INTEL_MID
> +	tristate "SDHCI support on Intel MID platforms"
> +	depends on MMC_SDHCI_PCI
> +	help
> +	  This includes support for the SDHCI controllers found on Intel
> +	  MID platform systems.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_OF
>  	tristate "SDHCI support on OpenFirmware platforms"
>  	depends on MMC_SDHCI && PPC_OF
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 697bbfe..21c80f0 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXC)		+=3D mxcmmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+=3D sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_MV)	+=3D sdhci-mv.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+=3D sdhci-pci.o
> +obj-$(CONFIG_MMC_SDHCI_INTEL_MID)	+=3D sdhci-intel-mid.o
>  obj-$(CONFIG_MMC_SDHCI_S3C)	+=3D sdhci-s3c.o
>  obj-$(CONFIG_MMC_SDHCI_SPEAR)	+=3D sdhci-spear.o
>  obj-$(CONFIG_MMC_WBSD)		+=3D wbsd.o
> diff --git a/drivers/mmc/host/sdhci-intel-mid.c b/drivers/mmc/host/sdhci-=
intel-mid.c
> new file mode 100644
> index 0000000..2828831
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-intel-mid.c
> @@ -0,0 +1,163 @@
> +#include <linux/delay.h>
> +#include <linux/highmem.h>
> +#include <linux/io.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/scatterlist.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/leds.h>
> +
> +#include <linux/mmc/host.h>
> +
> +#include "sdhci.h"
> +
> +/*
> + *	Support code for SDHCI on Intel MID platforms. We have lots
> + * 	of quirks specific to these platforms so wrap them up in one place
> + *	that keeps them out of the main flow. We can't just make it a new
> + *	driver as the shdci core code isn't really a library.
> + */
> +=20
> +static void sdhci_broken_reset(struct sdhci_host *host, u8 mask)
> +{
> +	unsigned long timeout;
> +	u32 uninitialized_var(ier);
> +
> +	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
> +		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +			SDHCI_CARD_PRESENT))
> +			return;
> +	}
> +
> +	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
> +		ier =3D sdhci_readl(host, SDHCI_INT_ENABLE);
> +
> +	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
> +
> +	if (mask & SDHCI_RESET_ALL)
> +		host->clock =3D 0;
> +
> +	/* Wait max 100 ms */
> +	timeout =3D 100;
> +
> +	/* hw clears the bit when it's done */
> +	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
> +		if (timeout =3D=3D 0) {
> +			printk(KERN_ERR "%s: Reset 0x%x never completed.\n",
> +				mmc_hostname(host->mmc), (int)mask);
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
> +		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
> +}
> +
> +static void sdhci_mid_broken_resetall(struct sdhci_host *host, int down)
> +{
> +	if (down)
> +		sdhci_broken_reset(host, SDHCI_RESET_ALL);
> +}
> +
> +static void sdhci_mid_init_no_reset(struct sdhci_host *host, int soft)
> +{
> +	u32 intmask;
> +
> +	intmask =3D sdhci_readl(host, SDHCI_INT_STATUS);
> +	sdhci_writel(host,
> +		intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE),
> +		SDHCI_INT_STATUS);
> +
> +        /* Ensure any IRQ left over from pre boot time (eg from Kboot) d=
oes
> +           not turn up and cause chaos */
> +	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> +
> +	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> +		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
> +		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
> +		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
> +		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
> +
> +	if (soft) {
> +		/* force clock reconfiguration */
> +		host->clock =3D 0;
> +		sdhci_set_ios(host->mmc, &host->mmc->ios);
> +	}
> +
> +	/* disable wakeup signal during initialization */
> +	sdhci_writeb(host, 0x0, SDHCI_WAKE_UP_CONTROL);
> +}
> +
> +/*
> + * HW problem exists in LNW A3 so clock register has to be set
> + * for every command if both SDIO0 and SDIO1 are enabled.
> + */
> +static void sdhci_clock_reset(struct sdhci_host *host)
> +{
> +	u16 clk;
> +	unsigned long timeout;
> +
> +	clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	clk |=3D SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 10 ms */
> +	timeout =3D 10;
> +	while (!((clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +		& SDHCI_CLOCK_INT_STABLE)) {
> +		if (timeout =3D=3D 0) {
> +			printk(KERN_ERR "%s: Internal clock never "
> +				"stabilised.\n",
> +				mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +}
> +
> +static void sdhci_clockreset_wcmd(struct sdhci_host *host,
> +				struct mmc_command *cmd, int flags)
> +{
> +	sdhci_clock_reset(host);
> + 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
> +}
> +
> +static void sdhci_lnw_a3_set_ios(struct sdhci_host *host,
> +					struct mmc_ios *ios, u8 ctrl)
> +{
> +	/*
> +	 * For LNW A3, HISPD bit has to be cleared in order to
> +	 * enable the 50MHz clock
> +	 */
> +	if (ios->timing =3D=3D MMC_TIMING_SD_HS ||
> +			ios->timing =3D=3D MMC_TIMING_MMC_HS)
> +		ctrl |=3D SDHCI_CTRL_HISPD;
> +	else
> +		ctrl &=3D ~SDHCI_CTRL_HISPD;
> +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +}
> +
> +/*
> + * HW problem exists in LNW A3 which leads to fake interrupt on SDIO1 if=
 SDIO0
> + * and SDIO1 are both enabled.
> + */
> +static void sdhci_lnw_a3_unexpected_cmd(struct sdhci_host *host, u32 int=
mask)
> +{
> +}
> +
> +struct sdhci_ops sdhci_intel_mrst_hc =3D {
> +	.reset =3D sdhci_broken_reset,
> +	.init =3D sdhci_mid_init_no_reset,
> +	.set_ios =3D sdhci_lnw_a3_set_ios,
> +	.reset_all =3D sdhci_mid_broken_resetall,
> +	.write_command =3D sdhci_clockreset_wcmd,
> +	.unexpected_cmd_irq =3D sdhci_lnw_a3_unexpected_cmd,
> +};
> +EXPORT_SYMBOL_GPL(sdhci_intel_mrst_hc);
> +
> +
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index e8aa99d..3e29e94 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -54,6 +54,8 @@ struct sdhci_pci_fixes {
>  	int			(*suspend)(struct sdhci_pci_chip*,
>  					pm_message_t);
>  	int			(*resume)(struct sdhci_pci_chip*);
> +
> +	struct sdhci_ops	*host_ops;
>  };
> =20
>  struct sdhci_pci_slot {
> @@ -397,6 +399,35 @@ static const struct sdhci_pci_fixes sdhci_via =3D {
>  	.probe		=3D via_probe,
>  };
> =20
> +#if defined(CONFIG_MMC_SDHCI_INTEL_MID) || defined(CONFIG_MMC_SDHCI_INTE=
L_MID_MODULE)
> +
> +/*
> + * ADMA operation is disabled for Moorestown platform due to
> + * hardware bugs.
> + */
> +static int mrst_hc0_probe(struct sdhci_pci_chip *chip)
> +{
> +	/*
> +	 * slots number is fixed here for MRST as SDIO3 is never used and has
> +	 * hardware bugs.
> +	 */
> +	chip->num_slots =3D 1;
> +	return 0;
> +}

Why is this function here and not in sdhci-intel-mid.c?

> +
> +static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 =3D {
> +	.quirks		=3D SDHCI_QUIRK_BROKEN_ADMA,
> +	.probe		=3D mrst_hc0_probe,
> +	.host_ops	=3D &sdhci_intel_mrst_hc,
> +};
> +
> +static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1 =3D {
> +	.quirks		=3D SDHCI_QUIRK_BROKEN_ADMA,
> +	.host_ops	=3D &sdhci_intel_mrst_hc,
> +};
> +
> +#endif
> +
>  static const struct pci_device_id pci_ids[] __devinitdata =3D {
>  	{
>  		.vendor		=3D PCI_VENDOR_ID_RICOH,
> @@ -494,6 +525,23 @@ static const struct pci_device_id pci_ids[] __devini=
tdata =3D {
>  		.driver_data	=3D (kernel_ulong_t)&sdhci_via,
>  	},
> =20
> +#if defined(CONFIG_MMC_SDHCI_INTEL_MID) || defined(CONFIG_MMC_SDHCI_INTE=
L_MID_MODULE)
> +	{
> +		.vendor		=3D PCI_VENDOR_ID_INTEL,
> +		.device		=3D PCI_DEVICE_ID_INTEL_MRST_SD0,
> +		.subvendor	=3D PCI_ANY_ID,
> +		.subdevice	=3D PCI_ANY_ID,
> +		.driver_data	=3D (kernel_ulong_t)&sdhci_intel_mrst_hc0,
> +	},
> +
> +	{
> +		.vendor		=3D PCI_VENDOR_ID_INTEL,
> +		.device		=3D PCI_DEVICE_ID_INTEL_MRST_SD1,
> +		.subvendor	=3D PCI_ANY_ID,
> +		.subdevice	=3D PCI_ANY_ID,
> +		.driver_data	=3D (kernel_ulong_t)&sdhci_intel_mrst_hc1,
> +	},
> +#endif
>  	{	/* Generic SD host controller */
>  		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
>  	},
> @@ -509,7 +557,7 @@ MODULE_DEVICE_TABLE(pci, pci_ids);
>   *                                                                      =
     *
>  \***********************************************************************=
******/
> =20
> -static int sdhci_pci_enable_dma(struct sdhci_host *host)
> +int sdhci_pci_enable_dma(struct sdhci_host *host)
>  {
>  	struct sdhci_pci_slot *slot;
>  	struct pci_dev *pdev;
> @@ -533,6 +581,7 @@ static int sdhci_pci_enable_dma(struct sdhci_host *ho=
st)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_pci_enable_dma);
> =20
>  static struct sdhci_ops sdhci_pci_ops =3D {
>  	.enable_dma	=3D sdhci_pci_enable_dma,
> @@ -687,7 +736,10 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_p=
robe_slot(
>  	slot->pci_bar =3D bar;
> =20
>  	host->hw_name =3D "PCI";
> -	host->ops =3D &sdhci_pci_ops;
> +	if (chip->fixes->host_ops)
> +		host->ops =3D chip->fixes->host_ops;
> +	else
> +		host->ops =3D &sdhci_pci_ops;
>  	host->quirks =3D chip->quirks;
> =20
>  	host->irq =3D pdev->irq;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f608626..9d8091a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -45,7 +45,7 @@ static void sdhci_finish_data(struct sdhci_host *);
>  static void sdhci_send_command(struct sdhci_host *, struct mmc_command *=
);
>  static void sdhci_finish_command(struct sdhci_host *);
> =20
> -static void sdhci_dumpregs(struct sdhci_host *host)
> +void sdhci_dumpregs(struct sdhci_host *host)
>  {
>  	printk(KERN_DEBUG DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> =20
> @@ -87,6 +87,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
> =20
>  	printk(KERN_DEBUG DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n");
>  }
> +EXPORT_SYMBOL_GPL(sdhci_dumpregs);
> =20
>  /***********************************************************************=
******\
>   *                                                                      =
     *
> @@ -94,7 +95,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
>   *                                                                      =
     *
>  \***********************************************************************=
******/
> =20
> -static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set)
> +void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
>  {
>  	u32 ier;
> =20
> @@ -104,6 +105,7 @@ static void sdhci_clear_set_irqs(struct sdhci_host *h=
ost, u32 clear, u32 set)
>  	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
>  	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_clear_set_irqs);
> =20
>  static void sdhci_unmask_irqs(struct sdhci_host *host, u32 irqs)
>  {
> @@ -143,6 +145,11 @@ static void sdhci_reset(struct sdhci_host *host, u8 =
mask)
>  	unsigned long timeout;
>  	u32 uninitialized_var(ier);
> =20
> +	if (host->ops->reset) {
> +		host->ops->reset(host, mask);
> +		return;
> +	}
> +
>  	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>  		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
>  			SDHCI_CARD_PRESENT))
> @@ -176,14 +183,21 @@ static void sdhci_reset(struct sdhci_host *host, u8=
 mask)
>  		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
>  }
> =20
> -static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> +/* Down is true if we are shutting down the port */
> +static void sdhci_reset_all(struct sdhci_host *host, int down)
> +{
> +	if (host->ops->reset_all)
> +		host->ops->reset_all(host, down);
> +	else
> +		sdhci_reset(host, SDHCI_RESET_ALL);
> +}
> =20
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
>  	if (soft)
>  		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
>  	else
> -		sdhci_reset(host, SDHCI_RESET_ALL);
> +		sdhci_reset_all(host, 0);
> =20
>  	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
>  		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
> @@ -945,7 +959,11 @@ static void sdhci_send_command(struct sdhci_host *ho=
st, struct mmc_command *cmd)
>  	if (cmd->data)
>  		flags |=3D SDHCI_CMD_DATA;
> =20
> -	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
> +	if (host->ops->write_command)
> +		host->ops->write_command(host, cmd, flags);
> +	else
> +		sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
> +						SDHCI_COMMAND);
>  }
> =20
>  static void sdhci_finish_command(struct sdhci_host *host)
> @@ -1139,7 +1157,7 @@ static void sdhci_request(struct mmc_host *mmc, str=
uct mmc_request *mrq)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> =20
> -static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host;
>  	unsigned long flags;
> @@ -1186,9 +1204,13 @@ static void sdhci_set_ios(struct mmc_host *mmc, st=
ruct mmc_ios *ios)
>  	else
>  		ctrl &=3D ~SDHCI_CTRL_HISPD;
> =20
> -	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +	if (host->ops->set_ios)
> +		host->ops->set_ios(host, ios, ctrl);
> +	else
> +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> =20
> -	/*
> +	/*	FIXME: This can also be moved to ops->set_ios
> +	 *
>  	 * Some (ENE) controllers go apeshit on some ios operation,
>  	 * signalling timeout and CRC errors even on CMD0. Resetting
>  	 * it on each ios seems to solve the problem.
> @@ -1200,6 +1222,7 @@ out:
>  	mmiowb();
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_set_ios);
> =20
>  static int sdhci_get_ro(struct mmc_host *mmc)
>  {
> @@ -1383,10 +1406,13 @@ static void sdhci_cmd_irq(struct sdhci_host *host=
, u32 intmask)
>  	BUG_ON(intmask =3D=3D 0);
> =20
>  	if (!host->cmd) {
> -		printk(KERN_ERR "%s: Got command interrupt 0x%08x even "
> -			"though no command operation was in progress.\n",
> -			mmc_hostname(host->mmc), (unsigned)intmask);
> -		sdhci_dumpregs(host);
> +		if (host->ops->unexpected_cmd_irq)
> +			host->ops->unexpected_cmd_irq(host, intmask);
> +		else {
> +			printk(KERN_ERR "%s: Got command interrupt 0x%08x even though no comm=
and operation was in progress.\n",
> +				mmc_hostname(host->mmc), (unsigned)intmask);
> +			sdhci_dumpregs(host);
> +		}
>  		return;
>  	}
> =20
> @@ -1703,7 +1729,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (debug_quirks)
>  		host->quirks =3D debug_quirks;
> =20
> -	sdhci_reset(host, SDHCI_RESET_ALL);
> +	sdhci_reset_all(host, 0);
> =20
>  	host->version =3D sdhci_readw(host, SDHCI_HOST_VERSION);
>  	host->version =3D (host->version & SDHCI_SPEC_VER_MASK)
> @@ -1829,6 +1855,9 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>  		mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> =20
> +	if (host->ops->set_caps)
> +		host->ops->set_caps(host);
> +
>  	mmc->ocr_avail =3D 0;
>  	if (caps & SDHCI_CAN_VDD_330)
>  		mmc->ocr_avail |=3D MMC_VDD_32_33|MMC_VDD_33_34;
> @@ -1881,7 +1910,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	} else {
>  		mmc->max_blk_size =3D (caps & SDHCI_MAX_BLOCK_MASK) >>
>  				SDHCI_MAX_BLOCK_SHIFT;
> -		if (mmc->max_blk_size >=3D 3) {
> +		if (mmc->max_blk_size > 3) {

Why this change? Not mentioned in the changelog. And wrong according to
the simplified standard v2. Is it V3 material?

>  			printk(KERN_WARNING "%s: Invalid maximum block size, "
>  				"assuming 512 bytes\n", mmc_hostname(mmc));
>  			mmc->max_blk_size =3D 0;
> @@ -1952,7 +1981,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =20
>  #ifdef SDHCI_USE_LEDS_CLASS
>  reset:
> -	sdhci_reset(host, SDHCI_RESET_ALL);
> +	sdhci_reset_all(host, 1);
>  	free_irq(host->irq, host);
>  #endif
>  untasklet:
> @@ -1993,7 +2022,7 @@ void sdhci_remove_host(struct sdhci_host *host, int=
 dead)
>  #endif
> =20
>  	if (!dead)
> -		sdhci_reset(host, SDHCI_RESET_ALL);
> +		sdhci_reset_all(host, 1);
> =20
>  	free_irq(host->irq, host);
> =20
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d316bc7..182fcc3 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -323,6 +323,17 @@ struct sdhci_ops {
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> +
> +	/* Interface hooks to allow drivers to override standard behaviour */
> +	void	(*reset)(struct sdhci_host *host, u8 mask);
> +	void	(*reset_all)(struct sdhci_host *host, int down);
> +	void	(*init)(struct sdhci_host *host, int soft);
> +	void 	(*write_command)(struct sdhci_host *host,
> +				struct mmc_command *cmd, int flags);
> +	void	(*set_ios)(struct sdhci_host *host,
> +				struct mmc_ios *ios, u8 ctrl);
> +	void	(*set_caps)(struct sdhci_host *host);
> +	void	(*unexpected_cmd_irq)(struct sdhci_host *host, u32 intmask);

That looks quite much on a first view. Might need to dig in deeper...

>  };
> =20
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> @@ -427,4 +438,13 @@ extern int sdhci_suspend_host(struct sdhci_host *hos=
t, pm_message_t state);
>  extern int sdhci_resume_host(struct sdhci_host *host);
>  #endif
> =20
> +extern void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set);
> +extern int sdhci_pci_enable_dma(struct sdhci_host *host);
> +extern void sdhci_dumpregs(struct sdhci_host *host);
> +extern void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> +
> +/* Host function sets from driver support files */
> +extern struct sdhci_ops sdhci_intel_mrst_hc;
> +
> +
>  #endif /* __SDHCI_H */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 9438660..674316e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2410,6 +2410,8 @@
>  #define PCI_DEVICE_ID_INTEL_82375	0x0482
>  #define PCI_DEVICE_ID_INTEL_82424	0x0483
>  #define PCI_DEVICE_ID_INTEL_82378	0x0484
> +#define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
> +#define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
>  #define PCI_DEVICE_ID_INTEL_I960	0x0960
>  #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
>  #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyPh/0ACgkQD27XaX1/VRsheQCgjtDCJkDn/zVOfvproBZrOwLI
ciEAoJuoKt4zwYh8slfxU6/X3+tcKmgx
=eEFR
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--

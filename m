From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 3/3] mmc: split the sdhci.h to help
 platforms that uses shdci-pltfm d.d. (V2)
Date: Tue, 28 Sep 2010 13:14:11 +0200
Message-ID: <20100928111411.GF4441@pengutronix.de>
References: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
 <1285663289-20283-2-git-send-email-peppe.cavallaro@st.com>
 <1285663289-20283-3-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34180 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab0I1LOM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 07:14:12 -0400
Content-Disposition: inline
In-Reply-To: <1285663289-20283-3-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 28, 2010 at 10:41:29AM +0200, Giuseppe CAVALLARO wrote:
> Some platforms based on the shdci-pltfm device driver need to
> set own quirks (that currently are in drivers/mmc/host/sdhci.h).
>=20
> This patch splits this header file in two parts:
> o drivers/mmc/host/sdhci.h
>      include the HC registers and I/O accessors.
> o include/linux/mmc/sdhci.h
>      include the sdhci structure and quirks.
>=20
> Instead of including the devices/mmc/host/shdci.h, all
> the  platforms, based on shdci-pltfm, can only include:
> include/linux/mmc/sdhci.h and include/linux/sdhci-pltfm.h.
>=20
> Also This patch avoids to add/change the calls/flags in the
> sdhci_pltfm_data structure.
>=20
> It has been tested on STM platforms (e.g. STx7106, STx7108,
> STx5206) where the driver is configured and used as shown
> in the example below:
>=20
> [snip]
> static int mmc_pad_resources(struct sdhci_host *sdhci)
> {
> 	if (!devm_stm_pad_claim(sdhci->mmc->parent,
> 				&stx7108_mmc_pad_config,
> 				dev_name(sdhci->mmc->parent)))
> 		return -ENODEV;
>=20
> 	return 0;
> }
>=20
> static struct sdhci_pltfm_data stx7108_mmc_platform_data =3D {
> 	.init =3D mmc_pad_resources,
> 	.quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> };
>=20
> static struct platform_device stx7108_mmc_device =3D {
> 	.name =3D "sdhci",
> [snip]
>=20
> Note: drivers/mmc/host/sdhci.h also includes the linux/mmc/sdhci.h
> and no modifications should be needed on other sdhci-<XXX> drivers.
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>  drivers/mmc/host/sdhci.h  |  138 ++-------------------------------------=
----
>  include/linux/mmc/sdhci.h |  144 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 151 insertions(+), 131 deletions(-)
>  create mode 100644 include/linux/mmc/sdhci.h
>=20
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 112543a..410ee8a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -1,6 +1,8 @@
>  /*
>   *  linux/drivers/mmc/host/sdhci.h - Secure Digital Host Controller Inte=
rface driver
>   *
> + * Header file for Host Controller registers and I/O accessors.
> + *
>   *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify
> @@ -8,14 +10,16 @@
>   * the Free Software Foundation; either version 2 of the License, or (at
>   * your option) any later version.
>   */
> -#ifndef __SDHCI_H
> -#define __SDHCI_H
> +#ifndef __SDHCI_HW_H
> +#define __SDHCI_HW_H
> =20
>  #include <linux/scatterlist.h>
>  #include <linux/compiler.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
> =20
> +#include <linux/mmc/sdhci.h>
> +
>  /*
>   * Controller registers
>   */
> @@ -192,134 +196,6 @@
>  #define SDHCI_MAX_DIV_SPEC_200	256
>  #define SDHCI_MAX_DIV_SPEC_300	2046
> =20
> -struct sdhci_ops;
> -
> -struct sdhci_host {
> -	/* Data set by hardware interface driver */
> -	const char		*hw_name;	/* Hardware bus name */
> -
> -	unsigned int		quirks;		/* Deviations from spec. */
> -
> -/* Controller doesn't honor resets unless we touch the clock register */
> -#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
> -/* Controller has bad caps bits, but really supports DMA */
> -#define SDHCI_QUIRK_FORCE_DMA				(1<<1)
> -/* Controller doesn't like to be reset when there is no card inserted. */
> -#define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
> -/* Controller doesn't like clearing the power reg before a change */
> -#define SDHCI_QUIRK_SINGLE_POWER_WRITE			(1<<3)
> -/* Controller has flaky internal state so reset it on each ios change */
> -#define SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS		(1<<4)
> -/* Controller has an unusable DMA engine */
> -#define SDHCI_QUIRK_BROKEN_DMA				(1<<5)
> -/* Controller has an unusable ADMA engine */
> -#define SDHCI_QUIRK_BROKEN_ADMA				(1<<6)
> -/* Controller can only DMA from 32-bit aligned addresses */
> -#define SDHCI_QUIRK_32BIT_DMA_ADDR			(1<<7)
> -/* Controller can only DMA chunk sizes that are a multiple of 32 bits */
> -#define SDHCI_QUIRK_32BIT_DMA_SIZE			(1<<8)
> -/* Controller can only ADMA chunks that are a multiple of 32 bits */
> -#define SDHCI_QUIRK_32BIT_ADMA_SIZE			(1<<9)
> -/* Controller needs to be reset after each request to stay stable */
> -#define SDHCI_QUIRK_RESET_AFTER_REQUEST			(1<<10)
> -/* Controller needs voltage and power writes to happen separately */
> -#define SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER		(1<<11)
> -/* Controller provides an incorrect timeout value for transfers */
> -#define SDHCI_QUIRK_BROKEN_TIMEOUT_VAL			(1<<12)
> -/* Controller has an issue with buffer bits for small transfers */
> -#define SDHCI_QUIRK_BROKEN_SMALL_PIO			(1<<13)
> -/* Controller does not provide transfer-complete interrupt when not busy=
 */
> -#define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<14)
> -/* Controller has unreliable card detection */
> -#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
> -/* Controller reports inverted write-protect state */
> -#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
> -/* Controller has nonstandard clock management */
> -#define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<17)
> -/* Controller does not like fast PIO transfers */
> -#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
> -/* Controller losing signal/interrupt enable states after reset */
> -#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
> -/* Controller has to be forced to use block size of 2048 bytes */
> -#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
> -/* Controller cannot do multi-block transfers */
> -#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
> -/* Controller can only handle 1-bit data transfers */
> -#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
> -/* Controller needs 10ms delay between applying power and clock */
> -#define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
> -/* Controller uses SDCLK instead of TMCLK for data timeouts */
> -#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
> -/* Controller reports wrong base clock capability */
> -#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> -/* Controller cannot support End Attribute in NOP ADMA descriptor */
> -#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> -/* Controller is missing device caps. Use caps provided by host */
> -#define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
> -/* Controller uses Auto CMD12 command to stop the transfer */
> -#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
> -/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
> -#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
> -
> -	int			irq;		/* Device IRQ */
> -	void __iomem *		ioaddr;		/* Mapped address */
> -
> -	const struct sdhci_ops	*ops;		/* Low level hw interface */
> -
> -	struct regulator	*vmmc;		/* Power regulator */
> -
> -	/* Internal data */
> -	struct mmc_host		*mmc;		/* MMC structure */
> -	u64			dma_mask;	/* custom DMA mask */
> -
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> -	struct led_classdev	led;		/* LED control */
> -	char   led_name[32];
> -#endif
> -
> -	spinlock_t		lock;		/* Mutex */
> -
> -	int			flags;		/* Host attributes */
> -#define SDHCI_USE_SDMA		(1<<0)		/* Host is SDMA capable */
> -#define SDHCI_USE_ADMA		(1<<1)		/* Host is ADMA capable */
> -#define SDHCI_REQ_USE_DMA	(1<<2)		/* Use DMA for this req. */
> -#define SDHCI_DEVICE_DEAD	(1<<3)		/* Device unresponsive */
> -
> -	unsigned int		version;	/* SDHCI spec. version */
> -
> -	unsigned int		max_clk;	/* Max possible freq (MHz) */
> -	unsigned int		timeout_clk;	/* Timeout freq (KHz) */
> -
> -	unsigned int		clock;		/* Current clock (MHz) */
> -	u8			pwr;		/* Current voltage */
> -
> -	struct mmc_request	*mrq;		/* Current request */
> -	struct mmc_command	*cmd;		/* Current command */
> -	struct mmc_data		*data;		/* Current data request */
> -	unsigned int		data_early:1;	/* Data finished before cmd */
> -
> -	struct sg_mapping_iter	sg_miter;	/* SG state for PIO */
> -	unsigned int		blocks;		/* remaining PIO blocks */
> -
> -	int			sg_count;	/* Mapped sg entries */
> -
> -	u8			*adma_desc;	/* ADMA descriptor table */
> -	u8			*align_buffer;	/* Bounce buffer */
> -
> -	dma_addr_t		adma_addr;	/* Mapped ADMA descr. table */
> -	dma_addr_t		align_addr;	/* Mapped bounce buffer */
> -
> -	struct tasklet_struct	card_tasklet;	/* Tasklet structures */
> -	struct tasklet_struct	finish_tasklet;
> -
> -	struct timer_list	timer;		/* Timer for timeouts */
> -
> -	unsigned int		caps;		/* Alternative capabilities */
> -
> -	unsigned long		private[0] ____cacheline_aligned;
> -};
> -
> -
>  struct sdhci_ops {
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>  	u32		(*read_l)(struct sdhci_host *host, int reg);
> @@ -440,4 +316,4 @@ extern int sdhci_suspend_host(struct sdhci_host *host=
, pm_message_t state);
>  extern int sdhci_resume_host(struct sdhci_host *host);
>  #endif
> =20
> -#endif /* __SDHCI_H */
> +#endif /* __SDHCI_HW_H */
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> new file mode 100644
> index 0000000..1fdc673
> --- /dev/null
> +++ b/include/linux/mmc/sdhci.h
> @@ -0,0 +1,144 @@
> +/*
> + *  linux/include/linux/mmc/sdhci.h - Secure Digital Host Controller Int=
erface
> + *
> + *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or (at
> + * your option) any later version.
> + */
> +#ifndef __SDHCI_H
> +#define __SDHCI_H
> +
> +#include <linux/scatterlist.h>
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +
> +struct sdhci_host {
> +	/* Data set by hardware interface driver */
> +	const char *hw_name;	/* Hardware bus name */
> +
> +	unsigned int quirks;	/* Deviations from spec. */
> +
> +/* Controller doesn't honor resets unless we touch the clock register */
> +#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
> +/* Controller has bad caps bits, but really supports DMA */
> +#define SDHCI_QUIRK_FORCE_DMA				(1<<1)
> +/* Controller doesn't like to be reset when there is no card inserted. */
> +#define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
> +/* Controller doesn't like clearing the power reg before a change */
> +#define SDHCI_QUIRK_SINGLE_POWER_WRITE			(1<<3)
> +/* Controller has flaky internal state so reset it on each ios change */
> +#define SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS		(1<<4)
> +/* Controller has an unusable DMA engine */
> +#define SDHCI_QUIRK_BROKEN_DMA				(1<<5)
> +/* Controller has an unusable ADMA engine */
> +#define SDHCI_QUIRK_BROKEN_ADMA				(1<<6)
> +/* Controller can only DMA from 32-bit aligned addresses */
> +#define SDHCI_QUIRK_32BIT_DMA_ADDR			(1<<7)
> +/* Controller can only DMA chunk sizes that are a multiple of 32 bits */
> +#define SDHCI_QUIRK_32BIT_DMA_SIZE			(1<<8)
> +/* Controller can only ADMA chunks that are a multiple of 32 bits */
> +#define SDHCI_QUIRK_32BIT_ADMA_SIZE			(1<<9)
> +/* Controller needs to be reset after each request to stay stable */
> +#define SDHCI_QUIRK_RESET_AFTER_REQUEST			(1<<10)
> +/* Controller needs voltage and power writes to happen separately */
> +#define SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER		(1<<11)
> +/* Controller provides an incorrect timeout value for transfers */
> +#define SDHCI_QUIRK_BROKEN_TIMEOUT_VAL			(1<<12)
> +/* Controller has an issue with buffer bits for small transfers */
> +#define SDHCI_QUIRK_BROKEN_SMALL_PIO			(1<<13)
> +/* Controller does not provide transfer-complete interrupt when not busy=
 */
> +#define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<14)
> +/* Controller has unreliable card detection */
> +#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
> +/* Controller reports inverted write-protect state */
> +#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
> +/* Controller has nonstandard clock management */
> +#define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<17)
> +/* Controller does not like fast PIO transfers */
> +#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
> +/* Controller losing signal/interrupt enable states after reset */
> +#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
> +/* Controller has to be forced to use block size of 2048 bytes */
> +#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
> +/* Controller cannot do multi-block transfers */
> +#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
> +/* Controller can only handle 1-bit data transfers */
> +#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
> +/* Controller needs 10ms delay between applying power and clock */
> +#define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
> +/* Controller uses SDCLK instead of TMCLK for data timeouts */
> +#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
> +/* Controller reports wrong base clock capability */
> +#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> +/* Controller cannot support End Attribute in NOP ADMA descriptor */
> +#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> +/* Controller is missing device caps. Use caps provided by host */
> +#define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
> +/* Controller uses Auto CMD12 command to stop the transfer */
> +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
> +/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
> +#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
> +
> +	int irq;		/* Device IRQ */
> +	void __iomem *ioaddr;	/* Mapped address */
> +
> +	const struct sdhci_ops *ops;	/* Low level hw interface */
> +
> +	struct regulator *vmmc;	/* Power regulator */
> +
> +	/* Internal data */
> +	struct mmc_host *mmc;	/* MMC structure */
> +	u64 dma_mask;		/* custom DMA mask */
> +
> +#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
> +	struct led_classdev led;	/* LED control */
> +	char led_name[32];
> +#endif
> +
> +	spinlock_t lock;	/* Mutex */
> +
> +	int flags;		/* Host attributes */
> +#define SDHCI_USE_SDMA		(1<<0)	/* Host is SDMA capable */
> +#define SDHCI_USE_ADMA		(1<<1)	/* Host is ADMA capable */
> +#define SDHCI_REQ_USE_DMA	(1<<2)	/* Use DMA for this req. */
> +#define SDHCI_DEVICE_DEAD	(1<<3)	/* Device unresponsive */
> +
> +	unsigned int version;	/* SDHCI spec. version */
> +
> +	unsigned int max_clk;	/* Max possible freq (MHz) */
> +	unsigned int timeout_clk;	/* Timeout freq (KHz) */
> +
> +	unsigned int clock;	/* Current clock (MHz) */
> +	u8 pwr;			/* Current voltage */
> +
> +	struct mmc_request *mrq;	/* Current request */
> +	struct mmc_command *cmd;	/* Current command */
> +	struct mmc_data *data;	/* Current data request */
> +	unsigned int data_early:1;	/* Data finished before cmd */
> +
> +	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
> +	unsigned int blocks;	/* remaining PIO blocks */
> +
> +	int sg_count;		/* Mapped sg entries */
> +
> +	u8 *adma_desc;		/* ADMA descriptor table */
> +	u8 *align_buffer;	/* Bounce buffer */
> +
> +	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
> +	dma_addr_t align_addr;	/* Mapped bounce buffer */
> +
> +	struct tasklet_struct card_tasklet;	/* Tasklet structures */
> +	struct tasklet_struct finish_tasklet;
> +
> +	struct timer_list timer;	/* Timer for timeouts */
> +
> +	unsigned int caps;	/* Alternative capabilities */
> +
> +	unsigned long private[0] ____cacheline_aligned;
> +};
> +#endif /* __SDHCI_H */
> --=20
> 1.5.5.6
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyhzgMACgkQD27XaX1/VRvyBACfSY3TTqhf1KCmEzgKEGTv6qeF
k3UAoMsiqCYldex0PTElrv93zFsuIDvq
=net3
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--

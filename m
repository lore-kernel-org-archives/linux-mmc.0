From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH (mmc-next) 2/3] mmc: split the sdhci.h to help
 platforms that uses shdci-pltfm d.d.
Date: Mon, 27 Sep 2010 12:43:20 +0200
Message-ID: <20100927104320.GD2664@pengutronix.de>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42043 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab0I0KnV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 06:43:21 -0400
Content-Disposition: inline
In-Reply-To: <1285233266-5039-2-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2010 at 11:14:25AM +0200, Giuseppe CAVALLARO wrote:
> Some platforms based on the shdci-pltfm device driver need to
> set own quirks (that currently are in drivers/mmc/host/sdhci.h).
>=20
> This patch splits this header file in two parts:
>=20
> o drivers/mmc/host/sdhci.h
>      it includes the HC registers
>=20
> o include/linux/mmc/sdhci.h
>      it includes the private structures, callbacks, quirks etc.
>=20
> So, instead of including the shdci.h from devices/mmc/host, all
> the  platforms based on shdci-pltfm will be able to only include:
> include/linux/mmc/sdhci.h and include/linux/sdhci-pltfm.h.
>=20
> This has been tested on STM targets (STx7106, STx7108, STx5206).
>=20
> Note: drivers/mmc/host/sdhci.h also includes the linux/mmc/sdhci.h
> and no modifications should be needed on other sdhci-<XXX> drivers.
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

IMO this is too much exporting here. I can't see a reason to export the
sdhci_host-structure, for example. My idea would be to start with a
minimal approach and just copy over the stuff we need now (the quirks).
If we need more later, we add it seperately then.

> ---
>  drivers/mmc/host/sdhci.h  |  271 ++-------------------------------------=
------
>  include/linux/mmc/sdhci.h |  269 +++++++++++++++++++++++++++++++++++++++=
+++++
>  2 files changed, 280 insertions(+), 260 deletions(-)
>  create mode 100644 include/linux/mmc/sdhci.h
>=20
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index ae28a31..3b96e4a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -1,5 +1,7 @@
>  /*
> - *  linux/drivers/mmc/host/sdhci.h - Secure Digital Host Controller Inte=
rface driver
> + *  linux/drivers/mmc/host/sdhci.h - Secure Digital Host Controller Inte=
rface
> + *
> + * Host Controller registers.
>   *
>   *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
>   *
> @@ -8,13 +10,10 @@
>   * the Free Software Foundation; either version 2 of the License, or (at
>   * your option) any later version.
>   */
> -#ifndef __SDHCI_H
> -#define __SDHCI_H
> +#ifndef __SDHCI_HW_H
> +#define __SDHCI_HW_H
> =20
> -#include <linux/scatterlist.h>
> -#include <linux/compiler.h>
> -#include <linux/types.h>
> -#include <linux/io.h>
> +#include <linux/mmc/sdhci.h>
> =20
>  /*
>   * Controller registers
> @@ -181,256 +180,8 @@
>  #define  SDHCI_VENDOR_VER_SHIFT	8
>  #define  SDHCI_SPEC_VER_MASK	0x00FF
>  #define  SDHCI_SPEC_VER_SHIFT	0
> -#define   SDHCI_SPEC_100	0
> -#define   SDHCI_SPEC_200	1
> -#define   SDHCI_SPEC_300	2
> -
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
> -struct sdhci_ops {
> -#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> -	u32		(*read_l)(struct sdhci_host *host, int reg);
> -	u16		(*read_w)(struct sdhci_host *host, int reg);
> -	u8		(*read_b)(struct sdhci_host *host, int reg);
> -	void		(*write_l)(struct sdhci_host *host, u32 val, int reg);
> -	void		(*write_w)(struct sdhci_host *host, u16 val, int reg);
> -	void		(*write_b)(struct sdhci_host *host, u8 val, int reg);
> -#endif
> -
> -	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
> -
> -	int		(*enable_dma)(struct sdhci_host *host);
> -	unsigned int	(*get_max_clock)(struct sdhci_host *host);
> -	unsigned int	(*get_min_clock)(struct sdhci_host *host);
> -	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> -};
> -
> -#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> -
> -static inline void sdhci_writel(struct sdhci_host *host, u32 val, int re=
g)
> -{
> -	if (unlikely(host->ops->write_l))
> -		host->ops->write_l(host, val, reg);
> -	else
> -		writel(val, host->ioaddr + reg);
> -}
> -
> -static inline void sdhci_writew(struct sdhci_host *host, u16 val, int re=
g)
> -{
> -	if (unlikely(host->ops->write_w))
> -		host->ops->write_w(host, val, reg);
> -	else
> -		writew(val, host->ioaddr + reg);
> -}
> -
> -static inline void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
> -{
> -	if (unlikely(host->ops->write_b))
> -		host->ops->write_b(host, val, reg);
> -	else
> -		writeb(val, host->ioaddr + reg);
> -}
> -
> -static inline u32 sdhci_readl(struct sdhci_host *host, int reg)
> -{
> -	if (unlikely(host->ops->read_l))
> -		return host->ops->read_l(host, reg);
> -	else
> -		return readl(host->ioaddr + reg);
> -}
> -
> -static inline u16 sdhci_readw(struct sdhci_host *host, int reg)
> -{
> -	if (unlikely(host->ops->read_w))
> -		return host->ops->read_w(host, reg);
> -	else
> -		return readw(host->ioaddr + reg);
> -}
> -
> -static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
> -{
> -	if (unlikely(host->ops->read_b))
> -		return host->ops->read_b(host, reg);
> -	else
> -		return readb(host->ioaddr + reg);
> -}
> -
> -#else
> -
> -static inline void sdhci_writel(struct sdhci_host *host, u32 val, int re=
g)
> -{
> -	writel(val, host->ioaddr + reg);
> -}
> -
> -static inline void sdhci_writew(struct sdhci_host *host, u16 val, int re=
g)
> -{
> -	writew(val, host->ioaddr + reg);
> -}
> -
> -static inline void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
> -{
> -	writeb(val, host->ioaddr + reg);
> -}
> -
> -static inline u32 sdhci_readl(struct sdhci_host *host, int reg)
> -{
> -	return readl(host->ioaddr + reg);
> -}
> -
> -static inline u16 sdhci_readw(struct sdhci_host *host, int reg)
> -{
> -	return readw(host->ioaddr + reg);
> -}
> -
> -static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
> -{
> -	return readb(host->ioaddr + reg);
> -}
> -
> -#endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
> -
> -extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
> -	size_t priv_size);
> -extern void sdhci_free_host(struct sdhci_host *host);
> -
> -static inline void *sdhci_priv(struct sdhci_host *host)
> -{
> -	return (void *)host->private;
> -}
> -
> -extern void sdhci_card_detect(struct sdhci_host *host);
> -extern int sdhci_add_host(struct sdhci_host *host);
> -extern void sdhci_remove_host(struct sdhci_host *host, int dead);
> -
> -#ifdef CONFIG_PM
> -extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t stat=
e);
> -extern int sdhci_resume_host(struct sdhci_host *host);
> -#endif
> -
> -#endif /* __SDHCI_H */
> +#define  SDHCI_SPEC_100	0
> +#define  SDHCI_SPEC_200	1
> +#define  SDHCI_SPEC_300	2
> +
> +#endif /* __SDHCI_HW_H */
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> new file mode 100644
> index 0000000..dd4552d
> --- /dev/null
> +++ b/include/linux/mmc/sdhci.h
> @@ -0,0 +1,269 @@
> +/*
> + *  linux/drivers/mmc/host/sdhci.h - Secure Digital Host Controller Inte=
rface
> + *
> + * * Private sdhci structure, quirks, callbacks.
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
> +struct sdhci_ops;
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
> +
> +struct sdhci_ops {
> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> +	u32(*read_l) (struct sdhci_host *host, int reg);
> +	u16(*read_w) (struct sdhci_host *host, int reg);
> +	u8(*read_b) (struct sdhci_host *host, int reg);
> +	void (*write_l) (struct sdhci_host *host, u32 val, int reg);
> +	void (*write_w) (struct sdhci_host *host, u16 val, int reg);
> +	void (*write_b) (struct sdhci_host *host, u8 val, int reg);
> +#endif
> +
> +	void (*set_clock) (struct sdhci_host *host, unsigned int clock);
> +
> +	int (*enable_dma) (struct sdhci_host *host);
> +	unsigned int (*get_max_clock) (struct sdhci_host *host);
> +	unsigned int (*get_min_clock) (struct sdhci_host *host);
> +	unsigned int (*get_timeout_clock) (struct sdhci_host *host);
> +};
> +
> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> +
> +static inline void sdhci_writel(struct sdhci_host *host, u32 val, int re=
g)
> +{
> +	if (unlikely(host->ops->write_l))
> +		host->ops->write_l(host, val, reg);
> +	else
> +		writel(val, host->ioaddr + reg);
> +}
> +
> +static inline void sdhci_writew(struct sdhci_host *host, u16 val, int re=
g)
> +{
> +	if (unlikely(host->ops->write_w))
> +		host->ops->write_w(host, val, reg);
> +	else
> +		writew(val, host->ioaddr + reg);
> +}
> +
> +static inline void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
> +{
> +	if (unlikely(host->ops->write_b))
> +		host->ops->write_b(host, val, reg);
> +	else
> +		writeb(val, host->ioaddr + reg);
> +}
> +
> +static inline u32 sdhci_readl(struct sdhci_host *host, int reg)
> +{
> +	if (unlikely(host->ops->read_l))
> +		return host->ops->read_l(host, reg);
> +	else
> +		return readl(host->ioaddr + reg);
> +}
> +
> +static inline u16 sdhci_readw(struct sdhci_host *host, int reg)
> +{
> +	if (unlikely(host->ops->read_w))
> +		return host->ops->read_w(host, reg);
> +	else
> +		return readw(host->ioaddr + reg);
> +}
> +
> +static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
> +{
> +	if (unlikely(host->ops->read_b))
> +		return host->ops->read_b(host, reg);
> +	else
> +		return readb(host->ioaddr + reg);
> +}
> +
> +#else
> +
> +static inline void sdhci_writel(struct sdhci_host *host, u32 val, int re=
g)
> +{
> +	writel(val, host->ioaddr + reg);
> +}
> +
> +static inline void sdhci_writew(struct sdhci_host *host, u16 val, int re=
g)
> +{
> +	writew(val, host->ioaddr + reg);
> +}
> +
> +static inline void sdhci_writeb(struct sdhci_host *host, u8 val, int reg)
> +{
> +	writeb(val, host->ioaddr + reg);
> +}
> +
> +static inline u32 sdhci_readl(struct sdhci_host *host, int reg)
> +{
> +	return readl(host->ioaddr + reg);
> +}
> +
> +static inline u16 sdhci_readw(struct sdhci_host *host, int reg)
> +{
> +	return readw(host->ioaddr + reg);
> +}
> +
> +static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
> +{
> +	return readb(host->ioaddr + reg);
> +}
> +
> +#endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
> +
> +extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
> +					   size_t priv_size);
> +extern void sdhci_free_host(struct sdhci_host *host);
> +
> +static inline void *sdhci_priv(struct sdhci_host *host)
> +{
> +	return (void *)host->private;
> +}
> +
> +extern void sdhci_card_detect(struct sdhci_host *host);
> +extern int sdhci_add_host(struct sdhci_host *host);
> +extern void sdhci_remove_host(struct sdhci_host *host, int dead);
> +
> +#ifdef CONFIG_PM
> +extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t stat=
e);
> +extern int sdhci_resume_host(struct sdhci_host *host);
> +#endif
> +
> +#endif /* __SDHCI_H */
> --=20
> 1.5.5.6
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygdUgACgkQD27XaX1/VRtd3wCdGpqPzp5bDuYGY54ijmqv3E66
DE8AoL/5BeVHIYt2cqLtHhEvuGcDa3OK
=Ewkb
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--

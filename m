From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] [wip] repair mci dma transfers for avr32
Date: Mon, 11 Jan 2016 10:54:47 +0200
Message-ID: <1452502487.26146.1.camel@linux.intel.com>
References: <1437998010-12036-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1439394548-1020-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15065 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758469AbcAKIyW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jan 2016 03:54:22 -0500
In-Reply-To: <1439394548-1020-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc@vger.kernel.org, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: ulf.hansson@linaro.org, arnd@arndb.de, hskinnemoen@gmail.com, egtvedt@samfundet.no, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com

+M=C3=A5ns

On Wed, 2015-08-12 at 17:49 +0200, Ludovic Desroches wrote:
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>=20
> Hi,
>=20
> Here is a rough draft to fix the regression. I have only compiled it.
> I will
> update all the boards later.
>=20
> I have removed the mci_dma_data since it is no more used for ARM
> platforms.

Sorry for really late answer, but seems M=C3=A5ns fixed the issue. He h=
as a
board to test as well.

>=20
> =C2=A0arch/avr32/boards/atngw100/setup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> =C2=A0arch/avr32/mach-at32ap/at32ap700x.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 31
> +++++++++++++++++++++--------
> =C2=A0arch/avr32/mach-at32ap/include/mach/board.h |=C2=A0=C2=A02 ++
> =C2=A0drivers/mmc/host/atmel-mci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 16 ++++++=
+++++++--
> =C2=A0include/linux/atmel-mci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A02 ++
> =C2=A0include/linux/platform_data/mmc-atmel-mci.h | 22 --------------=
---
> ---
> =C2=A06 files changed, 42 insertions(+), 32 deletions(-)
> =C2=A0delete mode 100644 include/linux/platform_data/mmc-atmel-mci.h
>=20
> diff --git a/arch/avr32/boards/atngw100/setup.c
> b/arch/avr32/boards/atngw100/setup.c
> index afeae89..8b4f3d1 100644
> --- a/arch/avr32/boards/atngw100/setup.c
> +++ b/arch/avr32/boards/atngw100/setup.c
> @@ -131,6 +131,7 @@ static struct mci_platform_data __initdata
> mci0_data =3D {
> =C2=A0		.wp_pin		=3D GPIO_PIN_PE(0),
> =C2=A0#endif
> =C2=A0	},
> +	.dma_filter =3D &atmci_filter,
> =C2=A0};
> =C2=A0
> =C2=A0static struct usba_platform_data atngw100_usba_data __initdata =
=3D {
> diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-
> at32ap/at32ap700x.c
> index 1d8b147..8c6f77e 100644
> --- a/arch/avr32/mach-at32ap/at32ap700x.c
> +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> @@ -7,6 +7,7 @@
> =C2=A0 */
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> =C2=A0#include <linux/platform_data/dma-dw.h>
> =C2=A0#include <linux/fb.h>
> =C2=A0#include <linux/init.h>
> @@ -17,7 +18,6 @@
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/usb/atmel_usba_udc.h>
> =C2=A0
> -#include <linux/platform_data/mmc-atmel-mci.h>
> =C2=A0#include <linux/atmel-mci.h>
> =C2=A0
> =C2=A0#include <asm/io.h>
> @@ -1332,7 +1332,7 @@ struct platform_device *__init
> =C2=A0at32_add_device_mci(unsigned int id, struct mci_platform_data *=
data)
> =C2=A0{
> =C2=A0	struct platform_device		*pdev;
> -	struct mci_dma_data	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
*slave;
> +	struct dw_dma_slave=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	*slave;
> =C2=A0	u32				pioa_mask;
> =C2=A0	u32				piob_mask;
> =C2=A0
> @@ -1351,15 +1351,15 @@ at32_add_device_mci(unsigned int id, struct
> mci_platform_data *data)
> =C2=A0				ARRAY_SIZE(atmel_mci0_resource)))
> =C2=A0		goto fail;
> =C2=A0
> -	slave =3D kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
> +	slave =3D kzalloc(sizeof(*slave), GFP_KERNEL);
> =C2=A0	if (!slave)
> =C2=A0		goto fail;
> =C2=A0
> -	slave->sdata.dma_dev =3D &dw_dmac0_device.dev;
> -	slave->sdata.src_id =3D 0;
> -	slave->sdata.dst_id =3D 1;
> -	slave->sdata.src_master =3D 1;
> -	slave->sdata.dst_master =3D 0;
> +	slave->dma_dev =3D &dw_dmac0_device.dev;
> +	slave->src_id =3D 0;
> +	slave->dst_id =3D 1;
> +	slave->src_master =3D 1;
> +	slave->dst_master =3D 0;
> =C2=A0
> =C2=A0	data->dma_slave =3D slave;
> =C2=A0
> @@ -1435,6 +1435,21 @@ fail:
> =C2=A0	return NULL;
> =C2=A0}
> =C2=A0
> +bool atmci_filter(struct dma_chan *chan, void *pdata)
> +{
> +	struct dw_dma_slave *sl_pdata =3D pdata;
> +
> +	if (!sl_pdata)
> +		return false;
> +
> +	if (sl_pdata->dma_dev =3D=3D chan->device->dev) {
> +		chan->private =3D sl_pdata;
> +		return true;
> +	} else {
> +		return false;
> +	}
> +}
> +
> =C2=A0/* ------------------------------------------------------------=
---
> -----
> =C2=A0 *=C2=A0=C2=A0LCDC
> =C2=A0 * ------------------------------------------------------------=
---
> ----- */
> diff --git a/arch/avr32/mach-at32ap/include/mach/board.h
> b/arch/avr32/mach-at32ap/include/mach/board.h
> index f1a316d..e6f9e56 100644
> --- a/arch/avr32/mach-at32ap/include/mach/board.h
> +++ b/arch/avr32/mach-at32ap/include/mach/board.h
> @@ -4,6 +4,7 @@
> =C2=A0#ifndef __ASM_ARCH_BOARD_H
> =C2=A0#define __ASM_ARCH_BOARD_H
> =C2=A0
> +#include <linux/dmaengine.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/serial.h>
> =C2=A0#include <linux/platform_data/macb.h>
> @@ -86,6 +87,7 @@ struct platform_device
> *at32_add_device_twi(unsigned int id,
> =C2=A0struct mci_platform_data;
> =C2=A0struct platform_device *
> =C2=A0at32_add_device_mci(unsigned int id, struct mci_platform_data
> *data);
> +bool atmci_filter(struct dma_chan *chan, void *pdata);
> =C2=A0
> =C2=A0struct ac97c_platform_data;
> =C2=A0struct platform_device *
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-
> mci.c
> index 9a39e0b..1d80135 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -30,7 +30,6 @@
> =C2=A0#include <linux/stat.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/platform_data/atmel.h>
> -#include <linux/platform_data/mmc-atmel-mci.h>
> =C2=A0
> =C2=A0#include <linux/mmc/host.h>
> =C2=A0#include <linux/mmc/sdio.h>
> @@ -2281,8 +2280,21 @@ static int atmci_configure_dma(struct
> atmel_mci *host)
> =C2=A0{
> =C2=A0	host->dma.chan =3D dma_request_slave_channel_reason(&host-
> >pdev->dev,
> =C2=A0							"rxtx");
> -	if (IS_ERR(host->dma.chan))
> +	if (IS_ERR(host->dma.chan) =3D=3D -ENODEV) {
> +		dma_cap_mask_t mask;
> +		struct mci_platform_data *pdata =3D host->pdev-
> >dev.platform_data;
> +		/*=C2=A0=C2=A0*/
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_SLAVE, mask);
> +
> +		host->dma.chan =3D dma_request_channel(mask,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pdata-
> >dma_filter,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pdata-
> >dma_slave);
> +		if (!host->dma.chan)
> +			return -ENODEV;
> +	} else {
> =C2=A0		return PTR_ERR(host->dma.chan);
> +	}
> =C2=A0
> =C2=A0	dev_info(&host->pdev->dev, "using %s for DMA transfers\n",
> =C2=A0		=C2=A0dma_chan_name(host->dma.chan));
> diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
> index 9177947..fe5d72f 100644
> --- a/include/linux/atmel-mci.h
> +++ b/include/linux/atmel-mci.h
> @@ -1,6 +1,7 @@
> =C2=A0#ifndef __LINUX_ATMEL_MCI_H
> =C2=A0#define __LINUX_ATMEL_MCI_H
> =C2=A0
> +#include <linux/dmaengine.h>
> =C2=A0#include <linux/types.h>
> =C2=A0
> =C2=A0#define ATMCI_MAX_NR_SLOTS	2
> @@ -38,6 +39,7 @@ struct mci_slot_pdata {
> =C2=A0struct mci_platform_data {
> =C2=A0	struct mci_dma_data	*dma_slave;
> =C2=A0	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
> +	bool (*dma_filter)=C2=A0	(struct dma_chan *chan, void
> *pdata);
> =C2=A0};
> =C2=A0
> =C2=A0#endif /* __LINUX_ATMEL_MCI_H */
> diff --git a/include/linux/platform_data/mmc-atmel-mci.h
> b/include/linux/platform_data/mmc-atmel-mci.h
> deleted file mode 100644
> index 399a2d5..0000000
> --- a/include/linux/platform_data/mmc-atmel-mci.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -#ifndef __MMC_ATMEL_MCI_H
> -#define __MMC_ATMEL_MCI_H
> -
> -#include <linux/platform_data/dma-atmel.h>
> -#include <linux/platform_data/dma-dw.h>
> -
> -/**
> - * struct mci_dma_data - DMA data for MCI interface
> - */
> -struct mci_dma_data {
> -#ifdef CONFIG_ARM
> -	struct at_dma_slave=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sdata;
> -#else
> -	struct dw_dma_slave=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sdata;
> -#endif
> -};
> -
> -/* accessor macros */
> -#define	slave_data_ptr(s)	(&(s)->sdata)
> -#define find_slave_dev(s)	((s)->sdata.dma_dev)
> -
> -#endif /* __MMC_ATMEL_MCI_H */

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy


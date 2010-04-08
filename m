From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 09/11] ARM: add PrimeCell generic DMA to PL022 v5
Date: Thu, 8 Apr 2010 00:17:21 -0600
Message-ID: <u2tfa686aa41004072317h613cca61x8f15982caccabddb@mail.gmail.com>
References: <1270682051-7058-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40034 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab0DHGRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Apr 2010 02:17:43 -0400
In-Reply-To: <1270682051-7058-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: akpm@linux-foundation.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-kernel@vger.kernel.org

On Wed, Apr 7, 2010 at 5:14 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This extends the PL022 UART driver with generic DMA engine support
> using the PrimeCell DMA engine interface. Also fix up the test
> code for the U300 platform.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

I have not reviewed, compiled, or tested this.  I've only skimmed over
it.  Simply for the purpose of merging the spi portion, you can add my
"Acked-by: Grant Likely <grant.likely@secretlab.ca>" line, but collect
other acks from people who will actually review it.

g.

> ---
> =A0arch/arm/mach-u300/dummyspichip.c | =A0 =A01 +
> =A0drivers/spi/amba-pl022.c =A0 =A0 =A0 =A0 =A0| =A0517 +++++++++++++=
++++++++++++++++++------
> =A0include/linux/amba/pl022.h =A0 =A0 =A0 =A0| =A0 =A06 +
> =A03 files changed, 438 insertions(+), 86 deletions(-)
>
> diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/d=
ummyspichip.c
> index 5f55012..5672189 100644
> --- a/arch/arm/mach-u300/dummyspichip.c
> +++ b/arch/arm/mach-u300/dummyspichip.c
> @@ -268,6 +268,7 @@ static struct spi_driver pl022_dummy_driver =3D {
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "spi-dummy",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus =3D &spi_bus_type,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.probe =A0=3D pl022_dummy_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(pl022_dummy_remove),
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index e9aeee1..09a701c 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -27,7 +27,6 @@
> =A0/*
> =A0* TODO:
> =A0* - add timeout on polled transfers
> - * - add generic DMA framework support
> =A0*/
>
> =A0#include <linux/init.h>
> @@ -45,6 +44,10 @@
> =A0#include <linux/amba/pl022.h>
> =A0#include <linux/io.h>
> =A0#include <linux/slab.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/amba/dma.h>
>
> =A0/*
> =A0* This macro is used to define some register default values.
> @@ -365,6 +368,14 @@ struct pl022 {
> =A0 =A0 =A0 =A0enum ssp_reading =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read;
> =A0 =A0 =A0 =A0enum ssp_writing =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 exp_fifo_level;
> + =A0 =A0 =A0 /* DMA settings */
> +#ifdef CONFIG_DMADEVICES
> + =A0 =A0 =A0 struct dma_chan =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dma_rx=
_channel;
> + =A0 =A0 =A0 struct dma_chan =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dma_tx=
_channel;
> + =A0 =A0 =A0 struct sg_table =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgt_rx;
> + =A0 =A0 =A0 struct sg_table =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgt_tx;
> + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*dummypage;
> +#endif
> =A0};
>
> =A0/**
> @@ -699,6 +710,367 @@ static void *next_transfer(struct pl022 *pl022)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return STATE_DONE;
> =A0}
> +
> +/*
> + * This DMA functionality is only compiled in if we have
> + * access to the generic DMA devices/DMA engine.
> + */
> +#ifdef CONFIG_DMADEVICES
> +static void unmap_free_dma_scatter(struct pl022 *pl022)
> +{
> + =A0 =A0 =A0 /* Unmap and free the SG tables */
> + =A0 =A0 =A0 dma_unmap_sg(&pl022->adev->dev, pl022->sgt_tx.sgl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->sgt_tx.nents, DMA_TO_=
DEVICE);
> + =A0 =A0 =A0 dma_unmap_sg(&pl022->adev->dev, pl022->sgt_rx.sgl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->sgt_rx.nents, DMA_FRO=
M_DEVICE);
> + =A0 =A0 =A0 sg_free_table(&pl022->sgt_rx);
> + =A0 =A0 =A0 sg_free_table(&pl022->sgt_tx);
> +}
> +
> +static void dma_callback(void *data)
> +{
> + =A0 =A0 =A0 struct pl022 *pl022 =3D data;
> + =A0 =A0 =A0 struct spi_message *msg =3D pl022->cur_msg;
> +
> + =A0 =A0 =A0 /* Sync in RX buffer to CPU */
> + =A0 =A0 =A0 BUG_ON(!pl022->sgt_rx.sgl);
> + =A0 =A0 =A0 dma_sync_sg_for_cpu(&pl022->adev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->sgt_rx.s=
gl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->sgt_rx.n=
ents,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_FROM_DEVICE=
);
> +
> +#ifdef VERBOSE_DEBUG
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Optionally dump out buffers to inspect contents, t=
his is
> + =A0 =A0 =A0 =A0* good if you want to convince yourself that the loo=
pback
> + =A0 =A0 =A0 =A0* read/write contents are the same, when adopting to=
 a new
> + =A0 =A0 =A0 =A0* DMA engine.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct scatterlist *sg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sg(pl022->sgt_rx.sgl, sg, pl02=
2->sgt_rx.nents, i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pl022->adev->d=
ev, "SPI RX SG ENTRY: %d", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print_hex_dump(KERN_ERR=
, "SPI RX: ",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0DUMP_PREFIX_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A016,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A01,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0sg_virt(sg),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0sg_dma_len(sg),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A01);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sg(pl022->sgt_tx.sgl, sg, pl02=
2->sgt_tx.nents, i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pl022->adev->d=
ev, "SPI TX SG ENTRY: %d", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print_hex_dump(KERN_ERR=
, "SPI TX: ",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0DUMP_PREFIX_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A016,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A01,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0sg_virt(sg),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0sg_dma_len(sg),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A01);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +#endif
> +
> + =A0 =A0 =A0 unmap_free_dma_scatter(pl022);
> +
> + =A0 =A0 =A0 /* Update total bytes transfered */
> + =A0 =A0 =A0 msg->actual_length +=3D pl022->cur_transfer->len;
> + =A0 =A0 =A0 if (pl022->cur_transfer->cs_change)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->cur_chip->
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_control(SSP_CHIP_DES=
ELECT);
> +
> + =A0 =A0 =A0 /* Move to next transfer */
> + =A0 =A0 =A0 msg->state =3D next_transfer(pl022);
> + =A0 =A0 =A0 tasklet_schedule(&pl022->pump_transfers);
> +}
> +
> +static void setup_dma_scatter(struct pl022 *pl022,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *buffe=
r,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned in=
t length,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sg_t=
able *sgtab)
> +{
> + =A0 =A0 =A0 struct scatterlist *sg;
> + =A0 =A0 =A0 int bytesleft =3D length;
> + =A0 =A0 =A0 void *bufp =3D buffer;
> + =A0 =A0 =A0 int mapbytes;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (buffer) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sg(sgtab->sgl, sg, sgtab->nent=
s, i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If there are less =
bytes left than what fits
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in the current pag=
e (plus page alignment offset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we just feed in th=
is, else we stuff in as much
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* as we can.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bytesleft < (PAGE_S=
IZE - offset_in_page(bufp)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mapbyte=
s =3D bytesleft;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mapbyte=
s =3D PAGE_SIZE - offset_in_page(bufp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_set_page(sg, virt_to=
_page(bufp),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mapbytes, offset_in_page(bufp));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bufp +=3D mapbytes;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytesleft -=3D mapbytes=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pl022->adev->d=
ev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "set RX=
/TX target page @ %p, %d bytes, %d left\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bufp, m=
apbytes, bytesleft);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Map the dummy buffer on every page *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_sg(sgtab->sgl, sg, sgtab->nent=
s, i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bytesleft < PAGE_SI=
ZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mapbyte=
s =3D bytesleft;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mapbyte=
s =3D PAGE_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_set_page(sg, virt_to=
_page(pl022->dummypage),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 mapbytes, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytesleft -=3D mapbytes=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pl022->adev->d=
ev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "set RX=
/TX to dummy page %d bytes, %d left\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mapbyte=
s, bytesleft);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 BUG_ON(bytesleft);
> +}
> +
> +/**
> + * configure_dma - configures the channels for the next transfer
> + * @data: SSP driver's private data structure
> + *
> + */
> +static int configure_dma(struct pl022 *pl022)
> +{
> + =A0 =A0 =A0 struct amba_dma_channel_config rx_conf =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =3D SSP_DR(pl022->phybase),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .direction =3D DMA_FROM_DEVICE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxburst =3D pl022->vendor->fifodepth =
>> 1,
> + =A0 =A0 =A0 };
> + =A0 =A0 =A0 struct amba_dma_channel_config tx_conf =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =3D SSP_DR(pl022->phybase),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .direction =3D DMA_TO_DEVICE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .maxburst =3D pl022->vendor->fifodepth =
>> 1,
> + =A0 =A0 =A0 };
> + =A0 =A0 =A0 unsigned int pages;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int sglen;
> + =A0 =A0 =A0 struct dma_chan *rxchan =3D pl022->dma_rx_channel;
> + =A0 =A0 =A0 struct dma_chan *txchan =3D pl022->dma_tx_channel;
> + =A0 =A0 =A0 struct dma_async_tx_descriptor *rxdesc;
> + =A0 =A0 =A0 struct dma_async_tx_descriptor *txdesc;
> +
> + =A0 =A0 =A0 /* Check that the channels are available */
> + =A0 =A0 =A0 if (!rxchan || !txchan)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 switch (pl022->read) {
> + =A0 =A0 =A0 case READING_NULL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Use the same as for writing */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_conf.addr_width =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case READING_U8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_conf.addr_width =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case READING_U16:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_conf.addr_width =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case READING_U32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_conf.addr_width =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch (pl022->write) {
> + =A0 =A0 =A0 case WRITING_NULL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Use the same as for reading */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_conf.addr_width =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case WRITING_U8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_conf.addr_width =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case WRITING_U16:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_conf.addr_width =3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case WRITING_U32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_conf.addr_width =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* SPI pecularity: we need to read and write the same w=
idth */
> + =A0 =A0 =A0 if (rx_conf.addr_width =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_conf.addr_width =3D tx_conf.addr_wid=
th;
> + =A0 =A0 =A0 if (tx_conf.addr_width =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_conf.addr_width =3D rx_conf.addr_wid=
th;
> + =A0 =A0 =A0 BUG_ON(rx_conf.addr_width !=3D tx_conf.addr_width);
> +
> + =A0 =A0 =A0 dma_set_ambaconfig(pl022->dma_rx_channel, &rx_conf);
> + =A0 =A0 =A0 dma_set_ambaconfig(pl022->dma_tx_channel, &tx_conf);
> +
> + =A0 =A0 =A0 /* Create sglists for the transfers */
> + =A0 =A0 =A0 pages =3D (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
> + =A0 =A0 =A0 dev_dbg(&pl022->adev->dev, "using %d pages for transfer=
\n", pages);
> +
> + =A0 =A0 =A0 ret =3D sg_alloc_table(&pl022->sgt_rx, pages, GFP_KERNE=
L);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc_rx_sg;
> +
> + =A0 =A0 =A0 ret =3D sg_alloc_table(&pl022->sgt_tx, pages, GFP_KERNE=
L);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc_tx_sg;
> +
> + =A0 =A0 =A0 /* Fill in the scatterlists for the RX+TX buffers */
> + =A0 =A0 =A0 setup_dma_scatter(pl022, pl022->rx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->cur_transfer=
->len, &pl022->sgt_rx);
> + =A0 =A0 =A0 setup_dma_scatter(pl022, pl022->tx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->cur_transfer=
->len, &pl022->sgt_tx);
> +
> + =A0 =A0 =A0 /* Map DMA buffers */
> + =A0 =A0 =A0 sglen =3D dma_map_sg(&pl022->adev->dev, pl022->sgt_rx.s=
gl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->sgt_rx.ne=
nts, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 if (sglen !=3D pages)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_rx_sgmap;
> +
> + =A0 =A0 =A0 sglen =3D dma_map_sg(&pl022->adev->dev, pl022->sgt_tx.s=
gl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->sgt_tx.ne=
nts, DMA_TO_DEVICE);
> + =A0 =A0 =A0 if (sglen !=3D pages)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tx_sgmap;
> +
> + =A0 =A0 =A0 /* Synchronize the TX scatterlist, invalidate buffers, =
caches etc */
> + =A0 =A0 =A0 dma_sync_sg_for_device(&pl022->adev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->s=
gt_tx.sgl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->s=
gt_tx.nents,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_TO_D=
EVICE);
> +
> + =A0 =A0 =A0 /* Send both scatterlists */
> + =A0 =A0 =A0 rxdesc =3D rxchan->device->device_prep_slave_sg(rxchan,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pl022->sgt_rx.sgl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pl022->sgt_rx.nents,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_FROM_DEVICE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> + =A0 =A0 =A0 if (!rxdesc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_rxdesc;
> +
> + =A0 =A0 =A0 txdesc =3D txchan->device->device_prep_slave_sg(txchan,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pl022->sgt_tx.sgl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pl022->sgt_tx.nents,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_TO_DEVICE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> + =A0 =A0 =A0 if (!txdesc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_txdesc;
> +
> + =A0 =A0 =A0 /* Put the callback on the RX transfer only, that shoul=
d finish last */
> + =A0 =A0 =A0 rxdesc->callback =3D dma_callback;
> + =A0 =A0 =A0 rxdesc->callback_param =3D pl022;
> +
> + =A0 =A0 =A0 /* Submit and fire RX and TX with TX last so we're read=
y to read! */
> + =A0 =A0 =A0 rxdesc->tx_submit(rxdesc);
> + =A0 =A0 =A0 txdesc->tx_submit(txdesc);
> + =A0 =A0 =A0 rxchan->device->device_issue_pending(rxchan);
> + =A0 =A0 =A0 txchan->device->device_issue_pending(txchan);
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_txdesc:
> +err_rxdesc:
> + =A0 =A0 =A0 dma_unmap_sg(&pl022->adev->dev, pl022->sgt_tx.sgl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->sgt_tx.nents, DMA_TO_=
DEVICE);
> +err_tx_sgmap:
> + =A0 =A0 =A0 dma_unmap_sg(&pl022->adev->dev, pl022->sgt_rx.sgl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->sgt_tx.nents, DMA_FRO=
M_DEVICE);
> +err_rx_sgmap:
> + =A0 =A0 =A0 sg_free_table(&pl022->sgt_tx);
> +err_alloc_tx_sg:
> + =A0 =A0 =A0 sg_free_table(&pl022->sgt_rx);
> +err_alloc_rx_sg:
> + =A0 =A0 =A0 return -ENOMEM;
> +}
> +
> +static int __init pl022_dma_probe(struct pl022 *pl022)
> +{
> + =A0 =A0 =A0 dma_cap_mask_t mask;
> +
> + =A0 =A0 =A0 /* Try to acquire a generic DMA engine slave channel */
> + =A0 =A0 =A0 dma_cap_zero(mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We need both RX and TX channels to do DMA, else do=
 none
> + =A0 =A0 =A0 =A0* of them.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 pl022->dma_rx_channel =3D dma_request_channel(mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 pl022->master_info->dma_filter,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 pl022->master_info->dma_rx_param);
> + =A0 =A0 =A0 if (!pl022->dma_rx_channel) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pl022->adev->dev, "no RX DMA c=
hannel!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_no_rxchan;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pl022->dma_tx_channel =3D dma_request_channel(mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 pl022->master_info->dma_filter,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 pl022->master_info->dma_tx_param);
> + =A0 =A0 =A0 if (!pl022->dma_tx_channel) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pl022->adev->dev, "no TX DMA c=
hannel!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_no_txchan;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pl022->dummypage =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> + =A0 =A0 =A0 if (!pl022->dummypage) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pl022->adev->dev, "no DMA dumm=
ypage!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_no_dummypage;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_info(&pl022->adev->dev, "setup for DMA on RX %s, TX=
 %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_chan_name(pl022->dma_rx_channel)=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_chan_name(pl022->dma_tx_channel)=
);
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_no_dummypage:
> + =A0 =A0 =A0 dma_release_channel(pl022->dma_tx_channel);
> +err_no_txchan:
> + =A0 =A0 =A0 dma_release_channel(pl022->dma_rx_channel);
> + =A0 =A0 =A0 pl022->dma_rx_channel =3D NULL;
> +err_no_rxchan:
> + =A0 =A0 =A0 return -ENODEV;
> +}
> +
> +static void terminate_dma(struct pl022 *pl022)
> +{
> + =A0 =A0 =A0 struct dma_chan *rxchan =3D pl022->dma_rx_channel;
> + =A0 =A0 =A0 struct dma_chan *txchan =3D pl022->dma_tx_channel;
> +
> + =A0 =A0 =A0 rxchan->device->device_control(rxchan, DMA_TERMINATE_AL=
L);
> + =A0 =A0 =A0 txchan->device->device_control(txchan, DMA_TERMINATE_AL=
L);
> + =A0 =A0 =A0 unmap_free_dma_scatter(pl022);
> +}
> +
> +static void inline pl022_dma_remove(struct pl022 *pl022)
> +{
> + =A0 =A0 =A0 if (pl022->busy)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 terminate_dma(pl022);
> + =A0 =A0 =A0 if (pl022->dma_tx_channel)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_release_channel(pl022->dma_tx_chann=
el);
> + =A0 =A0 =A0 if (pl022->dma_rx_channel)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_release_channel(pl022->dma_rx_chann=
el);
> + =A0 =A0 =A0 kfree(pl022->dummypage);
> +}
> +
> +#else
> +static inline int configure_dma(struct pl022 *pl022)
> +{
> + =A0 =A0 =A0 return -ENODEV;
> +}
> +
> +static inline int pl022_dma_probe(struct pl022 *pl022)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static inline void pl022_dma_remove(struct pl022 *pl022)
> +{
> +}
> +#endif
> +
> =A0/**
> =A0* pl022_interrupt_handler - Interrupt handler for SSP controller
> =A0*
> @@ -724,20 +1096,34 @@ static irqreturn_t pl022_interrupt_handler(int=
 irq, void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In DMA mode, this interrupt handler is only
> + =A0 =A0 =A0 =A0* used for handling error conditions.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (unlikely(pl022->cur_chip->enable_dma)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pl022->adev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "stray interrupt in DMA=
 mode (0x%08x)", irq_status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(CLEAR_ALL_INTERRUPTS, SSP_ICR(pl=
022->virtbase));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* Read the Interrupt Status Register */
> =A0 =A0 =A0 =A0irq_status =3D readw(SSP_MIS(pl022->virtbase));
>
> =A0 =A0 =A0 =A0if (unlikely(!irq_status))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_NONE;
>
> - =A0 =A0 =A0 /* This handles the error code interrupts */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* This handles the FIFO interrupts, the timeout
> + =A0 =A0 =A0 =A0* interrupts are flatly ignored, they cannot be
> + =A0 =A0 =A0 =A0* trusted.
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0if (unlikely(irq_status & SSP_MIS_MASK_RORMIS)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Overrun interrupt - bail out since =
our Data has been
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * corrupted
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pl022->adev->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "FIFO overrun\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pl022->adev->dev, "FIFO overru=
n\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (readw(SSP_SR(pl022->virtbase)) & S=
SP_SR_MASK_RFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pl022->adev->=
dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"RXFIF=
O is full\n");
> @@ -832,8 +1218,8 @@ static int set_up_next_transfer(struct pl022 *pl=
022,
> =A0}
>
> =A0/**
> - * pump_transfers - Tasklet function which schedules next interrupt =
transfer
> - * when running in interrupt transfer mode.
> + * pump_transfers - Tasklet function which schedules next transfer
> + * when running in interrupt or DMA transfer mode.
> =A0* @data: SSP driver private data structure
> =A0*
> =A0*/
> @@ -890,65 +1276,23 @@ static void pump_transfers(unsigned long data)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* Flush the FIFOs and let's go! */
> =A0 =A0 =A0 =A0flush(pl022);
> - =A0 =A0 =A0 writew(ENABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase)=
);
> -}
> -
> -/**
> - * NOT IMPLEMENTED
> - * configure_dma - It configures the DMA pipes for DMA transfers
> - * @data: SSP driver's private data structure
> - *
> - */
> -static int configure_dma(void *data)
> -{
> - =A0 =A0 =A0 struct pl022 *pl022 =3D data;
> - =A0 =A0 =A0 dev_dbg(&pl022->adev->dev, "configure DMA\n");
> - =A0 =A0 =A0 return -ENOTSUPP;
> -}
> -
> -/**
> - * do_dma_transfer - It handles transfers of the current message
> - * if it is DMA xfer.
> - * NOT FULLY IMPLEMENTED
> - * @data: SSP driver's private data structure
> - */
> -static void do_dma_transfer(void *data)
> -{
> - =A0 =A0 =A0 struct pl022 *pl022 =3D data;
> -
> - =A0 =A0 =A0 if (configure_dma(data)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pl022->adev->dev, "configurati=
on of DMA Failed!\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_config_dma;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* TODO: Implememt DMA setup of pipes here */
>
> - =A0 =A0 =A0 /* Enable target chip, set up transfer */
> - =A0 =A0 =A0 pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
> - =A0 =A0 =A0 if (set_up_next_transfer(pl022, pl022->cur_transfer)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Error path */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->cur_msg->state =3D STATE_ERROR;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->cur_msg->status =3D -EIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 giveback(pl022);
> + =A0 =A0 =A0 if (pl022->cur_chip->enable_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (configure_dma(pl022)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pl022->adev->d=
ev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "config=
uration of DMA failed, fall back to interrupt mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_config_dma;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 /* Enable SSP */
> - =A0 =A0 =A0 writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK_=
SSE),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_CR1(pl022->virtbase));
> -
> - =A0 =A0 =A0 /* TODO: Enable the DMA transfer here */
> - =A0 =A0 =A0 return;
>
> - err_config_dma:
> - =A0 =A0 =A0 pl022->cur_msg->state =3D STATE_ERROR;
> - =A0 =A0 =A0 pl022->cur_msg->status =3D -EIO;
> - =A0 =A0 =A0 giveback(pl022);
> - =A0 =A0 =A0 return;
> +err_config_dma:
> + =A0 =A0 =A0 writew(ENABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase)=
);
> =A0}
>
> -static void do_interrupt_transfer(void *data)
> +static void do_interrupt_dma_transfer(struct pl022 *pl022)
> =A0{
> - =A0 =A0 =A0 struct pl022 *pl022 =3D data;
> + =A0 =A0 =A0 u32 irqflags =3D ENABLE_ALL_INTERRUPTS;
>
> =A0 =A0 =A0 =A0/* Enable target chip */
> =A0 =A0 =A0 =A0pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
> @@ -959,15 +1303,26 @@ static void do_interrupt_transfer(void *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0giveback(pl022);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 /* If we're using DMA, set up DMA here */
> + =A0 =A0 =A0 if (pl022->cur_chip->enable_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Configure DMA transfer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (configure_dma(pl022)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pl022->adev->d=
ev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "config=
uration of DMA failed, fall back to interrupt mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_config_dma;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable interrupts in DMA mode, IRQ =
from DMA controller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqflags =3D DISABLE_ALL_INTERRUPTS;
> + =A0 =A0 =A0 }
> +err_config_dma:
> =A0 =A0 =A0 =A0/* Enable SSP, turn on interrupts */
> =A0 =A0 =A0 =A0writew((readw(SSP_CR1(pl022->virtbase)) | SSP_CR1_MASK=
_SSE),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_CR1(pl022->virtbase));
> - =A0 =A0 =A0 writew(ENABLE_ALL_INTERRUPTS, SSP_IMSC(pl022->virtbase)=
);
> + =A0 =A0 =A0 writew(irqflags, SSP_IMSC(pl022->virtbase));
> =A0}
>
> -static void do_polling_transfer(void *data)
> +static void do_polling_transfer(struct pl022 *pl022)
> =A0{
> - =A0 =A0 =A0 struct pl022 *pl022 =3D data;
> =A0 =A0 =A0 =A0struct spi_message *message =3D NULL;
> =A0 =A0 =A0 =A0struct spi_transfer *transfer =3D NULL;
> =A0 =A0 =A0 =A0struct spi_transfer *previous =3D NULL;
> @@ -1037,7 +1392,7 @@ static void do_polling_transfer(void *data)
> =A0*
> =A0* This function checks if there is any spi message in the queue th=
at
> =A0* needs processing and delegate control to appropriate function
> - * do_polling_transfer()/do_interrupt_transfer()/do_dma_transfer()
> + * do_polling_transfer()/do_interrupt_dma_transfer()
> =A0* based on the kind of the transfer
> =A0*
> =A0*/
> @@ -1085,10 +1440,8 @@ static void pump_messages(struct work_struct *=
work)
>
> =A0 =A0 =A0 =A0if (pl022->cur_chip->xfer_type =3D=3D POLLING_TRANSFER=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_polling_transfer(pl022);
> - =A0 =A0 =A0 else if (pl022->cur_chip->xfer_type =3D=3D INTERRUPT_TR=
ANSFER)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_interrupt_transfer(pl022);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_dma_transfer(pl022);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_interrupt_dma_transfer(pl022);
> =A0}
>
>
> @@ -1393,23 +1746,6 @@ static int calculate_effective_freq(struct pl0=
22 *pl022,
> =A0}
>
> =A0/**
> - * NOT IMPLEMENTED
> - * process_dma_info - Processes the DMA info provided by client driv=
ers
> - * @chip_info: chip info provided by client device
> - * @chip: Runtime state maintained by the SSP controller for each sp=
i device
> - *
> - * This function processes and stores DMA config provided by client =
driver
> - * into the runtime state maintained by the SSP controller driver
> - */
> -static int process_dma_info(struct pl022_config_chip *chip_info,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct chip_dat=
a *chip)
> -{
> - =A0 =A0 =A0 dev_err(chip_info->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cannot process DMA info, DMA not imple=
mented!\n");
> - =A0 =A0 =A0 return -ENOTSUPP;
> -}
> -
> -/**
> =A0* pl022_setup - setup function registered to SPI master framework
> =A0* @spi: spi device which is requesting setup
> =A0*
> @@ -1563,7 +1899,6 @@ static int pl022_setup(struct spi_device *spi)
> =A0 =A0 =A0 =A0 =A0 =A0&& ((pl022->master_info)->enable_dma)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->enable_dma =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&spi->dev, "DMA mode set in co=
ntroller state\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D process_dma_info(chip_info, =
chip);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (status < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_config_params=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->dmacr, SSP_DMA_EN=
ABLED,
> @@ -1623,7 +1958,7 @@ static void pl022_cleanup(struct spi_device *sp=
i)
> =A0}
>
>
> -static int __init
> +static int __devinit
> =A0pl022_probe(struct amba_device *adev, struct amba_id *id)
> =A0{
> =A0 =A0 =A0 =A0struct device *dev =3D &adev->dev;
> @@ -1670,6 +2005,7 @@ pl022_probe(struct amba_device *adev, struct am=
ba_id *id)
> =A0 =A0 =A0 =A0if (status)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_no_ioregion;
>
> + =A0 =A0 =A0 pl022->phybase =3D adev->res.start;
> =A0 =A0 =A0 =A0pl022->virtbase =3D ioremap(adev->res.start, resource_=
size(&adev->res));
> =A0 =A0 =A0 =A0if (pl022->virtbase =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOMEM;
> @@ -1698,6 +2034,12 @@ pl022_probe(struct amba_device *adev, struct a=
mba_id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&adev->dev, "probe - cannot ge=
t IRQ (%d)\n", status);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_no_irq;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* Get DMA channels */
> + =A0 =A0 =A0 status =3D pl022_dma_probe(pl022);
> + =A0 =A0 =A0 if (status !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_no_dma;
> +
> =A0 =A0 =A0 =A0/* Initialize and start queue */
> =A0 =A0 =A0 =A0status =3D init_queue(pl022);
> =A0 =A0 =A0 =A0if (status !=3D 0) {
> @@ -1724,6 +2066,8 @@ pl022_probe(struct amba_device *adev, struct am=
ba_id *id)
> =A0err_start_queue:
> =A0err_init_queue:
> =A0 =A0 =A0 =A0destroy_queue(pl022);
> + =A0 =A0 =A0 pl022_dma_remove(pl022);
> + err_no_dma:
> =A0 =A0 =A0 =A0free_irq(adev->irq[0], pl022);
> =A0err_no_irq:
> =A0 =A0 =A0 =A0clk_put(pl022->clk);
> @@ -1738,7 +2082,7 @@ pl022_probe(struct amba_device *adev, struct am=
ba_id *id)
> =A0 =A0 =A0 =A0return status;
> =A0}
>
> -static int __exit
> +static int __devexit
> =A0pl022_remove(struct amba_device *adev)
> =A0{
> =A0 =A0 =A0 =A0struct pl022 *pl022 =3D amba_get_drvdata(adev);
> @@ -1754,6 +2098,7 @@ pl022_remove(struct amba_device *adev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return status;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0load_ssp_default_config(pl022);
> + =A0 =A0 =A0 pl022_dma_remove(pl022);
> =A0 =A0 =A0 =A0free_irq(adev->irq[0], pl022);
> =A0 =A0 =A0 =A0clk_disable(pl022->clk);
> =A0 =A0 =A0 =A0clk_put(pl022->clk);
> @@ -1846,7 +2191,7 @@ static struct amba_driver pl022_driver =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D pl022_ids,
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D pl022_probe,
> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(pl022_remove),
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(pl022_remove),
> =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0=3D pl022_suspend,
> =A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0 =3D pl022_resume,
> =A0};
> diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
> index e4836c6..95f8d17 100644
> --- a/include/linux/amba/pl022.h
> +++ b/include/linux/amba/pl022.h
> @@ -201,6 +201,7 @@ enum ssp_chip_select {
> =A0};
>
>
> +struct dma_chan;
> =A0/**
> =A0* struct pl022_ssp_master - device.platform_data for SPI controlle=
r devices.
> =A0* @num_chipselect: chipselects are used to distinguish individual
> @@ -208,11 +209,16 @@ enum ssp_chip_select {
> =A0* =A0 =A0 each slave has a chipselect signal, but it's common that=
 not
> =A0* =A0 =A0 every chipselect is connected to a slave.
> =A0* @enable_dma: if true enables DMA driven transfers.
> + * @dma_rx_param: parameter to locate an RX DMA channel.
> + * @dma_tx_param: parameter to locate a TX DMA channel.
> =A0*/
> =A0struct pl022_ssp_controller {
> =A0 =A0 =A0 =A0u16 bus_id;
> =A0 =A0 =A0 =A0u8 num_chipselect;
> =A0 =A0 =A0 =A0u8 enable_dma:1;
> + =A0 =A0 =A0 bool (*dma_filter)(struct dma_chan *chan, void *filter_=
param);
> + =A0 =A0 =A0 void *dma_rx_param;
> + =A0 =A0 =A0 void *dma_tx_param;
> =A0};
>
> =A0/**
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

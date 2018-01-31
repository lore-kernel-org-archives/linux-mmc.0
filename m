From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8] mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Wed, 31 Jan 2018 11:31:34 +0100
Message-ID: <CAPDyKFr+AUf3wd7Vri9tFYMk66dMz5i6ryx=vphCCUJG=bZL4w@mail.gmail.com>
References: <20180128234453.2880-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:43791 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeAaKbg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Jan 2018 05:31:36 -0500
Received: by mail-io0-f195.google.com with SMTP id 72so14646648iom.10
        for <linux-mmc@vger.kernel.org>; Wed, 31 Jan 2018 02:31:35 -0800 (PST)
In-Reply-To: <20180128234453.2880-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Benjamin Beckmeyer <beckmeyer.b@rittal.de>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, "# 4.0+" <stable@vger.kernel.org>

On 29 January 2018 at 00:44, Linus Walleij <linus.walleij@linaro.org> wrote=
:
> The bounce buffer is gone from the MMC core, and now we found out
> that there are some (crippled) i.MX boards out there that have broken
> ADMA (cannot do scatter-gather), and also broken PIO so they must
> use SDMA. Closer examination shows a less significant slowdown
> also on SDMA-only capable Laptop hosts.
>
> SDMA sets down the number of segments to one, so that each segment
> gets turned into a singular request that ping-pongs to the block
> layer before the next request/segment is issued.
>
> Apparently it happens a lot that the block layer send requests
> that include a lot of physically discontiguous segments. My guess
> is that this phenomenon is coming from the file system.
>
> These devices that cannot handle scatterlists in hardware can see
> major benefits from a DMA-contiguous bounce buffer.
>
> This patch accumulates those fragmented scatterlists in a physically
> contiguous bounce buffer so that we can issue bigger DMA data chunks
> to/from the card.
>
> When tested with a PCI-integrated host (1217:8221) that
> only supports SDMA:
> 0b:00.0 SD Host controller: O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS
>         SD/MMC Card Reader Controller (rev 05)
> This patch gave ~1Mbyte/s improved throughput on large reads and
> writes when testing using iozone than without the patch.
>
> dmesg:
> sdhci-pci 0000:0b:00.0: SDHCI controller found [1217:8221] (rev 5)
> mmc0 bounce up to 128 segments into one, max segment size 65536 bytes
> mmc0: SDHCI controller on PCI [0000:0b:00.0] using DMA
>
> On the i.MX SDHCI controllers on the crippled i.MX 25 and i.MX 35
> the patch restores the performance to what it was before we removed
> the bounce buffers.
>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Beno=C3=AEt Th=C3=A9baudeau <benoit@wsystem.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
> Cc: stable@vger.kernel.org # v4.14+
> Fixes: de3ee99b097d ("mmc: Delete bounce buffer handling")
> Tested-by: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
> ChangeLog v7->v8:
> - Fixed bad information and spelling mistakes in the commit
>   message.
> - Use sdhci_sdma_address() in one more spot identified by Adrian.
> - Collected Adrian's ACK.
> ChangeLog v6->v7:
> - Fix the directions on dma_sync_for[device|cpu]() so the
>   ownership of the buffer gets swapped properly and in the right
>   direction for every transfer. Didn't see this because x86 PCI is
>   DMA coherent...
> - Tested and greelighted on i.MX 25.
> - Also tested on the PCI version.
> ChangeLog v5->v6:
> - Again switch back to explicit sync of buffers. I want to get this
>   solution to work because it gives more control and it's more
>   elegant.
> - Update host->max_req_size as noted by Adrian, hopefully this
>   fixes the i.MX. I was just lucky on my Intel laptop I guess:
>   the block stack never requested anything bigger than 64KB and
>   that was why it worked even if max_req_size was bigger than
>   what would fit in the bounce buffer.
> - Copy the number of bytes in the mmc_data instead of the number
>   of bytes in the bounce buffer. For RX this is blksize * blocks
>   and for TX this is bytes_xfered.
> - Break out a sdhci_sdma_address() for getting the DMA address
>   for either the raw sglist or the bounce buffer depending on
>   configuration.
> - Add some explicit bounds check for the data so that we do not
>   attempt to copy more than the bounce buffer size even if the
>   block layer is erroneously configured.
> - Move allocation of bounce buffer out to its own function.
> - Use pr_[info|err] throughout so all debug prints from the
>   driver come out in the same manner and style.
> - Use unsigned int for the bounce buffer size.
> - Re-tested with iozone: we still get the same nice performance
>   improvements.
> - Request a text on i.MX (hi Benjamin)
> ChangeLog v4->v5:
> - Go back to dma_alloc_coherent() as this apparently works better.
> - Keep the other changes, cap for 64KB, fall back to single segments.
> - Requesting a test of this on i.MX. (Sorry Benjamin.)
> ChangeLog v3->v4:
> - Cap the bounce buffer to 64KB instead of the biggest segment
>   as we experience diminishing returns with buffers > 64KB.
> - Instead of using dma_alloc_coherent(), use good old devm_kmalloc()
>   and issue dma_sync_single_for*() to explicitly switch
>   ownership between CPU and the device. This way we exercise the
>   cache better and may consume less CPU.
> - Bail out with single segments if we cannot allocate a bounce
>   buffer.
> - Tested on the PCI SDHCI on my laptop: requesting a new test
>   on i.MX from Benjamin. (Please!)
> ChangeLog v2->v3:
> - Rewrite the commit message a bit
> - Add Benjamin's Tested-by
> - Add Fixes and stable tags
> ChangeLog v1->v2:
> - Skip the remapping and fiddling with the buffer, instead use
>   dma_alloc_coherent() and use a simple, coherent bounce buffer.
> - Couple kernel messages to ->parent of the mmc_host as it relates
>   to the hardware characteristics.
> ---
>  drivers/mmc/host/sdhci.c | 164 +++++++++++++++++++++++++++++++++++++++++=
+++---
>  drivers/mmc/host/sdhci.h |   3 +
>  2 files changed, 159 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9290a3439d5..d24306b2b839 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -21,6 +21,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/scatterlist.h>
> +#include <linux/sizes.h>
>  #include <linux/swiotlb.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> @@ -502,8 +503,35 @@ static int sdhci_pre_dma_transfer(struct sdhci_host =
*host,
>         if (data->host_cookie =3D=3D COOKIE_PRE_MAPPED)
>                 return data->sg_count;
>
> -       sg_count =3D dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_le=
n,
> -                             mmc_get_dma_dir(data));
> +       /* Bounce write requests to the bounce buffer */
> +       if (host->bounce_buffer) {
> +               unsigned int length =3D data->blksz * data->blocks;
> +
> +               if (length > host->bounce_buffer_size) {
> +                       pr_err("%s: asked for transfer of %u bytes exceed=
s bounce buffer %u bytes\n",
> +                              mmc_hostname(host->mmc), length,
> +                              host->bounce_buffer_size);
> +                       return -EIO;
> +               }
> +               if (mmc_get_dma_dir(data) =3D=3D DMA_TO_DEVICE) {
> +                       /* Copy the data to the bounce buffer */
> +                       sg_copy_to_buffer(data->sg, data->sg_len,
> +                                         host->bounce_buffer,
> +                                         length);
> +               }
> +               /* Switch ownership to the DMA */
> +               dma_sync_single_for_device(host->mmc->parent,
> +                                          host->bounce_addr,
> +                                          host->bounce_buffer_size,
> +                                          mmc_get_dma_dir(data));
> +               /* Just a dummy value */
> +               sg_count =3D 1;
> +       } else {
> +               /* Just access the data directly from memory */
> +               sg_count =3D dma_map_sg(mmc_dev(host->mmc),
> +                                     data->sg, data->sg_len,
> +                                     mmc_get_dma_dir(data));
> +       }
>
>         if (sg_count =3D=3D 0)
>                 return -ENOSPC;
> @@ -673,6 +701,14 @@ static void sdhci_adma_table_post(struct sdhci_host =
*host,
>         }
>  }
>
> +static u32 sdhci_sdma_address(struct sdhci_host *host)
> +{
> +       if (host->bounce_buffer)
> +               return host->bounce_addr;
> +       else
> +               return sg_dma_address(host->data->sg);
> +}
> +
>  static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command=
 *cmd)
>  {
>         u8 count;
> @@ -858,8 +894,8 @@ static void sdhci_prepare_data(struct sdhci_host *hos=
t, struct mmc_command *cmd)
>                                              SDHCI_ADMA_ADDRESS_HI);
>                 } else {
>                         WARN_ON(sg_cnt !=3D 1);
> -                       sdhci_writel(host, sg_dma_address(data->sg),
> -                               SDHCI_DMA_ADDRESS);
> +                       sdhci_writel(host, sdhci_sdma_address(host),
> +                                    SDHCI_DMA_ADDRESS);
>                 }
>         }
>
> @@ -2248,7 +2284,12 @@ static void sdhci_pre_req(struct mmc_host *mmc, st=
ruct mmc_request *mrq)
>
>         mrq->data->host_cookie =3D COOKIE_UNMAPPED;
>
> -       if (host->flags & SDHCI_REQ_USE_DMA)
> +       /*
> +        * No pre-mapping in the pre hook if we're using the bounce buffe=
r,
> +        * for that we would need two bounce buffers since one buffer is
> +        * in flight when this is getting called.
> +        */
> +       if (host->flags & SDHCI_REQ_USE_DMA && !host->bounce_buffer)
>                 sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED=
);
>  }
>
> @@ -2352,8 +2393,45 @@ static bool sdhci_request_done(struct sdhci_host *=
host)
>                 struct mmc_data *data =3D mrq->data;
>
>                 if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> -                       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->=
sg_len,
> -                                    mmc_get_dma_dir(data));
> +                       if (host->bounce_buffer) {
> +                               /*
> +                                * On reads, copy the bounced data into t=
he
> +                                * sglist
> +                                */
> +                               if (mmc_get_dma_dir(data) =3D=3D DMA_FROM=
_DEVICE) {
> +                                       unsigned int length =3D data->byt=
es_xfered;
> +
> +                                       if (length > host->bounce_buffer_=
size) {
> +                                               pr_err("%s: bounce buffer=
 is %u bytes but DMA claims to have transferred %u bytes\n",
> +                                                      mmc_hostname(host-=
>mmc),
> +                                                      host->bounce_buffe=
r_size,
> +                                                      data->bytes_xfered=
);
> +                                               /* Cap it down and contin=
ue */
> +                                               length =3D host->bounce_b=
uffer_size;
> +                                       }
> +                                       dma_sync_single_for_cpu(
> +                                               host->mmc->parent,
> +                                               host->bounce_addr,
> +                                               host->bounce_buffer_size,
> +                                               DMA_FROM_DEVICE);
> +                                       sg_copy_from_buffer(data->sg,
> +                                               data->sg_len,
> +                                               host->bounce_buffer,
> +                                               length);
> +                               } else {
> +                                       /* No copying, just switch owners=
hip */
> +                                       dma_sync_single_for_cpu(
> +                                               host->mmc->parent,
> +                                               host->bounce_addr,
> +                                               host->bounce_buffer_size,
> +                                               mmc_get_dma_dir(data));
> +                               }
> +                       } else {
> +                               /* Unmap the raw data */
> +                               dma_unmap_sg(mmc_dev(host->mmc), data->sg=
,
> +                                            data->sg_len,
> +                                            mmc_get_dma_dir(data));
> +                       }
>                         data->host_cookie =3D COOKIE_UNMAPPED;
>                 }
>         }
> @@ -2636,7 +2714,8 @@ static void sdhci_data_irq(struct sdhci_host *host,=
 u32 intmask)
>                  */
>                 if (intmask & SDHCI_INT_DMA_END) {
>                         u32 dmastart, dmanow;
> -                       dmastart =3D sg_dma_address(host->data->sg);
> +
> +                       dmastart =3D sdhci_sdma_address(host);
>                         dmanow =3D dmastart + host->data->bytes_xfered;
>                         /*
>                          * Force update to the next DMA block boundary.
> @@ -3217,6 +3296,68 @@ void __sdhci_read_caps(struct sdhci_host *host, u1=
6 *ver, u32 *caps, u32 *caps1)
>  }
>  EXPORT_SYMBOL_GPL(__sdhci_read_caps);
>
> +static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
> +{
> +       struct mmc_host *mmc =3D host->mmc;
> +       unsigned int max_blocks;
> +       unsigned int bounce_size;
> +       int ret;
> +
> +       /*
> +        * Cap the bounce buffer at 64KB. Using a bigger bounce buffer
> +        * has diminishing returns, this is probably because SD/MMC
> +        * cards are usually optimized to handle this size of requests.
> +        */
> +       bounce_size =3D SZ_64K;
> +       /*
> +        * Adjust downwards to maximum request size if this is less
> +        * than our segment size, else hammer down the maximum
> +        * request size to the maximum buffer size.
> +        */
> +       if (mmc->max_req_size < bounce_size)
> +               bounce_size =3D mmc->max_req_size;
> +       max_blocks =3D bounce_size / 512;
> +
> +       /*
> +        * When we just support one segment, we can get significant
> +        * speedups by the help of a bounce buffer to group scattered
> +        * reads/writes together.
> +        */
> +       host->bounce_buffer =3D devm_kmalloc(mmc->parent,
> +                                          bounce_size,
> +                                          GFP_KERNEL);
> +       if (!host->bounce_buffer) {
> +               pr_err("%s: failed to allocate %u bytes for bounce buffer=
, falling back to single segments\n",
> +                      mmc_hostname(mmc),
> +                      bounce_size);
> +               /*
> +                * Exiting with zero here makes sure we proceed with
> +                * mmc->max_segs =3D=3D 1.
> +                */
> +               return 0;
> +       }
> +
> +       host->bounce_addr =3D dma_map_single(mmc->parent,
> +                                          host->bounce_buffer,
> +                                          bounce_size,
> +                                          DMA_BIDIRECTIONAL);
> +       ret =3D dma_mapping_error(mmc->parent, host->bounce_addr);
> +       if (ret)
> +               /* Again fall back to max_segs =3D=3D 1 */
> +               return 0;
> +       host->bounce_buffer_size =3D bounce_size;
> +
> +       /* Lie about this since we're bouncing */
> +       mmc->max_segs =3D max_blocks;
> +       mmc->max_seg_size =3D bounce_size;
> +       mmc->max_req_size =3D bounce_size;
> +
> +       pr_info("%s bounce up to %u segments into one, max segment size %=
u bytes\n",
> +               mmc_hostname(mmc), max_blocks, bounce_size);
> +
> +       return 0;
> +}
> +
>  int sdhci_setup_host(struct sdhci_host *host)
>  {
>         struct mmc_host *mmc;
> @@ -3713,6 +3854,13 @@ int sdhci_setup_host(struct sdhci_host *host)
>          */
>         mmc->max_blk_count =3D (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK)=
 ? 1 : 65535;
>
> +       if (mmc->max_segs =3D=3D 1) {
> +               /* This may alter mmc->*_blk_* parameters */
> +               ret =3D sdhci_allocate_bounce_buffer(host);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return 0;
>
>  unreg:
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 54bc444c317f..1d7d61e25dbf 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -440,6 +440,9 @@ struct sdhci_host {
>
>         int irq;                /* Device IRQ */
>         void __iomem *ioaddr;   /* Mapped address */
> +       char *bounce_buffer;    /* For packing SDMA reads/writes */
> +       dma_addr_t bounce_addr;
> +       unsigned int bounce_buffer_size;
>
>         const struct sdhci_ops *ops;    /* Low level hw interface */
>
> --
> 2.14.3
>

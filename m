From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 4/4] mmc: sdio support external scatter gather list
Date: Tue, 19 Dec 2017 13:39:39 +0100
Message-ID: <CAPDyKFrCjsUhmh3ccwemkGoUuXJ2RkjNZHuAf0J_ddHaAMrqyg@mail.gmail.com>
References: <1513685211-640-1-git-send-email-huxm@marvell.com> <1513685211-640-4-git-send-email-huxm@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34026 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964817AbdLSMjm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Dec 2017 07:39:42 -0500
Received: by mail-wr0-f194.google.com with SMTP id y21so19186228wrc.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Dec 2017 04:39:41 -0800 (PST)
In-Reply-To: <1513685211-640-4-git-send-email-huxm@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Xinming Hu <huxm@marvell.com>
Cc: Linux MMC <linux-mmc@vger.kernel.org>, Kalle Valo <kvalo@qca.qualcomm.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, Zhiyuan Yang <yangzy@marvell.com>, Tim Song <songtao@marvell.com>, Cathy Luo <cluo@marvell.com>, James Cao <jcao@marvell.com>, Ganapathi Bhat <gbhat@marvell.com>, Xu Wang <xwang4@marvell.com>, Bob Tan <tanbo@marvell.com>, Amitkumar Karwar <akarwar@marvell.com>

On 19 December 2017 at 13:06, Xinming Hu <huxm@marvell.com> wrote:
> Currently sdio device drivers need to prepare a big continuous
> physical memory for large data transfer. mmc stack will construct
> scatter/gather buffer list to make use of ADMA2.
>
> According to the sdio host controller specification version 4.00
> chapter 1.13.2, sdio device drivers have the ability to construct
> scatter/gather DMA buffer list. In this way, they do not need to allocate
> big memory.
>
> This patch refactors current sdio command 53 wrapper mmc_io_rw_extended,
> so that it can accept external scatter/gather buffer list from its caller,
> such as the sdio device driver. This patch is very useful on some embedded
> systems where large memory allocation fails sometimes. It gives 10 to 15%
> better throughput performance compared to a case in which small single
> data transfers are done.
>
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v4: same as v3/v2/v1
> v5: rebased on latest codebase
> v6: same as v5
> ---
>  drivers/mmc/core/sdio_io.c    | 22 ++++++++++++++++--
>  drivers/mmc/core/sdio_ops.c   | 53 +++++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/core/sdio_ops.h   |  3 ++-
>  include/linux/mmc/sdio_func.h |  6 +++++
>  4 files changed, 76 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 4806521..6046511 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -327,7 +327,7 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>                         size = blocks * func->cur_blksize;
>
>                         ret = mmc_io_rw_extended(func->card, write,
> -                               func->num, addr, incr_addr, buf,
> +                               func->num, addr, incr_addr, false, buf,
>                                 blocks, func->cur_blksize);
>                         if (ret)
>                                 return ret;
> @@ -345,7 +345,7 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>
>                 /* Indicate byte mode by setting "blocks" = 0 */
>                 ret = mmc_io_rw_extended(func->card, write, func->num, addr,
> -                        incr_addr, buf, 0, size);
> +                        incr_addr, false, buf, 0, size);
>                 if (ret)
>                         return ret;
>
> @@ -513,6 +513,24 @@ int sdio_writesb(struct sdio_func *func, unsigned int addr, void *src,
>  }
>  EXPORT_SYMBOL_GPL(sdio_writesb);
>
> +int sdio_readsb_sg_enh(struct sdio_func *func, unsigned int addr,

Could you please rename this to sdio_readsb_sg() instead?

> +                      struct sg_table *dst)

I think what Christoph suggested and I agree with, is to use a "struct
scatterlist *sg" instead of "struct sg_table *dst" as the
in-parameter.

The similar applies for the write API, of course.

> +{
> +       return mmc_io_rw_extended(func->card, 0, func->num,
> +                                 addr, 0, true,
> +                                 dst, 0, func->cur_blksize);
> +}
> +EXPORT_SYMBOL_GPL(sdio_readsb_sg_enh);
> +
> +int sdio_writesb_sg_enh(struct sdio_func *func, unsigned int addr,

Could you please rename this to sdio_writesb_sg() instead?

> +                       struct sg_table *src)
> +{
> +       return mmc_io_rw_extended(func->card, 1, func->num,
> +                                 addr, 0, true,
> +                                 src, 0, func->cur_blksize);
> +}
> +EXPORT_SYMBOL_GPL(sdio_writesb_sg_enh);
> +
>  /**
>   *     sdio_readw - read a 16 bit integer from a SDIO function
>   *     @func: SDIO function to access
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index abaaba3..2310a2a 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -115,16 +115,39 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
>         return mmc_io_rw_direct_host(card->host, write, fn, addr, in, out);
>  }
>
> +/**
> + *     mmc_io_rw_extended - wrapper for sdio command 53 read/write operation
> + *     @card: destination device for read/write
> + *     @write: zero indcate read, non-zero indicate write.
> + *     @fn: SDIO function to access
> + *     @addr: address of (single byte) FIFO
> + *     @incr_addr: set to 1 indicate read or write multiple bytes
> +               of data to/from an IO register address that
> +               increment by 1 after each operation.
> + *     @sg_enhance: if set true, the caller of this function will
> +               prepare scatter gather dma buffer list.
> + *     @buf: buffer that contains the data to write. if sg_enhance
> +               is set, it point to SG dma buffer list.
> + *     @blocks: number of blocks of data transfer.
> +               if set zero, indicate byte mode
> +               if set non-zero, indicate block mode
> +               if sg_enhance is set, this parameter will not be used.
> + *     @blksz: block size for block mode data transfer.
> + *
> + */

The descriptive function header isn't required here, because this is
an internal function for the mmc core.

However, if you really want this, I suggest you make it a separate patch.

>  int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
> -       unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz)
> +                      unsigned int addr, int incr_addr, bool sg_enhance,

Instead of letting this take a new bool variable, let's instead
provide it with a  "struct scatterlist *sg". In cases when it isn't
used, just provide NULL.

Depending on the end result, we may even consider to make a separate
function dealing with the scatterlist case, perhaps via sharing some
common functionality from mmc_io_rw_extended() instead.

> +                      void *buf, unsigned int blocks, unsigned int blksz)
>  {
>         struct mmc_request mrq = {};
>         struct mmc_command cmd = {};
>         struct mmc_data data = {};
>         struct scatterlist sg, *sg_ptr;
>         struct sg_table sgtable;
> +       struct sg_table *sgtable_external;
>         unsigned int nents, left_size, i;
>         unsigned int seg_size = card->host->max_seg_size;
> +       unsigned int sg_blocks = 0;
>
>         WARN_ON(blksz == 0);
>
> @@ -140,16 +163,35 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         cmd.arg |= fn << 28;
>         cmd.arg |= incr_addr ? 0x04000000 : 0x00000000;
>         cmd.arg |= addr << 9;
> +       cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
> +
> +       data.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
> +       data.blksz = blksz;
> +
> +       if (sg_enhance) {
> +               sgtable_external = buf;
> +
> +               for_each_sg(sgtable_external->sgl, sg_ptr,
> +                           sgtable_external->nents, i) {
> +                       if (sg_ptr->length > card->host->max_seg_size)
> +                               return -EINVAL;
> +                       sg_blocks += DIV_ROUND_UP(sg_ptr->length, blksz);

This looks wrong. For each iteration the number of sg_blocks will be
increased, with the round up method.

This may lead to that the data.blocks could get a in-correct value
(bigger) when assigned below, right?

> +               }
> +
> +               cmd.arg |= 0x08000000 | sg_blocks;

This isn't going to work for byte mode transfers. Seems like that
should be possible too when using a pre-allocated scatterlist, right!?

> +               data.blocks = sg_blocks;
> +               data.sg = sgtable_external->sgl;
> +               data.sg_len = sgtable_external->nents;
> +               goto mmc_data_req;
> +       }
> +
>         if (blocks == 0)
>                 cmd.arg |= (blksz == 512) ? 0 : blksz;  /* byte mode */
>         else
>                 cmd.arg |= 0x08000000 | blocks;         /* block mode */
> -       cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
>
> -       data.blksz = blksz;
>         /* Code in host drivers/fwk assumes that "blocks" always is >=1 */
>         data.blocks = blocks ? blocks : 1;
> -       data.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
>
>         left_size = data.blksz * data.blocks;
>         nents = DIV_ROUND_UP(left_size, seg_size);
> @@ -172,11 +214,12 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>                 sg_init_one(&sg, buf, left_size);
>         }
>
> +mmc_data_req:
>         mmc_set_data_timeout(&data, card);
>
>         mmc_wait_for_req(card->host, &mrq);
>
> -       if (nents > 1)
> +       if (!sg_enhance && nents > 1)
>                 sg_free_table(&sgtable);
>
>         if (cmd.error)
> diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
> index 96945ca..2d75100 100644
> --- a/drivers/mmc/core/sdio_ops.h
> +++ b/drivers/mmc/core/sdio_ops.h
> @@ -23,7 +23,8 @@
>  int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
>         unsigned addr, u8 in, u8* out);
>  int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
> -       unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz);
> +                      unsigned int addr, int incr_addr, bool sg_enhance,
> +                      void *buf, unsigned int blocks, unsigned int blksz);
>  int sdio_reset(struct mmc_host *host);
>  unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz);
>  void sdio_irq_work(struct work_struct *work);
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
> index 72d4de4..d36ba47 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -14,6 +14,7 @@
>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/scatterlist.h>
>
>  #include <linux/mmc/pm.h>
>
> @@ -136,6 +137,11 @@ extern int sdio_memcpy_fromio(struct sdio_func *func, void *dst,
>  extern int sdio_readsb(struct sdio_func *func, void *dst,
>         unsigned int addr, int count);
>
> +int sdio_readsb_sg_enh(struct sdio_func *func, unsigned int addr,
> +                      struct sg_table *dst);
> +int sdio_writesb_sg_enh(struct sdio_func *func, unsigned int addr,
> +                       struct sg_table *src);
> +
>  extern void sdio_writeb(struct sdio_func *func, u8 b,
>         unsigned int addr, int *err_ret);
>  extern void sdio_writew(struct sdio_func *func, u16 b,
> --
> 1.9.1
>

Kind regards
Uffe

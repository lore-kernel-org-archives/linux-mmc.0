From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: add API for data write using scatter gather DMA
Date: Fri, 22 Apr 2016 16:17:43 +0200
Message-ID: <CAPDyKFpDyBtGKxqhuo2NnioXfXcn8ZKB=EbyoaFkZ1LX34ZzkQ@mail.gmail.com>
References: <1459256261-22492-1-git-send-email-akarwar@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459256261-22492-1-git-send-email-akarwar-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amitkumar Karwar <akarwar-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishant Sarmukadam <nishants-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bing Zhao <bin9zha0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cathy Luo <cluo-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xinming Hu <huxm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 29 March 2016 at 14:57, Amitkumar Karwar <akarwar-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote:
> From: Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> This patch adds new API for SDIO scatter gather.
>
> Existing mmc_io_rw_extended() API expects caller to pass single contiguous
> buffer. It will be split if it exceeds segment size, SG table is prepared
> and used it for reading/writing the data.
>
> Our intention for defining new API here is to facilitate caller to provide
> ready SG table(scattered buffer list). It will be useful for the drivers
> which intend to handle SDIO SG internally.
>
> Signed-off-by: Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Xinming Hu <huxm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Amitkumar Karwar <akarwar-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---

So this has been posted and discussed earlier. In upcoming revisions,
please attach that history so people know when reviewing.

Moreover, if you have been using this API to improve throughput,
perhaps you can provide us with some numbers as well!?

>  drivers/mmc/core/sdio_ops.c   | 64 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/sdio_func.h |  5 ++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 62508b4..6875980 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -204,6 +204,70 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         return 0;
>  }
>
> +int mmc_io_rw_extended_sg(struct mmc_card *card, int write, unsigned fn,
> +                         unsigned addr, int incr_addr,
> +                         struct sg_table *sgt, unsigned blksz)
> +{
> +       struct mmc_request mrq = {NULL};
> +       struct mmc_command cmd = {0};
> +       struct mmc_data data = {0};
> +       struct scatterlist *sg_ptr;
> +       unsigned blocks = 0;
> +       int i;
> +
> +       WARN_ON(!card || !card->host);
> +       WARN_ON(fn > 7);
> +       WARN_ON(blksz == 0);

WARN_ON is not correct here. You should return proper error codes instead.

> +       for_each_sg(sgt->sgl, sg_ptr, sgt->nents, i) {
> +               WARN_ON(sg_ptr->length > card->host->max_seg_size);

This raises a concern. Somehow the callers of this new API needs to be
able to fetch the max_seg_size, as otherwise how would they know what
size to use when allocating the buffers.

Of course they can just pick the value from card->host->max_seg_size,
but that's not the correct way. Can we add a separate SDIO API for
this!?

Moreover, I think you should return a proper error code instead of WARN_ON.

> +               blocks += DIV_ROUND_UP(sg_ptr->length, blksz);
> +       }
> +
> +       /* sanity check */
> +       if (addr & ~0x1FFFF)
> +               return -EINVAL;
> +
> +       mrq.cmd = &cmd;
> +       mrq.data = &data;
> +
> +       cmd.opcode = SD_IO_RW_EXTENDED;
> +       cmd.arg = write ? 0x80000000 : 0x00000000;
> +       cmd.arg |= fn << 28;
> +       cmd.arg |= incr_addr ? 0x04000000 : 0x00000000;
> +       cmd.arg |= addr << 9;
> +       cmd.arg |= 0x08000000 | blocks;
> +       cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
> +
> +       data.blksz = blksz;
> +       data.blocks = blocks;
> +       data.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
> +
> +       data.sg = sgt->sgl;
> +       data.sg_len = sgt->nents;
> +
> +       mmc_set_data_timeout(&data, card);
> +       mmc_wait_for_req(card->host, &mrq);
> +
> +       if (cmd.error)
> +               return cmd.error;
> +       if (data.error)
> +               return data.error;
> +
> +       if (mmc_host_is_spi(card->host)) {
> +               /* host driver already reported errors */
> +       } else {
> +               if (cmd.resp[0] & R5_ERROR)
> +                       return -EIO;
> +               if (cmd.resp[0] & R5_FUNCTION_NUMBER)
> +                       return -EINVAL;
> +               if (cmd.resp[0] & R5_OUT_OF_RANGE)
> +                       return -ERANGE;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_io_rw_extended_sg);

Besides these comment, clearly you have duplicated code from
mmc_io_rw_extended() in the above function.

Can you try to re-factor mmc_io_rw_extended(), so we can avoid too
much code duplications.

> +
>  int sdio_reset(struct mmc_host *host)
>  {
>         int ret;
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
> index aab032a..2107e91 100644
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
> @@ -151,6 +152,10 @@ extern int sdio_memcpy_toio(struct sdio_func *func, unsigned int addr,
>  extern int sdio_writesb(struct sdio_func *func, unsigned int addr,
>         void *src, int count);
>
> +int mmc_io_rw_extended_sg(struct mmc_card *card, int write, unsigned fn,
> +                         unsigned addr, int incr_addr,
> +                         struct sg_table *sgt, unsigned blksz);
> +
>  extern unsigned char sdio_f0_readb(struct sdio_func *func,
>         unsigned int addr, int *err_ret);
>  extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

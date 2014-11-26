From: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] mmc: new API for data write using scatter gather DMA
Date: Wed, 26 Nov 2014 19:10:13 +0100
Message-ID: <54761785.2070803@broadcom.com>
References: <1417000056-16920-1-git-send-email-patila@marvell.com> <CAPDyKFr-iaPWKWWgk-5_XcJm9sag=y=uZjfJvo-DQiJFM8BVLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFr-iaPWKWWgk-5_XcJm9sag=y=uZjfJvo-DQiJFM8BVLw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Avinash Patil <patila-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akarwar-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, cluo-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, yangyang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, huxm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, bin9zha0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 11/26/14 14:43, Ulf Hansson wrote:
> On 26 November 2014 at 12:07, Avinash Patil<patila-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>  wrote:
>> From: Bing Zhao<bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>
>> This patch adds new API to handle scatter gather aggregation.
>
> Why is this needed?

One thing I can imagine is that the receiving device has specific 
scatter-gather alignment requirements that are not covered in 
mmc_io_rw_extended(). So the new API does not so much handle 
scatter-gather, but leaves that up to the caller. Question is whether 
mmc_io_rw_extended() could be changed to accommodate those requirements 
instead of duplicating big part of it. Without knowing the exact 
requirements that is difficult to answer.

Regards,
Arend

>
>>
>> Signed-off-by: Bing Zhao<bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Avinash Patil<patila-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Xinming Hu<huxm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Cathy Luo<cluo-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/mmc/core/sdio_ops.c   | 65 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mmc/sdio_func.h |  5 ++++
>>   2 files changed, 70 insertions(+)
>>
>> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
>> index 62508b4..4c5e362 100644
>> --- a/drivers/mmc/core/sdio_ops.c
>> +++ b/drivers/mmc/core/sdio_ops.c
>> @@ -15,6 +15,7 @@
>>   #include<linux/mmc/card.h>
>>   #include<linux/mmc/mmc.h>
>>   #include<linux/mmc/sdio.h>
>> +#include<linux/export.h>
>>
>>   #include "core.h"
>>   #include "sdio_ops.h"
>> @@ -204,6 +205,70 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>>          return 0;
>>   }
>>
>> +int mmc_io_rw_extended_sg(struct mmc_card *card, int write, unsigned fn,
>> +                         unsigned addr, int incr_addr,
>> +                         struct sg_table *sgt, unsigned blksz)
>> +{
>> +       struct mmc_request mrq = {NULL};
>> +       struct mmc_command cmd = {0};
>> +       struct mmc_data data = {0};
>> +       struct scatterlist *sg_ptr;
>> +       unsigned blocks = 0;
>> +       int i;
>> +
>> +       BUG_ON(!card || !card->host);
>> +       BUG_ON(fn>  7);
>> +       BUG_ON(!blksz);
>
> No BUG_ON() here please. Better to return an error.
>
>> +       for_each_sg(sgt->sgl, sg_ptr, sgt->nents, i) {
>> +               WARN_ON(sg_ptr->length>  card->host->max_seg_size);
>> +               blocks += DIV_ROUND_UP(sg_ptr->length, blksz);
>> +       }
>> +
>> +       /* sanity check */
>> +       if (addr&  ~0x1FFFF)
>> +               return -EINVAL;
>> +
>> +       mrq.cmd =&cmd;
>> +       mrq.data =&data;
>> +
>> +       cmd.opcode = SD_IO_RW_EXTENDED;
>> +       cmd.arg = write ? 0x80000000 : 0x00000000;
>> +       cmd.arg |= fn<<  28;
>> +       cmd.arg |= incr_addr ? 0x04000000 : 0x00000000;
>> +       cmd.arg |= addr<<  9;
>> +       cmd.arg |= 0x08000000 | blocks;
>> +       cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
>> +
>> +       data.blksz = blksz;
>> +       data.blocks = blocks;
>> +       data.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
>> +
>> +       data.sg = sgt->sgl;
>> +       data.sg_len = sgt->nents;
>> +
>> +       mmc_set_data_timeout(&data, card);
>> +       mmc_wait_for_req(card->host,&mrq);
>> +
>> +       if (cmd.error)
>> +               return cmd.error;
>> +       if (data.error)
>> +               return data.error;
>> +
>> +       if (mmc_host_is_spi(card->host)) {
>> +               /* host driver already reported errors */
>> +       } else {
>> +               if (cmd.resp[0]&  R5_ERROR)
>> +                       return -EIO;
>> +               if (cmd.resp[0]&  R5_FUNCTION_NUMBER)
>> +                       return -EINVAL;
>> +               if (cmd.resp[0]&  R5_OUT_OF_RANGE)
>> +                       return -ERANGE;
>> +       }
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(mmc_io_rw_extended_sg);
>> +
>>   int sdio_reset(struct mmc_host *host)
>>   {
>>          int ret;
>> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
>> index 50f0bc9..927ea8f 100644
>> --- a/include/linux/mmc/sdio_func.h
>> +++ b/include/linux/mmc/sdio_func.h
>> @@ -14,6 +14,7 @@
>>
>>   #include<linux/device.h>
>>   #include<linux/mod_devicetable.h>
>> +#include<linux/scatterlist.h>
>>
>>   #include<linux/mmc/pm.h>
>>
>> @@ -153,6 +154,10 @@ extern int sdio_memcpy_toio(struct sdio_func *func, unsigned int addr,
>>   extern int sdio_writesb(struct sdio_func *func, unsigned int addr,
>>          void *src, int count);
>>
>> +int mmc_io_rw_extended_sg(struct mmc_card *card, int write, unsigned fn,
>> +                         unsigned addr, int incr_addr,
>> +                         struct sg_table *sgt, unsigned blksz);
>> +
>>   extern unsigned char sdio_f0_readb(struct sdio_func *func,
>>          unsigned int addr, int *err_ret);
>>   extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
>> --
>> 1.8.1.4
>>
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

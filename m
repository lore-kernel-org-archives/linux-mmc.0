From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] MMC: at91_mci: modify cache flush routines
Date: Wed, 19 May 2010 13:04:54 +0200
Message-ID: <4BF3C5D6.3010707@atmel.com>
References: <20100511134409.GB27201@n2100.arm.linux.org.uk> <1273597793-28104-1-git-send-email-nicolas.ferre@atmel.com> <20100512141929.80c13953.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100512141929.80c13953.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, avictor.za@gmail.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Le 12/05/2010 23:19, Andrew Morton :
> On Tue, 11 May 2010 19:09:53 +0200
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
>> As we were using an internal dma flushing routine, this patch changes to the
>> DMA API flush_kernel_dcache_page(). Driver is able to compile now.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/mmc/host/at91_mci.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
>> index a6dd7da..813d208 100644
>> --- a/drivers/mmc/host/at91_mci.c
>> +++ b/drivers/mmc/host/at91_mci.c
>> @@ -315,7 +315,7 @@ static void at91_mci_post_dma_read(struct at91mci_host *host)
>>  		}
>>  
>>  		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
>> -		dmac_flush_range((void *)sgbuffer, ((void *)sgbuffer) + amount);
>> +		flush_kernel_dcache_page(sg_page(sg));
>>  		data->bytes_xfered += amount;
>>  		if (size == 0)
>>  			break;
> 
> The flush_kernel_dcache_page() documentation specifically says that
> thou shalt run flush_kernel_dcache_page() _prior_ to kunmapping the
> page.
> 
> I don't know if that makes a difference in the real world, but heck why
> not:
> 
> --- a/drivers/mmc/host/at91_mci.c~mmc-at91_mci-modify-cache-flush-routines-fix
> +++ a/drivers/mmc/host/at91_mci.c
> @@ -314,8 +314,8 @@ static void at91_mci_post_dma_read(struc
>  			dmabuf = (unsigned *)tmpv;
>  		}
>  
> -		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
>  		flush_kernel_dcache_page(sg_page(sg));
> +		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
>  		data->bytes_xfered += amount;
>  		if (size == 0)
>  			break;
> _

Andrew, thanks a lot for folding this in my patch.
I had no access to my emails last days and it was good to learn that
this patch went to 2.6.34-final.

Best regards,
-- 
Nicolas Ferre

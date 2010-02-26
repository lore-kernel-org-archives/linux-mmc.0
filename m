From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 1/7] mmc: at91_mci: fix pointer errors
Date: Fri, 26 Feb 2010 23:20:46 +0300
Message-ID: <20100226201934.GG8417@bicker>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, avictor.za@gmail.com, wolfgang.mues@auerswald.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 26, 2010 at 07:39:29PM +0100, Nicolas Ferre wrote:
> From: Wolfgang Muees <wolfgang.mues@auerswald.de>
> 
> Fixes two pointer errors, one which leads to memory overwrites if used with
> large chunks of data.
> 
> Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/mmc/host/at91_mci.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
> index 63924e0..6835104 100644
> --- a/drivers/mmc/host/at91_mci.c
> +++ b/drivers/mmc/host/at91_mci.c
> @@ -227,11 +227,13 @@ static inline void at91_mci_sg_to_dma(struct at91mci_host *host, struct mmc_data
>  			for (index = 0; index < (amount / 4); index++)
>  				*dmabuf++ = swab32(sgbuffer[index]);
>  		} else {
> -			memcpy(dmabuf, sgbuffer, amount);
> -			dmabuf += amount;
> +			char *tmpv = (char *)dmabuf;
> +			memcpy(tmpv, sgbuffer, amount);
> +			tmpv += amount;
> +			dmabuf = (unsigned *)tmpv;
>  		}
>  
> -		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
> +		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);

Please put spaces around the minus sign.

	kunmap_atomic(((void *)sgbuffer) - sg->offset, KM_BIO_SRC_IRQ);

regards,
dan carpenter

>  
>  		if (size == 0)
>  			break;
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

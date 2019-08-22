From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: jz4740: Drop dependency on arch header
Date: Thu, 22 Aug 2019 14:13:15 +0200
Message-ID: <CAPDyKFqMmCcsJi9r9j24wW9gOPsYr+t5TrryqpJ3=EH0ANwi9A@mail.gmail.com>
References: <20190810121608.24145-1-paul@crapouillou.net> <20190810121608.24145-2-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810121608.24145-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, od@zcrc.me
List-Id: linux-mmc@vger.kernel.org

On Sat, 10 Aug 2019 at 14:16, Paul Cercueil <paul@crapouillou.net> wrote:
>
> We don't need to set the 'slave_id' anymore - that field is never read
> by the DMA driver.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 59f81e8afcce..7ff2034d739a 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -25,8 +25,6 @@
>
>  #include <asm/cacheflush.h>
>
> -#include <asm/mach-jz4740/dma.h>
> -
>  #define JZ_REG_MMC_STRPCL      0x00
>  #define JZ_REG_MMC_STATUS      0x04
>  #define JZ_REG_MMC_CLKRT       0x08
> @@ -292,11 +290,9 @@ static int jz4740_mmc_start_dma_transfer(struct jz4740_mmc_host *host,
>         if (data->flags & MMC_DATA_WRITE) {
>                 conf.direction = DMA_MEM_TO_DEV;
>                 conf.dst_addr = host->mem_res->start + JZ_REG_MMC_TXFIFO;
> -               conf.slave_id = JZ4740_DMA_TYPE_MMC_TRANSMIT;
>         } else {
>                 conf.direction = DMA_DEV_TO_MEM;
>                 conf.src_addr = host->mem_res->start + JZ_REG_MMC_RXFIFO;
> -               conf.slave_id = JZ4740_DMA_TYPE_MMC_RECEIVE;
>         }
>
>         sg_count = jz4740_mmc_prepare_dma_data(host, data, COOKIE_MAPPED);
> --
> 2.21.0.593.g511ec345e18
>

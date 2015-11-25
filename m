From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: atmel-mci: atmci_convert_chksize depends on
 controller version
Date: Wed, 25 Nov 2015 17:33:59 +0100
Message-ID: <CAPDyKFpDS_BGO7sFe23xGYU4cuSozZ5BtTkJ9+mO30EVxmn=aA@mail.gmail.com>
References: <1448292452-5786-1-git-send-email-ludovic.desroches@atmel.com>
	<1448292452-5786-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448292452-5786-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-mmc@vger.kernel.org

On 23 November 2015 at 16:27, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> The atmci_convert_chksize() function is no more valid for controller
> version 0x600 due to the introduction of '2 data' chunk size.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 9f3bb61..a36ebda 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -180,20 +180,6 @@
>  #      define ATMCI_PDC_CONNECTED      1
>  #endif
>
> -/*
> - * Fix sconfig's burst size according to atmel MCI. We need to convert them as:
> - * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
> - *
> - * This can be done by finding most significant bit set.
> - */
> -static inline unsigned int atmci_convert_chksize(unsigned int maxburst)
> -{
> -       if (maxburst > 1)
> -               return fls(maxburst) - 2;
> -       else
> -               return 0;
> -}
> -
>  #define AUTOSUSPEND_DELAY      50
>
>  #define ATMCI_DATA_ERROR_FLAGS (ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
> @@ -732,6 +718,29 @@ static inline unsigned int atmci_get_version(struct atmel_mci *host)
>         return atmci_readl(host, ATMCI_VERSION) & 0x00000fff;
>  }
>
> +/*
> + * Fix sconfig's burst size according to atmel MCI. We need to convert them as:
> + * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
> + * With version 0x600, we need to convert them as: 1 -> 0, 2 -> 1, 4 -> 2,
> + * 8 -> 3, 16 -> 4.
> + *
> + * This can be done by finding most significant bit set.
> + */
> +static inline unsigned int atmci_convert_chksize(struct atmel_mci *host,
> +                                                unsigned int maxburst)
> +{
> +       unsigned int version = atmci_get_version(host);
> +       unsigned int offset = 2;
> +
> +       if (version >= 0x600)
> +               offset = 1;
> +
> +       if (maxburst > 1)
> +               return fls(maxburst) - offset;
> +       else
> +               return 0;
> +}
> +
>  static void atmci_timeout_timer(unsigned long data)
>  {
>         struct atmel_mci *host;
> @@ -1182,11 +1191,13 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
>         if (data->flags & MMC_DATA_READ) {
>                 direction = DMA_FROM_DEVICE;
>                 host->dma_conf.direction = slave_dirn = DMA_DEV_TO_MEM;
> -               maxburst = atmci_convert_chksize(host->dma_conf.src_maxburst);
> +               maxburst = atmci_convert_chksize(host,
> +                                                host->dma_conf.src_maxburst);
>         } else {
>                 direction = DMA_TO_DEVICE;
>                 host->dma_conf.direction = slave_dirn = DMA_MEM_TO_DEV;
> -               maxburst = atmci_convert_chksize(host->dma_conf.dst_maxburst);
> +               maxburst = atmci_convert_chksize(host,
> +                                                host->dma_conf.dst_maxburst);
>         }
>
>         if (host->caps.has_dma_conf_reg)
> --
> 2.5.0
>

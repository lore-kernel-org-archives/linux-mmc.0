From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: enable 8 bits buswidth support
Date: Wed, 30 Jan 2019 10:20:34 +0100
Message-ID: <CAPDyKFrknwcbTDKQsGTSo9oZWX3B=fq39Ea=YkoFt_8LoEj5AQ@mail.gmail.com>
References: <20190129164950.31052-1-nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129164950.31052-1-nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 29 Jan 2019 at 17:50, Nicolas Ferre <nicolas.ferre@microchip.com> wrote:
>
> This patch adds support for 8-bit buswidth.
> Relevant SDCR value modified.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 47189f9ed4e2..735aa5871358 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1410,6 +1410,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         case MMC_BUS_WIDTH_4:
>                 slot->sdc_reg |= ATMCI_SDCBUS_4BIT;
>                 break;
> +       case MMC_BUS_WIDTH_8:
> +               slot->sdc_reg |= ATMCI_SDCBUS_8BIT;
> +               break;
>         }
>
>         if (ios->clock) {
> @@ -2275,8 +2278,11 @@ static int atmci_init_slot(struct atmel_mci *host,
>          * use only one bit for data to prevent fifo underruns and overruns
>          * which will corrupt data.
>          */
> -       if ((slot_data->bus_width >= 4) && host->caps.has_rwproof)
> +       if ((slot_data->bus_width >= 4) && host->caps.has_rwproof) {
>                 mmc->caps |= MMC_CAP_4_BIT_DATA;
> +               if (slot_data->bus_width >= 8)
> +                       mmc->caps |= MMC_CAP_8_BIT_DATA;
> +       }
>
>         if (atmci_get_version(host) < 0x200) {
>                 mmc->max_segs = 256;
> --
> 2.17.1
>

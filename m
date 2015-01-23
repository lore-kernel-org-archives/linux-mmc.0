From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND] mmc: mmci: Get rid of dead code in mmci_dma_setup
Date: Fri, 23 Jan 2015 13:08:10 +0100
Message-ID: <CAPDyKFpUGj=nJ9vHPOeHX+-KsgSVZ8ngnPgnri9gYa6Dp2ML1A@mail.gmail.com>
References: <1421835437-26259-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421835437-26259-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 21 January 2015 at 11:17, Pramod Gurav <pramod.gurav@smartplayin.com> wrote:
> DMA configuration has been removed from function mmci_dma_setup but the
> local mask variable was not removed. This remains unused hence remove
> it from the function and operations on it
>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

Thanks! Applied for next.

Kind  regards
Uffe

> ---
>  drivers/mmc/host/mmci.c |    5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 47dcece..122a751 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -435,7 +435,6 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>  static void mmci_dma_setup(struct mmci_host *host)
>  {
>         const char *rxname, *txname;
> -       dma_cap_mask_t mask;
>         struct variant_data *variant = host->variant;
>
>         host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
> @@ -444,10 +443,6 @@ static void mmci_dma_setup(struct mmci_host *host)
>         /* initialize pre request cookie */
>         host->next_data.cookie = 1;
>
> -       /* Try to acquire a generic DMA engine slave channel */
> -       dma_cap_zero(mask);
> -       dma_cap_set(DMA_SLAVE, mask);
> -
>         /*
>          * If only an RX channel is specified, the driver will
>          * attempt to use it bidirectionally, however if it is
> --
> 1.7.9.5
>

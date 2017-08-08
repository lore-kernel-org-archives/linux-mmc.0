From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: renesas-sdhi: constify renesas_sdhi_internal_dmac_dma_ops
Date: Tue, 8 Aug 2017 12:38:27 +0200
Message-ID: <CAPDyKFp+rSRxsyW+E3kprPF-6dzMiHOoPxoikY2Xi=ypa-5JCw@mail.gmail.com>
References: <1502136903-21633-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502136903-21633-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, kernel-janitors@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 7 August 2017 at 22:15, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> The structure renesas_sdhi_internal_dmac_dma_ops is only passed as
> the second argument to renesas_sdhi_probe, which is const, so
> renesas_sdhi_internal_dmac_dma_ops can be const too.
>
> Done with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks, applied for next!

Kind regards
Uffe
>
> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 6717003..3a82577 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -233,7 +233,7 @@ static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
>         host->chan_rx = host->chan_tx = NULL;
>  }
>
> -static struct tmio_mmc_dma_ops renesas_sdhi_internal_dmac_dma_ops = {
> +static const struct tmio_mmc_dma_ops renesas_sdhi_internal_dmac_dma_ops = {
>         .start = renesas_sdhi_internal_dmac_start_dma,
>         .enable = renesas_sdhi_internal_dmac_enable_dma,
>         .request = renesas_sdhi_internal_dmac_request_dma,
>

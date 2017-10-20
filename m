From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: meson-mx-sdio: return correct error code
Date: Fri, 20 Oct 2017 12:02:41 +0200
Message-ID: <CAPDyKFpT78pzBAArnPT=poc6Mm5kQaTgnUKA2DyR3vm1wdfpBg@mail.gmail.com>
References: <20171013111943.zyp5myiwb3pp56vh@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171013111943.zyp5myiwb3pp56vh@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Carlo Caione <carlo@endlessm.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 13 October 2017 at 13:19, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> This has a copy and paste bug so we use "host->fixed_factor_clk" which
> is a valid pointer instead of "host->cfg_div_clk" which holds the error
> code.
>
> Fixes: 0aa0fb9cd239 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied for next!

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 19b499bbe691..dc30ed5e964b 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -621,7 +621,7 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>         host->cfg_div_clk = devm_clk_register(host->controller_dev,
>                                               &host->cfg_div.hw);
>         if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
> -               return PTR_ERR(host->fixed_factor_clk);
> +               return PTR_ERR(host->cfg_div_clk);
>
>         return 0;
>  }

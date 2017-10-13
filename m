From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 2/2] mmc: meson-mx-sdio: Cleanup IS_ERR() checks
Date: Fri, 13 Oct 2017 21:02:28 +0200
Message-ID: <CAFBinCBz95u=DdrVF2UL0wPe2oUP2Qhz37K7MVkMUDj0jn2HmA@mail.gmail.com>
References: <20171013111943.zyp5myiwb3pp56vh@mwanda> <20171013112049.rdcdqv6ooktlv5wz@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171013112049.rdcdqv6ooktlv5wz@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@endlessm.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 13, 2017 at 1:20 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Using PTR_ERR_OR_ZERO() instead of IS_ERR() works, but it's not how
> you're supposed to write these conditions.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for spotting and fixing this!
I double-checked devm_clk_register: we don't need IS_ERR_OR_NULL
because devm_clk_register never returns NULL

> ---
> I really hope it doesn't become a trend on to wrap all error checks in a
> WARN_ON() macro...
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index dc30ed5e964b..d0d921e0e589 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -602,7 +602,7 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>
>         host->fixed_factor_clk = devm_clk_register(host->controller_dev,
>                                                  &host->fixed_factor.hw);
> -       if (WARN_ON(PTR_ERR_OR_ZERO(host->fixed_factor_clk)))
> +       if (WARN_ON(IS_ERR(host->fixed_factor_clk)))
>                 return PTR_ERR(host->fixed_factor_clk);
>
>         clk_div_parent = __clk_get_name(host->fixed_factor_clk);
> @@ -620,7 +620,7 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>
>         host->cfg_div_clk = devm_clk_register(host->controller_dev,
>                                               &host->cfg_div.hw);
> -       if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
> +       if (WARN_ON(IS_ERR(host->cfg_div_clk)))
>                 return PTR_ERR(host->cfg_div_clk);
>
>         return 0;
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

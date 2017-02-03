From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] mmc: meson: Assign the minimum clk rate as close to 100KHz as possible
Date: Fri, 03 Feb 2017 12:11:42 -0600
Message-ID: <m2zii3jg9t.fsf@baylibre.com>
References: <1486110491-8921-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36780 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdBCSLo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 13:11:44 -0500
Received: by mail-io0-f178.google.com with SMTP id j13so23484959iod.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 10:11:44 -0800 (PST)
In-Reply-To: <1486110491-8921-1-git-send-email-ulf.hansson@linaro.org> (Ulf
        Hansson's message of "Fri, 3 Feb 2017 09:28:11 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The current code dealing with calculating mmc->f_min is a bit complicated.
> Additionally, the attempt to set an initial clock rate should explicitly
> use a rate between 100KHz to 400 KHz, according the (e)MMC/SD specs, which
> it doesn't.
>
> Fix the problem and clean up the code by using clk_round_rate() to pick the
> nearest minimum rate to 100KHz.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Note, this is compile tested only so I hope someone with the HW can give it a
> go.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Not being an MMC expert, I didn't fully understand how f_min was meant
to be used by the core code, so the initial driver was simply
calculating the lowest clock rate available based on the input clocks.

Thanks for cleaning that up.

Kevin

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 5eca88b..c672e01 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -240,7 +240,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
>  	unsigned int mux_parent_count = 0;
>  	const char *clk_div_parents[1];
> -	unsigned int f_min = UINT_MAX;
>  	u32 clk_reg, cfg;
>  
>  	/* get the mux parents */
> @@ -257,20 +256,10 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  			return ret;
>  		}
>  
> -		host->mux_parent_rate[i] = clk_get_rate(host->mux_parent[i]);
>  		mux_parent_names[i] = __clk_get_name(host->mux_parent[i]);
>  		mux_parent_count++;
> -		if (host->mux_parent_rate[i] < f_min)
> -			f_min = host->mux_parent_rate[i];
>  	}
>  
> -	/* cacluate f_min based on input clocks, and max divider value */
> -	if (f_min != UINT_MAX)
> -		f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
> -	else
> -		f_min = 4000000;  /* default min: 400 MHz */
> -	host->mmc->f_min = f_min;
> -
>  	/* create the mux */
>  	snprintf(clk_name, sizeof(clk_name), "%s#mux", dev_name(host->dev));
>  	init.name = clk_name;
> @@ -325,9 +314,13 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	writel(cfg, host->regs + SD_EMMC_CFG);
>  
>  	ret = clk_prepare_enable(host->cfg_div_clk);
> -	if (!ret)
> -		ret = meson_mmc_clk_set(host, f_min);
> +	if (ret)
> +		return ret;
> +
> +	/* Get the nearest minimum clock to 100KHz */
> +	host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 100000);
>  
> +	ret = meson_mmc_clk_set(host, host->mmc->f_min);
>  	if (!ret)
>  		clk_disable_unprepare(host->cfg_div_clk);

From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 6/9] mmc: meson-gx: remove unneeded meson_mmc_clk_set in meson_mmc_clk_init
Date: Fri, 17 Feb 2017 11:51:24 -0800
Message-ID: <m2bmu061fn.fsf@baylibre.com>
References: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
        <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36838 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934472AbdBQTv1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2017 14:51:27 -0500
Received: by mail-pg0-f48.google.com with SMTP id v184so17909320pgv.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2017 11:51:26 -0800 (PST)
In-Reply-To: <fc824f91-f686-64ab-83e4-86b04fd512f0@gmail.com> (Heiner
        Kallweit's message of "Thu, 16 Feb 2017 20:42:06 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> This clk_disable_unprepare isn't right here. At first the condition
> should be "if (ret)" as the disable/unprepare is supposed to be
> executed if the previous command fails.
> And if the previous command fails and meson_mmc_clk_init returns
> an error, then probe jumps to label free_host where we have this
> disable/unprepare already.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
> v2:
> - extended commit message
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 68e76fa8..850b0152 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -320,11 +320,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	/* Get the nearest minimum clock to 400KHz */
>  	host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 400000);
>  
> -	ret = meson_mmc_clk_set(host, host->mmc->f_min);
> -	if (!ret)
> -		clk_disable_unprepare(host->cfg_div_clk);
> -
> -	return ret;
> +	return meson_mmc_clk_set(host, host->mmc->f_min);
>  }
>  
>  static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)

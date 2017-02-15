From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 14/18] mmc: meson-gx: remove unneeded devm_kstrdup in meson_mmc_clk_init
Date: Wed, 15 Feb 2017 11:30:14 -0800
Message-ID: <m27f4r8d6h.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <04781c15-b543-337c-d6d4-8378bd558cf7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34037 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdBOTaQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 14:30:16 -0500
Received: by mail-pg0-f42.google.com with SMTP id z67so7308348pgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 11:30:16 -0800 (PST)
In-Reply-To: <04781c15-b543-337c-d6d4-8378bd558cf7@gmail.com> (Heiner
        Kallweit's message of "Tue, 14 Feb 2017 21:07:01 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> MMC core does a deep copy of init.name, therefore it's fully ok to

I assume you mean the clock framework, not the MMC core, right?

> provide a local variable.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

With the changelog fixed,

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 39904fb5..806554b1 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -276,7 +276,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  
>  	/* create the divider */
>  	snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
> -	init.name = devm_kstrdup(host->dev, clk_name, GFP_KERNEL);
> +	init.name = clk_name;
>  	init.ops = &clk_divider_ops;
>  	init.flags = CLK_SET_RATE_PARENT;
>  	clk_div_parents[0] = __clk_get_name(host->mux_clk);

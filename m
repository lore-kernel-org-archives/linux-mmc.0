From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 11/18] mmc: meson-gx: remove unneeded variable in meson_mmc_clk_init
Date: Wed, 15 Feb 2017 11:24:56 -0800
Message-ID: <m2lgt78dfb.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <d08aa734-0258-3d53-9726-f7d9f47b51eb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35564 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBOTY7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 14:24:59 -0500
Received: by mail-pg0-f53.google.com with SMTP id t188so174534pgt.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 11:24:59 -0800 (PST)
In-Reply-To: <d08aa734-0258-3d53-9726-f7d9f47b51eb@gmail.com> (Heiner
        Kallweit's message of "Tue, 14 Feb 2017 21:06:48 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Variable mux_parent_count can be replaced with constant
> MUX_CLK_NUM_PARENTS, so remove it.

Before the above sentence, add "Because the DT requires a fixed number
of mux parent clocks, ..."

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

With that,

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 159ee7b4..d05ffe8a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -237,7 +237,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	char clk_name[32];
>  	int i, ret = 0;
>  	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
> -	unsigned int mux_parent_count = 0;
>  	const char *clk_div_parents[1];
>  	u32 clk_reg, cfg;
>  
> @@ -256,7 +255,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  		}
>  
>  		mux_parent_names[i] = __clk_get_name(host->mux_parent[i]);
> -		mux_parent_count++;
>  	}
>  
>  	/* create the mux */
> @@ -265,7 +263,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	init.ops = &clk_mux_ops;
>  	init.flags = 0;
>  	init.parent_names = mux_parent_names;
> -	init.num_parents = mux_parent_count;
> +	init.num_parents = MUX_CLK_NUM_PARENTS;
>  
>  	host->mux.reg = host->regs + SD_EMMC_CLOCK;
>  	host->mux.shift = CLK_SRC_SHIFT;

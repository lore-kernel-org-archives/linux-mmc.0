From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/6] mmc: sh_mobile_sdhi: don't use array for DT configs
Date: Wed, 6 Apr 2016 11:56:31 +0200
Message-ID: <CAMuHMdV=Ts_mF6MougLh1qqOTJV__x0Zu2TfMVsiPdfe+O--3g@mail.gmail.com>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
	<1459934734-3613-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1459934734-3613-2-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Wed, Apr 6, 2016 at 11:25 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> We won't access an index based array to get our DT config, but create
> seperate structs instead. So, remove the array which only wastes memory.

While I agree with your patch, I don't agree with the memory consumption
comment...

It does remove 2 lines of source code ;-)

> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -51,10 +51,8 @@ struct sh_mobile_sdhi_of_data {
>         unsigned bus_shift;
>  };
>
> -static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
> -       {
> -               .tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
> -       },

Array of a single element.

> +static const struct sh_mobile_sdhi_of_data of_default_cfg = {
> +       .tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
>  };

Single element.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

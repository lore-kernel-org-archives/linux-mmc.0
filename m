From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: update entry for TMIO MMC driver
Date: Tue, 10 May 2016 12:28:34 +0200
Message-ID: <CAPDyKFrWaCajdjTYZat=1vYYynpP89Tv=u=syb6ffYkGk8478g@mail.gmail.com>
References: <1462782418-5908-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462782418-5908-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On 9 May 2016 at 10:26, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I have some more additions planned for this driver, so I'd like to get
> notified of other changes and coordinate them. Drop Ian as maintainer
> because he hasn't been involved in development for a while. Thanks for
> all the initial work, of course! Also, reflect the recent changes to
> the include file layout.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Ian Molton <ian@mnementh.co.uk>

Thanks, applied for next!

> ---
>
> Ian: If you'd like to stay involved, please speak up and I'll change my patch
> accordingly.

As I applied this patch with quite short delay, I will instead
recommend Ian to send a patch re-adding himself as co-maintainer. I am
happy to apply such patch if it shows up.

Kind regards
Uffe

>
>  MAINTAINERS | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42e65d128d015e..d22540c44b534b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11245,14 +11245,13 @@ S:    Maintained
>  F:     drivers/media/i2c/tc358743*
>  F:     include/media/i2c/tc358743.h
>
> -TMIO MMC DRIVER
> -M:     Ian Molton <ian@mnementh.co.uk>
> +TMIO/SDHI MMC DRIVER
> +M:     Wolfram Sang <wsa+renesas@sang-engineering.com>
>  L:     linux-mmc@vger.kernel.org
> -S:     Maintained
> +S:     Supported
>  F:     drivers/mmc/host/tmio_mmc*
>  F:     drivers/mmc/host/sh_mobile_sdhi.c
> -F:     include/linux/mmc/tmio.h
> -F:     include/linux/mmc/sh_mobile_sdhi.h
> +F:     include/linux/mfd/tmio.h
>
>  TMP401 HARDWARE MONITOR DRIVER
>  M:     Guenter Roeck <linux@roeck-us.net>
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

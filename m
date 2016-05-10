From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] MAINTAINERS: update entry for TMIO MMC driver
Date: Tue, 10 May 2016 09:02:46 +0900
Message-ID: <20160510000246.GB4530@verge.net.au>
References: <1462782418-5908-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462782418-5908-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 09, 2016 at 10:26:58AM +0200, Wolfram Sang wrote:
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

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Ian: If you'd like to stay involved, please speak up and I'll change my patch
> accordingly.
> 
>  MAINTAINERS | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42e65d128d015e..d22540c44b534b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11245,14 +11245,13 @@ S:	Maintained
>  F:	drivers/media/i2c/tc358743*
>  F:	include/media/i2c/tc358743.h
>  
> -TMIO MMC DRIVER
> -M:	Ian Molton <ian@mnementh.co.uk>
> +TMIO/SDHI MMC DRIVER
> +M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
>  L:	linux-mmc@vger.kernel.org
> -S:	Maintained
> +S:	Supported
>  F:	drivers/mmc/host/tmio_mmc*
>  F:	drivers/mmc/host/sh_mobile_sdhi.c
> -F:	include/linux/mmc/tmio.h
> -F:	include/linux/mmc/sh_mobile_sdhi.h
> +F:	include/linux/mfd/tmio.h
>  
>  TMP401 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
> -- 
> 2.7.0
> 

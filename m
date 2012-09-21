From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix max value of clkd
Date: Fri, 21 Sep 2012 22:28:00 +0530
Message-ID: <CANfBPZ8wpbMeePM8wOJ59gN0LKx3Ed+qRfnBeez18Nyq2DJ2Jg@mail.gmail.com>
References: <1348240872-16068-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:33087 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750755Ab2IUQ6W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Sep 2012 12:58:22 -0400
Received: by qaas11 with SMTP id s11so1421650qaa.19
        for <linux-mmc@vger.kernel.org>; Fri, 21 Sep 2012 09:58:21 -0700 (PDT)
In-Reply-To: <1348240872-16068-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org

On Fri, Sep 21, 2012 at 8:51 PM, Balaji T K <balajitk@ti.com> wrote:
> clock divisor can take a max value of 1023
> update code as per TRM so that card init can be handled with
> higher IP clock frequencies from which clock to the card is
> derived.
>
This is difficult to read without some punctuation / capitalization.

> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index d9af5f1..073b9ff 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -75,6 +75,7 @@
>  #define ICE                    0x1
>  #define ICS                    0x2
>  #define CEN                    (1 << 2)
> +#define CLKD_MAX               0x3FF

It'd be nice to have a comment on what 3FF stands for and it's
relation to clock in MHz.

>  #define CLKD_MASK              0x0000FFC0
>  #define CLKD_SHIFT             6
>  #define DTO_MASK               0x000F0000
> @@ -478,8 +479,8 @@ static u16 calc_divisor(struct omap_hsmmc_host *host, struct mmc_ios *ios)
>
>         if (ios->clock) {
>                 dsor = DIV_ROUND_UP(clk_get_rate(host->fclk), ios->clock);
> -               if (dsor > 250)
> -                       dsor = 250;
> +               if (dsor > CLKD_MAX)
> +                       dsor = CLKD_MAX;

Can these two lines be written in one line as
"dsor &= CLKD_MAX; " ?

>         }
>

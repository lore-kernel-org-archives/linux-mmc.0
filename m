From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sd: limit SD card power limit according to cards capabilities
Date: Wed, 13 Jan 2016 11:09:05 +0100
Message-ID: <CAPDyKFpcOZ3sLNESLfCgTmpiWbgh+tPbELV6oh7GWsVjuPzKGQ@mail.gmail.com>
References: <E1aFJ4v-00087o-NH@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35769 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbcAMKJH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2016 05:09:07 -0500
Received: by mail-yk0-f182.google.com with SMTP id x67so483997036ykd.2
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2016 02:09:06 -0800 (PST)
In-Reply-To: <E1aFJ4v-00087o-NH@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2 January 2016 at 11:06, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> The SD card specification allows cards to error out a SWITCH command
> where the requested function in a group is not supported.  The spec
> provides for a set of capabilities which indicate which functions are
> supported.
>
> In the case of the power limit, requesting an unsupported power level
> via the SWITCH command fails, resulting in the power level remaining at
> the power-on default of 0.72W, even though the host and card may support
> higher powers levels.
>
> This has been seen with SanDisk 8GB cards, which support the default
> 0.72W and 1.44W (200mA and 400mA) in combination with an iMX6 host,
> supporting up to 2.88W (800mA).  This currently causes us to try to set
> a power limit function value of '3' (2.88W) which the card errors out
> on, and thereby causes the power level to remain at 0.72W rather than
> the desired 1.44W.
>
> Arrange to limit the selected current limit by the capabilities reported
> by the card to avoid the SWITCH command failing.  Select the highest
> current limit that the host and card combination support.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, applied for fixes!

I also found a commit which most likely caused this being a
regression. I decided to add a fixes tag for it.
Even-though $subject patch doesn't apply cleanly on top that commit,
it's rather trivial to fix if someone wants it to be applied for an
old stable tree.

Fixes: a39ca6ae0a08 ("mmc: core: Simplify and fix for SD switch processing")

Kind regards
Uffe

> ---
> This is a bug fix, and as such needs merging into v4.4-rc and stable
> kernels.  There is probably more to come on this, as the SD simplified
> spec says that the power limit should be set _after_ switching to UHS
> mode:
>
> "In UHS-I mode, *after* selecting one of SDR50, SDR104 or DDR50 mode
>  by Function Group 1, host needs to change the Power Limit to enable
>  the card to operate in higher performance."
>
> However, unlike this patch, I have not (yet) seen any detrimental
> effects from setting this before.
>
>  drivers/mmc/core/sd.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 141eaa923e18..c4c6e4200d18 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -329,6 +329,7 @@ static int mmc_read_switch(struct mmc_card *card)
>                 card->sw_caps.sd3_bus_mode = status[13];
>                 /* Driver Strengths supported by the card */
>                 card->sw_caps.sd3_drv_type = status[9];
> +               card->sw_caps.sd3_curr_limit = status[7] | status[6] << 8;
>         }
>
>  out:
> @@ -545,14 +546,25 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
>          * when we set current limit to 200ma, the card will draw 200ma, and
>          * when we set current limit to 400/600/800ma, the card will draw its
>          * maximum 300ma from the host.
> +        *
> +        * The above is incorrect: if we try to set a current limit that is
> +        * not supported by the card, the card can rightfully error out the
> +        * attempt, and remain at the default current limit.  This results
> +        * in a 300mA card being limited to 200mA even though the host
> +        * supports 800mA. Failures seen with SanDisk 8GB UHS cards with
> +        * an iMX6 host. --rmk
>          */
> -       if (max_current >= 800)
> +       if (max_current >= 800 &&
> +           card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_800)
>                 current_limit = SD_SET_CURRENT_LIMIT_800;
> -       else if (max_current >= 600)
> +       else if (max_current >= 600 &&
> +                card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_600)
>                 current_limit = SD_SET_CURRENT_LIMIT_600;
> -       else if (max_current >= 400)
> +       else if (max_current >= 400 &&
> +                card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_400)
>                 current_limit = SD_SET_CURRENT_LIMIT_400;
> -       else if (max_current >= 200)
> +       else if (max_current >= 200 &&
> +                card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_200)
>                 current_limit = SD_SET_CURRENT_LIMIT_200;
>
>         if (current_limit != SD_SET_CURRENT_NO_CHANGE) {
> --
> 2.1.0
>

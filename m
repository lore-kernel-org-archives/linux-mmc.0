From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: do not abort if wp is disabled
Date: Fri, 13 Mar 2015 10:50:36 +0100
Message-ID: <CAPDyKFpU2rz4ZuDiyhFR=7BRS2HCySCukcSr-NN5A4gYnGiKYw@mail.gmail.com>
References: <1426234133-5889-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35774 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbbCMJuh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 05:50:37 -0400
Received: by qcwr17 with SMTP id r17so25254187qcw.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2015 02:50:36 -0700 (PDT)
In-Reply-To: <1426234133-5889-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>

On 13 March 2015 at 09:08, Jun Nie <jun.nie@linaro.org> wrote:
> Do not abort probe due to no detection to write protection pin,
> if host specify disable-wp.
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8be0df7..30ed253 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -394,11 +394,14 @@ int mmc_of_parse(struct mmc_host *host)
>         /* Parse Write Protection */
>         ro_cap_invert = of_property_read_bool(np, "wp-inverted");
>
> -       ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &ro_gpio_invert);
> -       if (!ret)
> -               dev_info(host->parent, "Got WP GPIO\n");
> -       else if (ret != -ENOENT)

I thought this else statement already took care of your issue.

The host driver shouldn't get an error code from mmc_of_parse() if the
optional "wp-gpio" doesn't exist. Right?

> -               return ret;
> +       if (!of_get_property(np, "disable-wp", NULL)) {
> +               ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0,
> +                                          &ro_gpio_invert);
> +               if (!ret)
> +                       dev_info(host->parent, "Got WP GPIO\n");
> +               else if (ret != -ENOENT)
> +                       return ret;
> +       }
>
>         /* See the comment on CD inversion above */
>         if (ro_cap_invert ^ ro_gpio_invert)
> --
> 1.9.1
>

Kind regards
Uffe

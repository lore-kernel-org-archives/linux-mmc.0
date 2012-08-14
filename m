From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: Adjust timings for power ramping up
Date: Tue, 14 Aug 2012 08:58:05 -0500
Message-ID: <CAGxe1ZGcfMQXMSZ_a5BqKoEEmr48AD01NU6LGtZEWCiktCnnXQ@mail.gmail.com>
References: <20120813161921.GA5022@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59857 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab2HNN6G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Aug 2012 09:58:06 -0400
Received: by vbbff1 with SMTP id ff1so338665vbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 14 Aug 2012 06:58:05 -0700 (PDT)
In-Reply-To: <20120813161921.GA5022@x230>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Rozhkov <dmitry.rozhkov@jollamobile.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 13 August 2012 11:19, Dmitry Rozhkov <dmitry.rozhkov@jollamobile.com> wrote:
> According to p6.4.1.1 of the Physical Layer Simplified Specification
> Ver3.01 the "host needs to keep power line level less than 0.5V and
> more than 1ms before power ramp up". This patch adds an explicit delay
> of 10ms just before power rump up.
>
> Without this patch some microSD cards (e.g. Kingston 8G Class 10) can't be
> used as bootable media on some TI OMAP chips at least.
> See https://bugs.nemomobile.org/show_bug.cgi?id=92 for details.
>
> Signed-off-by: Dmitry Rozhkov <dmitry.rozhkov@jollamobile.com>
> ---
>  drivers/mmc/core/core.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..22b0eb2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1163,6 +1163,13 @@ static void mmc_power_up(struct mmc_host *host)
>
>         mmc_host_clk_hold(host);
>
> +       /*
> +        * According to p6.4.1.1 of the Physical Layer Simplified Specification
> +        * Ver3.01 the "host needs to keep power line level less than 0.5V and
> +        * more than 1ms before power ramp up".
> +        */
> +       mmc_delay(10);
can you instead just try giving this delay in mmc_start_host as a
parameter to mmc_detect_change.
> +
>         /* If ocr is set, we use it */
>         if (host->ocr)
>                 bit = ffs(host->ocr) - 1;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

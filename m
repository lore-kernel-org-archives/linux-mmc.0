From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
Date: Wed, 31 Oct 2012 00:08:32 +0100
Message-ID: <CAPDyKFqM0cUkDDadm8MBK=+wHHYOSH3CVEHyiY1ybLkmPqSX7w@mail.gmail.com>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55976 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759732Ab2J3XId (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 19:08:33 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so383466wey.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Oct 2012 16:08:32 -0700 (PDT)
In-Reply-To: <1351584769-16662-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

On 30 October 2012 09:12,  <r66093@freescale.com> wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> When f_init is zero, the SDHC can't work correctly. So f_min will replace
> f_init, when f_init is zero.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
>         - add the CC
> changes for v3:
>         - enalbe the controller clock in platform, instead of core
>
>  drivers/mmc/core/core.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 06c42cf..9c162cd 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1319,7 +1319,10 @@ static void mmc_power_up(struct mmc_host *host)
>          */
>         mmc_delay(10);
>
> -       host->ios.clock = host->f_init;
> +       if (host->f_init)
> +               host->ios.clock = host->f_init;
> +       else
> +               host->ios.clock = host->f_min;

This should not be needed. host->f_init should never become zero, I believe.

>
>         host->ios.power_mode = MMC_POWER_ON;
>         mmc_set_ios(host);
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: omap_hsmmc: Check if MMC slot name is passed in pdata
Date: Wed, 27 Apr 2016 10:52:00 +0200
Message-ID: <CAPDyKFqCMfBx=VFy05MNDhO5ZpLw9x=Xmdst9JR0zHy+GHYJyQ@mail.gmail.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
	<1461714383-9956-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37573 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbcD0IwD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2016 04:52:03 -0400
Received: by mail-wm0-f41.google.com with SMTP id a17so6425324wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2016 01:52:01 -0700 (PDT)
In-Reply-To: <1461714383-9956-3-git-send-email-tony@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 27 April 2016 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> The legacy user space for n900 relies on the MMC slot names.
> Let's check if those are passed in pdata and use them.
>
> Then when we have a generic MMC slot name binding we can
> switch to use that assuming it works for the n900 legacy
> user space too.

I dropped this section, because I don't think it will happen.

>
> As this makes the DT booting compatible with legacy booting,
> we should be able to start dropping omap3 legacy booting
> support in v4.8.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Ulf, this is safe to pick separately to the MMC tree if it looks
> acceptable to you.
>
>
>  drivers/mmc/host/omap_hsmmc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e9d75c6..3563321 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1946,13 +1946,17 @@ MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
>
>  static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>  {
> -       struct omap_hsmmc_platform_data *pdata;
> +       struct omap_hsmmc_platform_data *pdata, *legacy;
>         struct device_node *np = dev->of_node;
>
>         pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>         if (!pdata)
>                 return ERR_PTR(-ENOMEM); /* out of memory */
>
> +       legacy = dev_get_platdata(dev);
> +       if (legacy && legacy->name)
> +               pdata->name = legacy->name;
> +
>         if (of_find_property(np, "ti,dual-volt", NULL))
>                 pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
>
> --
> 2.8.1
>

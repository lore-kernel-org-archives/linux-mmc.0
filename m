From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 8/8] mmc: core: use the broken-cd for non-removable card
Date: Tue, 28 Jan 2014 11:32:09 +0100
Message-ID: <CAPDyKFoXS5BMzHem3ahOVkdgC8YBrQXcQGyavSeLhn9zVvfNag@mail.gmail.com>
References: <52E7695B.2050504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:64996 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbaA1KcK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 05:32:10 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so201482qab.23
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jan 2014 02:32:09 -0800 (PST)
In-Reply-To: <52E7695B.2050504@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Arnd Bergmann <arnd@arndb.de>, Seungwon Jeon <tgih.jun@samsung.com>

On 28 January 2014 09:24, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Some SoC is used the broken card-detection.
> And it should be also used the "non-removable".
> Even if card is "non-removable", it didn't always use the cd-gpio.
>
> If it's used only broken-cd, then card-detect interrupt is polling.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/core/core.c |    4 ++--
>  drivers/mmc/core/host.c |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 098374b..df732aa 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2460,8 +2460,8 @@ void mmc_rescan(struct work_struct *work)
>          */
>         mmc_bus_put(host);
>
> -       if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
> -                       host->ops->get_cd(host) == 0) {
> +       if (host->ops->get_cd && host->ops->get_cd(host) == 0 &&
> +                       !(host->caps & MMC_CAP_NONREMOVABLE)) {

What's the difference here?

>                 mmc_claim_host(host);
>                 mmc_power_off(host);
>                 mmc_release_host(host);
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 4b81c93..52a64fe 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -356,6 +356,9 @@ int mmc_of_parse(struct mmc_host *host)
>          * configuration is performed.
>          */
>
> +       if (of_find_property(np, "broken-cd", &len))
> +               host->caps |= MMC_CAP_NEEDS_POLL;
> +

No. There are no meaning in using MMC_CAP_NEEDS_POLL in conjunction
with MMC_CAP_NONREMOVABLE.

Using MMC_CAP_NONREMOVABLE, will allow mmc_rescan to detect a card  -
only for one iteration. Thus MMC_CAP_NEEDS_POLL will have no effect.

Kind regards
Uffe


>         /* Parse Card Detection */
>         if (of_find_property(np, "non-removable", &len)) {
>                 host->caps |= MMC_CAP_NONREMOVABLE;
> @@ -364,9 +367,6 @@ int mmc_of_parse(struct mmc_host *host)
>
>                 explicit_inv_cd = of_property_read_bool(np, "cd-inverted");
>
> -               if (of_find_property(np, "broken-cd", &len))
> -                       host->caps |= MMC_CAP_NEEDS_POLL;
> -
>                 gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
>                 if (gpio == -EPROBE_DEFER)
>                         return gpio;
> --
> 1.7.9.5

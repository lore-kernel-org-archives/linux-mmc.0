From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Fix access to HS400-ES devices
Date: Tue, 14 Mar 2017 17:22:08 +0100
Message-ID: <CAPDyKFq61A0AgO=P0yVCYFDwym=32yVRAJG9rT0tBnyNjXEyaw@mail.gmail.com>
References: <1488406307-8952-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34578 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbdCNQWZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 12:22:25 -0400
Received: by mail-vk0-f49.google.com with SMTP id r136so54731933vke.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2017 09:22:19 -0700 (PDT)
In-Reply-To: <1488406307-8952-1-git-send-email-linux@roeck-us.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anssi Hannula <anssi.hannula@bitwise.fi>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>

On 1 March 2017 at 23:11, Guenter Roeck <linux@roeck-us.net> wrote:
> HS400-ES devices fail to initialize with the following error messages.
>
> mmc1: power class selection to bus width 8 ddr 0 failed
> mmc1: error -110 whilst initialising MMC card
>
> This was seen on Samsung Chromebook Plus. Code analysis points to
> commit 3d4ef329757c ("mmc: core: fix multi-bit bus width without
> high-speed mode"), which attempts to set the bus width for all but
> HS200 devices unconditionally. However, for HS400-ES, the bus width
> is already selected.
>
> Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Fixes: 3d4ef329757c ("mmc: core: fix multi-bit bus width ...")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Sorry for the delay. Been traveling.

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7fd722868875..b502601df228 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1730,7 +1730,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 err = mmc_select_hs400(card);
>                 if (err)
>                         goto free_card;
> -       } else {
> +       } else if (!mmc_card_hs400es(card)) {
>                 /* Select the desired bus width optionally */
>                 err = mmc_select_bus_width(card);
>                 if (err > 0 && mmc_card_hs(card)) {
> --
> 2.7.4
>

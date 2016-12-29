From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [Patch v1] mmc: sd: update sd_bus_speed when sd card speed switch fails
Date: Thu, 29 Dec 2016 11:27:05 +0100
Message-ID: <CAPDyKFoiBdO6RLcvNiaOd813RoOQvoznT+Pj6pbN+2f6e23wKQ@mail.gmail.com>
References: <1479119629-31821-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35771 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbcL2Kg1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2016 05:36:27 -0500
Received: by mail-wm0-f45.google.com with SMTP id a197so299705582wmd.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2016 02:36:26 -0800 (PST)
In-Reply-To: <1479119629-31821-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, frank.li@nxp.com, fugang.duan@nxp.com

Hi,

Sorry for the delay.

On 14 November 2016 at 11:33, Gao Pan <pandy.gao@nxp.com> wrote:
> In sd_set_bus_speed_mode(), sd card speed is switched to sd_bus_speed.
> However, the switch process may fail. When it happens, sd card is in
> default speed mode, which is SDR12 as described in Spec3.0.
>
> In such case, the sd_bus_speed should be updated according to status[16].

I don't think it's needed.

The card->sd_bus_speed is not reflecting the current set speed mode.
Instead it's reflecting what the highest speed mode the host and the
card together can agree upon.

Kind regards
Uffe

>
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> Reviewed-by: Fugang Duan <B38611@freescale.com>
> ---
>  drivers/mmc/core/sd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 73c762a..ac456ec 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -471,9 +471,11 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
>         if (err)
>                 return err;
>
> -       if ((status[16] & 0xF) != card->sd_bus_speed)
> +       if ((status[16] & 0xF) != card->sd_bus_speed) {
> +               card->sd_bus_speed = status[16] & 0xF;
>                 pr_warn("%s: Problem setting bus speed mode!\n",
>                         mmc_hostname(card->host));
> +       }
>         else {
>                 mmc_set_timing(card->host, timing);
>                 mmc_set_clock(card->host, card->sw_caps.uhs_max_dtr);
> --
> 1.9.1
>

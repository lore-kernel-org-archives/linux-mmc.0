From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv2] mmc: dw_mmc: add the message for deprecating supports-highspeed
Date: Wed, 12 Nov 2014 09:31:57 +0100
Message-ID: <CAPDyKFpQzxuAvZaakQ+knfJA+B7wE+Qk94wsQfPP-AOh8MqOoA@mail.gmail.com>
References: <1415771382-30831-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:60532 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbaKLIb6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Nov 2014 03:31:58 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so8450604qgd.22
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2014 00:31:58 -0800 (PST)
In-Reply-To: <1415771382-30831-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>

On 12 November 2014 06:49, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Recommend to use "mmc-cap-highspeed" or "sd-cap-highspeed" instead of
> "supports-highspeed".
> Although "supports-highspeed" supports, devloper can use
> "mmc-cap-highspeed" or "sd-cap-highspeed" through this message.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changelog V2:
>         - Fixed Checkpatch warning
>
>  drivers/mmc/host/dw_mmc.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index bb46b1b..d75dc26 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2434,8 +2434,11 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>                         return ERR_PTR(ret);
>         }
>
> -       if (of_find_property(np, "supports-highspeed", NULL))
> +       if (of_find_property(np, "supports-highspeed", NULL)) {
> +               dev_warn(dev, "supports-highspeed is deprecated. " \
> +                               "Use cap-mmc-highspeed or cap-sd-highspeed.\n");

Hi Jaehoon,

This will cause checkpatch warnings which I think we shall fix.

Kind regards
Uffe

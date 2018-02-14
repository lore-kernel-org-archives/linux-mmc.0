From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: bcm2835: Don't overwrite max frequency unconditionally
Date: Wed, 14 Feb 2018 11:38:44 +0100
Message-ID: <CAPDyKFox=mEdApLczTmpUQTuMc=AoDGevbwEauy4coAwwV1LMQ@mail.gmail.com>
References: <1518466424-30229-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:55477 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967089AbeBNKip (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Feb 2018 05:38:45 -0500
Received: by mail-it0-f65.google.com with SMTP id b66so14785155itd.5
        for <linux-mmc@vger.kernel.org>; Wed, 14 Feb 2018 02:38:45 -0800 (PST)
In-Reply-To: <1518466424-30229-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Phil Elwell <phil@raspberrypi.org>

On 12 February 2018 at 21:13, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> From: Phil Elwell <phil@raspberrypi.org>
>
> The optional DT parameter max-frequency could init the max bus frequency.
> So take care of this, before setting the max bus frequency.
>
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks, applied for fixes and by adding a stable tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/bcm2835.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 229dc18..768972a 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1265,7 +1265,8 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>         char pio_limit_string[20];
>         int ret;
>
> -       mmc->f_max = host->max_clk;
> +       if (!mmc->f_max || mmc->f_max > host->max_clk)
> +               mmc->f_max = host->max_clk;
>         mmc->f_min = host->max_clk / SDCDIV_MAX_CDIV;
>
>         mmc->max_busy_timeout = ~0 / (mmc->f_max / 1000);
> --
> 2.7.4
>

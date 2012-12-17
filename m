From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Problem with "mmc: core: Do not rescan non-removable devices"
Date: Mon, 17 Dec 2012 16:07:31 +0100
Message-ID: <CAPDyKFqVX-Rf-uWh1b-hdmGAyyrsA6gRNMSMn8pET-YNowqJbQ@mail.gmail.com>
References: <20121216163635.47537729@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:54044 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab2LQPHd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 10:07:33 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so2083590wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Dec 2012 07:07:31 -0800 (PST)
In-Reply-To: <20121216163635.47537729@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On 16 December 2012 06:36, NeilBrown <neilb@suse.de> wrote:
>
> hi,
>  the commit below causes my wifi to disappear on suspend and never
>  reappear.
>  Unfortunately the commentary says what the patch does but not why, so I
>  cannot tell if simply reverting it is correct, or if something more subtle
>  in needed.

Some more background to the patch; If the card slot is configured to
be a non-removable card and it appears that the slot does not contain
a card at boot; "mmc_rescan" should _not_ check at every
suspend/resume cycle if a card has been inserted. It will mean
unnecessary power up of the card slot and thus wast power for every
suspend/resume cycle. Moreover it should not be needed since the card
is not removable.

>
>  My wifi chip is a "libertas" driven "Marvell" chip.  It is permanently
>  attached to port 1 on an OMAP3 'hsmmc' interface.  So MMC_CAP_NONREMOVABLE
>  seem appropriate and is set.
>
>  It is normally inactive and when the suspend code notices this it doesn't
>  bother trying to suspend through the driver but just removes the core:
>                         /*
>                          * We simply "remove" the card in this case.
>                          * It will be redetected on resume.  (Calling
>                          * bus_ops->remove() with a claimed host can
>                          * deadlock.)
>                          */
>  (in mmc_suspend_host).  Only it isn't redetected on resume because
>  rescan_entered is set.

Correct, but this is how it is supposed to work.

An sdio functional driver (libertas) that handles non-removable sdio
devices, shall implement suspend|resume callbacks for the function
driver. Otherwise mmc_sdio_suspend function (drivers/mmc/core/sdio.c)
will return "-ENOSYS" and trigger the card and the card device to be
removed. That is not what you expect for non-removable device to
happen.

So, I suggest to you implement the suspend|resume callbacks in your
sdio func driver, that would do the trick I believe.

>
>  I guess we could clear rescan_entered at this point.  Would that make sense?
>  It seems to work.
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 06c42cf..65b8935 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2433,6 +2433,7 @@ int mmc_suspend_host(struct mmc_host *host)
>                         mmc_claim_host(host);
>                         mmc_detach_bus(host);
>                         mmc_power_off(host);
> +                       host->rescan_entered = 0;
>                         mmc_release_host(host);
>                         host->pm_flags = 0;
>                         err = 0;
>
>
> Thanks,
> NeilBrown
>
>
>
> From 3339d1e33185798a45dbdb5ea6c0bec1c27ca5fd Mon Sep 17 00:00:00 2001
> From: Johan Rudholm <johan.rudholm@stericsson.com>
> Date: Thu, 23 Aug 2012 13:40:55 +0200
> Subject: [PATCH] mmc: core: Do not rescan non-removable devices
>
> If MMC_CAP_NONREMOVABLE is set, only issue a detect job on init.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chris Ball <cjb@laptop.org>
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 835c9f0..af2c4d2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2053,6 +2053,11 @@ void mmc_rescan(struct work_struct *work)
>         if (host->rescan_disable)
>                 return;
>
> +       /* If there is a non-removable card registered, only scan once */
> +       if ((host->caps & MMC_CAP_NONREMOVABLE) && host->rescan_entered)
> +               return;
> +       host->rescan_entered = 1;
> +
>         mmc_bus_get(host);
>
>         /*
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f578a71..d5d9bd4 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -300,6 +300,7 @@ struct mmc_host {
>  #endif
>
>         int                     rescan_disable; /* disable card detection */
> +       int                     rescan_entered; /* used with nonremovable devices */
>
>         struct mmc_card         *card;          /* device attached to this host */
>

Kind regards
Ulf Hansson

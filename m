From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] libertas: call into generic suspend code before turning
 off power
Date: Tue, 9 Oct 2018 09:43:38 +0200
Message-ID: <CAPDyKFoo-gnjUg9Khc3EPm=cvHgyR_VNW8xgjP1Tea7wjRfvSw@mail.gmail.com>
References: <20181008200357.10819-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20181008200357.10819-1-daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 8 October 2018 at 22:03, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org> wrote:
> When powering down a SDIO connected card during suspend, make sure to call
> into the generic lbs_suspend() function before pulling the plug. This will
> make sure the card is successfully deregistered from the system to avoid
> communication to the card starving out.
>
> Fixes: 7444a8092906 ("libertas: fix suspend and resume for SDIO connected cards")
> Signed-off-by: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>

Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

BTW, if you need this to reach 4.19 I have already queued some other
mmc fixes so I can take this as well, if it helps. I need and ack of
course.

Kind regards
Uffe

> ---
> If possible, this should go in for 4.19.
>
>  drivers/net/wireless/marvell/libertas/if_sdio.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
> index 43743c26c071..39bf85d0ade0 100644
> --- a/drivers/net/wireless/marvell/libertas/if_sdio.c
> +++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
> @@ -1317,6 +1317,10 @@ static int if_sdio_suspend(struct device *dev)
>         if (priv->wol_criteria == EHS_REMOVE_WAKEUP) {
>                 dev_info(dev, "Suspend without wake params -- powering down card\n");
>                 if (priv->fw_ready) {
> +                       ret = lbs_suspend(priv);
> +                       if (ret)
> +                               return ret;
> +
>                         priv->power_up_on_resume = true;
>                         if_sdio_power_off(card);
>                 }
> --
> 2.17.1
>

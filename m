From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdio: don't reinitialize nonremovable
 powered-resumed cards
Date: Sun, 28 Nov 2010 09:42:04 +0100
Message-ID: <AANLkTiko9brvK33=GjzJgzGdmoufyNn=_mCNfUFAP-dT@mail.gmail.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
	<1290921690-6133-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64495 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab0K1ImF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2010 03:42:05 -0500
Received: by qyk12 with SMTP id 12so5086385qyk.19
        for <linux-mmc@vger.kernel.org>; Sun, 28 Nov 2010 00:42:04 -0800 (PST)
In-Reply-To: <1290921690-6133-3-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

2010/11/28 Ohad Ben-Cohen <ohad@wizery.com>:
> Upon system resume, SDIO core must reinitialize cards that were
> powered off during suspend.
>
> If the card had its power kept during suspend (and thus it
> is 'powered-resumed'), SDIO core performs only a limited reinitializi=
ng,
> mainly needed to make sure that the card wasn't removed/replaced.
>
> If a __nonremovable__ card is powered-resumed, we can safely skip the
> reinitializing phase.
>
> Note: 9b966aa removed the bus width reconfiguration since
> mmc_sdio_init_card already does it. It is brought back now in case
> mmc_sdio_init_card is skipped.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>
> I have not switched all existing code to mmc_card_is_powered_resumed(=
),
> I can do that as a subsequent clean up patch.
>
> =A0drivers/mmc/core/sdio.c =A0| =A0 16 ++++++++++++++--
> =A0include/linux/mmc/host.h | =A0 =A05 +++++
> =A02 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index efef5f9..b424fbe 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -627,15 +627,27 @@ static int mmc_sdio_suspend(struct mmc_host *ho=
st)
>
> =A0static int mmc_sdio_resume(struct mmc_host *host)
> =A0{
> - =A0 =A0 =A0 int i, err;
> + =A0 =A0 =A0 int i, err =3D 0;
>
> =A0 =A0 =A0 =A0BUG_ON(!host);
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0/* Basic card reinitialization. */
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> - =A0 =A0 =A0 err =3D mmc_sdio_init_card(host, host->ocr, host->card,
> +
> + =A0 =A0 =A0 /* No need to reinitialize powered-resumed nonremovable=
 cards */
> + =A0 =A0 =A0 if (mmc_card_is_removable(host) || !mmc_card_is_powered=
_resumed(host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_sdio_init_card(host, host->=
ocr, host->card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host=
->pm_flags & MMC_PM_KEEP_POWER));

You can use mmc_card_is_powered_resumed() here, too.

> + =A0 =A0 =A0 else if (mmc_card_is_powered_resumed(host)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We may have switched to 1-bit mode d=
uring suspend */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D sdio_enable_4bit_bus(host->card=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(host,=
 MMC_BUS_WIDTH_4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (!err && host->sdio_irqs)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_signal_sdio_irq(host);
> =A0 =A0 =A0 =A0mmc_release_host(host);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 381c77f..30b6fb9 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -317,5 +317,10 @@ static inline int mmc_card_is_removable(struct m=
mc_host *host)
> =A0 =A0 =A0 =A0return !(host->caps & MMC_CAP_NONREMOVABLE) && mmc_ass=
ume_removable;
> =A0}
>
> +static inline int mmc_card_is_powered_resumed(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 return host->pm_flags & MMC_PM_KEEP_POWER;
> +}
> +
> =A0#endif
>

Best Regards,
Micha=B3 Miros=B3aw

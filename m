From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC/PATCH RESEND] mmc: sdhci: Enable high speed support for MMC cards
Date: Mon, 30 Aug 2010 10:34:48 +0900
Message-ID: <AANLkTikswH2GdmXvRBWoeJcbrAn+JbzLTOA9fkPyV=fB@mail.gmail.com>
References: <20100827191945.GI20407@void.printf.net>
	<AANLkTinmaio2PAcnwP7+U8P4O1-T3HiLYz_ej3zGAV5Y@mail.gmail.com>
	<m362yu4sef.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39095 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab0H3Bev convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Aug 2010 21:34:51 -0400
Received: by wyb35 with SMTP id 35so6201216wyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 29 Aug 2010 18:34:50 -0700 (PDT)
In-Reply-To: <m362yu4sef.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, "George G. Davis" <gdavis@mvista.com>, Zhangfei Gao <zgao6@marvell.com>

On Sun, Aug 29, 2010 at 1:24 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Kyungmin,
>
> =A0 > It's already patched. you can find it easily at list.
>
> I think you're talking about this patch from Zhangfei:
>
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Mon, 16 Aug 2010 21:15:32 -0400
> Subject: [PATCH] sdhci: support MMC_CAP_MMC_HIGHSPEED
>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> Acked-by: Matt Fleming <matt@console-pimps.org>
> Acked-by: Kyungmin Park <kmpark@infradead.org>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7855121..913555e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1823,7 +1823,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_DO_HISPD)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | M=
MC_CAP_MMC_HIGHSPEED;
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> --

right, it's required patch and should be merged at this rc window.

>
> But this patch wasn't sent to Andrew either -- and so isn't in Linus'
> or Andrew's tree -- and it's also only one of the two hunks in George=
's
> earlier patch. =A0George also had:
>
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1180,7 +1180,8 @@ static void sdhci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_4BITBUS;
>
> - =A0 =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_SD_HS &&
> + =A0 =A0 =A0 if ((ios->timing =3D=3D MMC_TIMING_SD_HS ||
> + =A0 =A0 =A0 =A0 =A0 =A0ios->timing =3D=3D MMC_TIMING_MMC_HS) &&
> =A0 =A0 =A0 =A0 =A0 =A0!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_HISPD;
> =A0 =A0 =A0 =A0else
>
Does it need? I mean when probing the mmc card it doesn't have
MMC_TIMING_MMC_HS. so it can't trigger the this condition at my
environment.

> So, we still have to send a patch to Andrew, and decide which patch i=
t
> should be. =A0What do you think?

Anyone okay.
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

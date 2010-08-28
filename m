From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC/PATCH RESEND] mmc: sdhci: Enable high speed support for MMC cards
Date: Sat, 28 Aug 2010 14:39:59 +0900
Message-ID: <AANLkTinmaio2PAcnwP7+U8P4O1-T3HiLYz_ej3zGAV5Y@mail.gmail.com>
References: <20100827191945.GI20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64127 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab0H1FkC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Aug 2010 01:40:02 -0400
Received: by wwb28 with SMTP id 28so4456586wwb.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Aug 2010 22:40:01 -0700 (PDT)
In-Reply-To: <20100827191945.GI20407@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, "George G. Davis" <gdavis@mvista.com>

Hi Chris,

On Sat, Aug 28, 2010 at 4:19 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> This patch wasn't responded to -- any feedback from the list?
>
> From: George G. Davis <gdavis@mvista.com>
> Date: Thu, 18 Feb 2010 15:27:53 -0500
>
> Allow high speed mode for high speed capable ver 4.x MMC cards.
>
> Comments and/or feedback appreciated.
>
> Signed-off-by: George G. Davis <gdavis@mvista.com>
> [cjb: rebase patch against Linus]
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A07 +++++--
> =A01 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fdc9233..8e360e1 100644
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
> @@ -1823,8 +1824,10 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> - =A0 =A0 =A0 if (caps & SDHCI_CAN_DO_HISPD)
> + =A0 =A0 =A0 if (caps & SDHCI_CAN_DO_HISPD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED;
> + =A0 =A0}
It's already patched. you can find it easily at list.

Thank you,
Kyungmin Park
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> --
> 1.7.0.1
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

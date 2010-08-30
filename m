From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 2/2] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case
Date: Mon, 30 Aug 2010 10:06:30 +0900
Message-ID: <AANLkTi==jmKYt+X=mP+AfHbkR3_ZVy=Ha_46WURv3Q-Q@mail.gmail.com>
References: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
	<7e892c443f11d51a30029ddfeef27af09a9a970d.1283003070.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34115 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0H3BHA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Aug 2010 21:07:00 -0400
Received: by wyb35 with SMTP id 35so6181379wyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 29 Aug 2010 18:06:59 -0700 (PDT)
In-Reply-To: <7e892c443f11d51a30029ddfeef27af09a9a970d.1283003070.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

On Sat, Aug 28, 2010 at 10:53 PM, Matt Fleming <matt@console-pimps.org>=
 wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> If controller use SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk,
> controller need always polling detect
>
> In this case, always generated interrupt.Because controller checked c=
ard status.
> I think that is not efficiently.
>
> But if card is nonremovable, we need not always polling.
> So i added the check-point which is nonremovable or not
>
> =A0Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f6be963..3111859 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1827,8 +1827,9 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_DO_HISPD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | =
MMC_CAP_MMC_HIGHSPEED;
>
> - =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> + =A0 =A0 =A0 if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) =
&&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !mmc_card_is_removable(mmc))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_=
NEEDS_POLL;
>
> =A0 =A0 =A0 =A0mmc->ocr_avail =3D 0;
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_VDD_330)
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

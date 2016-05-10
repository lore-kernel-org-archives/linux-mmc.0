From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra30
Date: Tue, 10 May 2016 09:09:53 +0200
Message-ID: <1462864193.13327.2.camel@lynxeye.de>
References: <1462806903-13860-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462806903-13860-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Jon,

Am Montag, den 09.05.2016, 16:15 +0100 schrieb Jon Hunter:
> Support for SD cards is not working on the Tegra30 Beaver board and
> on
> boot the following error message is seen if an SD card is present:
>=20
> =C2=A0mmc0: error -110 whilst initialising SD card
>=20
Can you please tell me what kind of SD card you used and at which point
in the initialization it is hanging? I've tested this change on Beaver
and haven't seen any failures after I implemented the memcomppad
calibration.

> In addition to this, Tegra30 is also randomly hanging during system
> suspend when entering and is caused by the Tegra SDHCI driver.=20

I'll have a look at this soonish.

> Similar
> issues have been seen on the Tegra124 Jetson TK1 and are linked to
> the
> UHS-I tuning sequence. Disabling the UHS-I modes for Tegra30 fixes SD
> card support and prevents any hangs from occurring when entering
> system
> suspend. Therefore, disable the UHS-I modes for Tegra30 for now until
> we can correct the tuning sequence for Tegra.
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> =C2=A0drivers/mmc/host/sdhci-tegra.c | 4 ----
> =C2=A01 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-
> tegra.c
> index bcc0de47fe7e..24c33aee8e7c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -347,10 +347,6 @@ static const struct sdhci_pltfm_data
> sdhci_tegra30_pdata =3D {
> =C2=A0
> =C2=A0static const struct sdhci_tegra_soc_data soc_data_tegra30 =3D {
> =C2=A0	.pdata =3D &sdhci_tegra30_pdata,
> -	.nvquirks =3D NVQUIRK_ENABLE_SDHCI_SPEC_300 |
> -		=C2=A0=C2=A0=C2=A0=C2=A0NVQUIRK_ENABLE_SDR50 |
> -		=C2=A0=C2=A0=C2=A0=C2=A0NVQUIRK_ENABLE_SDR104 |
> -		=C2=A0=C2=A0=C2=A0=C2=A0NVQUIRK_HAS_PADCALIB,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct sdhci_ops tegra114_sdhci_ops =3D {

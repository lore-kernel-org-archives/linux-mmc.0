From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [RFC 1/2] sdhci : recompute timeout_clk when needed
Date: Thu, 10 Jul 2014 10:03:20 +0200
Message-ID: <20140710100320.77697cfe@parrot.com>
References: <1404979264-8070-1-git-send-email-matthieu.castet@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:25937 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbaGJIIn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jul 2014 04:08:43 -0400
In-Reply-To: <1404979264-8070-1-git-send-email-matthieu.castet@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>

Please ignore this mail, it is a mistake (it was already sent).

Sorry for the noise.

Le Thu, 10 Jul 2014 10:01:03 +0200,
Matthieu CASTET <matthieu.castet@parrot.com> a =E9crit :

> when SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set, timeout_clk is sdclk=
=2E
> We need to update it when we change sdclk in sdhci_set_clock.
> This allow to have a more precisse timeout and max_busy_timeout. This
> can help for command that need a big busy wait (erase, ...).
>=20
> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
> ---
>  drivers/mmc/host/sdhci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9df59a4..76b1aab 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1192,8 +1192,13 @@ void sdhci_set_clock(struct sdhci_host *host, =
unsigned int clock)
>  	}
> =20
>  clock_set:
> -	if (real_div)
> +	if (real_div) {
>  		host->mmc->actual_clock =3D (host->max_clk * clk_mul) / real_div;
> +		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
> +			host->timeout_clk =3D host->mmc->actual_clock / 1000;
> +			host->mmc->max_busy_timeout =3D (1 << 27) / host->timeout_clk;
> +		}
> +	}
> =20
>  	clk |=3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>  	clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)


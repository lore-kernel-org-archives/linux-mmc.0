From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/29] mmc: sh_mmcif: add regulator support
Date: Thu, 3 May 2012 16:45:32 +0100
Message-ID: <20120503154532.GP3955@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-9-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bd2KlmcTHfsQFEJ+"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336057558-11031-9-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--Bd2KlmcTHfsQFEJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 05:05:37PM +0200, Guennadi Liakhovetski wrote:

> +#include <linux/regulator/consumer.h>

Where's this used?

> +static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
> +{
> +	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
> +
> +	if (!(host->mmc->caps & MMC_CAP_POWER_OFF_CARD))
> +		return;

Surely the core should be implementing this?

--Bd2KlmcTHfsQFEJ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoqgUAAoJEBus8iNuMP3dcNEP/jCt4hWKKgIuuTQTjTH9kvWM
4LJRA134rc+XrBzCcOlJL+L1KmPfQ9Fx4tyOh5GBbljx7bw+QCUaojYLFB1Tqybf
U2p2/VFdViW3WNcPK2zdlRGsjTRNErBfAKKJ0CY8u4FRMAv9Dci3B/taCgZPJY9j
ru7DCLHD5G8MzHJbZ8PNKss+XhxVQyjcNXC8b04/LegijR9kXuqtA2oMPm0wxaT+
c25N77Mz/sX96e7ArT0Iqep4h7bsDQdBdTmJgt2AwycQmS8Oncu66ftM15hqHPJr
5MjxidoZqXLZHUoeJCMGyZNEbLFFRTgL9R96Bkte/FAAWIVropLCVU+VzmPRldLN
IP6ELFBit1xsUUuBoDwGDXud2pV8zIiO6ucUQVxuiaWCMyRiTViaGDkuQXkb8J+P
+xWRX7+pKWf0EKnzw2v4/UnQdi2WwJglj/9FPn78AR7xA8XwhfY5oEUX/FZyGdmG
nh3XnKA2MK970aPuZ4rg5EMpt0LWQBPDOqDe/fptnQz3X8A3o17nQBdtXs752zCp
oszl5fP7Eef4+x+/dBRH3UYzRW5nlHUX3B1yaRItDcYipMQOeHZvQOoFMRxSQVKo
Lg3RjEUybmiZHPbKY1ZCFDyY9V+HlEpKv/B/2cBGZrMbtC3tTZg5C/LoStYkbpii
N0MRJb9ciUmDD0PkbEXX
=hzkc
-----END PGP SIGNATURE-----

--Bd2KlmcTHfsQFEJ+--

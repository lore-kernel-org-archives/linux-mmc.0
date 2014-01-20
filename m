From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 20 Jan 2014 16:36:27 +0000
Message-ID: <20140120163627.GT17314@sirena.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xt4oM5y0t/70YhQj"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57205 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbaATQgo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2014 11:36:44 -0500
Content-Disposition: inline
In-Reply-To: <1390190215-22700-2-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-mmc@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, chris@printf.net, robh+dt@kernel.org, ijc+devicetree@hellion.org.ok, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org


--xt4oM5y0t/70YhQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2014 at 07:56:53PM -0800, Olof Johansson wrote:

> +	if (host->card_regulator) {

NULL is a potentially valid regulator; use IS_ERR().  Also see below...

> +		dev_dbg(host->parent, "Enabling external regulator");
> +		if (regulator_enable(host->card_regulator))
> +			dev_err(host->parent, "Failed to enable external regulator");

You should really log the error code here.

> +	host->card_regulator = regulator_get(host->parent, "card-external-vcc");
> +

...this won't handle probe deferral or other errors.  Given what this is
for it should probably be using regulator_get_optional(), the driver is
happy to carry on if a supply isn't available.  On the other hand it
just enables and disables so it's probably easier to just ignore that
and let the stub regulator get used anyway.

I have to say I do worry what happens if the device has multiple
supplies that need to be managed (which is common enough, for example
analogue and digital supplies tend to be decoupled) or if the device can
do useful things with the supplies.  In the case of SDIO it's *probably*
less relevant though I have seen applications where it might be.

--xt4oM5y0t/70YhQj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3VCIAAoJELSic+t+oim9hAcQAI6jHQjZbpCVKAuy5QCEgfQO
qalfUkwCgNERZgm8KhmL3HjyY6/5Qi2bj21gC/qqWWT3KwSvct+HC+WflxpdO+/F
p5y0UeJciAS6XF5sUPaTgpXkcl3w/NOvJClaOJputDUDF3og2IAa9cGnXcwvNp8X
5zg40avldTr1lsdYw5GZPyUov+3F+Vkv9aJpmXnQF5liP1RlIMthdP1ai/CpO7y7
ELLbS5KVGN7mqzZpSTkEp0K8LkZbATQ51g9Zb1bQni5CrjqSSyApvQTvQ1B0jDjV
DVJTb8lxUFWwTHXw3yd+LYpdx0NcnoRV4dAdcEs3r4ktHg8rfcq8rEAFCsK23sg8
Mgq12bnW75f/jJy/a1QnFD56+u7dveu80kIfnu/+XZ3Mz93ZcOQ7dmczOe47uSDX
1hm33vnulJbelWFZMDwsPlaG7QxQF33ccOoGSlZtyAd8vOnk0PPGWhMC8R6NeGEm
P1BiqMb2I/JpYC6Me/MkxG61mOQCRV/LW8fNKDFn3L3DSsZ6nWRZoMOwirqNU5+M
fW5YYBJD71JWHc1a2VQUpOgAoMasBGme2eYNW7p7WP+Nz7iyR5xbpQ9IaEBDlT9k
P1GkUYTOLNLsDeFoUYjZJruxOQDfS8jGGHLxO22h4BMKxeRCbiuXpZs8GR9y0nk3
ayYJ4u+LmhV6oyHy5pCV
=fX3X
-----END PGP SIGNATURE-----

--xt4oM5y0t/70YhQj--

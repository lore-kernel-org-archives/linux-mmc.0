From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/5] mmc: tmio: improve checkpatch cleanness
Date: Tue, 30 May 2017 21:58:52 +0200
Message-ID: <20170530195852.7r63hmfbbrwae6kt@ninjato>
References: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
 <1496148654-20386-5-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eacvl5txvugptbn6"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496148654-20386-5-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--eacvl5txvugptbn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 02:50:53PM +0200, Simon Horman wrote:
> Trivial updates to improve checkpatch cleanness.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Wow, all of them! When I reviewed your DMA refactoring patches, I meant
to fix only the whitespace issues which were affecting your patches. But
okay, it is a good timing to fix all of those, because of the said DMA
refactoring work, the BSP patches won't fit anymore anyhow, so upporting
them will not become significantly harder.

And while I don't agree with all of checkpatch suggestions, this patch
increases code readability for sure. I guess, what I am saying is:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

and

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I moved big files around two SD cards attached simultaneously to two
card slots on my Renesas Lager (H2).

> -	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio=
) {
> +	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) &&
> +	    !host->force_pio) {
>  		u32 status =3D sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
>  		bool done =3D false;

Let me give just one example where I think the 80 char limit doesn't
help readability. But no need to fix IMO; as I said, most of the stuff
is really helpful.


--eacvl5txvugptbn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlktzvwACgkQFA3kzBSg
KbYz0Q/+O8QXloD++knphFYhtUyTrVcwtUWK5qAGEkN9utbkuiCH8fIZrVg7ykhI
dZWnGCpbJBAErSeAeG8bfmXXFAaObf3YlDkrAxabbv3IlUpyz46MfnpawTAiVZ5J
VDxZli0ZeCrxMR5fSWxoKvErBkxB9rlQ/qeicr8UR2tV8mz5yVv1V2dJRlXHmegC
o046o6HqgBXlR0eExXjCtRn8wkw4nXG+MWAIhU3wO6n28lBfu26zNBiA6acAg5mi
o8cVg+WlnEzPesCsqhmXcRjCaYhd6FRu1wnjo1GTLFxZG3UMiC64J36tBZrTPHmf
JspDB6+Q1MRSRe65coCFgRAxvgMy8cyOe0qD4Sn2JLtnNECKj/TxKl1EISdHgSj3
qIlMd1mBvO8VS4a1yte6FAknU22NsKCDhlGG92/x78E33Y/rnY9qVxUHodmL8eiY
DQdoFdWeZu/wF1+NDJI2hZ3y/l8k9MpBYFLkp1ex2Zd4klSwLtdbiAMtzLUWEjnp
jWWc5Z9XIWeYFubc5Pr/0D5lLqUEZlr+/JMopDJVJL/+WGf6im8SpQu4NIOT1hIc
AiOaA/otq8IFUY0Eyrm8pTG0eUbO9icgHUfoEyjonhtuD/6AjdfH6KdINze+jEnK
fKAZMRTRJfNRLOMGW9gTRNmUDNPRh0sk6LV04CWitF79yl6urgc=
=REnM
-----END PGP SIGNATURE-----

--eacvl5txvugptbn6--

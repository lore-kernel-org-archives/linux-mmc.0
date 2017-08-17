From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Thu, 17 Aug 2017 12:40:47 +0200
Message-ID: <20170817104047.ikfljcrggl2ncxqv@ninjato>
References: <1502845901-163345-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ax6xbvyjqsnsmr6z"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59375 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbdHQKkt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Aug 2017 06:40:49 -0400
Content-Disposition: inline
In-Reply-To: <1502845901-163345-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--ax6xbvyjqsnsmr6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Wed, Aug 16, 2017 at 09:11:41AM +0800, Shawn Lin wrote:
> We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
> mode as it is expected behaviour and most of the backup partition
> tables should be located near some of the last blocks which will
> always make open-ending read exceed the capacity of cards.
>=20
> Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop c=
md into account")
> Fixes: a04e6bae9e6f ("mmc: core: check also R1 response for stop commands=
")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>=20
> Tested-by: Shawn Guo <shawnguo@kernel.org>
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

I'd think these Tested-by should be dropped. We changed the patch quite
a bit meanwhile and I am quite sure Shimoda-san didn't test this new
version of the patch. Dunno about Shawn. Hopefully they have time to
re-test?

> +	/*
> +	 * Per the SD specification(physical layer version 4.10)[1],
> +	 * section 4.3.3, it explicitly states that "When the last
> +	 * block of user area is read using CMD18, the host should
> +	 * ignore OUT_OF_RANGE error that may occur even the sequence
> +	 * is correct". And JESD84-B51 for eMMC also has a similar
> +	 * statement on section 6.8.3.
> +	 *
> +	 * Multiple block read/write could be done by either predefined
> +	 * method, namely CMD23, or open-ending mode.
> +	 *

Very minor nit: I'd remove this empty line and merge the two paragraphs.

> +	 * For open-ending mode, we should ignore the OUT_OF_RANGE
> +	 * error as it's normal behaviour.
> +	 *
> +	 * However the spec[1] doesn't tell us whether we should also
> +	 * ignore that for predefined method. But per the spec[1], section
> +	 * 4.15 Set Block Count Command, it says"If illegal block count
> +	 * is set, out of range error will be indicated during read/write
> +	 * operation (For example, data transfer is stopped at user area
> +	 * boundary)." In another word, we could expect a out of range error
> +	 * in the response for the following CMD18/25. And if argument of
> +	 * CMD23 + the argument of CMD18/25 exceed the max number of blocks,
> +	 * we could also expect to get a -ETIMEDOUT or any error number from
> +	 * the host drivers due to missing data response(for write)/data(for
> +	 * read), as the cards will stop the data transfer by itself per the
> +	 * spec. So we only need to check R1_OUT_OF_RANGE for open-ending mode.
> +	 */

Very good! I like this a lot.

Also minor nit, but likely better readable:

> +
> +	if (!brq->stop.error) {
		bool OOR_with_open_end;

> +		/* If there is no error yet, check R1 response */
> +		val =3D brq->stop.resp[0] & CMD_ERRORS;

		OOR_with_open_end =3D val & R1_OUT_OF_RANGE && !brq->mrq.sbc;

		if (val && !OOR_with_open_end)
> +			brq->stop.error =3D -EIO;

=2E..

> +	if (brq->sbc.error || brq->cmd.error ||
> +	    brq->stop.error || brq->data.error) {

I am not super strict with the 80 char limit and think one line is
better readable, but I leave that to you and/or Ulf.

Other than that minor stuff:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for this collaboration! I liked it :)

Regards,

   Wolfram


--ax6xbvyjqsnsmr6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVcqsACgkQFA3kzBSg
KbZU8A//Zim/wGEvpjSkLV7s+vRnrniu0thDLPOZkCQbecUhA2flj7iSKN42dwFt
LAxohzAuFmj1QnKulKv4JF43lskHYQSwX4n76ewZqDc1TCkvKJO6CL9t1T0sTQNE
8PrsxEz6LfDGAcvaqsfamzEnOtvCr1PZKvKnCFKbsaAE4Z/XSFK5WJDr10KqruGV
vlvwUV0wOoKgA0puYq/t2yGpplnJ0YNg9jtt1HfYl5+Sy+eSId5mpHki8vxN2O/q
kP91cc2Pu84Ku5n8twhTH8hcMrg8Dai0WC9cqg0TQFxLvxxIttQjG0lyLLXD6WYv
G6/xtN6btapHQtO4eBcAvdclEmL6sFn7WRh85Mgixd/GFl5sz/eYl232gJW5/bbC
p8DDoIynwKTEFtoPXXgd0aXRi19dklU6KAn2kxjbsi981CFmO1kpSMVN6NHBDG8G
1GyIeyCg+O84TExca+891sdG/1vNfyp7hTdsAzJEDyhx3vIWAHl7AZ5B+0ZbeEG0
E3EDgwIQrfwGUYInU+bGSdB0Tcdd4uxwsh5S/N4HK0hDWIftkCwnsP4MUcXqtc7l
/6MKgBeHZqbyY41QTumFvfnDXhXLsp3wY4OFU3INhaCyoCf6ST+E4qXv9IVth8U3
7QtRV6tPfvAy8ZJ4p0TUWkMzZZwKg8lRH7BpEeg2++EKswkQsx8=
=SNEa
-----END PGP SIGNATURE-----

--ax6xbvyjqsnsmr6z--

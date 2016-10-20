From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Thu, 20 Oct 2016 15:28:53 +0200
Message-ID: <20161020132852.GB4177@katana>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58459 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933643AbcJTN3D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Oct 2016 09:29:03 -0400
Content-Disposition: inline
In-Reply-To: <20160912141507.6837-3-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2016 at 10:15:06AM -0400, Chris Brandt wrote:
> For the r7s72100 SOC, the DATA_PORT register was changed to 32-bits wide.
> Therefore a new flag has been created that will allow 32-bit reads/writes
> to the DATA_PORT register instead of 16-bit (because 16-bits accesses are
> not supported).
>=20
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v3:
> * changed loops to memcpy
> v2:
> * changed 'data * 0xFF' to 'data & 0xFF'
> * added 'const' for sd_ctrl_write32_rep

Sadly, I don't have SDHI documentation for this SoC.

* Does it have a version register (CTL_VERSION)? If so, what does it
  say?
* Does it have SD_BUF0 width setting (named either EXT_ACC or HOST_MODE,
  so far always comes after the version register)? If so, what is its
  layout?

Unrelated to this patch but nice to know:

* Does it support DMA? Is it compatible to the current implementation?

That being asked, R-Car SoCs can have SDBUF0 32-bit wide as well (Gen3
even 64-bit). So far, this is only used for DMA, though.

Thanks,

   Wolfram

> +		/* if count was multiple of 4 */
> +		if (!(count & 0x3))
> +			return;
> +		buf8 =3D (u8 *)(buf + (count >> 2));
> +		count %=3D 4;

To skip the same operation done on 'count' twice, maybe?

		buf8 =3D (u8 *)(buf + (count >> 2));
		count &=3D 3;

		if (!count)
			return;


--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYCMaUAAoJEBQN5MwUoCm2UIQQAKtuj+1jHRcqKFXAeALkK0U+
tXKUVAVOAfPT0/HaxcR7LeR1UxRnHCcdEZxjZArLrN9MGraUH7+XSsG7efbDDunN
xZYlkdeXJ3lsfV7XVPkhI+cajC7lrfNUOfqo6pO4EqOdmYQEd6wRD+2ITVwcUB1u
Wif/GPSl4wld2e5Rh3XbLm1JlDRZHOMVF+CxbactqenV+1vbQbLaft6WR7jiFZ/u
IWvrPE5Mif7U+hsI1/HJ/3lZXk6QXgrpPGOdAh4rrkmaJg9BdLAS27spYGXHUPxF
sG82ByXm88jzCYcW6EJP968xo/vOacWljmKVbZhqo3bjDTySHJoCmGzEdJrqcCKQ
3v9FbQdZCYdpmUkSh2QZLeaXTjqy5v3fHUEaWWqSuaYIM0H/cmYi15GSC9quB2+X
ruzF63xRrt9fEelBzbB1gzbcskRNIRo+9Os+H82kUCN9lFBYdGWj4FoNBJsH58NX
Wf55aRmps1+siXHyso1LPPJWxTGVli5NUiG/MIgr3OpJwJLpK8dKuVegxPX05Ebj
oOSvafyrdbGMhO0Bv7xnc6aYygqITAF0ltqI6UFu6THnmTuYblUWskfALvVMrGwu
Sni7LOXGztn4sS1+R7JFr3Q8lQq5TIHbnTCwgWOO/ONZufZpEyX1mdiEMahzUu+A
LHR28X99oh5XDKHe+n53
=EK4X
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

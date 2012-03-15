From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND 4/8] mmc: omap: context save after enabling
 runtime pm
Date: Thu, 15 Mar 2012 16:59:14 +0200
Message-ID: <20120315145912.GS28447@arwen.pp.htv.fi>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
 <1331822022-26714-5-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E1BPhOSoTthPQdPL"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:41945 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965121Ab2COO7Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Mar 2012 10:59:25 -0400
Received: by mail-lpp01m010-f41.google.com with SMTP id z14so3446605lag.14
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 07:59:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331822022-26714-5-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, balbi@ti.com


--E1BPhOSoTthPQdPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 08:03:38PM +0530, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
>=20
> call context save api after enabling runtime pm
> to make sure register access in context save api happens with clk enabled.
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>

Cc stable ?

--=20
balbi

--E1BPhOSoTthPQdPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYgPAAAoJEIaOsuA1yqRETEkP/ir33xo8BcNgGkp7u5d4/3nG
cPRssYCEcCKaQPh1h2XzjBQk4g6JYBy5pVOk0CLDyuUI6JEv7oPBDdXhYEjXS8/z
f3MDayv/7uAhPe/FwEFbq9BuV/qMchbeXDI8j0MOZCkqYINFYC2xawGPwl2wyW5s
Fak9iaskPEZSF1XeOg/K4q0L7rnr2V1vGvYOVoVs6bySy2vci+ffB1vMISFaKYh+
bMoQN3e7y9fLTAo3GNWDA00cJNqNpP6v8/pzEt+v8IfLMgihv9BtDhGpfYQ6okdl
/sJsltpS/fsuML706AjWkruLq363+1ZfuIKbBnPZVS+0z2ShzdWiP+jE5kPetyMx
e0FL//LkUcqUHOahsUFC6y9xbM6Pzg3YlHfjh2BjqLlojEUTygSx4g6NHOk+tKMp
4rP3DrrzP5arjNA1fBjSCGMMGElIF3tFOD85gbkb88T5jhqS+34F7HyRZYeCOoRU
r4uwkw4rcwzxiIWyRzMxEZLm8GfSiPzTIIhxkp11CPGXnTBhacG1tYHxx8/X7iqF
Jskvdg06HvlpvSvqRiL/3GI7xIrpHUAhGifKJ66f9IXNH4rNLI4EPGdw0UO0Z8Q/
Kuhvn35q3UmRKuLGN7rAHkyxvqpUm3Fj1Y8zwTy7X3IpdK8+Eeb94WR9GKTxkHF3
Ih6FGHaLziATeJT2xPZv
=p43e
-----END PGP SIGNATURE-----

--E1BPhOSoTthPQdPL--

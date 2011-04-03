From: Sascha Silbe <sascha-ml-reply-to-2011-2@silbe.org>
Subject: Re: [PATCH v4 2/3]mmc: enable TRIM/ERASE caps for SDHCI host
Date: Sun, 03 Apr 2011 11:41:41 +0200
Message-ID: <1301823199-sup-1704@twin.sascha.silbe.org>
References: <20110212062220.GC25519@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-1301823731-978476-32191-9345-4-="; protocol="application/pgp-signature"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20110212062220.GC25519@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, cjb <cjb@laptop.org>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, adrian.hunter@flatty.sascha.silbe.org, adrian.hunter@nokia.com
List-Id: linux-mmc@vger.kernel.org


--=-1301823731-978476-32191-9345-4-=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Excerpts from Chuanxiao Dong's message of Sat Feb 12 07:22:20 +0100 2011:=

> SDHCI host controller has TRIM/ERASE capability, enable these caps for =
erasing
> purpose.
> =

> ERASE command needs R1B response. So for such command with busy signal,=
 before
> sending command, SDHCI host driver will simply set a maximum value for =
timeout
> control register which is safe to use.
> =

> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Tested-By: Sascha Silbe <sascha-pgp@silbe.org>

Tested on an OLPC XO-1 using a SanDisk 4GB class 4 card (retail). The
BLKDISCARD ioctl (range 0..card size) returned immediately, no timeout
issue encountered.

Sascha

-- =

http://sascha.silbe.org/
http://www.infra-silbe.de/

--=-1301823731-978476-32191-9345-4-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.0-git7d24ffa (GNU/Linux)

iQEcBAEBCgAGBQJNmEDWAAoJELpz82VMF3DaTFQIAI2UGYeSRoU0ij4tYcL0RFl3
mg5XShD730DNdNfA1AUTNy1tcEmToQ3v8ngF2wUCOuahTOBw2OnwNBw4fLVGi6cF
x62A4Y05Uqx2lVTzQcCD2icCvQdUa4zm4gLA7jRkRl/LXbNiNEvrMoOxu+VYrh/S
LYL/V1fKC0L6F3+XB+OVA9wu2AQfHaPolAboLFYhGK0Ugsf+qqesVL9i18yCbZvr
iGnQPpaJlacSJoyeBXpDPs8vIXN7AEi3za20F1dK1if+2ncIqoG02YdgqR4YsOSb
/YykP5SXwt3yBMs6HFUVq6jRpfMA0IH7V/UcRBOD04yseGOgza9VIk9ZY+uUrG4=
=5yzw
-----END PGP SIGNATURE-----

--=-1301823731-978476-32191-9345-4-=--

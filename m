From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [PATCH] sdio: pass unknown cis tuples to sdio drivers
Date: Fri, 11 Sep 2009 08:28:34 +0000 (GMT)
Message-ID: <759014.23228.qm@web28308.mail.ukl.yahoo.com>
References: <20090911010102.4c7840b0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web28308.mail.ukl.yahoo.com ([87.248.110.127]:26280 "HELO
	web28308.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750704AbZIKI2c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Sep 2009 04:28:32 -0400
In-Reply-To: <20090911010102.4c7840b0.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, bcm43xx-dev@lists.berlios.de, linux-wireless@vger.kernel.org

--- El vie, 11/9/09, Andrew Morton <akpm@linux-foundation.org> escribi=F3=
:
> > >=20
> > > ret =3D=3D -EINVAL
> > >=20
> >=20
> > At this point ret is not -EINVAL.
>=20
> Yes it is.=A0 We just did
>=20
> =A0=A0=A0 ret =3D -EINVAL;
>=20
>=20
> If that assignment happens, we leak `this'.
>=20

Hi Andrew,

I misunderstood you. I thought that you were trying to imply on your or=
iginal comment that retval was _already_ -EINVAL at that point.

Now I see the issue. `this' should be freed if successfully parsed (!re=
t) or if invalid and not going to be passed to a SDIO driver (ret =3D=3D=
 -EINVAL).

Thanks for catching that. I'll send an updated patch.

Cheers,
Albert



     =20

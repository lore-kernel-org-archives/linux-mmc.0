From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [RFC][PATCH v2] mmc_block: Allow more than 8 partitions per card
Date: Thu, 22 Oct 2015 19:07:41 +0100
Message-ID: <1445537261.10397.70.camel@decadent.org.uk>
References: <1445533241-10292-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-xWNe0AdmqiIIQIp6950C"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51168 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965425AbbJVSIA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2015 14:08:00 -0400
In-Reply-To: <1445533241-10292-1-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, Colin Cross <ccross@android.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Android Kernel Team <kernel-team@android.com>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


--=-xWNe0AdmqiIIQIp6950C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2015-10-22 at 10:00 -0700, John Stultz wrote:
> From: Colin Cross <ccross@android.com>
>=20
> It is quite common for Android devices to utilize more
> then 8 partitions on internal eMMC storage.
>=20
> The vanilla kernel can support this via
> CONFIG_MMC_BLOCK_MINORS, however that solution caps the
> system to 256 minors total, which limits the number of
> mmc cards the system can support.
[...]

This commit was intended to allow support for 256 cards with any number
of partitions:

commit a26eba614afff0e39594101bcb73014a9a22fb33
Author: Ben Hutchings <ben@decadent.org.uk>
Date:=C2=A0=C2=A0=C2=A0Thu Nov 6 03:35:09 2014 +0000

=C2=A0=C2=A0=C2=A0=C2=A0mmc: block: Increase max_devices

I don't think the new patch is sufficient or necessary to increase the
limit further.

Do you have a compatibility requirement to retain the numbering of the
first 7 partitions?

Ben.

--=20
Ben Hutchings
Q.  Which is the greater problem in the world today, ignorance or apathy?
A.  I don't know and I couldn't care less.

--=-xWNe0AdmqiIIQIp6950C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVikl7ee/yOyVhhEJAQrmEA//cVc4bOu0NoUolSx4TSN/XouTiZC2gZt1
4anSiNOvGHUIdW8vf3N9ofTbiN1Wd1yp5EngR89cpxRSkbaSX2LCtdQWEebBu0Hd
efvRQ0Pqn7unTXZ+MmfUKMb6xJ8fH1Vc74VNClVnGmwS+e2qtqhYlltN8YG9YUG9
ntlunPXupops453YYQV94QkfpyTk9rheGPUwRROC4+3+Xe822HBakoKrKReR5DFB
EVPQmjNQo5t4SyuDYjieFtMVOTlRMDe/KJDj+8Ieqgjz7r2+VUaItoHPiJUVcDb0
2pJJmVlqMxSGXOE08WD+4Lou3gdF/c1+fBYVT+5EGgreFU/Jf1oM26ZDD/fquhZk
yxC/PJOpL55iLqB0fzKu10728MB5OkZaVrMLI8NreIKO9qtCl/7gOuT7IhV7vbZH
g9X3id2lOobDSTtXJi+byKNHn1BJRdPTLdfwjGProblBrORoxAQq4SMnTXPmQ0rx
H+mCNfl6PqGRmuvwRvTsLuA3Amn1Dv81mo68NPab4Kqp8i8nbIYjJtUdV5xLq0MH
Uwha7RIbmFKoQ+S8xL3FEPVQxcBkqWgcqPVyH7AzQJzWQ5R3/9cBrc0o/tKKIc42
RfazZ+yYibfsEu/5DpGcrcv99jFB2km6qkT6fkG+50jguxC86X56tfv9TGKtHYbS
I4/oCuv+a+s=
=f28p
-----END PGP SIGNATURE-----

--=-xWNe0AdmqiIIQIp6950C--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] mmc: sh_mobile_sdhi: remove obsolete irq_by_name
 registration
Date: Thu, 28 Apr 2016 08:19:35 +0200
Message-ID: <20160428061935.GA1613@katana>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
 <1459934734-3613-3-git-send-email-wsa@the-dreams.de>
 <CAPDyKFqixO2EGxdx4ERy=DSTR+KBunrYyfR26+AYN0k5_dVHiw@mail.gmail.com>
 <20160419093713.GC1521@katana>
 <20160427225457.GV21636@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160427225457.GV21636@brightrain.aerifal.cx>
Sender: linux-sh-owner@vger.kernel.org
To: Rich Felker <dalias@libc.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I don't have any of the affected boards to test, but as long as
> they're not actually using the include file you're removing, I don't
> see any harm. It's my intent to remove all of these board files full
> of platform devices as soon as we get working device tree bindings for
> everything, anyway. So,
>=20
> Acked-by: Rich Felker <dalias@libc.org>

Thanks! Ulf already applied a version with the SH specific bits factored
out. I'll send out a seperate patch for this right now. To make things
easier for all, I assume your acks will extend to this new patch as well.

Thanks again...


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXIat3AAoJEBQN5MwUoCm209YP/3Ax2ueLgbhybn6pYhjCYfuO
qx8xYVvIbhrWNlKCxMqrTvWqLpo+3/w0+vpNQHIr9EwENrSUCaZVpXk5B49oShl5
79QHGwpKi9ZsdQwcsLqat9ueIDJDuIKP33hBzN4kl6ztFXJN0hhHEjkcjVm9CSC+
Of2yrTG25ciBNEuq4fAjfaJnVBQgrqXqsZaUMzPzYUaxmNYBp3f3ycfc796w+Jbr
kuuIVbZxxoBmS5xulJVBQo2B5fxF9/Kl12pKHjCcIOjGlMCdUmd7cEfmoCai6Vfn
/9TKACSUEQRPDcHbF/vj35QNBlDWtb4PNniOZ8Uy4U9c9ZwAaOz2rZiJPJZCEV+J
tnG6LxPTWhf10dsq8/KIgsBk6IwHM7T7Ey7ZjnF/7kO1G8VlvZFml8iXUPfsPaua
cb+eGN9AMBwrp8yaiQszM8gWWByDnl3hvzCTOuGapds0ZNPEfmNQerSwggZoKSvE
vcMDEz6XfRq/6TjIesZAZlWVmJ9BvTk9oUV1iVG3PTBksAJvkwI63g5xaHQiq3sV
80CHt+5EwltlztUXVehbpCapAXzk66ka8llqvhMxS26rwur5y4KjzRcaYGMRtTG4
wuJldtqxFz12eTlFjVCXqTNNAXGGystNsl8z4M+MkzOO9MmCz4C2/WyDceGFjuQb
JY7uJXL37Nl7fk0i6wAH
=G8F9
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 1/7] pinctrl: sh-pfc: r8a7790: Implement voltage switching
 for SDHI
Date: Tue, 1 Mar 2016 14:42:44 +0100
Message-ID: <20160301134244.GA1514@katana>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
 <1455913003-6140-2-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXQWfYGRAuA-o+baN2dWnx-G1fOtRTU8xApZTxc5h_Sbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXQWfYGRAuA-o+baN2dWnx-G1fOtRTU8xApZTxc5h_Sbg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <ulrich.hecht@gmail.com>
List-Id: linux-mmc@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> ... and use "pfc->windows->virt + IOCTRL6" here and in
> r8a7790_set_io_voltage(), cfr. r8a7778_pinmux_get_bias().

This would mean I need to do something like this for unlocking:

	iowrite32(~data, pfc->windows->virt); /* unlock reg */

I hope this is okay, too.

Note: The new fast SDXC card I got produces timeouts. I want to
investigate first before resending this series.


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1ZxTAAoJEBQN5MwUoCm2mXQP/ApwcpmKMx8Dp63JBFHMMDja
+mpSWDf/iY8ze7yOAGXcSsnRPPt75hverq9FDKFqWKmDAhUqnGpBbfoXPi4UKjmZ
izPMRMuS8RKIqssylca3B4JeBob3nafJKWqmpSKc3PkvkKPYZ6A9PtAtwsbz/Z7S
5gu3u9HpwoAVYwr8h7/8LytzJ37oXQnmPrPtiQsBHwvx0PFV+WGjBw1q+g6l1KD3
fewF9JWcDvzOhcc0SaQUHPESuJ1vPMD8ISmT2ZkEELhg4cH3rW6KqVs6wmMbjp2t
lUv0W8QHICwtyLrz8W0kNXKR9ZQKZNuPYWUC5vsc38bJ/cZeFYvOKZhmf/ulRyUH
nMY8uINWmRJx6a+cvn83UUi8vCYGQh00UAnb+oZfYxgFP95RnbdJJ6qFKNABoo2N
gAdh1NV9MrydKfK1fiS6ChMQwcIVd5OJqqp7lIJzpZ6pn6P011JBG8LJoR3rJRfE
BlDatKbyQHQbgBZAzq/36mV1mzI7AhEoIWJ/6IxK7kUJ5QjwaQvWFlEJcU3Yli1d
Can35JkbmNBy3SggxQnIG8GnU/QsTjsJZj5+SOtjbfu1KogbEgzj9e+jchelCyFw
o8MF870Mji0AYTe1OUyE2LuHiJixSSHGaPcYnJ6DSAlfZhVRDia8JHyIwvlig8Vn
UQm2P1FMSxP29YPbDCS6
=OGLJ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

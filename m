From: David Haworth <dave@fen-net.de>
Subject: Re: IMX6 ESDHC mmc with UHS-I occasional failure with DDR50 cards
Date: Wed, 5 Apr 2017 00:00:40 +0200
Message-ID: <20170404220040.GA2997@fen-net.de>
References: <CAJ+vNU2S5NubFzKkHKjS2iHPt2_ysC-2e87ghUXPxsVEOKX+4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hermes.f3n.de ([212.204.115.44]:37233 "EHLO hermes.f3n.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755116AbdDDWSq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Apr 2017 18:18:46 -0400
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2S5NubFzKkHKjS2iHPt2_ysC-2e87ghUXPxsVEOKX+4w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tim,

This looks uncomfortably familiar.
I've been having problems with "some" micro-SDHC cards, but in
different circumstances: mmc_spi on a raspberry pi.

"Good" cards sign on as "mmcblk1: mmc1:0000 00000 7.35 GiB"
"Bad" cards sign on as  "mmcblk1: mmc1:0000 SU08G 7.40 GiB"
and eventually return a bit shifted response.

The "bad" cards are all SanDisk cards. The "good" cards are cheap
cards with one exception that is marked as SanDisk but looks like
a fake.

More details here:
https://www.raspberrypi.org/forums/viewtopic.php?f=3D44&t=3D172562&p=3D1103=
943#p1103943
if you can read it.
Unfortunately I don't have a solution.

All the best
Dave

On 2017-04-04 14:26:40 -0700, Tim Harvey wrote:
> Greetings,
>=20
> I've been seeing mmc failures with Linux 4.10 on some IMX6 boards with
> UHS-I support when used with DDR50 cards (I've got a couple from
> different manufacturers). I do not see the same issues when using
> SDR104 cards. I can also see the issue on the latest linux-mmc repo.
>=20
> The issue is easily replicated by ejecting and inserting the DDR50 card
>=20
> A successful init looks like this:
> [  150.514018] mmc0: host does not support reading read-only switch,
> assuming write-enable
> [  150.578204] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
> [  150.592140] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
> [  150.611512]  mmcblk0: p1
>=20
> A failing init (about 1 of every 5 trys) looks like this:
> [   49.514082] mmc0: host does not support reading read-only switch,
> assuming write-enable
> [   49.676112] mmc0: tuning execution failed: -5
> [   49.680510] mmc0: ddr50 tuning failed
> [   49.684206] mmc0: new ultra high speed DDR50 SDHC card at address aaaa
> [   49.696456] mmcblk0: mmc0:aaaa SL08G 7.40 GiB
> ^^^^ failed to read the partition table and at this point all access fail=
s:
> # dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D1k count=3D1
> [   89.417210] mmcblk0: error -84 transferring data, sector 0, nr 32,
> cmd response 0x900, card status 0xb00
> 1+0 records in
> 1+0 records out
> 1024 bytes (1.0 kB, 1.0 KiB) copied, 0.1227 s, 8.3 kB/s
>=20
> I know the issue started occurring in Linux v4.4 but I also have heard
> there are some tuning patches in the queue so before I bisected
> between v4.4 and v4.3. Note that v4.3 is missing DDR50 tuning but when
> I backport that I found that when ddr tuning failed there it did not
> cause the card to not be accessible.
>=20
> Regards,
>=20
> Tim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljkF4gACgkQHM6a+0rWdYqPRQCfZIDs3Y5Hpi5gbHYF6TS+OiMy
ingAoJU/sdKOegmfFyowUIG/p0ivPlLs
=f6Ys
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

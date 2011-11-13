From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: DDR eMMC write failures
Date: Sun, 13 Nov 2011 22:05:14 +0530
Message-ID: <000601cca222$3a103430$ae309c90$@org>
References: <CAHzg1A-7RNthipDredO4KSrC+bM0nqLuhWaw1cveFzzfXd2k3Q@mail.gmail.com> <CAHzg1A_igBoJ01eNzS5HX3LAAWo7tkTtmdbh8ACASt5r9LvbLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:56309 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab1KMQfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Nov 2011 11:35:18 -0500
In-Reply-To: <CAHzg1A_igBoJ01eNzS5HX3LAAWo7tkTtmdbh8ACASt5r9LvbLg@mail.gmail.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Praveen Krishnan' <praveen.gk@gmail.com>, linux-mmc@vger.kernel.org

I guess there is some issue with board level signal condition issue on =
MMC
interface lines. You may try increasing the drive strength of interface
lines from host controller side.

Regards,
Subhash

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Praveen Krishnan
> Sent: Saturday, November 05, 2011 5:57 AM
> To: linux-mmc@vger.kernel.org
> Subject: Re: DDR eMMC write failures
>=20
> I am seeing some very strange things.
>=20
> When I do
>=20
> Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D512k count=3D200 (it fails w=
hen
> writing about 100MB of data with a crc error)
>=20
> When I do
> Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D64k count=3D3000 (it fails o=
nly after
> 125 MB of data with a crc error)
>=20
> When I do
>=20
> Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D32k count=3D16000 (it fails =
when I
> try to write 500MB of data, but good until 375MB of data)
>=20
> Any ideas what I am running into?
>=20
> Thanks,
> Praveen
>=20
>=20
> On Wed, Nov 2, 2011 at 4:51 PM, Praveen Krishnan <praveen.gk@gmail.co=
m>
> wrote:
> > Hello all,
> >
> > I am working on getting the DDR50 mode up and running for the eMMC
> > cards. =A0I am running into some weird CRC error cases. =A0Initiall=
y, I
> > thought that everything works fine, but when I stress test it with
> > large amounts of data (more than 100MB of writes), I notice that my
> > console is spewed with venomous error messages. =A0I get a CRC erro=
r
> and
> > every now and then, I also see this message "Got data interrupt eve=
n
> > though no data operation was in progress" and "Buffer I/O error" an=
d
> > so on.
> >
> > Can anybody give any pointers as to what could be causing this?
> >
> > Thanks a lot,
> > Praveen
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: DDR eMMC write failures
Date: Sun, 13 Nov 2011 22:18:54 +0530
Message-ID: <000901cca224$22f49b40$68ddd1c0$@org>
References: <CAHzg1A-7RNthipDredO4KSrC+bM0nqLuhWaw1cveFzzfXd2k3Q@mail.gmail.com> <CAHzg1A_igBoJ01eNzS5HX3LAAWo7tkTtmdbh8ACASt5r9LvbLg@mail.gmail.com> <000601cca222$3a103430$ae309c90$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:40795 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab1KMQs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Nov 2011 11:48:57 -0500
In-Reply-To: <000601cca222$3a103430$ae309c90$@org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Praveen Krishnan' <praveen.gk@gmail.com>, linux-mmc@vger.kernel.org

You may also try by lowering the clock speed (from 50mhz to some lower =
value
say 40 or 30 Mhz). See if you are still seeing the data crc errors with
lower clock speed in DDR50 mode or not.

Regards,
Subhash

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
> Sent: Sunday, November 13, 2011 10:05 PM
> To: 'Praveen Krishnan'; linux-mmc@vger.kernel.org
> Subject: RE: DDR eMMC write failures
>=20
> I guess there is some issue with board level signal condition issue o=
n
> MMC
> interface lines. You may try increasing the drive strength of interfa=
ce
> lines from host controller side.
>=20
> Regards,
> Subhash
>=20
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Praveen Krishnan
> > Sent: Saturday, November 05, 2011 5:57 AM
> > To: linux-mmc@vger.kernel.org
> > Subject: Re: DDR eMMC write failures
> >
> > I am seeing some very strange things.
> >
> > When I do
> >
> > Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D512k count=3D200 (it fails=
 when
> > writing about 100MB of data with a crc error)
> >
> > When I do
> > Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D64k count=3D3000 (it fails=
 only
> after
> > 125 MB of data with a crc error)
> >
> > When I do
> >
> > Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D32k count=3D16000 (it fail=
s when I
> > try to write 500MB of data, but good until 375MB of data)
> >
> > Any ideas what I am running into?
> >
> > Thanks,
> > Praveen
> >
> >
> > On Wed, Nov 2, 2011 at 4:51 PM, Praveen Krishnan
> <praveen.gk@gmail.com>
> > wrote:
> > > Hello all,
> > >
> > > I am working on getting the DDR50 mode up and running for the eMM=
C
> > > cards. =A0I am running into some weird CRC error cases. =A0Initia=
lly, I
> > > thought that everything works fine, but when I stress test it wit=
h
> > > large amounts of data (more than 100MB of writes), I notice that =
my
> > > console is spewed with venomous error messages. =A0I get a CRC er=
ror
> > and
> > > every now and then, I also see this message "Got data interrupt
> even
> > > though no data operation was in progress" and "Buffer I/O error"
> and
> > > so on.
> > >
> > > Can anybody give any pointers as to what could be causing this?
> > >
> > > Thanks a lot,
> > > Praveen
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


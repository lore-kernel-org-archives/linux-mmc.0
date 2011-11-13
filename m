From: Praveen Krishnan <praveen.gk@gmail.com>
Subject: Re: DDR eMMC write failures
Date: Sun, 13 Nov 2011 10:02:38 -0800
Message-ID: <CAHzg1A_rdN4__cmQgjeVsF68KuyTuB0RNE5KYgs0AXTpNv+jmw@mail.gmail.com>
References: <CAHzg1A-7RNthipDredO4KSrC+bM0nqLuhWaw1cveFzzfXd2k3Q@mail.gmail.com>
	<CAHzg1A_igBoJ01eNzS5HX3LAAWo7tkTtmdbh8ACASt5r9LvbLg@mail.gmail.com>
	<000601cca222$3a103430$ae309c90$@org>
	<000901cca224$22f49b40$68ddd1c0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64274 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab1KMSCk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Nov 2011 13:02:40 -0500
Received: by fagn18 with SMTP id n18so2606658fag.19
        for <linux-mmc@vger.kernel.org>; Sun, 13 Nov 2011 10:02:39 -0800 (PST)
In-Reply-To: <000901cca224$22f49b40$68ddd1c0$@org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org

On Sun, Nov 13, 2011 at 8:48 AM, Subhash Jadavani
<subhashj@codeaurora.org> wrote:
>
> You may also try by lowering the clock speed (from 50mhz to some lowe=
r value
> say 40 or 30 Mhz). See if you are still seeing the data crc errors wi=
th
> lower clock speed in DDR50 mode or not.
=46igured there was an hardware issue.  The DMA was not able to service
the FIFO to keep pace with the DDR transfer rate.  There was a FIFO
underrun happening, because of which the clock used to get gated in
the middle of a transfer.  This was leading to a CRC issue.  Adjusted
the drive strength as well (and this fixes the initialization issue
when the cards used to randomly fail during init). And yes, have seen
that it works at lower frequencies. Anyway, thanks for the
suggestions.
> Regards,
> Subhash
>
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Subhash Jadavani
> > Sent: Sunday, November 13, 2011 10:05 PM
> > To: 'Praveen Krishnan'; linux-mmc@vger.kernel.org
> > Subject: RE: DDR eMMC write failures
> >
> > I guess there is some issue with board level signal condition issue=
 on
> > MMC
> > interface lines. You may try increasing the drive strength of inter=
face
> > lines from host controller side.
> >
> > Regards,
> > Subhash
> >
> > > -----Original Message-----
> > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > owner@vger.kernel.org] On Behalf Of Praveen Krishnan
> > > Sent: Saturday, November 05, 2011 5:57 AM
> > > To: linux-mmc@vger.kernel.org
> > > Subject: Re: DDR eMMC write failures
> > >
> > > I am seeing some very strange things.
> > >
> > > When I do
> > >
> > > Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D512k count=3D200 (it fai=
ls when
> > > writing about 100MB of data with a crc error)
> > >
> > > When I do
> > > Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D64k count=3D3000 (it fai=
ls only
> > after
> > > 125 MB of data with a crc error)
> > >
> > > When I do
> > >
> > > Dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D32k count=3D16000 (it fa=
ils when I
> > > try to write 500MB of data, but good until 375MB of data)
> > >
> > > Any ideas what I am running into?
> > >
> > > Thanks,
> > > Praveen
> > >
> > >
> > > On Wed, Nov 2, 2011 at 4:51 PM, Praveen Krishnan
> > <praveen.gk@gmail.com>
> > > wrote:
> > > > Hello all,
> > > >
> > > > I am working on getting the DDR50 mode up and running for the e=
MMC
> > > > cards. =A0I am running into some weird CRC error cases. =A0Init=
ially, I
> > > > thought that everything works fine, but when I stress test it w=
ith
> > > > large amounts of data (more than 100MB of writes), I notice tha=
t my
> > > > console is spewed with venomous error messages. =A0I get a CRC =
error
> > > and
> > > > every now and then, I also see this message "Got data interrupt
> > even
> > > > though no data operation was in progress" and "Buffer I/O error=
"
> > and
> > > > so on.
> > > >
> > > > Can anybody give any pointers as to what could be causing this?
> > > >
> > > > Thanks a lot,
> > > > Praveen
> > > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-m=
mc"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>

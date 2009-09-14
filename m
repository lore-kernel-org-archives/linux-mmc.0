From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Mon, 14 Sep 2009 22:27:29 +0200
Message-ID: <20090914202729.GB10398@elf.ucw.cz>
References: <20090903232317.GA6760@lst.de> <c4e36d110909111445nb6592cfue01543f5d04c2cda@mail.gmail.com> <m3eiqdqfnm.fsf@pullcord.laptop.org> <200909120036.41725.rjw@sisk.pl> <c4e36d110909140139u786f2165oc5a35dce5b2c0527@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933913AbZINU1k@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c4e36d110909140139u786f2165oc5a35dce5b2c0527@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Ball <cjb@laptop.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk
List-Id: linux-mmc@vger.kernel.org

On Mon 2009-09-14 10:39:44, Zdenek Kabelac wrote:
> 2009/9/12 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Saturday 12 September 2009, Chris Ball wrote:
> >> Hi,
> >>
> >> =A0 =A0> Well system could check basic card ids if they match afte=
r resume
> >>
> >> No. =A0That (arguably) guarantees that it's the same card, but not=
 that
> >> it wasn't modified in another machine during the suspend.
> >
> > Generally speaking, we'd also need to check superblocks for this to=
 work.
> >
> >> =A0 =A0> if some users wants to crash his card by randomly swappin=
g it
> >> =A0 =A0> during suspend/resume - I'd have no problem with that....
> >>
> >> You should have a problem with it. =A0Taking a card from a suspend=
ed
> >> machine and working on it with a different machine is not a bizarr=
e
> >> thing to want to do.
> >
> > Agreed.
>=20
>=20
> Well - ok - so let me ask this question - if I'll replace local hard
> drive during suspend - what will happen - is this prohibited by hw
> (e.i. to switch SATA cables) ?

During _suspend_: yes. You are not expected to open your machine while
powered up.

> IMHO filesystem should be able to detect corruption of its data
> structures - (assuming fs is notified about suspend/resume
> operation)

Patch welcome.

> Also there could be one simple quick solution/hack - to require to
> have at least all remote drives unmounted - so suspend would be
> refused if it runs mounted card/usb drive -  this would be 100% bette=
r
> than current solution which effectively kills my laptop if I forget t=
o
> unmount card in mmc reader - especially if dmesg contains message wit=
h
> the reason why my suspend fails.

It should not _kill_ your laptop -- that's a bug we want to
fix. Instead it is designed to behave as if you hot-unplugged your
card while mounted.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html

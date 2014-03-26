From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: mvsdio: unhandled interrupt, mmc writes queuing up
Date: Wed, 26 Mar 2014 07:50:29 +0100
Message-ID: <20140326075029.4fcc6675@pluto>
References: <20140325192759.GJ29769@segv.de>
	<53320055.9080307@gmail.com>
	<20140326000735.GI28304@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140326000735.GI28304@titan.lakedaemon.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Alexander Elbs <alex@segv.de>, Nicolas Pitre <nico@fluxnic.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
List-Id: linux-mmc@vger.kernel.org

Hi Jason,

Will try this out this evening when I'm back home (and have some time
to reboot the sheevaplug).


Note that the write-back stalls seem to be nilfs2 specific (I'm getting
them on usb-storage as well while ext4 filesystem on usb-storage
does not present the stall issue).

Bruno


On Tue, 25 Mar 2014 20:07:35 -0400 Jason Cooper wrote:
> On Tue, Mar 25, 2014 at 11:16:53PM +0100, Sebastian Hesselbarth wrote=
:
> > On 03/25/2014 08:27 PM, Alexander Elbs wrote:
> > >> On Wed, 19 Mar 2014, Bruno Pr=C3=A9mont wrote:
> > >>> Since upgrading my Sheevaplug from 3.7.2 to 3.13.6 (FDT) I'm se=
eing
> > >>>   mvsdio f1090000.mvsdio: unhandled interrupt status=3D0x8810 e=
n=3D0x0000 pio=3D0
> > >>> at varied timings.
> > >=20
> > > I have the same problem on my sheevaplug.
> > >=20
> > >> It has been many years since I've looked at the code for this dr=
iver. =20
> > >> I'm therefore including Thomas Petazzoni to the CC list as he ap=
pears to=20
> > >> have been the most active since then.
> > >>
> > >> The reported status seems to indicate missing data in the contex=
t of a=20
> > >> transfer with CMD12, and a CRC error ensued of course.
> > >>
> > >> At this point I'd suggest testing intermediate kernels between 3=
=2E7 and=20
> > >> 3.13, and try bisection until you find the offending commit.
> > >>
> > >> [...]
> > >>> I get same results with 3.14-rc7.
> > >>
> > >> Excellent, that reduces the search space significantly.  You can=
 do a=20
> > >> git bisect directly.
> > >=20
> > > I did a git bisect.
> > >   good: no message "unhandled interrupt"
> > >   bad: message above appears
> > >   skipped: unbootable kernel, usually stuck after the line "Uncom=
pressing Linux".=20
> > >=20
> > > So far I am down to a few commits after 3.11.
> > >=20
> > > $ git bisect view --oneline
> > > 2326f04 (refs/bisect/bad) ARM: kirkwood: convert to DT irqchip an=
d clocksource
> >=20
> > Can you please try the patches contained in [1]?
> >=20
> > They have been Acked-by Jason Cooper, but I guess we simply lost
> > track of them.
> >=20
> > Sebastian
> >=20
> > [1] https://lkml.org/lkml/2013/11/15/276
>=20
> Bruno,
>=20
> If these work for you, please send a Tested-by and I'll keep better
> track of them this time.  I think these were sent before we had a
> process for shuttling things into irqchip...
>=20
> thx,
>=20
> Jason.

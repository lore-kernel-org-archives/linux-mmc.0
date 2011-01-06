From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: outstanding TMIO MMC patches
Date: Thu, 6 Jan 2011 10:57:03 +0900
Message-ID: <AANLkTik_o1QPgrgARDixix4mxQCfiX6DBd8VTrSFWKAc@mail.gmail.com>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange>
	<AANLkTi=NWFmskvAosK9fO65OGNLrqEY-_PdvKydyn=G2@mail.gmail.com>
	<20110105045347.GA23889@linux-sh.org>
	<20110105165757.GA7876@void.printf.net>
	<20110105173029.GG23889@linux-sh.org>
	<20110105185717.GA9016@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110105185717.GA9016@void.printf.net>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On Thu, Jan 6, 2011 at 3:57 AM, Chris Ball <cjb@laptop.org> wrote:
> On Thu, Jan 06, 2011 at 02:30:30AM +0900, Paul Mundt wrote:
>> This is basically where the problem lies. Ian has some version of th=
e
>> hardware that we don't, and he likewise doesn't have access to the
>> version that we do (of course there would be no problem in making th=
e
>> hardware available to whoever decides to step up and look after TMIO=
 in a
>> more constructive fashion, though). There are likewise issues with
>> regards to who has access to what specifications, and there are case=
s
>> where neither Ian nor any of the people from our side have any specs=
 at
>> all. With this sort of a scenario it can be quite difficult to avoid
>> stepping on other peoples toes and making sure that things aren't be=
ing
>> inadvertently broken, and this is something I don't see any specific
>> resolution to, other than if you're not around to test and object in=
 a
>> timely fashion, you lose. I don't know if other MMC drivers have the=
 same
>> problem or not, but I can't imagine that this situation is terribly
>> unique when you have both corporations and hobbyists working on the =
same
>> driver from vastly different angles.
>
> I see. =A0So, if most patches are coming from your side, it seems tha=
t the
> largest problem for the moment is that no-one except Ian can test you=
r
> patches against his hardware. =A0Do we think there's any chance of so=
meone
> (I guess ideally you but possibly me) getting hold of hardware with I=
an's
> MMC block in, for at least occasional testing before releases?
>
> If not, is there any kind of split in the driver that we could use to=
 try
> to isolate changes more?

At this point we make use of capability flags prefixed with TMIO_MMC
to flag that the specific hardware block supports a certain feature.
So for instance the SDIO code for tmio-mmc is rather isolated and is
only enabled if TMIO_MMC_SDIO_IRQ is flagged - like it is by the SDHI
mfd wrapper.

Like Paul mentioned, upcoming Runtime PM changes will be very
intrusive, so the current abstraction may not be enough in the near
future. But let's deal with that then.

As for SDHI documentation, we have access to very little information.
The SDHI blocks are not even included in the regular per-SoC data
sheet. I managed to figure out that we can use the tmio-mmc driver by
comparing bit fields in an out-of-tree driver with existing mainline
drivers.

I suspect that the SDHI hardware block is somewhat related to the
MN57xx family, perhaps, MN5774. For not so much information in
japanese google for "2002_co2.pdf mn57xx". According to that
information there are a wide range of devices available but we're yet
to see any open driver coming from the vendor. At this point all we've
got is the tmio-mmc driver that has been reverse engineered by
hobbyists.

Many thanks for your help!

/ magnus

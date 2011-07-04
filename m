From: Koen Beel <koen.beel.barco@gmail.com>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Mon, 4 Jul 2011 12:37:45 +0200
Message-ID: <CAHMSPgNNDzsqEUa0ELKxamP_Tav4XK46grRAQ99rMDw65ecdOw@mail.gmail.com>
References: <20110630145507.GG1997@pengutronix.de>
	<20110701091753.GE1922@pengutronix.de>
	<BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
	<20110701122709.GJ1922@pengutronix.de>
	<BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
	<20110701144409.GA3825@pengutronix.de>
	<20110701154628.GD8631@S2100-06.ap.freescale.net>
	<20110702131225.GA5478@pengutronix.de>
	<20110703092850.GA9938@S2100-06.ap.freescale.net>
	<20110703103124.GA1333@pengutronix.de>
	<20110703115418.GB9938@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52486 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab1GDKhq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 06:37:46 -0400
Received: by wyg8 with SMTP id 8so3313085wyg.19
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jul 2011 03:37:45 -0700 (PDT)
In-Reply-To: <20110703115418.GB9938@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

On Sun, Jul 3, 2011 at 1:54 PM, Shawn Guo <shawn.guo@freescale.com> wro=
te:
> On Sun, Jul 03, 2011 at 12:31:24PM +0200, Wolfram Sang wrote:
>> On Sun, Jul 03, 2011 at 05:28:52PM +0800, Shawn Guo wrote:
>> > On Sat, Jul 02, 2011 at 03:12:25PM +0200, Wolfram Sang wrote:
>> > > On Fri, Jul 01, 2011 at 11:46:29PM +0800, Shawn Guo wrote:
>> > > > On Fri, Jul 01, 2011 at 04:44:09PM +0200, Wolfram Sang wrote:
>> > > > > Hi,
>> > > > >
>> > > > > On Fri, Jul 01, 2011 at 03:26:39PM +0200, Koen Beel wrote:
>> > > > > > I send the patch as attachment for now.
>> > > > >
>> > > > > Fine with me in this case...
>> > > > >
>> > > > > > But I'll have to look into another way of doing this. Corp=
orate mail
>> > > > > > system is adding stupid disclaimers, gmail web ui is not w=
orking ok
>> > > > > > and corporate firewalls avoid using a different smtp serve=
r...
>> > > > >
>> > > > > Good luck with that!
>> > > > >
>> > > > > About the patch itself: I didn't verify the formulas, but it=
 does solve one
>> > > > > special problem here. Thanks a lot! So:
>> > > > >
>> > > > > Tested-by: Wolfram Sang <w.sang@pengutronix.de>
>> > > > >
>> > > > > @chris: If Shawn also likes the patch, I think this is a sta=
ble candidate.
>> > > > >
>> > > > Thanks for the fixing, Koen.
>> > > >
>> > > > Acked-by: Shawn Guo <shawn.guo@freescale.com>
>> > >
>> > > Well, maybe not. My colleague complained and I think he is right=
 that we are
>> > > mapping div2 from the range 0 to 256 (inclusive!) to an 8-bit ra=
nge. This must
>> > > be wrong for one value per se.
>> > >
>> > If you look at the context of the patch, you will find it's 'div2 =
- 1'
>> > than 'div2' gets written into register.
>>
>> Exactly. The '- 1' is why Koen changed the upper limit from < 256 to=
 <=3D 256.
>> The lower limit fix is currently 'if (div2 =3D=3D 0) div2 =3D=3D 1',=
 which is a 2:1
>> mapping. Not good, or?
>>
> So you are saying the patch is a right fix but not the most optimal
> one? =C2=A0In that case, it does not concern me. =C2=A0I acked it as =
an valid
> fix.

According to the mx23/28 datasheet:
- actual mmc/sdio clock =3D ssp_sck =3D (sspclk) / ( clock_divide * (1+=
clock_rate) )
- clock_divide ranges from 2 to 254, by steps of 2
- clock_rate ranges from 0 to 255, so div2 ranges from 1 to 256
- if div2 is the range [0..1[, the only thing we can do is setting it
on 1. It just can't be lower. The actual clock rate will be lower then
requested.
- div2 will only be < 1 if div1 is 2. This is because div1 is tested
for a good value starting at the lowest possible value (2). Making
div2 higher will not solve the issue, it will only result in an even
lower actual clock
- you could choose the give dev_err ("cannot set clock to ...") but i
would not do that. Default requested clock for high speed sdio is 50
MHz and the default configuration for mx23 does not support this, so
you will also get an error. And having a lower clock then requested is
not that bad as having a higher clock.

In the code (as before):
- div1 =3D clock_divide (just written in hw)
- div2 =3D 1+clock_rate (clock_rate =3D div2 - 1 is written in hw)

So i think its correct. It work here in all tested condition.

Regards,
Koen

>
> --
> Regards,
> Shawn
>
>

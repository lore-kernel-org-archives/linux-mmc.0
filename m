From: Pavel Machek <pavel@ucw.cz>
Subject: Re: autosleep suspend too frquent problem
Date: Thu, 5 Jun 2014 15:51:08 +0200
Message-ID: <20140605135108.GA14162@amd.pavel.ucw.cz>
References: <35FD53F367049845BC99AC72306C23D1029A27656A2D@CNBJMBX05.corpusers.net>
 <20140603120128.GA5080@amd.pavel.ucw.cz>
 <CAPDyKFqnC1u_Nhe7sJrAzBc8YktDUJC4KAKTPtYVK-Qk6mmk0A@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D1029A27656A38@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33310 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaFENvM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 09:51:12 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1029A27656A38@CNBJMBX05.corpusers.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'Ulf Hansson' <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Thu 2014-06-05 14:51:41, Wang, Yalin wrote:
> Hi =20
>=20
> Thanks for your clarification.
>=20
> One problem is the sd card driver itself .
>=20
> In addition, I also think kernel's autosleep.c module
> Have problem too.
> It just test wake up count ,if the count is zero, then enter suspend.
>=20
> This will result in frequent suspend / resume problems sometimes,
> It is not acceptable, I think also need to be fixed to=20
> Avoid this special scenario .

Android phones pretty much want to sleep very very often. But if you
think there's coding bug in there, let us know..
								Pavel

> Thanks
>=20
>=20
> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]=20
> Sent: Wednesday, June 04, 2014 5:53 AM
> To: Pavel Machek
> Cc: Wang, Yalin; len.brown@intel.com; rjw@sisk.pl; linux-pm@vger.kern=
el.org; linux-kernel@vger.kernel.org; linux-mmc
> Subject: Re: autosleep suspend too frquent problem
>=20
> On 3 June 2014 14:01, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >
> >> I found sd card sometimes are damaged/ destroyed On our devices .
> >> And seems it is caused by kernel's frequently suspend/resume, Beca=
use=20
> >> during suspend/resume, the driver will suspend/resume sdcard Very=20
> >> frequently, this will damaged the sdcard sometimes, and the damage=
 is=20
> >> not recoverable ..
> >>
> >> Sometimes kernel will enter suspend and exit suspend very frequent=
ly,=20
> >> Especially when the system is in idle, but some driver is not idle=
,=20
> >> And it will  wake up the system by irq frequently.
> >> By our power test result, if system enter suspend /resume very=20
> >> frequently, Will consume more power , because it will enable /disa=
ble=20
> >> many devices During a short time .
> >>
> >> I make a patch to prevent the system to enter suspend/resume state=
=20
> >> More than one time during 2 seconds=EF=BC=9A
> >
> > It is good you managed to diagnose the problem, but this si not the=
=20
> > right solution.
> >
> > Either:
> >
> > 1) don't power down SD card during system suspend
>=20
> NAK. The amount of power a card (even if there are good behaving card=
s as well) may utilize, in powered but idle state could be significant.
> I have seen cases of constant power consumption of several mA here.
>=20
> >
> > or maybe even better
> >
> > 2) don't power _up_ SD card during system resume. Let it be powered=
=20
> > down until the first access.
>=20
> Good news! This is "almost" supported already by the mmc subsystem.
>=20
> If your mmc host has set the capability flag MMC_CAP_RUNTIME_RESUME, =
that means the card won't be powered up (and initialized) until the nex=
t request.
>=20
> However, for removable cards (!MMC_CAP_NONREMOVABLE), during system r=
esume phase, the mmc core will trigger a "rescan" of the card, to verif=
y it has not been removed. Thus, unfortunate for this use case, the fir=
st request (for removable cards) will be triggered during the system re=
sume phase.
>=20
> I suppose we should add some extra conditions/flags which makes the m=
mc core to handle the above scenario. Actually I have been thinking of =
putting together a patch for this, but it never pops up on the top of m=
y TODO list. :-)
>=20
> Additionally, I wonder if this bouncing up and down from suspend to r=
esume, could have other negative impact for other subsystems? Is it jus=
t a mmc subsystem problem? I am not so sure.
>=20
> Kind regards
> Ulf Hansson
>=20
> >
> > Thanks,
> >                                                                    =
    =20
> > Pavel
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures)=20
> > http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe=20
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org=
=20
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html

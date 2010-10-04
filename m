From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Mon, 4 Oct 2010 12:33:51 -0500
Message-ID: <CD6B4CE9F7FA427BBD19242F669AD014@am.dhcp.ti.com>
References: <cover.1266847842.git.david.vrabel@csr.com><20100827192248.GJ20407@void.printf.net><4C7CC480.2040903@csr.com><4C7F3E0F.2080402@compulab.co.il><AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com><C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com> <AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49070 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab0JDReR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2010 13:34:17 -0400
In-Reply-To: <AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Steve Sakoman' <sakoman@gmail.com>
Cc: 'Mike Rapoport' <mike@compulab.co.il>, 'David Vrabel' <david.vrabel@csr.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org



> -----Original Message-----
> From: Steve Sakoman [mailto:sakoman@gmail.com]
> Sent: Monday, October 04, 2010 11:57 AM
> To: Madhusudhan
> Cc: Mike Rapoport; David Vrabel; Chris Ball; linux-mmc@vger.kernel.or=
g;
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
>=20
> On Mon, Oct 4, 2010 at 9:45 AM, Madhusudhan <madhu.cr@ti.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Steve Sakoman [mailto:sakoman@gmail.com]
> >> Sent: Monday, October 04, 2010 11:32 AM
> >> To: Mike Rapoport
> >> Cc: David Vrabel; Chris Ball; linux-mmc@vger.kernel.org; linux-
> >> omap@vger.kernel.org; madhu.cr@ti.com
> >> Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
> >>
> >> On Wed, Sep 1, 2010 at 11:02 PM, Mike Rapoport <mike@compulab.co.i=
l>
> >> wrote:
> >> > David Vrabel wrote:
> >> >>
> >> >> On 27/08/2010 20:22, Chris Ball wrote:
> >> >>>
> >> >>> Hi David,
> >> >>>
> >> >>> On Mon, Feb 22, 2010 at 02:24:17PM +0000, David Vrabel wrote:
> >> >>>>
> >> >>>> These patches add support for SDIO cards to the omap_hsmmc dr=
iver.
> >> >>>> Power management changes to prevent SDIO cards from being tur=
ned
> off
> >> >>>> and losing all state, and card interrupts.
> >> >>>>
> >> >>>> I've been unable to test these exact patches as I only have a=
n
> N900
> >> for
> >> >>>> testing and the N900 support in mainline is incomplete.
> >> >>>>
> >> >>>> Changes since v1:
> >> >>>> - (hopefully) get all cards working again by removing a secon=
d
> call
> >> to
> >> >>>> =A0read MMCi_STAT in the interrupt handler.
> >> >>>> - flush posted writes after enabling/disabling SDIO interrupt=
s.
> >> >>>> - tweak the FIXME commit on disabling FCLK to better match wh=
at
> >> really
> >> >>>> =A0going on (at least I think so anyway).
> >> >>>>
> >> >>>> David Vrabel (2):
> >> >>>> =A0mmc: omap_hsmmc: don't turn SDIO cards off when idle
> >> >>>> =A0mmc: omap_hsmmc: enable SDIO card interrupts
> >> >>>
> >> >>> Looks like this patchset wasn't merged. =A0Mike Rapoport repli=
ed with
> a
> >> fix
> >> >>> for libertas. =A0Would you like to resubmit it?
> >> >>
> >> >> I thought Madhu had picked this up and was going to submit it.
> >> >>
> >> >> Regardless of whether that is the case, I think it needs to be
> >> submitted
> >> >> by someone who can run mainline kernels (I can't) and ideally
> someone
> >> >> who can test it with SDIO cards.
> >> >
> >> > I'll try to update the patches in the next few days.
> >>
> >> Any update on the status of these patches? =A0I'm happy to help te=
st!
> >>
> > Steve,
> >
> > I have not been able to test SDIO card interrupts. If you could hel=
p
> test
> > that it's great.
>=20
> Where can I grab the most recent patches?  The original set don't app=
ly
> cleanly.
>=20

Yes. They may not apply. I can rebase them and send it to you for testi=
ng.
Are you using the two patches posted by David Vrabel?

Regards,
Madhu

> Steve


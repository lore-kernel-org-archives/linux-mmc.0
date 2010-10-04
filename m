From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Mon, 4 Oct 2010 11:45:23 -0500
Message-ID: <C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com>
References: <cover.1266847842.git.david.vrabel@csr.com><20100827192248.GJ20407@void.printf.net><4C7CC480.2040903@csr.com><4C7F3E0F.2080402@compulab.co.il> <AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: 'Steve Sakoman' <sakoman@gmail.com>, 'Mike Rapoport' <mike@compulab.co.il>
Cc: 'David Vrabel' <david.vrabel@csr.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Steve Sakoman [mailto:sakoman@gmail.com]
> Sent: Monday, October 04, 2010 11:32 AM
> To: Mike Rapoport
> Cc: David Vrabel; Chris Ball; linux-mmc@vger.kernel.org; linux-
> omap@vger.kernel.org; madhu.cr@ti.com
> Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
>=20
> On Wed, Sep 1, 2010 at 11:02 PM, Mike Rapoport <mike@compulab.co.il>
> wrote:
> > David Vrabel wrote:
> >>
> >> On 27/08/2010 20:22, Chris Ball wrote:
> >>>
> >>> Hi David,
> >>>
> >>> On Mon, Feb 22, 2010 at 02:24:17PM +0000, David Vrabel wrote:
> >>>>
> >>>> These patches add support for SDIO cards to the omap_hsmmc drive=
r.
> >>>> Power management changes to prevent SDIO cards from being turned=
 off
> >>>> and losing all state, and card interrupts.
> >>>>
> >>>> I've been unable to test these exact patches as I only have an N=
900
> for
> >>>> testing and the N900 support in mainline is incomplete.
> >>>>
> >>>> Changes since v1:
> >>>> - (hopefully) get all cards working again by removing a second c=
all
> to
> >>>> =A0read MMCi_STAT in the interrupt handler.
> >>>> - flush posted writes after enabling/disabling SDIO interrupts.
> >>>> - tweak the FIXME commit on disabling FCLK to better match what
> really
> >>>> =A0going on (at least I think so anyway).
> >>>>
> >>>> David Vrabel (2):
> >>>> =A0mmc: omap_hsmmc: don't turn SDIO cards off when idle
> >>>> =A0mmc: omap_hsmmc: enable SDIO card interrupts
> >>>
> >>> Looks like this patchset wasn't merged. =A0Mike Rapoport replied =
with a
> fix
> >>> for libertas. =A0Would you like to resubmit it?
> >>
> >> I thought Madhu had picked this up and was going to submit it.
> >>
> >> Regardless of whether that is the case, I think it needs to be
> submitted
> >> by someone who can run mainline kernels (I can't) and ideally some=
one
> >> who can test it with SDIO cards.
> >
> > I'll try to update the patches in the next few days.
>=20
> Any update on the status of these patches?  I'm happy to help test!
>=20
Steve,

I have not been able to test SDIO card interrupts. If you could help te=
st
that it's great.

Regards,
Madhu

> Steve

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

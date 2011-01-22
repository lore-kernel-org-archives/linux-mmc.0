From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
Date: Fri, 21 Jan 2011 19:27:06 -0800
Message-ID: <477F20668A386D41ADCC57781B1F704307F4EA2885@SC-VEXCH1.marvell.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
 <alpine.LFD.2.00.1009021344430.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009021923171.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009072119210.19366@xanadu.home>
 <477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
 <1284459351.2359.17.camel@stummala-linux.in.qualcomm.com>
 <477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1009152222400.19366@xanadu.home>
 <AANLkTinjpe8iGcOyru=09WrBq4f5PfBo2QcUs40OycXg@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F704307F4EA2865@SC-VEXCH1.marvell.com>
 <alpine.LFD.2.00.1101212148320.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56286 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754879Ab1AVDcf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 22:32:35 -0500
In-Reply-To: <alpine.LFD.2.00.1101212148320.8580@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>



> -----Original Message-----
> From: Nicolas Pitre [mailto:nico@fluxnic.net]
> Sent: Friday, January 21, 2011 6:56 PM
> To: Bing Zhao
> Cc: zhangfei gao; Sahitya Tummala; linux-mmc@vger.kernel.org; Michal =
Miroslaw; Chris Ball; Andrew
> Morton; Maxim Levitsky
> Subject: RE: [PATCH v2] sdio: skip initialization on powered resume
>=20
> On Fri, 21 Jan 2011, Bing Zhao wrote:
>=20
> > Hi Zhangfei,
> >
> > > -----Original Message-----
> > > From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
> > > Sent: Friday, January 21, 2011 1:07 AM
> > > To: Nicolas Pitre; Bing Zhao
> > > Cc: Sahitya Tummala; linux-mmc@vger.kernel.org; Michal Miroslaw; =
Chris Ball; Andrew Morton; Maxim
> > > Levitsky
> > > Subject: Re: [PATCH v2] sdio: skip initialization on powered resu=
me
> > >
> > > On Wed, Sep 15, 2010 at 10:26 PM, Nicolas Pitre <nico@fluxnic.net=
> wrote:
> > > > On Wed, 15 Sep 2010, Bing Zhao wrote:
> > > >
> > > >> If CMD7 is sent _before_ client driver's resume handler is cal=
led,
> > > >> while 8686 card is in sleep mode, it will fail. If CMD7 is sen=
t
> > > >> _after_ client driver's resume handler is called, it should su=
cceed.
> > > >
> > > > Maybe that's what we should do in the powered suspend case then=
=2E
> > > >
> > > >> By the way, a patch "mmc: fix all hangs related to mmc/sd card
> > > >> insert/removal during suspend/resume"
> > > >> (4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e by Maxim Levitsky) h=
as
> > > >> removed the call to mmc_detect_change() in mmc_resume_host().
> > > >
> > > > If a card is removed while the host is suspended, then this sho=
uld be
> > > > detected.
> > > >
> > > >
> > > > Nicolas
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux=
-mmc" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
> > > >
> > >
> > > Hi, Bing
> > >
> > > Do you have any updated patch to skip mmc_sdio_init_card in resum=
e back.
> > > We need such patch in enable host sleep feature for mrvl8787.
> >
> > I posted a patch that skips mmc_sdio_init_card() with MMC_PM_SKIP_R=
ESUME_PROBE flag earlier:
> >
> > [PATCH v1] sdio: add MMC_PM_SKIP_RESUME_PROBE to workaround powered=
 resume
> > http://marc.info/?l=3Dlinux-mmc&m=3D128294262424567&w=3D2
> >
> > Nicolas commented that it's too hackish with this approach.
> > http://marc.info/?l=3Dlinux-mmc&m=3D128294738230151&w=3D2
> >
> > Other than that, I couldn't think of a better way to solve the issu=
e here:
> >
> > In mmc_sdio_init_card() CIS device/vendor IDs are read to check if =
the
> > card has been replaced or not when the system was suspended. But
> > reading these IDs will cause CMD52 timeout if the card is in sleep
> > state. The function driver can wake up the card by writing to certa=
in
> > card specific register, so that the followed SDIO commands (CMD52,
> > CMD53, etc.) can go through. But the resume handler of the function
> > driver won't be invoked until the IDs get validated.
>=20
> Please add the extra explanation above to the commit log so that
> the context is not lost.  And then
>=20
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
>=20
> Then this could be revisited eventually when more devices are support=
ed
> and a better abstraction to cover their needs could be created.
>=20
>=20
> Nicolas

Hi Nicolas,

Thanks for ack. I'll resend the patch with extra explanation in commit =
log.


Hi Chris,

I'll rebase and test the patch based on git://git.kernel.org/pub/scm/li=
nux/kernel/git/cjb/mmc.git tree. Should I use "master" or "mmc-next" br=
anch?

Thanks,

Bing


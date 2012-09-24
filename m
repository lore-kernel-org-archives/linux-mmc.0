From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v3] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Mon, 24 Sep 2012 03:13:22 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C191EAD@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1348223135-6435-1-git-send-email-r66093@freescale.com>
 <m3y5k3e4tq.fsf@pullcord.laptop.org>
 <6A474F70-46DB-43ED-92C0-5D111AA64D48@kernel.crashing.org>
 <110EED8CC96DFC488B7E717A2027A27C191E05@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:23356
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754882Ab2IXDN0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 23 Sep 2012 23:13:26 -0400
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C191E05@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Shaohui-B21989 <B21989@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>



Best Regards
Jerry Huang


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Huang Changming-R66093
> Sent: Monday, September 24, 2012 10:37 AM
> To: Kumar Gala; Chris Ball
> Cc: linux-mmc@vger.kernel.org; Xie Shaohui-B21989; Anton Vorontsov
> Subject: RE: [PATCH v3] powerpc/esdhc: disable CMD23 for some Freescale
> SoCs
> 
> 
> 
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org]
> > Sent: Saturday, September 22, 2012 2:36 AM
> > To: Chris Ball
> > Cc: Huang Changming-R66093; linux-mmc@vger.kernel.org; Huang
> > Changming- R66093; Xie Shaohui-B21989; Anton Vorontsov
> > Subject: Re: [PATCH v3] powerpc/esdhc: disable CMD23 for some
> > Freescale SoCs
> >
> >
> > On Sep 21, 2012, at 11:08 AM, Chris Ball wrote:
> >
> > > Hi,
> > >
> > > On Fri, Sep 21 2012, r66093@freescale.com wrote:
> > >> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > >> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > >> @@ -143,6 +143,35 @@ static void esdhc_of_resume(struct sdhci_host
> > >> *host) } #endif
> > >>
> > >> +static const u32 non_cmd23_processor_table[] = {
> > >> +	/* P1020 Dual/Single core */
> > >> +	0x80EC00, 0x80E400, 0x80ED00, 0x80E500,
> > >> +	/* P1021 Dual/Single core */
> > >> +	0x80EC01, 0x80E401, 0x80ED01, 0x80E501,
> > >> +	/* P1022 Dual/Single core */
> > >> +	0x80EE00, 0x80E600, 0x80EF00, 0x80E700,
> > >> +	/* P1024 Dual/Single core */
> > >> +	0x80EC02, 0x80E402, 0x80ED02, 0x80E502,
> > >> +	/* P1025 Dual/Single core */
> > >> +	0x80EC03, 0x80E403, 0x80ED03, 0x80E503,
> > >> +	/* P4080 and P4040 */
> > >> +	0x820000, 0x820800, 0x820100, 0x820900
> > >
> > > I don't see how this method improves on either of the previous two
> > > we've discussed.  If anything, Kumar's suggested method seems better
> > > than this
> > > one:  it detected the MMC IP revision, which I'd expect to be more
> > > reliable than building a list of which SoCs contain that IP.
> > >
> > > Why is this better than using DT or detecting the MMC revision?
> > >
> > > Thanks,
> >
> > I feel like I missed this patch, but I'd rather we go with the version
> > I sent since the # of IP versions we have is 3 or 4, instead of the 30
> > or
> > 40 SoCs we have.
> >
> MPC8536 and P4080 have the same IP version (VVN1.0), but MPC8536 support
> CMD23, P4080 can't, how to handle these two silicones?
> For the future silicones, no one can make sure all silicones support
> CMD23.
> don't say almost 0%, which just is the assumption, otherwise, why p4080
> can't support it and mpc8536 can?
MPC837x has the same VVN1.0 as the MPC8536 and p4080, which supports CMD23, too.


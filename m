From: Scott Wood <oss@buserror.net>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Fri, 08 Jan 2016 00:34:32 -0600
Message-ID: <1452234872.19133.29.camel@buserror.net>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	 <1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
	 <1450116253.15946.353.camel@freescale.com>
	 <CAPDyKFrKSMC0uo8re3CxjNCUsVnEMau=GTKq=v_3ooNnQxw2Eg@mail.gmail.com>
	 <CAPDyKFoYxM4Nv_pHCZbGzuswMCXTLyj6CYgLjYnRguscUs9LrQ@mail.gmail.com>
	 <HE1PR04MB0889791AB9F06A5591D4CD5FF8FB0@HE1PR04MB0889.eurprd04.prod.outlook.com>
	 <CAPDyKFqhRVh9XdY=2aMP5sL5kp+RkHV_tsA4=Oj_88e8NN9DCw@mail.gmail.com>
	 <1451329828.18314.154.camel@freescale.com>
	 <HE1PR04MB0889469615D576548DF0EE75F8F40@HE1PR04MB0889.eurprd04.prod.outlook.com>
	 <AM3PR04MB530AAF1632EA442F05C95BF91F50@AM3PR04MB530.eurprd04.prod.outlook.com>
	 <HE1PR04MB0889197B75CA5C8FDB793F87F8F60@HE1PR04MB0889.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from host.buserror.net ([209.198.135.123]:35769 "EHLO
	host.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbcAHGxS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jan 2016 01:53:18 -0500
In-Reply-To: <HE1PR04MB0889197B75CA5C8FDB793F87F8F60@HE1PR04MB0889.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Lu Y.B." <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Xiaobo Xie <X.Xie@freescale.com>, Leo li <LeoLi@freescale.com>

On Fri, 2016-01-08 at 06:17 +0000, Yangbo Lu wrote:
> > -----Original Message-----
> > From: Scott Wood
> > Sent: Friday, January 08, 2016 6:24 AM
> > To: Yangbo Lu; Scott Wood; Ulf Hansson
> > Cc: Lu Y.B.; linux-mmc; Xiaobo Xie; Li Leo
> > Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for
> > MMC_SDHCI_OF_ESDHC
> > 
> > On 01/06/2016 12:58 AM, Yangbo Lu wrote:
> > > > -----Original Message-----
> > > > From: Scott Wood [mailto:scottwood@freescale.com]
> > > > Sent: Tuesday, December 29, 2015 3:10 AM
> > > > To: Ulf Hansson; Yangbo Lu
> > > > Cc: Lu Yangbo-B47093; linux-mmc; Xie Xiaobo-R63061; Leo li
> > > > Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for
> > > > MMC_SDHCI_OF_ESDHC
> > > > 
> > > > On Mon, 2015-12-28 at 13:10 +0100, Ulf Hansson wrote:
> > > > > On 28 December 2015 at 11:26, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > > > > > Sent: Thursday, December 17, 2015 7:31 PM
> > > > > > > To: Scott Wood
> > > > > > > Cc: Lu Yangbo-B47093; linux-mmc; Xie Xiaobo-R63061; Leo li
> > > > > > > Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for
> > > > > > > MMC_SDHCI_OF_ESDHC
> > > > > > > 
> > > > > > > [...]
> > > > > > > 
> > > > > > > > > 
> > > > > > > > > And I think stubs for reading SVR is quite a bad idea. 
> > > > > > > > >  It'll
> > > > > > > > > make the driver build but it will silently not be able to
> > > > > > > > > apply
> > > > > > > > > SVR-based
> > > > > > > workarounds.
> > > > > > > > 
> > > > > > > > It doesn't have to be "silent", the driver can return an error
> > > > > > > > (and print error messages) from its ->probe() method, if the
> > > > > > > > calls to the GUTS driver fails.
> > > > > > > > 
> > > > > > > > Anyway, I mentioned this idea only to understand the need for
> > > > > > > > *optional* GUTS supports. Perhaps there is a cross SOC drivers
> > > > > > > > that for some platforms depends on GUTS but on others it
> > > > > > > > doesn't.
> > > > > > > > 
> > > > > > > > Maybe that isn't case then!?
> > > > > > > 
> > > > > > > Can you please answer this question!?
> > > > > > > 
> > > > > > > According to the earlier versions of this patchset and from your
> > > > > > > comments [1], it *do* seems like the GUTS driver may be optional
> > > > > > > and thus stubs could address this.
> > > > > > > 
> > > > > > > Kind regards
> > > > > > > Uffe
> > > > > > > 
> > > > > > > [1]
> > > > > > > http://www.spinics.net/lists/linux-mmc/msg34412.html
> > > > > > 
> > > > > > [Lu Yangbo-B47093] Hi Scott and Uffe, In the earlier version, I'd
> > > > > > like to use syscon support and only add 'syscon' compatible in the
> > > > > > dts whose eSDHC needs to use it to get SVR.
> > > > > > But I never thought this had caused so much discussion... :(
> > > > > 
> > > > > Sorry, I understand your frustration but that's life sometimes. :-)
> > > > > 
> > > > > To me, the syscon solution is more elegant...
> > > > 
> > > > The syscon patch was terrible.  It would have accessed a certain
> > > > location in any node labelled "syscon" whether it was guts or not, in
> > > > addition to the other complaints.
> > > > 
> > > > -Scott
> > > 
> > > [Lu Yangbo-B47093] As my understand, the syscon APIs would just check
> > whether there is a 'syscon' compatible.
> > > If no, the APIs return. We still could maintain a list of compatibles
> > for guts if using syscon.
> > 
> > Where would that list of compatibles go?  Duplicated in every driver that
> > needs something from guts?  Why decentralize the implementation?
> > 
> > > In my opinion, syscon and guts driver are just two method to get SVR.
> > 
> > The guts driver could eventually handle more than just SVR, and it could
> > handle SVR better (e.g. on PPC fall back to reading the SPR if guts is
> > unavailable).
> > 
> > -Scott
> 
> [Lu Yangbo-B47093] Ok... It seems no proper place to maintain the guts list
> presently...
> I also have had a question about the guts driver.
> Could you suggest where to register the guts driver, to make it registered
> for all QorIQ platforms and avoid unavailability to call it?

In an initcall, just like other normal drivers.  Maybe subsys_initcall.

-Scott


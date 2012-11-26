From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined
 reference to `__aeabi_uldivmod'
Date: Mon, 26 Nov 2012 07:23:07 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E11767B3@039-SN2MPN1-022.039d.mgd.msft.net>
References: <50b2a62c.slEE/d1mNq4kUCUf%fengguang.wu@intel.com>
 <110EED8CC96DFC488B7E717A2027A27C235D56@039-SN1MPN1-003.039d.mgd.msft.net>
 <20121126060231.GA24503@localhost>
 <99E897753B6F7048BD8CCDB4661D02E1176757@039-SN2MPN1-022.039d.mgd.msft.net>
 <20121126062156.GA25132@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:29255
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752555Ab2KZHXM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Nov 2012 02:23:12 -0500
In-Reply-To: <20121126062156.GA25132@localhost>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Huang Changming-R66093 <r66093@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>




Regards
Haijun.


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Fengguang Wu
> Sent: Monday, November 26, 2012 2:22 PM
> To: Zhang Haijun-B42677
> Cc: Huang Changming-R66093; linux-mmc@vger.kernel.org; Chris Ball
> Subject: Re: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined
> reference to `__aeabi_uldivmod'
> 
> I don't understand your question... The question is, did Chris use the
> same environment detailed in the original report? 

[Haijun: ] yes, I mean that if you use the same environment detailed in Chris's mail.
Including the config and the platform. No need yet, thank you anyway.

Did he check out the
> right commit (d29254e21ddddee37b3c8525817398d96d6403f3) and used the
> right config (omap2plus_defconfig)?
> 
> On Mon, Nov 26, 2012 at 06:12:24AM +0000, Zhang Haijun-B42677 wrote:
> > Thanks, Fengguang, did you use the same environment as Chris?
> > If so that's just the reason caused the err.
> >
> > Regards
> > Haijun.
> >
> >
> > > -----Original Message-----
> > > From: Fengguang Wu [mailto:fengguang.wu@intel.com]
> > > Sent: Monday, November 26, 2012 2:03 PM
> > > To: Huang Changming-R66093
> > > Cc: Zhang Haijun-B42677; linux-mmc@vger.kernel.org; Chris Ball
> > > Subject: Re: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc):
> > > undefined reference to `__aeabi_uldivmod'
> > >
> > > On Mon, Nov 26, 2012 at 05:54:33AM +0000, Huang Changming-R66093
> wrote:
> > > > Hi, Robot
> > > > I don't find the `__aeabi_uldivmod' in branch 'mmc-next' of
> > > > linux-mmc
> > > tree.
> > > > Could you point out which file use it?
> > > >
> > > > This patch just use the 'div_u64' to calculate the timeout in
> > > > order to
> > > avoid overflow.
> > >
> > > Hi! This is confirmed to fix the problem:
> > >
> > > diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c index
> > > 48ad361..daf0636 100644
> > > --- a/drivers/mmc/host/omap.c
> > > +++ b/drivers/mmc/host/omap.c
> > > @@ -921,7 +921,7 @@ static inline void set_data_timeout(struct
> > > mmc_omap_host *host, struct mmc_reque
> > >  	u16 reg;
> > >
> > >  	cycle_ns = 1000000000 / host->current_slot->fclk_freq;
> > > -	timeout = req->data->timeout_ns / cycle_ns;
> > > +	timeout = div_u64(req->data->timeout_ns, cycle_ns);
> > >  	timeout += req->data->timeout_clks;
> > >
> > >  	/* Check if we need to use timeout multiplier register */
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html



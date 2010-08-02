From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: RE: [PATCH] mmc: add SDHCI driver for STM platforms.
Date: Mon, 2 Aug 2010 17:00:48 +0200
Message-ID: <107012446AC13D4C90B85672EAF5FB0E9C2E08E21B@SAFEX1MAIL3.st.com>
References: <1280392279-17406-1-git-send-email-peppe.cavallaro@st.com>
 <107012446AC13D4C90B85672EAF5FB0E9C2E08E16C@SAFEX1MAIL3.st.com>
 <20100802134050.GA7944@console-pimps.org>
 <107012446AC13D4C90B85672EAF5FB0E9C2E08E20E@SAFEX1MAIL3.st.com>
 <20100802143631.GB7944@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:50335 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752635Ab0HBPBH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Aug 2010 11:01:07 -0400
In-Reply-To: <20100802143631.GB7944@console-pimps.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Matt,

> -----Original Message-----
> From: Matt Fleming [mailto:matt@console-pimps.org]
> Sent: Monday, August 02, 2010 4:37 PM
> To: Peppe CAVALLARO
> Cc: Andrew Morton; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms.
> 
> On Mon, Aug 02, 2010 at 04:03:30PM +0200, Peppe CAVALLARO wrote:
> > Hi Matt,
> >
> > > -----Original Message-----
> > > From: Matt Fleming [mailto:matt@console-pimps.org]
> > > Sent: Monday, August 02, 2010 3:41 PM
> > > To: Peppe CAVALLARO
> > > Cc: Andrew Morton
> > > Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms.
> > >
> > > On Fri, Jul 30, 2010 at 04:04:16PM +0200, Peppe CAVALLARO wrote:
> > > > Hello!
> > > > I wonder if somebody's had some spare moment to review this patch.
> > > > Welcome advice and feedback as usual
> > > >
> > > > Many thanks in advance.
> > > >
> > > > Best Regards,
> > > > Giuseppe
> > >
> > > You're best bet is to CC Andrew on mmc patches (which I've now done).
> >
> > Thanks for your feedback and sorry if I didn't put Andrew on CC before.
> > I'm newer in this mailing list.
> 
> I'm sorry, I dropped the linux-mmc mailing list when I replied to your
> mail! My bad.

No problem! Thanks!

> 
> > > What is devm_stm_pad_claim()? I can't find this function in linus'
> > > tree, or in -next, or in Andrew's -mm series. Where is this function
> > > from?
> >
> > This comes from our STMicroelectronics platform pad management
> > infrastructure; code available from:
> > http://git.stlinux.com/?p=stm/linux-sh4-2.6.32.y.git;a=summary It's
> > used to claim/manage various resources i.e. PIO and clock lines.
> 
> That's interesting. So, this driver won't build with linus' tree? I

No, it won't.

> didn't think that the kernel catered for external interfaces like this
> - it causes all sorts of issues, not least of which is the fact that
> the driver can't be built or tested with the mainline kernel.
> 

I know that this can be a problem but, having it in the main-line,
it could also help me on developing and testing the Arasan HC
on newer Kernels for our STM platforms.

> Andrew, what do you make of this?

Regards,
Peppe

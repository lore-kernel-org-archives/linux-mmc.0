From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: RE: [PATCH] mmc: add SDHCI driver for STM platforms.
Date: Wed, 4 Aug 2010 07:47:21 +0200
Message-ID: <107012446AC13D4C90B85672EAF5FB0E9C2E08E343@SAFEX1MAIL3.st.com>
References: <1280392279-17406-1-git-send-email-peppe.cavallaro@st.com>
	<107012446AC13D4C90B85672EAF5FB0E9C2E08E16C@SAFEX1MAIL3.st.com>
	<20100802134050.GA7944@console-pimps.org>
	<107012446AC13D4C90B85672EAF5FB0E9C2E08E20E@SAFEX1MAIL3.st.com>
	<20100802143631.GB7944@console-pimps.org>
	<20100803152119.0df3d55c.akpm@linux-foundation.org>
	<107012446AC13D4C90B85672EAF5FB0E9C2E08E340@SAFEX1MAIL3.st.com>
 <20100803224425.bf7c4c43.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:34892 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755440Ab0HDFry convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Aug 2010 01:47:54 -0400
In-Reply-To: <20100803224425.bf7c4c43.akpm@linux-foundation.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Fleming <matt@console-pimps.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Andrew,

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org]
> Sent: Wednesday, August 04, 2010 7:44 AM
> To: Peppe CAVALLARO
> Cc: Matt Fleming; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms.
> 
> On Wed, 4 Aug 2010 07:35:20 +0200 Peppe CAVALLARO <peppe.cavallaro@st.com>
> wrote:
> 
> > Hi Andrew,
> >
> > > -----Original Message-----
> > > From: Andrew Morton [mailto:akpm@linux-foundation.org]
> > > Sent: Wednesday, August 04, 2010 12:21 AM
> > > To: Matt Fleming
> > > Cc: Peppe CAVALLARO; linux-mmc@vger.kernel.org
> > > Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms.
> > >
> > > On Mon, 2 Aug 2010 15:36:31 +0100
> > > Matt Fleming <matt@console-pimps.org> wrote:
> > >
> > > > > > What is devm_stm_pad_claim()? I can't find this function in
> linus'
> > > > > > tree, or in -next, or in Andrew's -mm series. Where is this
> function
> > > > > > from?
> > > > >
> > > > > This comes from our STMicroelectronics platform pad management
> > > > > infrastructure; code available from:
> > > > > http://git.stlinux.com/?p=stm/linux-sh4-2.6.32.y.git;a=summary It's
> > > > > used to claim/manage various resources i.e. PIO and clock lines.
> > > >
> > > > That's interesting. So, this driver won't build with linus' tree? I
> > > > didn't think that the kernel catered for external interfaces like
> this
> > > > - it causes all sorts of issues, not least of which is the fact that
> > > > the driver can't be built or tested with the mainline kernel.
> > > >
> > > > Andrew, what do you make of this?
> > >
> > > It definitely needs to be compileable.  Otherwise it's dead code to
> > > everyone else and nobody can maintain it as they make tree-wide or
> > > subsystem-wide changes.
> > >
> > > Also I do think the code in mainline should be able to be excecutable
> > > (and testable!) without external code dependencies.  This gets into the
> > > realm of licensing concerns: is the out-of-tree code GPL?  If not then
> > > people will make a big fuss.  If it _is_ GPL then get it merged up!
> >
> > It is under GPL license and available from git.stlinux.com at this time.
> > Please also consider that I'm going to maintain and update the sdhci-stm
> > driver, currently on high priority in our side.
> >
> 
> So why not merge the sdhci-stm driver into mainline at the same time as
> "mmc: add SDHCI driver for STM platforms"?  Then all of this won't be an
> issue at all.

Yes, we can do it. The driver will be merged next. It is not a problem
for me ;-).

Peppe

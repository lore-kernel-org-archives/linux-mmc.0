From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms.
Date: Tue, 3 Aug 2010 15:21:19 -0700
Message-ID: <20100803152119.0df3d55c.akpm@linux-foundation.org>
References: <1280392279-17406-1-git-send-email-peppe.cavallaro@st.com>
	<107012446AC13D4C90B85672EAF5FB0E9C2E08E16C@SAFEX1MAIL3.st.com>
	<20100802134050.GA7944@console-pimps.org>
	<107012446AC13D4C90B85672EAF5FB0E9C2E08E20E@SAFEX1MAIL3.st.com>
	<20100802143631.GB7944@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46921 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757873Ab0HCWV1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Aug 2010 18:21:27 -0400
In-Reply-To: <20100802143631.GB7944@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Peppe CAVALLARO <peppe.cavallaro@st.com>, linux-mmc@vger.kernel.org

On Mon, 2 Aug 2010 15:36:31 +0100
Matt Fleming <matt@console-pimps.org> wrote:

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
> didn't think that the kernel catered for external interfaces like this
> - it causes all sorts of issues, not least of which is the fact that
> the driver can't be built or tested with the mainline kernel.
> 
> Andrew, what do you make of this?

It definitely needs to be compileable.  Otherwise it's dead code to
everyone else and nobody can maintain it as they make tree-wide or
subsystem-wide changes.

Also I do think the code in mainline should be able to be excecutable
(and testable!) without external code dependencies.  This gets into the
realm of licensing concerns: is the out-of-tree code GPL?  If not then
people will make a big fuss.  If it _is_ GPL then get it merged up!

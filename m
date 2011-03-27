From: Simon Horman <horms@verge.net.au>
Subject: Re: outstanding tmio patches
Date: Sun, 27 Mar 2011 09:20:11 +0900
Message-ID: <20110327002011.GC31554@verge.net.au>
References: <Pine.LNX.4.64.1103231505450.6836@axis700.grange>
 <m3k4folztx.fsf@pullcord.laptop.org>
 <m3mxkjl2nr.fsf@pullcord.laptop.org>
 <Pine.LNX.4.64.1103251518290.22824@axis700.grange>
 <m3ipv7l07b.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:48467 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1C0AUR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Mar 2011 20:20:17 -0400
Content-Disposition: inline
In-Reply-To: <m3ipv7l07b.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>

On Fri, Mar 25, 2011 at 10:54:48AM -0400, Chris Ball wrote:
> Hi,
> 
> On Fri, Mar 25 2011, Guennadi Liakhovetski wrote:
> > Hm, strange, now all patches should be correct - if the correct versions 
> > are taken. Let's do it easier: I've uploaded all 15 patches (14 mine and 1 
> > from Simon) as a quilt series to
> >
> > http://download.open-technology.de/tmio-for-2.6.39/
> 
> Thanks, I just needed to pull changes from Linus into mmc-next.
> 
> I've pushed everything out to mmc-next now.  If anyone else is able to
> grab mmc-next and supply a Tested-by: for their hardware, that'd be
> appreciated.

Hi,

I have done some tests on a Renesas Mackerel board (Guennadi likely has
one too) both with and without my "mmc, ARM: Add zboot from eSD support for
SuperH Mobile ARM" change - which needs to go through RMK's tree
and is the motivation for the " mmc: tmio_mmc: Move some defines into a
shared header" patch.

I didn't notice any problems.

FWIW

Tested-by: Simon Horman <horms@verge.net.au>

> Also, if anyone thinks that some of this should wait until .40, now's a
> good time to speak up.  :)

I have no particular objections though I do agree that it
is a lot of churn at this stage of the release cycle.

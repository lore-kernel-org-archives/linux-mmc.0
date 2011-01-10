From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
Date: Tue, 11 Jan 2011 00:45:14 +0900
Message-ID: <20110110154514.GC3760@linux-sh.org>
References: <20110109124928.GC25591@verge.net.au> <1294589548.8897.1.camel@rojo> <20110109225042.GB29257@verge.net.au> <c1e9db480d82d1804930ddcc7bb0db02@rootnode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:56846 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab1AJPrU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jan 2011 10:47:20 -0500
Content-Disposition: inline
In-Reply-To: <c1e9db480d82d1804930ddcc7bb0db02@rootnode.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <mail@pawelmoll.com>
Cc: Simon Horman <horms@verge.net.au>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Mon, Jan 10, 2011 at 10:10:19AM +0000, Pawel Moll wrote:
> On Mon, 10 Jan 2011 07:50:42 +0900, Simon Horman <horms@verge.net.au> 
> wrote:
> >>>  Documentation/arm/SH-Mobile/Makefile              |    8 +
> >>>  Documentation/arm/SH-Mobile/vrl4.c                |  169 
> >>+++++++++++++++++++++
> >>How about putting those two into "tools" (in particular "tools/arm")
> >>instead of "Documentation"?
> >>Just a thought... ;-)
> >
> >Thats fine by me except that tools/arm doesn't exist yet.
> >It would be good to get some consensus before creating it.
> 
> I think there is consensus regarding "tools" as a place for user-space 
> tools - eg. perf tools used to live in "Documentation/..." and then were 
> moved to "tools/perf".
> 
> Now, whether your stuff should be in "tools/SH-Mobile" or 
> "tools/arm/SH-Mobile", I have no opinion ;-)
> 
I agree that this is a worthwhile direction to move to, but we're a long
way from a consensus. x86 has traditionally littered scripts/ and others
have sunk to arch/<foo>/tools hostprogs abuse and so forth. perf is a bit
of a special case in that it's fairly architecture agnostic. 

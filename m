From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/5] tmio PM: aggressive clock gating, register layout limitation
Date: Tue, 8 Mar 2011 17:42:52 +0900
Message-ID: <20110308084251.GB28316@linux-sh.org>
References: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:49192 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756570Ab1CHInD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Mar 2011 03:43:03 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Mon, Mar 07, 2011 at 07:47:45PM +0100, Guennadi Liakhovetski wrote:
> 5 more patches, that fix high register access on sh-mobile in a correct 
> way and implement aggressive clock gating. Marked as RFC because testing 
> on non-SDHI platforms is required! The next step would be to add 
> runtime-pm to clock gating, but I'm refraining from this for now, because 
> similar patches for SDHCI have still not been committed and it seems, 
> there are still doubts about the right way to do that.
> 
> Patches apply on top of my previous 2 patches from earlier today.
> 
I'm a bit confused about this series in general. Patch 1 and 5 are both
marked RFC but 2/3/4 seem to be unrelated and intended for merging,
despite the fact I find the approach itself to be rather suspect. So why
exactly are these all lumped together?

Please do not create patch series that are intentionally muddled. Since
you have two distinct things here with completely different intentions
and you've not explicitly stated whether there's any dependencies between
the two it simply creates a giant mess.

A patch series should be logically structured in some way other than
"here's a bunch of random patches I have pending for this particular
driver", particularly if only parts of it are intended to be merged.

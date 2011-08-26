From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4 v9] mmc: sdhi: Allow named IRQs to use specific
 handlers
Date: Fri, 26 Aug 2011 18:13:19 +0900
Message-ID: <20110826091319.GA5380@verge.net.au>
References: <1314235648-8959-1-git-send-email-horms@verge.net.au>
 <1314235648-8959-4-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108261022320.25272@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44268 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab1HZJNY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2011 05:13:24 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108261022320.25272@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>

On Fri, Aug 26, 2011 at 10:42:39AM +0200, Guennadi Liakhovetski wrote:
> From: Simon Horman <horms@verge.net.au>
> 
> Allow named IRQs to use corresponding specific handlers. If named IRQs are 
> used, at least an "sdcard" IRQ has to be specified by the platform. If 
> names are not used, an arbitrary number of IRQs can be provided by the 
> platform, in which case the generic ISR will be used for each of them.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Acked-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> [g.liakhovetski@gmx.de: style and typo corrections, platform data check]
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Simon, this is what I propose to commit. I fixed a typo, wrong multi-line 
> comment style and indentation spaces in your patch. Besides, I added a 
> check to require the SDCARD IRQ if named IRQs are used. It is a common 
> practice to verify platform data availability and at least some basic 
> correctness and completeness. This check is trivial and adds extra 
> robustness to the driver. Please, have a look, whether you agree with my 
> version.

Hi Guennadi,

thanks, this looks fine to me.

I would prefer slightly if SDCARD wasn't required.
But I think that is a discussion that we can have
if/when a use-case arises.

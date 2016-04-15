From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/5] mmc: tmio: make CTL_STATUS handling consistent
Date: Fri, 15 Apr 2016 10:51:47 +1000
Message-ID: <20160415005147.GB31938@verge.net.au>
References: <1460650609-2105-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40659 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbcDOAvv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2016 20:51:51 -0400
Content-Disposition: inline
In-Reply-To: <1460650609-2105-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Apr 14, 2016 at 06:16:44PM +0200, Wolfram Sang wrote:
> It took me a little to discover that CTL_STATUS has a different handling than
> the other registers. CTL_STATUS and CTL_STATUS2, both u16, are merged into a
> virtual u32. However, CTL_STATUS2 was also directly accessed.
> 
> Clean this up, make this consistent, and document this. Making the driver less
> complex and easier to work with.
> 
> Tested on Renesas R-Car Gen2 and Gen3. It is on top of my not-yet applied
> series "[PATCH 0/6] mmc: tmio/sdhi: clean up cruft". A complete branch is here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi-uhs

Wow, you have had some fun there.

These changes look correct and seem to be valuable clean ups to me.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


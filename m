From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/2] mmc: sh_mmcif: simplify platform DMA configuration
Date: Mon, 5 Sep 2011 13:15:54 +0900
Message-ID: <20110905041553.GB22142@linux-sh.org>
References: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:53581 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab1IEEQF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Sep 2011 00:16:05 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Aug 30, 2011 at 06:26:34PM +0200, Guennadi Liakhovetski wrote:
> A simple cosmetic clean-up, no functional changes. Patch 2/2 depends on 
> patch 1/2 and can wait until 3.3. Paul, would you be able to put it under 
> the carpet somewhere until then or shall I resend it after 3.2-rc1 is out? 
> After both these patches have been applied, we can remove struct 
> sh_mmcif_plat_data::dma around 3.4 or 4.0 or whatever;-)
> 
It's not a problem, I'll just flag it as awaiting upstream in the
tracker. Anything flagged as such I generally give a once over after each
merge window to see if their dependencies have been worked out.

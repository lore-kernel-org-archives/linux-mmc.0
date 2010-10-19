From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Tue, 19 Oct 2010 20:45:16 +0100
Message-ID: <20101019194516.GA28424@void.printf.net>
References: <1287492541-3060-1-git-send-email-eric@eukrea.com> <20101019150743.GA26784@pengutronix.de> <4CBDB694.4000209@eukrea.com> <20101019193638.GB31336@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53500 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756875Ab0JSTpT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Oct 2010 15:45:19 -0400
Content-Disposition: inline
In-Reply-To: <20101019193638.GB31336@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, r65037@freescale.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.gsc@gmail.com

On Tue, Oct 19, 2010 at 09:36:38PM +0200, Wolfram Sang wrote:
> > I do have, but I can't do the tests until next week because of other priorities.
> 
> I'd suggest to add a proper patch next week then (maybe together with correct
> usage of the MULTIBLOCK-quirk, too?). It's a new driver, so adding update
> patches late in the cycle should not cause problems? Of course, Chris makes the
> final decision about that.

Fine with me, tested patches are good.  There's no need to rush to get
it in before -rc1. 

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Wed, 22 Jul 2015 21:59:42 +0800
Message-ID: <20150722135939.GA13623@shlinux1.ap.freescale.net>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
 <20150709075032.GD23464@tiger>
 <20150709092949.GB3917@shlinux1.ap.freescale.net>
 <20150709132736.GG23464@tiger>
 <20150713114310.GA9453@shlinux1.ap.freescale.net>
 <55A49D35.7010002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bbn0101.outbound.protection.outlook.com ([157.56.111.101]:40168
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965518AbbGVOHj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 10:07:39 -0400
Content-Disposition: inline
In-Reply-To: <55A49D35.7010002@web.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Soeren Moch <smoch@web.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@freescale.com>, ulf.hansson@linaro.org, chris@printf.net, s.trumtrar@pengutronix.de, LW@KARO-electronics.de, marex@denx.de, rabeeh@solid-run.com, gwenhael.goavec-merou@armadeus.com, rmk+kernel@arm.linux.org.uk, hs@denx.de, tharvey@gateworks.com, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, lisovy@gmail.com, robertcnelson@gmail.com, linux-arm-kernel@lists.infradead.org, ipaton0@gmail.com, fabio.estevam@freescale.com, linux-mmc@vger.kernel.org, p.zabel@pengutronix.de, shawn.guo@linaro.org

On Tue, Jul 14, 2015 at 07:25:09AM +0200, Soeren Moch wrote:
> 
> 
> On 13.07.2015 13:43, Dong Aisheng wrote:
> > On Thu, Jul 09, 2015 at 09:27:36PM +0800, Shawn Guo wrote:
> >> On Thu, Jul 09, 2015 at 05:29:50PM +0800, Dong Aisheng wrote:
> >>> I agree with you.
> >>> One difference is that i'd like to fix it ASAP without reverting 8d86e4f
> >>> due to more patches depends on it is already there as i mentioned above..
> >>> Revert it may need to revert a lot others.
> >>>
> >>> The pain is that v4.1 is left broken.
> >>
> >> Oh, crap!  I thought it's been there with only v4.2-rc1, and did not
> >> know v4.1 is already broken.  In that case, reverting 8d86e4f isn't
> >> the best option.  I suggest you rebase the dts series on top of
> >> v4.2-rc1, and send it via mmc tree.
> >>
> > 
> > Yes, will go that way.
> > 
> > Then you may need help take care of new dts going through your tree
> > to make sure no broken code in again.
> 
> Dong,
> 
> I use a microSD card (mmc0) with the root filesystem on a tbs2910 board.
> I cannot see any difference between linux-4.0 and linux-4.1 (vanilla
> kernel with corresponding dtb), there is absolutely no problem with card
> detect.
> 
> Can you please explain what exactly is broken in linux-4.1?
> 

The CD function is broken.
If you enable CONFIG_MMC_DEBUG, you will see the MMC core keep polling the
card because MMC_CAP_NEEDS_POLL is wrongly set.
You can refer to cover-letter for more detailed explaination.

If you're using a non-removable card(having non-removable property in dts),
you may not have this issue.

Regards
Dong Aisheng

> Thanks,
> Soeren
> 
> > Thanks
> > 
> > Regards
> > Dong Aisheng
> > 
> >> Shawn

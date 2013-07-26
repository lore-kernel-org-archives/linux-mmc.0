From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [RFC 0/2] Set mmc(blk)X with DT alias
Date: Fri, 26 Jul 2013 10:09:53 +0200
Message-ID: <20130726080953.GA2118@pengutronix.de>
References: <1374656973-16250-1-git-send-email-s.trumtrar@pengutronix.de>
 <51F16046.3020809@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33631 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab3GZIKB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 04:10:01 -0400
Content-Disposition: inline
In-Reply-To: <51F16046.3020809@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, kernel@pengutronix.de

On Thu, Jul 25, 2013 at 10:28:38AM -0700, Stephen Warren wrote:
> On 07/24/2013 02:09 AM, Steffen Trumtrar wrote:
> > Hi!
> > 
> > Embedded devices often use multiple SD/MMC devices as boot/rootfs disks.
> > Some of them are removable, some not. If the removable cards are not
> > present, but are probed before the non-removable ones, the indexing
> > scheme changes. This makes it harder to hard-code the rootfs in the
> > cmdline.
> >
> > First solution I came up with was the alias-node in DT.
> > I guess my implementation is pretty hacky and ugly, but you can get lost
> > pretty fast in the whole mmc stack.
> > For example, the second patch should use "card->host->index" instead of parsing
> > the alias again, I guess. I'm not sure why it currently doesn't though.
> 
> This has been discussed a few times before and rejected IIRC. One issue
> is that block device ID is actually decoupled from host controller ID
> anyway, e.g. if a removable device is mounted, removed, and then
> re-plugged the new device can get a different ID, so this approach
> doesn't really work in all cases anyway.
> 

Hm, okay. I actually wasn't aware of the older discussions.

> > So, if there is a better place or solution to specify a reliable ordering
> > of mmc devices, please let me hear it.
> 
> root=UUID=xxx or root=PARTUUID=xxx are the best solution. With recent
> U-Boot, you can enable and use the "part" command to find the partition
> UUID automatically, and hence not need to hard-code anything. Something
> similar could presumably be implemented for other bootloaders.

I am actually okay with that. I know barebox can do that, but didn't knew that
U-Boot is also capabable of that.
So, I'm okay with dropping the patch.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC 0/2] Set mmc(blk)X with DT alias
Date: Thu, 25 Jul 2013 10:28:38 -0700
Message-ID: <51F16046.3020809@wwwdotorg.org>
References: <1374656973-16250-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55520 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab3GYR2m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2013 13:28:42 -0400
In-Reply-To: <1374656973-16250-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, kernel@pengutronix.de

On 07/24/2013 02:09 AM, Steffen Trumtrar wrote:
> Hi!
> 
> Embedded devices often use multiple SD/MMC devices as boot/rootfs disks.
> Some of them are removable, some not. If the removable cards are not
> present, but are probed before the non-removable ones, the indexing
> scheme changes. This makes it harder to hard-code the rootfs in the
> cmdline.
>
> First solution I came up with was the alias-node in DT.
> I guess my implementation is pretty hacky and ugly, but you can get lost
> pretty fast in the whole mmc stack.
> For example, the second patch should use "card->host->index" instead of parsing
> the alias again, I guess. I'm not sure why it currently doesn't though.

This has been discussed a few times before and rejected IIRC. One issue
is that block device ID is actually decoupled from host controller ID
anyway, e.g. if a removable device is mounted, removed, and then
re-plugged the new device can get a different ID, so this approach
doesn't really work in all cases anyway.

> So, if there is a better place or solution to specify a reliable ordering
> of mmc devices, please let me hear it.

root=UUID=xxx or root=PARTUUID=xxx are the best solution. With recent
U-Boot, you can enable and use the "part" command to find the partition
UUID automatically, and hence not need to hard-code anything. Something
similar could presumably be implemented for other bootloaders.

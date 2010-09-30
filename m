From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] sdhci: add support for sd 3.0 host and hooks for dual
	data rate eMMC
Date: Thu, 30 Sep 2010 06:53:40 +0100
Message-ID: <20100930055340.GA5164@void.printf.net>
References: <6E692E1B-FB67-4FB0-9316-9E990CEB89ED@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49967 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab0I3Fxm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Sep 2010 01:53:42 -0400
Content-Disposition: inline
In-Reply-To: <6E692E1B-FB67-4FB0-9316-9E990CEB89ED@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zgao6@marvell.com>, Mark Brown <markb@marvell.com>

Hi Philip,

On Wed, Sep 29, 2010 at 10:27:12PM -0700, Philip Rakity wrote:
> This code has not been tested on mmc-test but has been patched against.  I have run it against 2.6.32 (with some minor changes).
> 
> I wanted to give folks a chance to comment before making it a formal patch.  The code add the hooks into the sdhci layer for 
> version 3.0 of the controller, including mmc/eMMC dual data rate support (ddr).    The next RFC adds support for DDR at the mmc layer

This doesn't apply against mmc-next, in part because it duplicates code
from Zhangfei's SDHC 3.0 patches in mmc-next here:

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=90ce6eed919bf30fa545bbe93265bc6c463cedda
http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=07f1a246a56b12fe85897580cc696160f41e3983
http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=0bd7f9f081e9131d4d724f3a3bd19a500c10a5e3

and from Hanumath's DDR 4.4 patch, and Adrian's additions to it, which I
haven't merged into -next yet but plan to soon -- I've been waiting for
more feedback on them.  They already add DDR support at the MMC layer:

https://patchwork.kernel.org/patch/177312/
https://patchwork.kernel.org/patch/177332/

If you could study these and rebase your patch on top of all of them,
it would help us see what you're changing.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

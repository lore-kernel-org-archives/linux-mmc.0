From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4 1/1]MMC: add support of sdhci-pxa driver
Date: Mon, 25 Oct 2010 11:57:50 +0100
Message-ID: <20101025105750.GA30789@void.printf.net>
References: <AANLkTi=kS7YV4B0OEHNfm1hjCAsgeUHB7cMR10yBwMRF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53157 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab0JYK5v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Oct 2010 06:57:51 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=kS7YV4B0OEHNfm1hjCAsgeUHB7cMR10yBwMRF@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "eric.y.miao" <eric.y.miao@gmail.com>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Marek Vasut <marek.vasut@gmail.com>

Hi Zhangfei,

On Mon, Oct 25, 2010 at 06:00:37AM -0400, zhangfei gao wrote:
> Hi, Chris
> 
> Add default working speed in this version, thanks.

I've taken the previous patch version into mmc-next now:

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=536ac998f6076a0ae423b1046b85d7690e8b7107

So, please send further changes as individual patches against the
version in mmc-next, and I'll apply them after the merge.

Are you going to submit a patch to e.g. arch/arm/mach-mmp that hooks
up a platform_device using this driver?

By the way, we used this driver on an OLPC XO-1.75 (MMP2) today.
I haven't finished testing it yet, though.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

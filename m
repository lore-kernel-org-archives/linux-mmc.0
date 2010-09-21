From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Tue, 21 Sep 2010 02:03:25 +0100
Message-ID: <20100921010324.GA5873@void.printf.net>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36421 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab0IUBDb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Sep 2010 21:03:31 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi Zhangfei/Saeed,

On Mon, Sep 20, 2010 at 05:46:02PM +0800, zhangfei gao wrote:
> Hi, Chris,
> 
> Here is patch to support pxa168(aspen)/pxa910(ttc)/mmp2, the
> controller follow sdh 3.0.
> Currently verified sd, Micron 16G emmc need some workaround, 8G is OK,
> marvell 8787 would be verified later.
> Help review.

Could you help me understand how this new driver relates to the Marvell
SoC driver that I merged last week (CONFIG_MMC_SDHCI_MV)?  Are the SD
IPs in Dove and MMP2 different enough to warrant a separate driver, or
could support for both be included in sdhci-mv.c?

If we're going to have multiple drivers for the SD blocks in Armada/PXA,
it at least seems that MMC_SDHCI_MV has been mis-named.  Any thoughts?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

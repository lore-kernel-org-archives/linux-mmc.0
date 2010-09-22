From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Wed, 22 Sep 2010 03:27:22 +0100
Message-ID: <20100922022721.GB3821@void.printf.net>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com> <20100921010324.GA5873@void.printf.net> <AANLkTi=Rwj7hDfDxKqLNwyparxWv3RvQ2HJvo1qbJVe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41335 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab0IVC1Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Sep 2010 22:27:25 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=Rwj7hDfDxKqLNwyparxWv3RvQ2HJvo1qbJVe2@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi,

On Mon, Sep 20, 2010 at 11:16:18PM -0400, zhangfei gao wrote:
> We have considered using the same driver with dove once saeed push the
> driver, but at last we decide to use seperate driver to easy
> maintaince and further extension.
> 
> There are different IP developed by different group between Dove and
> pxa168/pxa910/mmp2, and would be more and more different.
> The pxa serious ip is follow sdh spec 3.0, and support sd 3.0 and emmc
> 4.4, which need ddr50 and 1.8v requirement, the limitation is adma
> still has some issue and in fixing.
> Still some private register with differnt address, such as power
> control, clock timming tunning and etc.
> 
> The dove ip is follow sdh spec 2.0, and it has own limitation, such as
> 1.8v may not be supported.
> 
> In a word, they are differnt ip, and it is reasonable to use seprate driver.

Okay.  If we're going to have two different MV_SDHCI drivers, please
coordinate to have different Kconfig entries for the Dove/MMP and MMP2
drivers that correctly identify which SoCs are supported by each, and
resend.  Neither driver should be called CONFIG_MV_SDHCI, since there
will be no one driver for all MV_SDHCIs.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

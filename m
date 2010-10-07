From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2 1/1]MMC: add support of sdhci-pxa driver
Date: Thu, 7 Oct 2010 20:45:26 +0100
Message-ID: <20101007194526.GA16587@void.printf.net>
References: <AANLkTikK0oEwLEXaf_Q5XWi3nxoq8WKCzKiF87E_Z3k+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34812 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab0JGTp1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Oct 2010 15:45:27 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikK0oEwLEXaf_Q5XWi3nxoq8WKCzKiF87E_Z3k+@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, kmpark@infradead.org, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi Zhangfei, all,

On Tue, Sep 28, 2010 at 11:23:35PM -0400, zhangfei gao wrote:
> We strongly prefer using standalone host driver currently, like
> sdhci-s3c.c, the scheme is more mature, more similar as our
> controller, and more flexiable for sharing one controller in different
> platform with different requirement.
> We would rather pay more effort to enable new feature of silicon,  to
> enhance the sdhci.c, which benefit much more silicon vender, instead
> of paying much effort in how to abstract probe and remove.
> For the driver lever, we don't want too much dependence, the more
> dependence, the less stability.
> The sdhci-pltfm has good idea, however currently it does not meet our
> requirement, not say in the future.

Sorry for taking so long to reply to this -- it's been difficult to
decide whether to take this as a non-pltfm driver.

I've decided to take it since our encouragement of platform drivers is
recent, and Eric is also in favor of keeping it separate, and you've
both argued that -pltfm isn't easily able to handle the shared clock
situation on your hardware.  (I'm sure it could be extended to be.)
So, please update the patch in light of Matt Fleming's review comments
and re-submit.

I don't agree, however, with the argument that SDHCI drivers are more
stable if they don't depend on a common core; the common core will
receive more maintenance if more people are using it.  Going forward,
I think that new SDHCI driver work should either use -pltfm or give
strong technical reasons why -pltfm isn't appropriate, and give us a
chance to improve -pltfm in response.  I think we should also consider
converting existing drivers over to platform drivers, even though that's
clearly difficult to accomplish after a driver's been merged. 

Hope that helps to explain the situation as I see it, and I'd be happy
to hear any more comments on the -pltfm approach in general.

Thanks!

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

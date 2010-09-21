From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] add support PXA168/PXA910/MMP2 SD Host Controller
Date: Tue, 21 Sep 2010 17:18:07 +0100
Message-ID: <20100921161807.GA18231@void.printf.net>
References: <AANLkTi=jeL0J1kfT+toB3BEAGJ5Cc5jZsHstD1hutNQB@mail.gmail.com> <20100920095042.GC4058@pengutronix.de> <AANLkTin28uj+L+AyUYVwoAyaUOmpfw3tc6JFEcVgtXBy@mail.gmail.com> <20100920131055.GE4058@pengutronix.de> <AANLkTin0ZDmTJ5gea65BiU+dWy+nD=wjp_xDOgYzxZF8@mail.gmail.com> <20100921101116.GE3168@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33236 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757434Ab0IUQSJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Sep 2010 12:18:09 -0400
Content-Disposition: inline
In-Reply-To: <20100921101116.GE3168@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi Wolfram,

On Tue, Sep 21, 2010 at 12:11:16PM +0200, Wolfram Sang wrote:
> I guess to fully understand all constraints, one must really working
> with your platform, what I don't do. I agree that a nicely working
> driver is better than no driver; however, I fear once a driver hit the
> mainline being non-pltfm, it will hardly be converted later, even if it
> was considered to be worthwhile. So this is why I ask initially if it
> couldn't be done.
> 
> Chris, do you see a rule of thumb here? Or what are your preferences?

I agree with you entirely:  even if we end up deciding not to use -pltfm
here (which looks like it's probably going to be the case), we should at
least specify what's stopping us from doing so and look into extending
-pltfm so that it might be useful next time around.  So, thank you for
asking those questions!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

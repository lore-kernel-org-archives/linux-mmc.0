From: Chris Ball <cjb@laptop.org>
Subject: Re: [patch 1/1] sdhci-base-clock-freqency-change-in-spec-3.0
Date: Tue, 14 Sep 2010 14:18:53 +0100
Message-ID: <20100914131853.GC17079@void.printf.net>
References: <AANLkTims_z+X_bOK2v3AekBZWg1LsSecRCUeAi5HGseW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60529 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab0INNSz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Sep 2010 09:18:55 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTims_z+X_bOK2v3AekBZWg1LsSecRCUeAi5HGseW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

Hi,

On Fri, Aug 20, 2010 at 02:22:56AM -0400, zhangfei gao wrote:
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 20 Aug 2010 14:02:36 -0400
> Subject: [PATCH] sdhci: base clock freqency change in spec 3.0

Thanks, applied to mmc-next.

We should have all of the changes required for SDHC 3.0 (8-bit wide data,
10-bit divided clock mode, base clock frequency change) present in the
mmc-next tree now.  Would someone with access to 3.0 hardware be able to
test that it's all working?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

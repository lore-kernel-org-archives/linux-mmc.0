From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Fri, 22 Oct 2010 01:27:38 +0100
Message-ID: <20101022002738.GA688@void.printf.net>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com> <20101021141302.GA11912@void.printf.net> <20101021145249.GA13095@void.printf.net> <201010220220.10398.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56575 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203Ab0JVA1j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Oct 2010 20:27:39 -0400
Content-Disposition: inline
In-Reply-To: <201010220220.10398.marek.vasut@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, zhangfei gao <zhangfei.gao@gmail.com>, Matt Fleming <matt@console-pimps.org>, eric.y.miao@gmail.com, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi Marek,

On Fri, Oct 22, 2010 at 02:20:10AM +0200, Marek Vasut wrote:
> > > I'll take the drivers/mmc/ hunks, but you should send the plat-pxa/
> > > patch through the ARM tree.
> > 
> > Oh.  If we do that then the driver won't compile until everything's
> > together, because it #includes <plat/sdhci.h>.  Haojian/Eric, what do
> > you prefer here?  Should I take the arch/arm/ hunk via the MMC tree?
> > (If so, please provide ACKs.)
> 
> Hi, where can I find the whole driver so I can take a look? It didn't 
> crash into linux-arm-kernel for some reason.

Here it is:

http://thread.gmane.org/gmane.linux.kernel.mmc/4190

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

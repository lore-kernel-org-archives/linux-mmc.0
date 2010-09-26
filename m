From: Chris Ball <cjb@laptop.org>
Subject: Re: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Sun, 26 Sep 2010 16:59:05 +0100
Message-ID: <20100926155905.GB19772@void.printf.net>
References: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com> <AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com> <AANLkTimk2_KcmSAV-UZ3JY1JFD657SnfyPFgP_zE5bbP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58845 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448Ab0IZP7I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 Sep 2010 11:59:08 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimk2_KcmSAV-UZ3JY1JFD657SnfyPFgP_zE5bbP@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Saeed Bishara <saeed@marvell.com>

On Sun, Sep 26, 2010 at 10:45:02PM +0800, Haojian Zhuang wrote:
> > I prefer we rename it to something like sdhci-mmp.c and the 'pxa' in the
> > source code to 'mmp' to cause less confusion with pxamci.c?
>
> Maybe sdhci-pxa.c is better. pxamci.c isn't compatible with sdhci, so
> it won't make people confusion.

The confusion can still happen when people are wondering which driver to
build for their SoC.

It seems that both names are confusing -- sdhci-mmp would confuse this
driver with the one submitted by Saeed Bishara for Dove/MMP, and
sdhci-pxa confuses it with pxamci.c.

Have you considered sdhci-mmp for Saeed's driver, and sdhci-mmp2 for
this driver?  Or, sdhci-dove and sdhci-mmp2?  Perhaps a non-exhaustive
distinction is better than an incorrectly generalized one.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

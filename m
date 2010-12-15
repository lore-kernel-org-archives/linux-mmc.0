From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 05:35:28 -0600
Message-ID: <20101215113528.GB2500@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-5-git-send-email-olof@lixom.net> <4D08A798.1070709@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:42970 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab0LOLf3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 06:35:29 -0500
Content-Disposition: inline
In-Reply-To: <4D08A798.1070709@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>

On Wed, Dec 15, 2010 at 05:03:44PM +0530, Pavan Kondeti wrote:
> On 12/15/2010 10:19 AM, Olof Johansson wrote:
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (res == NULL)
> > +		return -ENODEV;
> > +
> > +	ioaddr = ioremap(res->start, res->end - res->start);
> > +
> 
> Return value is not checked.

Good catch. Thanks.


-Olof

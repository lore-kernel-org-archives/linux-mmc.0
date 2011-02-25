From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 7/8] OMAP: adapt hsmmc to hwmod framework
Date: Fri, 25 Feb 2011 12:57:11 -0800
Message-ID: <20110225205711.GE20560@atomide.com>
References: <1298653783-26410-1-git-send-email-kishore.kadiyala@ti.com>
 <1298653783-26410-8-git-send-email-kishore.kadiyala@ti.com>
 <20110225204343.GD20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49995 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab1BYU5R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 15:57:17 -0500
Content-Disposition: inline
In-Reply-To: <20110225204343.GD20560@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com

* Tony Lindgren <tony@atomide.com> [110225 12:42]:
> * Kishore Kadiyala <kishore.kadiyala@ti.com> [110225 09:00]:
> > +static int omap_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
> ...
> 
> > +	static int mmc_num;
> > +
> > +	c += mmc_num;
> 
> This does not look right..

So since mmc_num is static, it gets initialized to 0, then increased
for each call.. What if you want to intialize controller 1 and 3 but
not 2?

Also, why do you pass void *hsmmcinfo to the function and then cast
it to struct omap2_hsmmc_inf *? Why not pass struct omap2_hsmmc_info *
to start with?

Regards,

Tony

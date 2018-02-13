From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/3] mmc: tmio: add eMMC HS400 mode support
Date: Tue, 13 Feb 2018 12:33:53 +0100
Message-ID: <20180213113353.tioy73y2ggsat7m3@verge.net.au>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180119133906.11280-3-horms+renesas@verge.net.au>
 <20180207222012.5hxmo2sdelur4uoj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47842 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933964AbeBMLd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Feb 2018 06:33:58 -0500
Content-Disposition: inline
In-Reply-To: <20180207222012.5hxmo2sdelur4uoj@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wed, Feb 07, 2018 at 11:20:12PM +0100, Wolfram Sang wrote:
> 
> Hi Simon,
> 
> > +	void (*disable_scc)(struct mmc_host *mmc);
> 
> Do we really need this callback? I'd think it can be folded into
> reset_hs400_mode() because it is called only once?
> 
> > +	void (*prepare_hs400_tuning)(struct mmc_host *mmc, struct mmc_ios *ios);
> 
> Can't we use the host->ops->prepare_hs400_tuning() callback invoked by
> the core?

Empirically that does not seem to work.

> > +	void (*reset_hs400_mode)(struct mmc_host *mmc);
> 
> Maybe we can get rid of this, too? See later...
> 
> > +	if (host->disable_scc)
> > +		host->disable_scc(mmc);
> 
> (Here, this can be folded into the next callback)

Yes, agreed. I've folded the callbacks as you suggest.

> > +
> > +	/* reset HS400 mode */
> > +	if (ios->timing != MMC_TIMING_MMC_HS400 && host->reset_hs400_mode)
> > +		host->reset_hs400_mode(mmc);
> 
> I wonder: If for any ios which is != MMC_TIMING_MMC_HS400, the
> hs400_mode needs to be reset. Couldn't we as well then disable the mode
> always after the MMC_TIMING_MMC_HS400 tuning was selected? Just
> brainstorming here...

Perhaps but I'm unsure where we would hook in this change, any ideas?


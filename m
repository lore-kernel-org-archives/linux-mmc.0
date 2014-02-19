From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 31/31] mmc: sdhci-tegra: get rid of special
	PRESENT_STATE register handling
Date: Wed, 19 Feb 2014 23:22:53 +0000
Message-ID: <20140219232253.GW21483@n2100.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk> <E1WFmKj-0006nv-Py@rmk-PC.arm.linux.org.uk> <53050E43.3030602@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:43476 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750996AbaBSXXA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2014 18:23:00 -0500
Content-Disposition: inline
In-Reply-To: <53050E43.3030602@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org

On Wed, Feb 19, 2014 at 01:04:19PM -0700, Stephen Warren wrote:
> On 02/18/2014 08:11 AM, Russell King wrote:
> > sdhci-tegra provides a get_ro method, which overrides the checking
> > of the write protect bit in the PRESENT_STATE register in sdhci.c:
> > 
> >         if (host->flags & SDHCI_DEVICE_DEAD)
> >                 is_readonly = 0;
> >         else if (host->ops->get_ro)
> >                 is_readonly = host->ops->get_ro(host);
> >         else
> >                 is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
> >                                 & SDHCI_WRITE_PROTECT);
> > 
> > This means it's pointless detecting accesses to this register and
> > manually setting the SDHCI_WRITE_PROTECT as it has no effect.
> > 
> > This means that the whole of tegra_sdhci_readl() can be removed and
> > we can use the builtin sdhci readl functionality here.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks.

> > =-DO NOT APPLY-=
> 
> Is that just because it's an RFC and you want to make sure it doesn't
> get accepted early, or are you explicitly trying to stop people applying
> this, testing it, and giving Tested-by?

The script was a little too over-zealous.  It was just supposed to do
the following transformation:

--- => =-DO NOT APPLY-=
+++ => =+DO NOT APPLY+=

which would've made it reversible with a trivial sed expression - but I
cocked up because of the utterly random nature of regexp flavours, and
instead gave sed this:

	sed -i 's/^---/=-DO NOT APPLY-=/;s/^\+\+\+/=+DO NOT APPLY+=/'

The escaped '+' ends up causing sed to match a single + at the beginning
of a line.  (Other regexp flavours require you to escape the '+' otherwise
it's interpreted as "one or more".)

I had added that mode to my script a few months ago, and I just assumed
I'd fully tested it when I used it yesterday... clearly not so.

So... yes it was designed to stop it being _accepted_ but it should have
also been completely reversible for those who wished to apply it via
the obvious reversed sed expression.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

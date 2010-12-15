From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 05:31:15 -0600
Message-ID: <20101215113115.GB2086@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-5-git-send-email-olof@lixom.net> <4D08A54E.9070103@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:43639 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab0LOLbP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 06:31:15 -0500
Content-Disposition: inline
In-Reply-To: <4D08A54E.9070103@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>

Hi,

On Wed, Dec 15, 2010 at 01:23:58PM +0200, Mike Rapoport wrote:
> Hi Olof,
> 
> Overall looks good, just some nitpicking comments.
> 
[...]

> > +struct tegra_sdhci_platform_data {
> > +	int cd_gpio;
> > +	int wp_gpio;
> > +	int power_gpio;
> 
> The power_gpio seems to be unused...

Yep, will remove.

> > +static unsigned int tegra_sdhci_get_ro(struct sdhci_host *sdhci)
> > +{
> > +	struct tegra_sdhci_host *host = sdhci_priv(sdhci);
> > +
> > +	if (host->wp_gpio != -1)
> 
> if (gpio_is_valid(host->wp_gpio)) whould be better IMO.
[...]
> > +	if (plat->cd_gpio != -1) {
> 
> if (gpio_is_valid(host->wp_gpio)) whould be better IMO.
> 

Fair enough (x2).

> > +		rc = request_irq(gpio_to_irq(plat->cd_gpio), carddetect_irq,
> > +			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> > +			mmc_hostname(sdhci->mmc), sdhci);
> > +
> > +		if (rc)
> > +			goto err_remove_host;
> > +	}
> 
> It seems to me that the tegra_sdhci_probe should handle gpio initialization,
> rather then keep gpio_request etc calls in the board files.

Yeah, I had been planning on moving that over but not at this pass. I can do that
though.

> > +	printk(KERN_INFO "sdhci%d: initialized irq %d ioaddr %p\n", pdev->id,
> > +			sdhci->irq, sdhci->ioaddr);
> > +
> 
> dev_info?

Yep, will change.



Thanks!


-Olof

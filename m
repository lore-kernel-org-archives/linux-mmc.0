From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3 v2] Add SDHCI driver for Tegra
Date: Wed, 22 Dec 2010 08:06:29 +0000
Message-ID: <20101222080629.GA19898@void.printf.net>
References: <1293004871-1918-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50349 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab0LVIGc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 03:06:32 -0500
Content-Disposition: inline
In-Reply-To: <1293004871-1918-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Olof,

On Wed, Dec 22, 2010 at 02:01:08AM -0600, Olof Johansson wrote:
> This is the second version of the SDHCI driver for tegra. I moved it
> over to a sdhci-pltfm variant, which turned out to be feasible -- at
> least as long as the platform_data is never required by sdhci-pltfm and
> can be used by the sub-driver.
> 
> I also did away with wone of the quirks, since based on current testing
> it seems to no longer be required. If needed it can be reintroduced in
> some way or other later on instead.

At first glance, this looks *much* better as a -pltfm driver.  Thanks
very much for redoing it!

> The one remaining quirk is of the kind that can be moved entirely into
> the driver, and I will look at doing so when I get around to cleaning
> up other quirks together with it.

Yes, that'd be great.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

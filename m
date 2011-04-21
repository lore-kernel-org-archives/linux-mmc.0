From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/5] consolidate sdhci pltfm & OF drivers and get them
 self registered
Date: Thu, 21 Apr 2011 15:48:18 +0800
Message-ID: <20110421074818.GC4024@S2100-06.ap.freescale.net>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
 <20110419102031.GA4164@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:54738
	"EHLO VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753428Ab1DUHoa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 03:44:30 -0400
Content-Disposition: inline
In-Reply-To: <20110419102031.GA4164@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-dev@lists.linaro.org, sameo@linux.intel.com, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Wolfram,

Thanks for the review.

On Tue, Apr 19, 2011 at 12:20:31PM +0200, Wolfram Sang wrote:
[...]
> The approach seems sensible, so have a look at my (mostly minor)
> comments inside the patches. However, there is one bigger piece missing.
> You converted all the drivers which had a seperate source-file and
> hooked into sdhci-pltfm.c. However, those are only those users which
> need additional code to work around the quirks. There are also users
> which can take the plain pltfm-driver with a properly set
> platform_data (check the thread "[PATCH] mmc: add SDHCI driver for STM
> platforms (V2)" for an example). Those have to be converted, too.

Even those drivers need pltfm-<something>.c to accommodate the
platform_data, right?  I think sdhci-dove.c (sitting on mainline) is
also such an example.  So if I'm not mistaken, I did take care of the
drivers which can take the current plain pltfm-sdhci driver.

> Now the discussion could be if every of those users gets its own
> pltfm-<something>.c or if we create something similat to
> sdhci-pltfm-generic, which can also be setup with platform_data like the
> old driver (/me likes the latter a bit more. If we don't change the name
> of the driver (not talking about the sourcefile) and keep it
> "sdhci-pltfm", then you wouldn't need to change all those users if you
> ensured it behaves the same.
> 
Since there are already pltfm-<something>.c to hold platform_data for
those users anyway, it's not an argument here.

> Also, I think the next version of this series should have all makers of
> a sdhci-pltfm user CCed so we give them a chance to report breakage. Or
> donate acks or tested-by.
> 
Ok, will do.

-- 
Regards,
Shawn


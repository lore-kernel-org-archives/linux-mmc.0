From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/5] consolidate sdhci pltfm & OF drivers and get them self registered
Date: Thu, 31 Mar 2011 12:36:53 -0400
Message-ID: <m38vvvz1p6.fsf@pullcord.laptop.org>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45688 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757906Ab1CaQbN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 31 Mar 2011 12:31:13 -0400
In-Reply-To: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Fri, 25 Mar 2011 16:48:46 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, linaro-dev@lists.linaro.org, patches@linaro.org

Hi Wolfram,

On Fri, Mar 25 2011, Shawn Guo wrote:
> Here are what the patch set does.
>
> * Remove .probe and .remove hooks from sdhci-pltfm.c and make it be
>   a pure common helper function providers.
> * Add .probe and .remove hooks for sdhci pltfm drivers sdhci-cns3xxx,
>   sdhci-dove, sdhci-tegra, and sdhci-esdhc-imx to make them self
>   registered with calling helper functions created above.
> * Migrate the use of sdhci_of_host and sdhci_of_data to
>   sdhci_pltfm_host and sdhci_pltfm_data, so that OF version host and
>   data structure works can be saved, and pltfm version works for both
>   cases.
> * Add OF common helper stuff into sdhci-pltfm.c, and make OF version
>   sdhci drivers sdhci-of-esdhc and sdhci-of-hlwd become self
>   registered as well, so that sdhci-of-core.c and sdhci-of.h can be
>   removed.
> * Consolidate the OF and pltfm esdhc drivers into one with sharing
>   the same pair of .probe and .remove hooks.  As a result,
>   sdhci-esdhc-imx.c and sdhci-of-esdhc.c go away, while
>   sdhci-esdhc.c comes in and works for both MPCxxx and i.MX.
> * Eliminate include/linux/mmc/sdhci-pltfm.h with moving stuff into
>   drivers/mmc/host/sdhci-pltfm.h.

If you get time, would appreciate getting an ACK from you on the patch
changes (including Grant's review).  Thanks very much!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

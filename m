From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Add a common clk API based
 implementation of get_timeout_clock
Date: Tue, 29 Jan 2013 13:51:13 +0800
Message-ID: <20130129055112.GB21504@S2101-09.ap.freescale.net>
References: <1359397632-31646-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:16891
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319Ab3A2FvI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 00:51:08 -0500
Content-Disposition: inline
In-Reply-To: <1359397632-31646-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Chris Ball <cjb@laptop.org>, Stephen Warren <swarren@wwwdotorg.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org

On Mon, Jan 28, 2013 at 07:27:12PM +0100, Lars-Peter Clausen wrote:
> Quite a few drivers have a implementation of the get_timeout_clock callback
> which simply returns the result of clk_get_rate on devices clock. This patch
> adds a common implementation of this to the sdhci-pltfm module and replaces all
> custom implementations with the common one.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> I've only runtime tested this patch on a platform which is not yet upstream. For
> the drivers which are modified in this patch I've only done compile time
> testing. But I think all changes, but maybe the bcm2835 one, are straight
> forward.
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |  9 +--------

Acked-by: Shawn Guo <shawn.guo@linaro.org>


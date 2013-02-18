From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci_pltfm: Constify sdhci_pltfm_data
Date: Mon, 18 Feb 2013 10:58:12 +0800
Message-ID: <20130218025810.GJ6782@S2101-09.ap.freescale.net>
References: <1360865181-11785-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:27287
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754047Ab3BRDKv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Feb 2013 22:10:51 -0500
Content-Disposition: inline
In-Reply-To: <1360865181-11785-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mike Rapoport <mike@compulab.co.il>, Albert Herranz <albert_herranz@yahoo.es>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org

On Thu, Feb 14, 2013 at 07:06:19PM +0100, Lars-Peter Clausen wrote:
> The sdhci_pltfm_data struct is never modified within the sdhci_pltfm module. So
> make the pdata parameter to sdhci_pltfm_init and sdhci_pltfm_register const.
> This allows drivers to declare their sdhci_pltfm_data struct as const.
> 
> This patch also makes the sdhci_pltfm_data declarations const where possible.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
...
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-

For all 3 patches,

Acked-by: Shawn Guo <shawn.guo@linaro.org>


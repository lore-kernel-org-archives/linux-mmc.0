From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2 1/2] mmc: sdhci-esdhc-imx: fix access hardirq-unsafe
 lock in atomic context
Date: Tue, 31 Dec 2013 13:24:38 +0800
Message-ID: <20131231052436.GA22122@S2101-09.ap.freescale.net>
References: <1388042634-17281-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:43509 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750746Ab3LaFYb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Dec 2013 00:24:31 -0500
Content-Disposition: inline
In-Reply-To: <1388042634-17281-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de

On Thu, Dec 26, 2013 at 03:23:53PM +0800, Dong Aisheng wrote:
> Sometimes we may meet the following lockdep issue.
> The root cause is .set_clock callback is executed with spin_lock_irqsave
> in sdhci_do_set_ios. However, the IMX set_clock callback will try to access
> clk_get_rate which is using a mutex lock.
> 
> The fix avoids access mutex in .set_clock callback by initializing the
> pltfm_host->clock at probe time and use it later instead of calling
> clk_get_rate again in atomic context.

<snip>

> Cc: Chris Ball <cjb@laptop.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

For both,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Fixes: 0ddf03c mmc: esdhc-imx: parse max-frequency from devicetree
> Signed-off-by: Dong Aisheng <b29396@freescale.com>


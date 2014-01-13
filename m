From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH V2 1/2] mmc: sdhci-esdhc-imx: fix access hardirq-unsafe lock in atomic context
Date: Mon, 13 Jan 2014 18:41:59 +0000
Message-ID: <86k3e3afm0.fsf@void.printf.net>
References: <1388042634-17281-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51474 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaAMSmB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 13:42:01 -0500
In-Reply-To: <1388042634-17281-1-git-send-email-b29396@freescale.com> (Dong
	Aisheng's message of "Thu, 26 Dec 2013 15:23:53 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de

Hi,

On Thu, Dec 26 2013, Dong Aisheng wrote:
> Sometimes we may meet the following lockdep issue.
> The root cause is .set_clock callback is executed with spin_lock_irqsave
> in sdhci_do_set_ios. However, the IMX set_clock callback will try to access
> clk_get_rate which is using a mutex lock.
>
> The fix avoids access mutex in .set_clock callback by initializing the
> pltfm_host->clock at probe time and use it later instead of calling
> clk_get_rate again in atomic context.
>
> [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]

Thanks, pushed to mmc-next.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>

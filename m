From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/8] mmc: sdhci-esdhc-imx: add std tuning for mx6sl and DDR mode support
Date: Sun, 20 Oct 2013 22:12:45 -0400
Message-ID: <87sivv8j8i.fsf@octavius.laptop.org>
References: <1382096930-7964-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47893 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab3JUCMx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Oct 2013 22:12:53 -0400
In-Reply-To: <1382096930-7964-1-git-send-email-b29396@freescale.com> (Dong
	Aisheng's message of "Fri, 18 Oct 2013 19:48:42 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, wsa@the-dreams.de

Hi Dong,

On Fri, Oct 18 2013, Dong Aisheng wrote:
> The i.MX6SL supports standard tuning as defined in standard host control spec v3.0.
> So this patch series add std tuning support for i.MX6SL.
> (NOTE i.MX6SL can also work on the old manual tuning mode as i.MX6Q/DL)
> In the meanwhile, it also adds DDR mode support.
> Then SD3.0 cards which can only support DDR50 can work properly now
> with this patch series.
>
> Patch 1~3 add stardard tuning support for i.MX6SL.
> Patch 4~5 add DDR mode and delay line support
> Patch 6~8 some other related minor fixes.
>
> Tested on i.MX6SL EVK board.
>
> The patch series is generated based on the latest mmc-next branch with Shawn's
> (1)[PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type in Chris' tree.

Thanks, all eight patches pushed to mmc-next for 3.13 with Shawn's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

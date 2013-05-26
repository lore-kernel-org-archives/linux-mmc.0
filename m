From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: fix multiblock reads on i.MX53
Date: Sun, 26 May 2013 13:14:39 -0400
Message-ID: <8738t9slxc.fsf@octavius.laptop.org>
References: <1363272225-1304-1-git-send-email-l.stach@pengutronix.de>
	<1363337366-8532-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38333 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423Ab3EZROn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:14:43 -0400
In-Reply-To: <1363337366-8532-1-git-send-email-l.stach@pengutronix.de> (Lucas
	Stach's message of "Fri, 15 Mar 2013 09:49:26 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

Hi,

On Fri, Mar 15 2013, Lucas Stach wrote:
> The eSDHC controller on the i.MX53 needs an additional, non spec
> compliant CMD12 after a multiblock read with a predefined number of
> blocks. Otherwise the internal state machine won't go back to the
> idle state.
>
> This commit effectively reverts 5b6b0ad6 (mmc: sdhci-esdhc-imx:
> fix for mmc cards on i.MX5), which fixed part of the problem by
> making multiblock reads work, however this fix was not sufficient
> when multi- and singleblock reads got intermixed.
>
> This implements the recommended workaround (Freescale i.MX Reference
> Manual, section 29.6.8 "Multi-block Read") by manually sending a
> CMD12 with the RSPTYP bits cleared.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

I haven't seen any review comments from -imx developers -- I've gone
ahead and applied this to mmc-next now.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-esdhc-imx: fix warning during module remove function
Date: Mon, 13 Jan 2014 18:40:09 +0000
Message-ID: <8638krbu9i.fsf@void.printf.net>
References: <1388042634-17281-1-git-send-email-b29396@freescale.com>
	<1388042634-17281-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51361 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaAMSkM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 13:40:12 -0500
In-Reply-To: <1388042634-17281-2-git-send-email-b29396@freescale.com> (Dong
	Aisheng's message of "Thu, 26 Dec 2013 15:23:54 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de

Hi,

On Thu, Dec 26 2013, Dong Aisheng wrote:
> Since the clock is managed by runtime pm currently, we do not need
> disable it again during driver remove function, or it will cause
> clock disable count mismatch issue since the clocks have already been disabled.
>
> The issue can be simply reproduced by unbind the devices via sysfs.
> mx6slevk:/sys/bus/platform/drivers/sdhci-esdhc-imx# echo 2194000.usdhc > unbind
> mmc1: card aaaa removed
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 657 at drivers/clk/clk.c:842 __clk_disable+0x68/0x88()

Thanks, pushed to mmc-next.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>

From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v3] mmc/sdio: add a quirk for broken SDIO_CCCR_INTx polling
Date: Sat, 18 Jan 2014 03:55:56 +0000
Message-ID: <86txd254fn.fsf@void.printf.net>
References: <1385509160-26793-1-git-send-email-bzhao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58225 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbaARDz6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Jan 2014 22:55:58 -0500
In-Reply-To: <1385509160-26793-1-git-send-email-bzhao@marvell.com> (Bing
	Zhao's message of "Tue, 26 Nov 2013 15:39:20 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Paul Stewart <pstew@chromium.org>, Doug Anderson <dianders@chromium.org>

Hi,

On Tue, Nov 26 2013, Bing Zhao wrote:
> Polling SDIO_CCCR_INTx could create a fake interrupt with Marvell
> SD8797 card. Add a quirk to handle this case. The fixup here is
> to issue a dummy CMD52 read to function 0 register 0xff, and this
> dummy read must be right after SDIO_CCCR_INTx is read.
>
> Patch has been verified on a dw_mmc controller (Samsung Chromebook)
> with MMC_CAP_SDIO_IRQ disabled.
>
> Reviewed-by: Paul Stewart <pstew@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, sorry for the delay, pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>

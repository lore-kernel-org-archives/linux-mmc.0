From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-esdhc-imx: adding eMMC HS200 mode support
Date: Tue, 26 Nov 2013 16:39:43 -0500
Message-ID: <87ob56g7vk.fsf@octavius.laptop.org>
References: <1383142242-24989-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34310 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533Ab3KZVjy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 16:39:54 -0500
In-Reply-To: <1383142242-24989-1-git-send-email-b29396@freescale.com> (Dong
	Aisheng's message of "Wed, 30 Oct 2013 22:10:40 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, wsa@the-dreams.de

Hi Dong,

On Wed, Oct 30 2013, Dong Aisheng wrote:
> Dong Aisheng (2):
>   mmc: sdhci: replace msleep with mdelay for tuning
>   mmc: sdhci-esdhc-imx: add eMMC HS200 mode support
>
>  drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
>  drivers/mmc/host/sdhci.c           |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)

Patch 1 is no longer required, applied patch 2 to mmc-next for 3.14,
thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

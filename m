From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: PATCH: sdhci.h fix typo
Date: Thu, 29 Apr 2010 09:36:14 +0100
Message-ID: <20100429083614.GD2589@trinity.fluff.org>
References: <x2g309424b61004290105l9ac20be7w46b202b96eb8a7d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:55794 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191Ab0D3VOg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Apr 2010 17:14:36 -0400
Content-Disposition: inline
In-Reply-To: <x2g309424b61004290105l9ac20be7w46b202b96eb8a7d1@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

On Thu, Apr 29, 2010 at 04:05:06PM +0800, zhangfei gao wrote:
> Hi,
> 
> Here is one typo erro in sdhci.h, though it does not impact the stability.
> 
> Thanks
> 
> >From 1fbcb05dbab2e5e5de72060f0481a279fa3eda18 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Thu, 22 Apr 2010 11:25:17 +0800
> Subject: [PATCH] mmc: SDHCI_INT_DATA_MASK typo error
> 
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> Reviewed-by: Matt Fleming <matt@console-pimps.org>
> ---
>  drivers/mmc/host/sdhci.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 842f46f..9ba4268 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -127,7 +127,7 @@
>  #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
>  		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
>  		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
> -		SDHCI_INT_DATA_END_BIT | SDHCI_ADMA_ERROR)
> +		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)

Hmm, how did I end up missing this one? A definite bug, SDHCI_ADMA_ERROR
value is 0x54. Currentlyt there is no INT definiton for the 0x4, and
SDHCI_INT_SPACE_AVAIL is 0x10. We end up adding SDHCI_INT_CARD_INSERT to
the list of interrupts for SDHCI_INT_DATA_MASK.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


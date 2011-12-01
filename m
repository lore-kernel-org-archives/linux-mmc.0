From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock from 100ms to 1ms
Date: Thu, 01 Dec 2011 13:10:33 -0500
Message-ID: <87vcq0kvs6.fsf@laptop.org>
References: <1321944150-12162-1-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50778 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524Ab1LASKa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 13:10:30 -0500
In-Reply-To: <1321944150-12162-1-git-send-email-tony.lin@freescale.com> (Tony
	Lin's message of "Tue, 22 Nov 2011 14:42:30 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lin <tony.lin@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, X.Xie@freescale.com, avorontsov@ru.mvista.com

Hi,

On Tue, Nov 22 2011, Tony Lin wrote:
> 1ms is enough for hardware to change the clock to stable.
> 100ms is too long in the tasklet.
>
> Signed-off-by: Tony Lin <tony.lin@freescale.com>
> CC: Xiaobo Xie <X.Xie@freescale.com>
> CC: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/mmc/host/sdhci-esdhc.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index c3b08f1..b97b2f5 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -73,7 +73,7 @@ static inline void esdhc_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  		| (div << ESDHC_DIVIDER_SHIFT)
>  		| (pre_div << ESDHC_PREDIV_SHIFT));
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> -	mdelay(100);
> +	mdelay(1);
>  out:
>  	host->clock = clock;
>  }

I don't know if 1ms is actually long enough for the clock to stabilize
on all boards, but I'll push this change to mmc-next and we can see if
we get any regression reports.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

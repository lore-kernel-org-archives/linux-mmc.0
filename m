From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-of-esdhc: fix building error
Date: Fri, 27 Sep 2013 13:20:43 +0800
Message-ID: <20130927052041.GH25146@S2101-09.ap.freescale.net>
References: <1380254414-12045-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:29752
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab3I0FS5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2013 01:18:57 -0400
Content-Disposition: inline
In-Reply-To: <1380254414-12045-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, fengguang.wu@intel.com

On Fri, Sep 27, 2013 at 12:00:14PM +0800, Dong Aisheng wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
> head:   53279906cf17c2b6138c70f41ec8f2da53cea65f
> commit: d31fc00a71b4f3a52d23c5a995ccd63e50a2c877 [36/41] mmc: sdhci-esdhc: move common esdhc_set_clock to platform driver
> config: make ARCH=powerpc allmodconfig
> 
> All error/warnings:
> 
>    drivers/mmc/host/sdhci-of-esdhc.c: In function 'esdhc_of_set_clock':
> >> drivers/mmc/host/sdhci-of-esdhc.c:229:179: error: 'host_clock' undeclared (first use in this function)
>      dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
>                                                                                                                                                                                       ^
>    drivers/mmc/host/sdhci-of-esdhc.c:229:179: note: each undeclared identifier is reported only once for each function it appears in
> 
> vim +/host_clock +229 drivers/mmc/host/sdhci-of-esdhc.c
> 
>    223          while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
>    224                  pre_div *= 2;
>    225
>    226          while (host->max_clk / pre_div / div > clock && div < 16)
>    227                  div++;
>    228
>  > 229           dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
>    230                  clock, host_clock / pre_div / div);
>    231
>    232          pre_div >>= 1;
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

I just compile-tested it with powerpc toolchain, so

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Hi Chris,

It's your call to apply it as a fix patch or amend it to the offending
one.  We're fine with either way.

Shawn

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index b1605a1..0b24997 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -227,7 +227,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  		div++;
>  
>  	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
> -		clock, host_clock / pre_div / div);
> +		clock, host->max_clk / pre_div / div);
>  
>  	pre_div >>= 1;
>  	div--;
> -- 
> 1.7.2.rc3
> 
> 


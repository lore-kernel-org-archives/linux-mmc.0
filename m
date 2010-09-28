From: Philip Rakity <prakity@marvell.com>
Subject: Re: [patch] sdhci: correct f_min in sd 3.0
Date: Mon, 27 Sep 2010 21:05:26 -0700
Message-ID: <8C0FC31B-681F-4541-AD64-43578FC926F6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:39765 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750891Ab0I1EPQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Sep 2010 00:15:16 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zgao6@marvell.com>


The code snippet
> +			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
>  				if ((host->max_clk / div) <= clock)
>  					break;

is not correct.  In sdio 3.0 the value is not a power of 2 for the divider but the value to be divided down-- all the bits count
2) 10-bit Divided Clock
Host Controller Version 3.00 supports this mandatory mode instead of the
8-bit Divided Clock Mode.  The length of the divider is extended to 10 bits and all
divider values shall be supported.
3FFh    1/2046  Divided Clock

Philip

Hi Zhangfei,

On Sat, Sep 25, 2010 at 12:23:33AM -0400, zhangfei gao wrote:
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 20 Sep 2010 15:15:18 -0400
> Subject: [PATCH] sdhci: correct f_min in sd 3.0
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    8 +++++---
>  drivers/mmc/host/sdhci.h |    3 +++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 5928b0a..829e78a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1007,14 +1007,14 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  		if (host->max_clk <= clock)
>  			div = 1;
>  		else {
> -			for (div = 2; div < 2046; div += 2) {
> +			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
>  				if ((host->max_clk / div) <= clock)
>  					break;
>  			}
>  		}
>  	} else {
>  		/* Version 2.00 divisors must be a power of 2. */
> -		for (div = 1; div < 256; div *= 2) {
> +		for (div = 1; div < SDHCI_MAX_DIV_SPEC_200; div *= 2) {
>  			if ((host->max_clk / div) <= clock)
>  				break;
>  		}
> @@ -1836,8 +1836,10 @@ int sdhci_add_host(struct sdhci_host *host)
>  	mmc->ops = &sdhci_ops;
>  	if (host->ops->get_min_clock)
>  		mmc->f_min = host->ops->get_min_clock(host);
> +	else if (host->version >= SDHCI_SPEC_300)
> +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>  	else
> -		mmc->f_min = host->max_clk / 256;
> +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
>  	mmc->f_max = host->max_clk;
>  	mmc->caps |= MMC_CAP_SDIO_IRQ;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index ae28a31..d35fb3d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -185,6 +185,9 @@
>  #define   SDHCI_SPEC_200	1
>  #define   SDHCI_SPEC_300	2
>  
> +#define	SDHCI_MAX_DIV_SPEC_200	256
> +#define	SDHCI_MAX_DIV_SPEC_300	2046
> +
>  struct sdhci_ops;
>  
>  struct sdhci_host {

Thanks very much, I've applied this to mmc-next now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


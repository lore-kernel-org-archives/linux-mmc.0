From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-s3c: fix the wrong register value, when clock is disabled
Date: Thu, 29 Aug 2013 21:18:41 -0400
Message-ID: <87a9k0x9fy.fsf@octavius.laptop.org>
References: <51FBBD7A.4050501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33271 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356Ab3H3BSr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Aug 2013 21:18:47 -0400
In-Reply-To: <51FBBD7A.4050501@samsung.com> (Jaehoon Chung's message of "Fri,
	02 Aug 2013 23:08:58 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>

Hi Jaehoon,

On Fri, Aug 02 2013, Jaehoon Chung wrote:
> When use the QUIRK_NONSTANDARD_CLOCK, then never set to 0 at clock control register.
> This patch is fixed this problem.
> ([PATCHv2] mmc: sdhci-s3c: fix teh wrong register value, when clock is disabled)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog v2:
> 	- modified the comment
>
>  drivers/mmc/host/sdhci-s3c.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 926aaf6..1572b6a 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -296,9 +296,12 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  	unsigned long timeout;
>  	u16 clk = 0;
>  
> -	/* don't bother if the clock is going off */
> -	if (clock == 0)
> +	/* If the clock is going off, set to 0 at clock control register */
> +	if (clock == 0) {
> +		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +		host->clock = clock;
>  		return;
> +	}
>  
>  	sdhci_s3c_set_clock(host, clock);

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

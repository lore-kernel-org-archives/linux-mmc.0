From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv2] mmc: sdhci-s3c: fix the wrong register value when, clock is disabled
Date: Thu, 27 Jun 2013 10:53:10 -0400
Message-ID: <87ip0zr4fd.fsf@octavius.laptop.org>
References: <51A2DCC4.2020307@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37378 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab3F0OxP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:53:15 -0400
In-Reply-To: <51A2DCC4.2020307@samsung.com> (Jaehoon Chung's message of "Mon,
	27 May 2013 13:10:44 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Jaehoon,

On Mon, May 27 2013, Jaehoon Chung wrote:
> When use the QUIRK_NONSTANDARD_CLOCK, then never set to 0 at clock control register.
> This patch is fixed this problem.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.co
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog v2:
> - Rebased at the latest mmc tree
>
>  drivers/mmc/host/sdhci-s3c.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 926aaf6..ce71f32 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -297,8 +297,11 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  	u16 clk = 0;
>  
>  	/* don't bother if the clock is going off */
> -	if (clock == 0)
> +	if (clock == 0) {
> +		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +		host->clock = clock;
>  		return;
> +	}
>  
>  	sdhci_s3c_set_clock(host, clock);

You should change the comment too, since your patch invalidates it.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

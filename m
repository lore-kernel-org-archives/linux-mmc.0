From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V5 1/3] SDHCI: S3C: Use generic clock names for sdhci bus clock options
Date: Wed, 26 Oct 2011 15:59:42 -0400
Message-ID: <m2obx34j81.fsf@bob.laptop.org>
References: <1318588126-19167-1-git-send-email-rajeshwari.s@samsung.com>
	<1318588126-19167-2-git-send-email-rajeshwari.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34443 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab1JZUAN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 26 Oct 2011 16:00:13 -0400
In-Reply-To: <1318588126-19167-2-git-send-email-rajeshwari.s@samsung.com>
	(Rajeshwari Shinde's message of "Fri, 14 Oct 2011 15:58:44 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org

Hi Rajeshwari, Kukjin,

On Fri, Oct 14 2011, Rajeshwari Shinde wrote:
> This patch modifies the driver to stop depending on the clock names
> being passed from the platform and switch over to bus clock lookup
> using generic clock names.
>
> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 82709b6..a5fde87 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -435,14 +435,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  
>  	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>  		struct clk *clk;
> -		char *name = pdata->clocks[ptr];
> +		char name[14];
>  
> -		if (name == NULL)
> -			continue;
> +		sprintf(name, "mmc_busclk.%d", ptr);

Let's use snprintf() here instead -- it's better to have fewer uses of
sprintf() to audit.

>  		clk = clk_get(dev, name);
>  		if (IS_ERR(clk)) {
> -			dev_err(dev, "failed to get clock %s\n", name);
>  			continue;
>  		}

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

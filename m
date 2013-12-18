From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/4] Moving of_init_opp_table
Date: Wed, 18 Dec 2013 15:43:17 +0800
Message-ID: <20131218074315.GH6691@S2101-09.ap.freescale.net>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
 <1387329451-17480-2-git-send-email-john.tobias.ph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:12614
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961Ab3LRHmL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 02:42:11 -0500
Content-Disposition: inline
In-Reply-To: <1387329451-17480-2-git-send-email-john.tobias.ph@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, festevam@gmail.com, cjb@laptop.org

On Tue, Dec 17, 2013 at 05:17:29PM -0800, John Tobias wrote:
>     Moving of_init_opp_table from mach-imx6q.c to imx6q-cpufreq.c in order to avoid adding it to mach-imx6sl.c.
>     Just incase the cpu frequency scaling is enabled on iMX6SL.

Drop the leading spaces and wrap the lines around 72 column.

> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 5 +++++

For this patch, a proper patch subject prefix would be 'cpufreq: imx6q: '
You can use 'git log' to find out what a proper prefix for a file/patch
should be.

>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 4b3f18e..2eea3d9 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -166,6 +166,11 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> +	if (of_init_opp_table(cpu_dev)) {
> +		dev_err(cpu_dev,"failed to init OPP table\n");
> +		return -ENODEV;
> +	}
> +

Before doing that in the driver, you should check and make sure that
platform hasn't supply a opp table.

Shawn

>  	arm_clk = devm_clk_get(cpu_dev, "arm");
>  	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
>  	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
> -- 
> 1.8.3.2
> 


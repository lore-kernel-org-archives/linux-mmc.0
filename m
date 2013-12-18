From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/4] Removing imx6q_opp_init
Date: Wed, 18 Dec 2013 15:49:28 +0800
Message-ID: <20131218074926.GI6691@S2101-09.ap.freescale.net>
References: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
 <1387329451-17480-3-git-send-email-john.tobias.ph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:28478
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751072Ab3LRHsX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 02:48:23 -0500
Content-Disposition: inline
In-Reply-To: <1387329451-17480-3-git-send-email-john.tobias.ph@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, festevam@gmail.com, cjb@laptop.org

On Tue, Dec 17, 2013 at 05:17:30PM -0800, John Tobias wrote:
>     Since of_init_opp_table is in imx6q-cpufreq.c, the imx6q_opp_init is no longer needed anymore.
>     The only question right now is the imx6q_opp_check_1p2ghz function.
> 
>     Is the function below are acceptible under imx6q_init_late?.
> 
>     if (!cpu_dev)
>         imx6q_opp_check_1p2ghz(cpu_dev);
> 
>     If not, what is the better way to impelement because the said function is board specific?.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index d0cfb22..f5d9e04 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -183,31 +183,6 @@ put_node:
>  	of_node_put(np);
>  }
>  
> -static void __init imx6q_opp_init(void)
> -{
> -	struct device_node *np;
> -	struct device *cpu_dev = get_cpu_device(0);
> -
> -	if (!cpu_dev) {
> -		pr_warn("failed to get cpu0 device\n");
> -		return;
> -	}
> -	np = of_node_get(cpu_dev->of_node);
> -	if (!np) {
> -		pr_warn("failed to find cpu0 node\n");
> -		return;
> -	}
> -
> -	if (of_init_opp_table(cpu_dev)) {
> -		pr_warn("failed to init OPP table\n");
> -		goto put_node;
> -	}
> -
> -	imx6q_opp_check_1p2ghz(cpu_dev);
> -
> -put_node:
> -	of_node_put(np);
> -}
>  
>  static struct platform_device imx6q_cpufreq_pdev = {
>  	.name = "imx6q-cpufreq",
> @@ -215,6 +190,7 @@ static struct platform_device imx6q_cpufreq_pdev = {
>  
>  static void __init imx6q_init_late(void)
>  {
> +	struct device *cpu_dev = get_cpu_device(0);
>  	/*
>  	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
>  	 * to run cpuidle on them.
> @@ -223,8 +199,10 @@ static void __init imx6q_init_late(void)
>  		imx6q_cpuidle_init();
>  
>  	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
> -		imx6q_opp_init();
>  		platform_device_register(&imx6q_cpufreq_pdev);
> +		
> +		if (!cpu_dev)
> +			imx6q_opp_check_1p2ghz(cpu_dev);

imx6q_opp_check_1p2ghz() only works after of_init_opp_table() is called.
So you shouldn't make these changes in mach-imx6q.c, but in cpufreq
driver check if platform already supplies an opp table, and only calls
of_init_opp_table() in driver in case that platform hasn't.  Then, for
imx6q case where opp table is supplied by platform, driver will skip
of_init_opp_table() call, while for imx6sl case where platform does not
handle opp table, driver will just call of_init_opp_table().

Shawn

>  	}
>  }
>  
> -- 
> 1.8.3.2
> 


From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3]: Support cpu frequency scaling and power management
 for iMX6SL
Date: Tue, 17 Dec 2013 22:14:42 +0800
Message-ID: <20131217141440.GV6691@S2101-09.ap.freescale.net>
References: <CACUGKYP68joryww1cDreWWd1t_1VmfoNyFb1o2JvekH12_O7iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:25272
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753058Ab3LQONl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 09:13:41 -0500
Content-Disposition: inline
In-Reply-To: <CACUGKYP68joryww1cDreWWd1t_1VmfoNyFb1o2JvekH12_O7iw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Chris Ball <cjb@laptop.org>, Anson.Huang@freescale.com

On Mon, Dec 16, 2013 at 05:40:18PM -0800, John Tobias wrote:
> iMX6SL re-using iMX6Q driver in order to enable the cpu frequency
> scaling and power management
> 
> From: John Tobias <john.tobias.ph@gmail.com>
> 
> 
> diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
> index 2f952e3..e66eccf 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -9,7 +9,10 @@
> 
>  #include <linux/irqchip.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/pm_opp.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/regmap.h>
> @@ -17,6 +20,7 @@
>  #include <asm/mach/map.h>
> 
>  #include "common.h"
> +#include "cpuidle.h"
> 
>  static void __init imx6sl_fec_init(void)
>  {
> @@ -34,6 +38,47 @@ static void __init imx6sl_fec_init(void)
>         }
>  }
> 
> +

One blank line is enough.

> +static void __init imx6sl_opp_init(void)
> +{
> +       struct device_node *np;
> +       struct device *cpu_dev = get_cpu_device(0);
> +
> +       if (!cpu_dev) {
> +               pr_warn("failed to get cpu0 device\n");
> +               return;
> +       }
> +       np = of_node_get(cpu_dev->of_node);
> +       if (!np) {
> +               pr_warn("failed to find cpu0 node\n");
> +               return;
> +       }
> +
> +       if (of_init_opp_table(cpu_dev)) {
> +               pr_warn("failed to init OPP table\n");
> +               goto put_node;
> +       }
> +
> +put_node:
> +       of_node_put(np);
> +}

We have this for imx6q, because we need to check 1.2GHz case.  But
I hope we can improve imx6q-cpufreq driver to invoke of_init_opp_table()
from there, if platform does not supply an opp table, so that we can
save these code in platform for most of cases.

> +
> +static struct platform_device imx6q_cpufreq_pdev = {
> +       .name = "imx6q-cpufreq",
> +};
> +
> +
> +static void __init imx6sl_init_late(void)
> +{
> +       /* re-use imx6q */
> +       imx6q_cpuidle_init();

It's not about cpufreq.  The change does not belong to this patch.

> +
> +       if (IS_ENABLED(CONFIG_ARM_IMX6SQ_CPUFREQ)) {

IMX6SQ?

Shawn

> +               imx6sl_opp_init();
> +               platform_device_register(&imx6q_cpufreq_pdev);
> +       }
> +}
> +
>  static void __init imx6sl_init_machine(void)
>  {
>         struct device *parent;
> @@ -70,6 +115,7 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite
> (Device Tree)")
>         .map_io         = debug_ll_io_init,
>         .init_irq       = imx6sl_init_irq,
>         .init_machine   = imx6sl_init_machine,
> +       .init_late      = imx6sl_init_late,
>         .dt_compat      = imx6sl_dt_compat,
>         .restart        = mxc_restart,
>  MACHINE_END


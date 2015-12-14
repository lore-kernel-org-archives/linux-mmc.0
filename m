From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4, 3/6] powerpc/fsl: move mpc85xx.h to include/linux
Date: Mon, 14 Dec 2015 16:12:16 -0600
Message-ID: <1450131136.15946.390.camel@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	 <1450067067-44869-4-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0117.outbound.protection.outlook.com ([207.46.100.117]:10944
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753582AbbLNW2b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Dec 2015 17:28:31 -0500
In-Reply-To: <1450067067-44869-4-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com

On Mon, 2015-12-14 at 12:24 +0800, Yangbo Lu wrote:
> Move mpc85xx.h to include/linux and rename it to svr.h as
> a common header file. It has been used for mpc85xx and it will
> be used for ARM-based SoC as well.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> Changes for v4:
> 	- None
> ---
>  drivers/clk/clk-qoriq.c                                   | 2 +-
>  drivers/i2c/busses/i2c-mpc.c                              | 2 +-
>  drivers/iommu/fsl_pamu.c                                  | 2 +-
>  drivers/net/ethernet/freescale/gianfar.c                  | 2 +-
>  arch/powerpc/include/asm/mpc85xx.h => include/linux/svr.h | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)
>  rename arch/powerpc/include/asm/mpc85xx.h => include/linux/svr.h (97%)

include/linux/fsl/svr.h


> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 1ab0fb8..98c5ae0 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -1146,7 +1146,7 @@ bad_args:
>  }
>  
>  #ifdef CONFIG_PPC
> -#include <asm/mpc85xx.h>
> +#include <linux/svr.h>

Now that it's not PPC-specific the #include can go to the top of the file with
the rest of them.

>  
>  static const u32 a4510_svrs[] __initconst = {
>  	(SVR_P2040 << 8) | 0x10,	/* P2040 1.0 */
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 48ecffe..24b5bc7 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -27,9 +27,9 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/svr.h>
>  
>  #include <asm/mpc52xx.h>
> -#include <asm/mpc85xx.h>
>  #include <sysdev/fsl_soc.h>
>  
>  #define DRV_NAME "mpc-i2c"
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index a34355f..b014b63 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -24,7 +24,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/genalloc.h>
>  
> -#include <asm/mpc85xx.h>
> +#include <linux/svr.h>

Move it with the other linux/ includes (i.e. remove the blank line before
this).

>  
>  /* define indexes for each operation mapping scenario */
>  #define OMI_QMAN        0x00
> diff --git a/drivers/net/ethernet/freescale/gianfar.c
> b/drivers/net/ethernet/freescale/gianfar.c
> index 3e6b9b4..9b2d641 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -90,7 +90,7 @@
>  #include <asm/io.h>
>  #ifdef CONFIG_PPC
>  #include <asm/reg.h>
> -#include <asm/mpc85xx.h>
> +#include <linux/svr.h>
>  #endif
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>

Same comment as clk-qoriq.c -- this can come out of the ifdef and go with the
other linux/ includes.

-Scott


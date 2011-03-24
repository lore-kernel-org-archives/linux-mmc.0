From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V7 3/4] mmc: sdhci-esdhc: make the writel/readl as the general APIs
Date: Thu, 24 Mar 2011 19:14:03 -0400
Message-ID: <m3r59wm7r8.fsf@pullcord.laptop.org>
References: <1300684936-8218-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1300684936-8218-4-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53503 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934372Ab1CXXRj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Mar 2011 19:17:39 -0400
In-Reply-To: <1300684936-8218-4-git-send-email-Hong-Xing.Zhu@freescale.com>
	(Richard Zhu's message of "Mon, 21 Mar 2011 13:22:15 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, eric.miao@linaro.org

Hi Richard,

On Mon, Mar 21 2011, Richard Zhu wrote:
> Add one flag to indicate the GPIO CD/WP is enabled or not
> on imx platforms, and reuse the writel/readl as the general
> APIs for imx SOCs.
>
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   39 +++++++++++++++++++++++++++++------
>  drivers/mmc/host/sdhci-pltfm.h     |    2 +-
>  2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 3b52485..372455b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/gpio.h>
> +#include <linux/slab.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sdhci-pltfm.h>
>  #include <mach/hardware.h>
> @@ -24,6 +25,13 @@
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>  
> +#define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
> +
> +struct pltfm_imx_data {
> +	int flags;
> +	u32 scratchpad;
> +};
> +
>  static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
>  {
>  	void __iomem *base = host->ioaddr + (reg & ~0x3);
> @@ -34,10 +42,14 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
>  
>  static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +
>  	/* fake CARD_PRESENT flag on mx25/35 */
>  	u32 val = readl(host->ioaddr + reg);
>  
> -	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
> +	if (unlikely((reg == SDHCI_PRESENT_STATE)
> +			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP))) {
>  		struct esdhc_platform_data *boarddata =
>  				host->mmc->parent->platform_data;
>  
> @@ -55,7 +67,11 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  
>  static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>  {
> -	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE))
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +
> +	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
> +			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)))
>  		/*
>  		 * these interrupts won't work with a custom card_detect gpio
>  		 * (only applied to mx25/35)
> @@ -76,6 +92,7 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
>  static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = pltfm_host->priv;
>  
>  	switch (reg) {
>  	case SDHCI_TRANSFER_MODE:
> @@ -83,10 +100,10 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  		 * Postpone this write, we must do it together with a
>  		 * command write that is down below.
>  		 */
> -		pltfm_host->scratchpad = val;
> +		imx_data->scratchpad = val;
>  		return;
>  	case SDHCI_COMMAND:
> -		writel(val << 16 | pltfm_host->scratchpad,
> +		writel(val << 16 | imx_data->scratchpad,
>  			host->ioaddr + SDHCI_TRANSFER_MODE);
>  		return;
>  	case SDHCI_BLOCK_SIZE:
> @@ -146,7 +163,9 @@ static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
>  }
>  
>  static struct sdhci_ops sdhci_esdhc_ops = {
> +	.read_l = esdhc_readl_le,
>  	.read_w = esdhc_readw_le,
> +	.write_l = esdhc_writel_le,
>  	.write_w = esdhc_writew_le,
>  	.write_b = esdhc_writeb_le,
>  	.set_clock = esdhc_set_clock,
> @@ -168,6 +187,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
>  	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
>  	struct clk *clk;
>  	int err;
> +	struct pltfm_imx_data *imx_data;
>  
>  	clk = clk_get(mmc_dev(host->mmc), NULL);
>  	if (IS_ERR(clk)) {
> @@ -177,7 +197,10 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
>  	clk_enable(clk);
>  	pltfm_host->clk = clk;
>  
> -	if (cpu_is_mx35() || cpu_is_mx51())
> +	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
> +	pltfm_host->priv = imx_data;
> +
> +	if (!cpu_is_mx25())
>  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  
>  	if (cpu_is_mx25() || cpu_is_mx35()) {

kzalloc() can fail.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 5/5] sdhci-s3c: Add support no internal clock divider in
 host controller
Date: Fri, 17 Sep 2010 10:22:20 +0900
Message-ID: <03a401cb5606$c9780670$5c681350$%kim@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
 <1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jeongbae Seo' <jeongbae.seo@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>, 'Chris Ball' <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Jeongbae Seo wrote:
> 
> From: Hyuk Lee <hyuk1.lee@samsung.com>
> 
> This patch adds to support no internal clock divider in SDHCI.
> The external clock divider can be used to make a proper clock
> because SDHCI doesn't support internal clock divider by itself.
> 
Hi,

Please add Chris Ball <cjb@laptop.org> who is a maintainer of MMC subsystem
in Cc later.

> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   63
> ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 71ad416..6160960 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -96,6 +96,13 @@ static unsigned int sdhci_s3c_get_max_clk(struct
> sdhci_host *host)
>  	unsigned int rate, max;
>  	int clk;
> 
> +	/*
> +	 * There is only one clock source(sclk) if there is no clock divider
> +	 * in the host controller
> +	 */
> +	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
> +		return clk_round_rate(ourhost->clk_bus[2], UINT_MAX);
> +
>  	/* note, a reset will reset the clock source */
> 
>  	sdhci_s3c_check_sclk(host);
> @@ -130,6 +137,15 @@ static unsigned int sdhci_s3c_consider_clock(struct
> sdhci_s3c *ourhost,
>  	if (!clksrc)
>  		return UINT_MAX;
> 
> +	/*
> +	 * There is only one clock source(sclk) if there is no clock divider
> +	 * in the host controller
> +	 */
> +	if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
> +		rate = clk_round_rate(clksrc, wanted);
> +		return wanted - rate;
> +	}
> +
>  	rate = clk_get_rate(clksrc);
> 
>  	for (div = 1; div < 256; div *= 2) {
> @@ -159,6 +175,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host
*host,
> unsigned int clock)
>  	int best_src = 0;
>  	int src;
>  	u32 ctrl;
> +	unsigned int timeout;
> 
>  	/* don't bother if the clock is going off. */
>  	if (clock == 0)
> @@ -204,6 +221,35 @@ static void sdhci_s3c_set_clock(struct sdhci_host
*host,
> unsigned int clock)
>  			(ourhost->pdata->cfg_card)(ourhost->pdev, host-
> >ioaddr,
>  						   &ios, NULL);
>  	}
> +
> +	/*
> +	 * There is only one clock source(sclk) if there is no clock divider
> +	 * in the host controller
> +	 */
> +	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
> +		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
> +		clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
> +
> +		writew(SDHCI_CLOCK_INT_EN, host->ioaddr +
> SDHCI_CLOCK_CONTROL);
> +
> +		/* Wait max 20 ms */
> +		timeout = 20;
> +		while (!((sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +			& SDHCI_CLOCK_INT_STABLE)) {
> +			if (timeout == 0) {
> +				printk(KERN_ERR "%s: clock never
> stabilised.\n"
> +						, mmc_hostname(host-
> >mmc));
> +				return;
> +			}
> +			timeout--;
> +			mdelay(1);
> +		}
> +
> +		writew(SDHCI_CLOCK_INT_EN | SDHCI_CLOCK_CARD_EN,
> +				host->ioaddr + SDHCI_CLOCK_CONTROL);
> +
> +		host->clock = clock;
> +	}
>  }
> 
>  /**
> @@ -221,6 +267,13 @@ static unsigned int sdhci_s3c_get_min_clock(struct
> sdhci_host *host)
>  	unsigned int delta, min = UINT_MAX;
>  	int src;
> 
> +	/*
> +	 * There is only one clock source(sclk) if there is no clock divider
> +	 * in the host controller
> +	 */
> +	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
> +		return clk_round_rate(ourhost->clk_bus[2], 400000);
> +
>  	for (src = 0; src < MAX_BUS_CLK; src++) {
>  		delta = sdhci_s3c_consider_clock(ourhost, src, 0);
>  		if (delta == UINT_MAX)
> @@ -425,6 +478,16 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
>  	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
>  	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
> 
> +	/*
> +	 * If controller does not have internal clock divider,
> +	 * we need to use another method with setup a quirk.
> +	 */
> +	if (pdata->clk_type)
> +		host->quirks |= SDHCI_QUIRK_NONSTANDARD_CLOCK;
> +
> +	if (pdata->host_caps)
> +		host->mmc->caps |= pdata->host_caps;
> +

If you want to add above feature, please separate it...

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

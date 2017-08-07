From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 4/5] mmc: sdhci-of-arasan: constify sdhci_pltfm_data and
 sdhci_ops structures
Date: Mon, 7 Aug 2017 14:50:38 +0200
Message-ID: <4a087f6a-a51c-2add-402f-2d377457482e@xilinx.com>
References: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502099444-10473-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1502099444-10473-5-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Michal Simek <michal.simek@xilinx.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 7.8.2017 11:50, Julia Lawall wrote:
> The sdhci_pltfm_data structure is only passed as the second argument
> of sdhci_pltfm_init, which is const, while the sdhci_ops structure
> is only stored in the ops field of a sdhci_pltfm_data structure,
> which is also const.  Thus both kinds of structures can be const as
> well.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/mmc/host/sdhci-of-arasan.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 528a5d2..0720ea7 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -262,7 +262,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>  	return -EINVAL;
>  }
>  
> -static struct sdhci_ops sdhci_arasan_ops = {
> +static const struct sdhci_ops sdhci_arasan_ops = {
>  	.set_clock = sdhci_arasan_set_clock,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -271,7 +271,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>  
> -static struct sdhci_pltfm_data sdhci_arasan_pdata = {
> +static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>  	.ops = &sdhci_arasan_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

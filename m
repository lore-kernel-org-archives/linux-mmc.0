From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 09/12] mmc: sdhci-omap: Workaround for Errata i834
Date: Thu, 26 Apr 2018 10:53:20 +0300
Message-ID: <142e17bd-1e1d-f26f-1b81-389fbb841fcd@intel.com>
References: <20180425120937.29867-1-kishon@ti.com>
 <20180425120937.29867-10-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425120937.29867-10-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 25/04/18 15:09, Kishon Vijay Abraham I wrote:
> Errata i834 in AM572x Sitara Processors Silicon Revision 2.0, 1.1
> (SPRZ429L July 2014–Revised April 2018 [1]) mentions the maximum
> obtainable timeout through MMC host controller is 700ms. And for
> commands taking longer than 700ms, hardware timeout should be
> disabled and software timeout should be used.
> 
> The workaround for Errata i834 can be achieved by adding
> SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk in sdhci-omap.
> 
> [1] -> http://www.ti.com/lit/er/sprz429l/sprz429l.pdf
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 2d9ea23610d5..b2c54940d032 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -715,7 +715,8 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
>  	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
>  		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   SDHCI_QUIRK2_RSP_136_HAS_CRC,
> +		   SDHCI_QUIRK2_RSP_136_HAS_CRC |
> +		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
>  	.ops = &sdhci_omap_ops,
>  };
>  
> 

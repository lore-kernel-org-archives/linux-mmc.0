From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Date: Tue, 27 Feb 2018 16:08:24 +0200
Message-ID: <6abab0b5-72c5-0578-91aa-5d0c3867e53b@intel.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 27/02/18 15:55, Phil Edworthy wrote:
> Since the controller does not support the end-of-busy IRQ, don't use it.
> Otherwise, on older SD cards you will get lots of these messages:
> "mmc0: Got data interrupt 0x00000002 even though no data operation was in progress"

SDHCI_QUIRK2_STOP_WITH_TC may be the quirk you want but it doesn't match
your description.  SDHCI_QUIRK2_STOP_WITH_TC is when we always get a TC
(end-of-busy) IRQ with the STOP command even when we didn't ask for one.
Hence the TC interrupt (0x00000002) comes when we think we are already finished.

> 
> This has been reported on Xilinx devices that also use the Arasan IP.
> See https://patchwork.kernel.org/patch/8062871/
> 
> This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c33a5f7..ab66e32 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>  	.ops = &sdhci_arasan_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +			SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>  
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
> 

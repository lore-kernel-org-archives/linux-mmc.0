From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix
 HS50 data hold time problem
Date: Tue, 7 May 2019 09:32:58 +0300
Message-ID: <195374db-9a9a-2807-d8be-50ec4e8fedcb@intel.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
 <20190506170115.10840-2-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506170115.10840-2-scott.branden@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

On 6/05/19 8:01 PM, Scott Branden wrote:
> From: Trac Hoang <trac.hoang@broadcom.com>
> 
> The iproc host eMMC/SD controller hold time does not meet the
> specification in the HS50 mode. This problem can be mitigated
> by disabling the HISPD bit; thus forcing the controller output
> data to be driven on the falling clock edges rather than the
> rising clock edges.
> 
> This change applies only to the Cygnus platform.
> 
> Fixes: c833e92bbb60 ("mmc: sdhci-iproc: support standard byte register accesses")
> Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-iproc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 9d12c06c7fd6..9d4071c41c94 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -196,7 +196,8 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
> -	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_NO_HISPD_BIT,
>  	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
>  	.ops = &sdhci_iproc_32only_ops,
>  };
> 

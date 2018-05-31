From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Remove NO_CARD_NO_RESET quirk
Date: Thu, 31 May 2018 08:55:48 +0300
Message-ID: <c61b82f1-8095-91dd-b4ea-5e38b1f257fe@intel.com>
References: <20180530144335.7888-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530144335.7888-1-georgi.djakov@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>, ulf.hansson@linaro.org
Cc: vviswana@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org, stummala@codeaurora.org, asutoshd@codeaurora.org, bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 30/05/18 17:43, Georgi Djakov wrote:
> Now we have a proper implementation for the power irq handling and this
> quirk is not needed anymore. In fact, it is causing card detection delays
> on apq8096 platforms and the following error is displayed:
> sdhci_msm 74a4900.sdhci: mmc0: pwr_irq for req: (4) timed out
> 
> The quirk is forcing the controller to retain 1.8V signalling on the slot
> even when a new card is inserted, which is not correct. The proper behavior
> would be to reset the controller in order to start with 3.3V signaling.
> 
> Fixes: c0309b3803fe ("mmc: sdhci-msm: Add sdhci msm register write APIs which wait for pwr irq")
> Suggested-by: Vijay Viswanath <vviswana@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> This can go for v4.18, as it's not a critical fix.
> Tested on db410c and db820c.
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c283291db705..791779173332 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1333,7 +1333,6 @@ static const struct sdhci_ops sdhci_msm_ops = {
>  
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> -		  SDHCI_QUIRK_NO_CARD_NO_RESET |
>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> 

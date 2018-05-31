From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Remove NO_CARD_NO_RESET quirk
Date: Thu, 31 May 2018 13:04:46 +0200
Message-ID: <CAPDyKFqb5z+D43L8vCYBk+=nbreEUm3Xd1UWAXSFjHEOZ4a+MA@mail.gmail.com>
References: <20180530144335.7888-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530144335.7888-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Vijay Viswanath <vviswana@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Asutosh Das <asutoshd@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 30 May 2018 at 16:43, Georgi Djakov <georgi.djakov@linaro.org> wrote:
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

Thanks, applied for next!

Kind regards
Uffe

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
>         .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> -                 SDHCI_QUIRK_NO_CARD_NO_RESET |
>                   SDHCI_QUIRK_SINGLE_POWER_WRITE |
>                   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,

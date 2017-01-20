From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RESEND PATCHv1 5/8] mmc: sdhci-msm: configure
 CORE_CSR_CDC_DELAY_CFG to recommended value
Date: Fri, 20 Jan 2017 09:42:11 -0800
Message-ID: <e7b37b16-3d87-3766-6e03-9f67cd29b64a@codeaurora.org>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
 <1484031652-12059-6-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1484031652-12059-6-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 01/09/2017 11:00 PM, Ritesh Harjani wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
>
> Program CORE_CSR_CDC_DELAY_CFG for hardware recommended 1.25ns delay.
> We may see data CRC errors if it's programmed for any other delay
> value.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index a028568..84d29dd 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -679,7 +679,7 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
>  	writel_relaxed(0x4, host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG1);
>  	writel_relaxed(0xCB732020, host->ioaddr + CORE_CSR_CDC_REFCOUNT_CFG);
>  	writel_relaxed(0xB19, host->ioaddr + CORE_CSR_CDC_COARSE_CAL_CFG);
> -	writel_relaxed(0x3AC, host->ioaddr + CORE_CSR_CDC_DELAY_CFG);
> +	writel_relaxed(0x4E2, host->ioaddr + CORE_CSR_CDC_DELAY_CFG);
>  	writel_relaxed(0x0, host->ioaddr + CORE_CDC_OFFSET_CFG);
>  	writel_relaxed(0x16334, host->ioaddr + CORE_CDC_SLAVE_DDA_CFG);
>  

There's a comment block above this set of writes that repeats what's
happening in the code.

        /*
         * Perform CDC Register Initialization Sequence
         *
         * CORE_CSR_CDC_CTLR_CFG0       0x11800EC
         * CORE_CSR_CDC_CTLR_CFG1       0x3011111
         * CORE_CSR_CDC_CAL_TIMER_CFG0  0x1201000
         * CORE_CSR_CDC_CAL_TIMER_CFG1  0x4
         * CORE_CSR_CDC_REFCOUNT_CFG    0xCB732020
         * CORE_CSR_CDC_COARSE_CAL_CFG  0xB19
         * CORE_CSR_CDC_DELAY_CFG       0x3AC
         * CORE_CDC_OFFSET_CFG          0x0
         * CORE_CDC_SLAVE_DDA_CFG       0x16334
         */

Perhaps we should just delete those comments because they're incorrect now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

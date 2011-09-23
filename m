From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH V1] mmc: core: HS200 mode support for eMMC 4.5
Date: Fri, 23 Sep 2011 10:53:29 +0800
Message-ID: <20110923025324.GA4680@ladygaga>
References: <1316690020-8742-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316690020-8742-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 22, 2011 at 04:43:40PM +0530, Girish K S wrote:
> This patch adds the support of the HS200 bus speed for
> eMMC 4.5 devices.
> The eMMC 4.5 devices have support for 200MHz bus speed.
> The mmc core and host modules have been touched to add support
> for this module.
> It is necessary to know the card type in the sdhci.c file to
> add support for eMMC tuning function. So card.h file is included
> to import the card data structure.
> 
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
>  v1:
>  cases which produce same result have been combined to reduce
>  repeated assignments. patch recreated after rebase to chris 
>  balls mmc-next branch.

Your patch does not apply to mmc-next tree...

> 
> @@ -1661,7 +1663,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
>  		if (!tuning_loop_counter && !timeout)
>  			break;
> 

The sdhci_execute_tuning will not proceed here unless the ctrl register
indicates the host is running at UHS_SDR104 or UHS_SDR50 with
SDHCI_SDR50_NEEDS_TUNING flag set. Does your host also reflect this when
running at 200Mhz bus speed?

> -		cmd.opcode = MMC_SEND_TUNING_BLOCK;
> +		if (mmc->card->type == MMC_TYPE_MMC)
> +			cmd.opcode = MMC_SEND_TUNING_BLOCK_HS200;
> +		else
> +			cmd.opcode = MMC_SEND_TUNING_BLOCK;
>  		cmd.arg = 0;
>  		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
>  		cmd.retries = 0;

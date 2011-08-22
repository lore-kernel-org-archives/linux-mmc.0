From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 1/2] msm: Fix a typo in MSM SDCC driver gpio setup
Date: Mon, 22 Aug 2011 08:50:41 -0700
Message-ID: <20110822155041.GA4829@huya.qualcomm.com>
References: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
 <1313927564-10355-2-git-send-email-alexander.tarasikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1313927564-10355-2-git-send-email-alexander.tarasikov@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Alexander Tarasikov <alexander.tarasikov@gmail.com>
Cc: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, cjb@laptop.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Aug 21, 2011 at 03:52:43PM +0400, Alexander Tarasikov wrote:
> The use of && instead of || caused a NULL pointer dereference if
> gpio setup was not passed via platform data
> 
> Signed-off-by: Alexander Tarasikov <alexander.tarasikov@gmail.com>
> ---
>  drivers/mmc/host/msm_sdcc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index a4c865a..d06539d 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -939,7 +939,7 @@ static void msmsdcc_setup_gpio(struct msmsdcc_host *host, bool enable)
> 	struct msm_mmc_gpio_data *curr;
> 	int i, rc = 0;
> 
> -	if (!host->plat->gpio_data && host->gpio_config_status == enable)
> +	if (!host->plat->gpio_data || host->gpio_config_status == enable)
> 		return;
> 
> 	curr = host->plat->gpio_data;

Both of your patches have somehow gotten mangled in transit (the
context lines have lost their leading space).  Did you perhaps edit
the patch files with an editor that is configured to fold spaces into
tabs?

I was able to fix up the files and apply the patches, and will include
these once Sahitya has a chance to review them.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

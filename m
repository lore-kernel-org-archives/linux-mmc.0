From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEDN PATCH v2 3/4] mmc: sdhci: Don't try to switch to
 unsupported voltage
Date: Fri, 23 Sep 2016 10:12:43 +0300
Message-ID: <785df157-dadc-4dd3-76e9-aea3a0f031a5@intel.com>
References: <1474589577-11193-1-git-send-email-shawn.lin@rock-chips.com>
 <1474589577-11193-3-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7142 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbcIWHRm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 23 Sep 2016 03:17:42 -0400
In-Reply-To: <1474589577-11193-3-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Ziyuan Xu <xzy.xu@rock-chips.com>

On 23/09/16 03:12, Shawn Lin wrote:
> From: Ziyuan Xu <xzy.xu@rock-chips.com>
> 
> Sdhci shouldn't switch to the unsupported voltage if claiming
> that it can not support the requested voltage. Let's fix it.
> 
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4805566..b1f1edd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1845,7 +1845,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  
>  	switch (ios->signal_voltage) {
>  	case MMC_SIGNAL_VOLTAGE_330:
> -		if (!(host->flags & SDHCI_SIGNALING_330))
> +		if (!(host->flags & SDHCI_SIGNALING_330) ||
> +		    !(host->caps & SDHCI_CAN_VDD_330))

You are mixing signal voltage and supply voltage here.  Note, I don't
believe all drivers set the capabilities correctly when they are using
regulators, but in any case this is not the place in the code to make such
assumptions.

Better for the driver to remove SDHCI_SIGNALING_330 from flags when it is
not supported.

>  			return -EINVAL;
>  		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
>  		ctrl &= ~SDHCI_CTRL_VDD_180;
> @@ -1872,7 +1873,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  
>  		return -EAGAIN;
>  	case MMC_SIGNAL_VOLTAGE_180:
> -		if (!(host->flags & SDHCI_SIGNALING_180))
> +		if (!(host->flags & SDHCI_SIGNALING_180) ||
> +		    !(host->caps & SDHCI_CAN_VDD_180))

You are mixing signal voltage and supply voltage here, and this is not
correct: not being able to do 1.8V supply does not mean you can't do 1.8V
signaling.  The SDHCI way of determining supported signal voltages is based
on supported transfer modes.

If the driver can't get the transfer modes correct (e.g. we still don't have
MMC_CAP2_3_3V_ONLY_DDR or equivalent), remove SDHCI_SIGNALING_180 from the
flags.

>  			return -EINVAL;
>  		if (!IS_ERR(mmc->supply.vqmmc)) {
>  			ret = mmc_regulator_set_vqmmc(mmc, ios);
> 


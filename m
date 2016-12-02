From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 1/2] mmc: sdhci: continue normal tuning if unsupported
 by platform tuning
Date: Fri, 2 Dec 2016 16:18:55 +0200
Message-ID: <0edcfd1d-e7fa-bf51-a1a3-110f1bfdc73c@intel.com>
References: <1480645311-13004-1-git-send-email-yamada.masahiro@socionext.com>
 <1480645311-13004-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63902 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934341AbcLBOX6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Dec 2016 09:23:58 -0500
In-Reply-To: <1480645311-13004-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org

On 02/12/16 04:21, Masahiro Yamada wrote:
> Some SDHCI-compat controllers support not only SD, but also eMMC,
> but they use different commands for tuning: CMD19 for SD, CMD21 for
> eMMC.
> 
> Due to the difference of the underlying mechanism, some controllers
> (at least, the Cadence IP is the case) provide their own registers
> for the eMMC tuning.
> 
> This commit will be useful when we want to use platform-specific
> tuning (to support eMMC HS200), but still let it reuse the code
> provided by sdhci_execute_tuning() for SD timing.
> 
> If sdhci_ops::platform_execute_tuning receives a timing it does not
> take care of, it can return -ENOTSUPP.  Then, it will fall back to
> the SDHCI standard tuning.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I want to use this in the next commit.
> 
> The Cadence IP supports eMMC as well as SD.
> 
> The tuning for SD is pretty simple; just set the "Execute Tuning" bit
> of the HOST_CONTROL2 register.  So, I can re-use the
> sdhci_execute_tuning().
> 
> On the other hand, Cadence provides its own way for eMMC HS200 tuning;
> I need to touch some registers that are specific to Cadence's design.
> 
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 42ef3eb..cdce489 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2004,7 +2004,9 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	if (host->ops->platform_execute_tuning) {
>  		spin_unlock_irqrestore(&host->lock, flags);
>  		err = host->ops->platform_execute_tuning(host, opcode);
> -		return err;
> +		if (err != -ENOTSUPP)
> +			return err;
> +		spin_lock_irqsave(&host->lock, flags);

platform_execute_tuning() should not exist.  You could export
sdhci_execute_tuning() and then provide your ->execute_tuning() (e.g.
host->mmc_host_ops.execute_tuning = sdhci_cdns_execute_tuning) which can
call sdhci_execute_tuning() if it needs to.


>  	}
>  
>  	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> 


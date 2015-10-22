From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart handler
Date: Thu, 22 Oct 2015 09:36:01 +0900
Message-ID: <56282F71.2070408@samsung.com>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 22.10.2015 00:15, Javier Martinez Canillas wrote:
> The pwrseq_emmc driver does a eMMC card reset before a system reboot to
> allow broken or limited ROM boot-loaders (that don't have an eMMC reset
> logic) to be able to read the second stage from the eMMC.
> 
> But this has to be called before a system reboot handler and while most
> of them use the priority 128, there are other restart handlers (such as
> the syscon-reboot one) that use a higher priority. So, use the highest
> priority to make sure that the eMMC hw is reset before a system reboot.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> 
> ---
> Hello,
> 
> This patch was needed since a recent series from Alim [0] added
> syscon reboot and poweroff support to Exynos SoCs and removed
> the reset handler in the Exynos Power Management Unit (PMU) code.
> 
> But the PMU and syscon-reboot restart handler have a different
> priority so [0] breaks restart when eMMC is used on these boards.
> 
> [0]: http://www.spinics.net/lists/arm-kernel/msg454396.html
> 
> So this patch must be merged before [0] to avoid regressions.
> 
> Best regards,
> Javier
> 
>  drivers/mmc/core/pwrseq_emmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index 137c97fb7aa8..ad4f94ec7e8d 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -84,11 +84,11 @@ struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
>  
>  	/*
>  	 * register reset handler to ensure emmc reset also from
> -	 * emergency_reboot(), priority 129 schedules it just before
> -	 * system reboot
> +	 * emergency_reboot(), priority 255 is the highest priority
> +	 * so it will be executed before any system reboot handler.
>  	 */
>  	pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
> -	pwrseq->reset_nb.priority = 129;
> +	pwrseq->reset_nb.priority = 255;

I see the problem which you are trying to solve but this may be tricker
then just kicking the number. Some of restart handlers are registered
with priority 192. I found few of such, like: at91_restart_nb,
zynq_slcr_restart_nb, rmobile_reset_nb (maybe more, I did not grep too
much).

I guess they chose the "192" priority on purpose.

Effectively, now the emmc handler will be executed before their
handlers... is it an issue? Maybe some testing on these platforms is
necessary?

Best regards,
Krzysztof

>  	register_restart_handler(&pwrseq->reset_nb);
>  
>  	pwrseq->pwrseq.ops = &mmc_pwrseq_emmc_ops;
> 

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart handler
Date: Tue, 27 Oct 2015 11:10:01 +0100
Message-ID: <CAPDyKFoMQcC5sdCEKHWqNOdw1Yw8e8yRpdx7mtq7sMxg6sAi+A@mail.gmail.com>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On 21 October 2015 at 17:15, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
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

So it seems like there have been a good discussion around this. I
don't have any objections, but is more concerned about potential
regressions.

I have queued it up for next (4.4) so we get some testing in
linux-next. If anyone have issues, please report them.

Kind regards
Uffe

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
>         /*
>          * register reset handler to ensure emmc reset also from
> -        * emergency_reboot(), priority 129 schedules it just before
> -        * system reboot
> +        * emergency_reboot(), priority 255 is the highest priority
> +        * so it will be executed before any system reboot handler.
>          */
>         pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
> -       pwrseq->reset_nb.priority = 129;
> +       pwrseq->reset_nb.priority = 255;
>         register_restart_handler(&pwrseq->reset_nb);
>
>         pwrseq->pwrseq.ops = &mmc_pwrseq_emmc_ops;
> --
> 2.4.3
>

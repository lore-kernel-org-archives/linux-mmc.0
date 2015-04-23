From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: add missing pm event in mmc_pm_notify to fix
 hib restore
Date: Thu, 23 Apr 2015 15:19:15 +0200
Message-ID: <CAPDyKFqA5Wvod_0J-52FJ9Vktt1kdq7H7c9UcX-daJ0hazWU+Q@mail.gmail.com>
References: <1429785823-16939-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1429785823-16939-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 April 2015 at 12:43,  <grygorii.strashko@linaro.org> wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>
> The PM_RESTORE_PREPARE is not handled now in mmc_pm_notify(),
> as result mmc_rescan() could be scheduled and executed at
> late hibernation restore stages when MMC device is suspended
> already - which, in turn, will lead to system crash on TI dra7-evm board:
>
> WARNING: CPU: 0 PID: 3188 at drivers/bus/omap_l3_noc.c:148 l3_interrupt_handler+0x258/0x374()
> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER1_P3 (Idle): Data Access in User mode during Functional access
>
> Hence, add missed PM_RESTORE_PREPARE PM event in mmc_pm_notify().
>
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Huh, that was an old bug you found. :-)

I have applied it for fixes and added the below fixes tag.

Fixes: 4c2ef25fe0b8 (mmc: fix all hangs related to mmc/sd card
insert/removal during suspend/resume)

Thanks and kind regards!
Uffe

> ---
>  drivers/mmc/core/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c296bc0..92e7671 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2651,6 +2651,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>         switch (mode) {
>         case PM_HIBERNATION_PREPARE:
>         case PM_SUSPEND_PREPARE:
> +       case PM_RESTORE_PREPARE:
>                 spin_lock_irqsave(&host->lock, flags);
>                 host->rescan_disable = 1;
>                 spin_unlock_irqrestore(&host->lock, flags);
> --
> 1.9.1
>

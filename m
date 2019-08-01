From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: dw_mmc: Fix possible null-pointer dereferences
 in dw_mci_runtime_resume()
Date: Thu, 1 Aug 2019 16:58:34 +0200
Message-ID: <CAPDyKFp7z3uXws4+jL=-U6cZekVX+QeJNKmqegmap8ZWhbgRoA@mail.gmail.com>
References: <20190726142252.9654-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726142252.9654-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 26 Jul 2019 at 16:23, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> In dw_mci_runtime_resume(), there is an if statement on line 3420
> to check whether host->slot is NULL:
>     if (host->slot && ...)
>
> When host->slot is NULL, it is used on line 3458:
>     if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> and on line 3462:
>     dw_mci_setup_bus(host->slot, true);
>         struct dw_mci *host = slot->host;
>
> Thus, possible null-pointer dereferences may occur.
>
> To fix these bugs, host->slot is checked before being used.
>
> These bugs are found by a static analysis tool STCheck written by us.

I fully respect these kind of tools and they for sure find lots of
problems for us.

However, in this case I think the fix should be made a bit
differently, see more below.

>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index faaaf52a46d2..91bd6c3ccf50 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3455,11 +3455,12 @@ int dw_mci_runtime_resume(struct device *dev)
>         mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>
>
> -       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> +       if (host->slot && (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER))
>                 dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);

Unless I missing something (still in "slow mode" due to holidays),
dw_mci_runtime_suspend|resume() should only be called when there is a
slot (host->slot) initialized for the host. This is guaranteed by the
the driver when it runs ->probe().

>
>         /* Force setup bus to guarantee available clock output */
> -       dw_mci_setup_bus(host->slot, true);
> +       if (host->slot)
> +               dw_mci_setup_bus(host->slot, true);

Ditto.

>
>         /* Now that slots are all setup, we can enable card detect */
>         dw_mci_enable_cd(host);

So, I am thinking that there is really no need to check for host->slot
at all. And if there really were, I am sure there would have been bug
reports already about it.

Kind regards
Uffe

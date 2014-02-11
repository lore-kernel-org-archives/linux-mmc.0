From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFT][PATCH v2] mmc: change cb710-mmc platform power management
 to use dev_pm_ops
Date: Tue, 11 Feb 2014 23:43:19 +0100
Message-ID: <CAPDyKFr9RiaiVCdFX_DdNF+Rd-C3CEStPDd7+e0VJQuGfeq_fQ@mail.gmail.com>
References: <1392149781-4991-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:38794 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbaBKWnU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2014 17:43:20 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so12537227qab.19
        for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2014 14:43:19 -0800 (PST)
In-Reply-To: <1392149781-4991-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, mirq-linux@rere.qmqm.pl, Chris Ball <chris@printf.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, shuahkhan@gmail.com

On 11 February 2014 21:16, Shuah Khan <shuah.kh@samsung.com> wrote:
> Change cb710-mmc platform driver to register pm ops using dev_pm_ops instead
> of legacy pm_ops. The existing legacy suspend/resume routines are identical
> and simply clear IRQ mask in the device in case it got undefined during sleep
> state. Changed code to collapse suspend and resume into one .pm interface
> for suspend and resume which gets installed for suspend, freeze, poweroff,
> thaw, restore, and resume states.
>
> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> ---
>
> patch v2: Addresses review comments on patch v1
>
>  drivers/mmc/host/cb710-mmc.c |   42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index 1087b4c..ccf7a75 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -662,26 +662,6 @@ static const struct mmc_host_ops cb710_mmc_host = {
>         .get_cd = cb710_mmc_get_cd,
>  };
>
> -#ifdef CONFIG_PM
> -
> -static int cb710_mmc_suspend(struct platform_device *pdev, pm_message_t state)
> -{
> -       struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
> -
> -       cb710_mmc_enable_irq(slot, 0, ~0);
> -       return 0;
> -}
> -
> -static int cb710_mmc_resume(struct platform_device *pdev)
> -{
> -       struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
> -
> -       cb710_mmc_enable_irq(slot, 0, ~0);
> -       return 0;
> -}
> -
> -#endif /* CONFIG_PM */
> -
>  static int cb710_mmc_init(struct platform_device *pdev)
>  {
>         struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
> @@ -762,13 +742,31 @@ static int cb710_mmc_exit(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM
> +static int cb710_mmc_suspend_resume(struct device *dev)
> +{
> +       struct cb710_slot *slot = cb710_pdev_to_slot(to_platform_device(dev));
> +
> +       cb710_mmc_enable_irq(slot, 0, ~0);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops cb710_mmc_dev_pm_ops = {
> +       .suspend = cb710_mmc_suspend_resume,
> +       .resume = cb710_mmc_suspend_resume,
> +       /* Hibernate hooks */
> +       .freeze = cb710_mmc_suspend_resume,
> +       .thaw = cb710_mmc_suspend_resume,
> +       .poweroff = cb710_mmc_suspend_resume,
> +       .restore = cb710_mmc_suspend_resume,
> +};
> +#endif
>  static struct platform_driver cb710_mmc_driver = {
>         .driver.name = "cb710-mmc",
>         .probe = cb710_mmc_init,
>         .remove = cb710_mmc_exit,
>  #ifdef CONFIG_PM
> -       .suspend = cb710_mmc_suspend,
> -       .resume = cb710_mmc_resume,
> +       .driver.pm = &cb710_mmc_dev_pm_ops,
>  #endif
>  };

I suggest you have a look at SIMPLE_DEV_PM_OPS macro. That would
simplify this patch.

Kind regards
Ulf Hansson

>
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

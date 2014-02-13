From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFT][PATCH v3] mmc: change cb710-mmc platform power management
 to use dev_pm_ops
Date: Thu, 13 Feb 2014 10:47:59 +0100
Message-ID: <CAPDyKFoukY2PGNWimUbRqDr36eJ_+eBASJR4uac6nH4-kowmCQ@mail.gmail.com>
References: <1392240089-19489-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:45215 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbaBMJsA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2014 04:48:00 -0500
Received: by mail-qa0-f47.google.com with SMTP id j5so15822208qaq.34
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2014 01:47:59 -0800 (PST)
In-Reply-To: <1392240089-19489-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, mirq-linux@rere.qmqm.pl, Chris Ball <chris@printf.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Shuah Khan <shuahkhan@gmail.com>

On 12 February 2014 22:21, Shuah Khan <shuah.kh@samsung.com> wrote:
> Change cb710-mmc platform driver to register pm ops using dev_pm_ops instead
> of legacy pm_ops. The existing legacy suspend/resume routines are identical
> and simply clear IRQ mask in the device in case it got undefined during sleep
> state. Changed code to collapse suspend and resume into one .pm interface
> for suspend and resume which gets installed for suspend, freeze, poweroff,
> thaw, restore, and resume states using SIMPLE_DEV_PM_OPS().
>
> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> ---
>
> patch v3: Addresses review comments on patch v2
>
>  drivers/mmc/host/cb710-mmc.c |   40 ++++++++++++++++------------------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index 1087b4c..2dc7b2dc 100644
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
> @@ -762,14 +742,26 @@ static int cb710_mmc_exit(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int cb710_mmc_suspend_resume(struct device *dev)
> +{
> +       struct cb710_slot *slot = cb710_pdev_to_slot(to_platform_device(dev));
> +
> +       cb710_mmc_enable_irq(slot, 0, ~0);
> +       return 0;
> +}
> +#else
> +#define cb710_mmc_suspend_resume NULL

You don't need this. The macro will handle this for you.

Kind regards
Ulf Hansson

> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cb710_mmc_dev_pm_ops, cb710_mmc_suspend_resume,
> +                        cb710_mmc_suspend_resume);
> +
>  static struct platform_driver cb710_mmc_driver = {
>         .driver.name = "cb710-mmc",
>         .probe = cb710_mmc_init,
>         .remove = cb710_mmc_exit,
> -#ifdef CONFIG_PM
> -       .suspend = cb710_mmc_suspend,
> -       .resume = cb710_mmc_resume,
> -#endif
> +       .driver.pm = &cb710_mmc_dev_pm_ops,
>  };
>
>  module_platform_driver(cb710_mmc_driver);
> --
> 1.7.10.4
>

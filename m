From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci-acpi: support deferred probe
Date: Tue, 10 Jan 2017 16:38:49 +0100
Message-ID: <CAPDyKFo5jcv+YathFEG86fAPt=nH42Z35LjztDV0ozFNY8d48Q@mail.gmail.com>
References: <1482719296-4783-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36398 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbdAJPi5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 10:38:57 -0500
Received: by mail-wm0-f41.google.com with SMTP id c85so131557786wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 07:38:51 -0800 (PST)
In-Reply-To: <1482719296-4783-1-git-send-email-rui.zhang@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, cja@gmx.net, darcari@redhat.com

On 26 December 2016 at 03:28, Zhang Rui <rui.zhang@intel.com> wrote:
> With commit
> 67bf5156edc4 (gpio / ACPI: fix returned error from acpi_dev_gpio_irq_get()),
> mmc_gpiod_request_cd() returns -EPROBE_DEFER if GPIO is not ready
> when sdhci-acpi driver is probed, and sdhci-acpi driver should be probed
> again later in this case.
>
> This fixes an order issue when both GPIO and sdhci-acpi drivers are built as
> modules.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=177101
> Tested-by: Jonas Aaberg <cja@gmx.net>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Seems like both a fixes tag and a stable tag would we useful.

Please re-spin and make also the changes that Adrian proposed to the change log.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 160f695..5440323 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -466,7 +466,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>         if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
>                 bool v = sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
>
> -               if (mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0, NULL)) {
> +               err = mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0, NULL);
> +               if (err) {
> +                       if (err == -EPROBE_DEFER)
> +                               goto err_free;
>                         dev_warn(dev, "failed to setup card detect gpio\n");
>                         c->use_runtime_pm = false;
>                 }
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

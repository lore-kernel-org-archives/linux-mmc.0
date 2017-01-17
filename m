From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-acpi: support deferred probe
Date: Tue, 17 Jan 2017 15:23:35 +0100
Message-ID: <CAPDyKFq0sVGjaw3E+VQiHckHB6=nCQzGJTOmzhho0byM5AuHrw@mail.gmail.com>
References: <1484305415.2221.45.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36262 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdAQOXi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 09:23:38 -0500
Received: by mail-wm0-f51.google.com with SMTP id c85so202106736wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2017 06:23:37 -0800 (PST)
In-Reply-To: <1484305415.2221.45.camel@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, =?UTF-8?B?Sm9uYXMgw4ViZXJn?= <cja@gmx.net>, darcari@redhat.com, adrain <adrian.hunter@intel.com>

On 13 January 2017 at 12:03, Zhang Rui <rui.zhang@intel.com> wrote:
> From c889f737322b797b743c63eda241d0283696d3f5 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Wed, 7 Dec 2016 13:13:31 +0800
> Subject: [PATCH v3] mmc: sdhci-acpi: support deferred probe
>
> With commit 67bf5156edc4 ("gpio / ACPI: fix returned error from
> acpi_dev_gpio_irq_get()"), mmc_gpiod_request_cd() returns -EPROBE_DEFER if
> GPIO is not ready when sdhci-acpi driver is probed, and sdhci-acpi driver
> should be probed again later in this case.
>
> This fixes an order issue when both GPIO and sdhci-acpi drivers are built
> as modules.
>
> CC: stable@vger.kernel.org # v4.9
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=177101
> Tested-by: Jonas Aaberg <cja@gmx.net>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

I strongly encourage you to run checkpatch of all your change before
submitting patches. Below is the output, it gave me. It prevents me
from applying the change. Please fix and re-spin!

ERROR: Please use git commit description style 'commit <12+ chars of
sha1> ("<title line>")' - ie: 'commit fatal: bad o
("da241d0283696d3f5")'
#14:
>From c889f737322b797b743c63eda241d0283696d3f5 Mon Sep 17 00:00:00 2001

ERROR: patch seems to be corrupt (line wrapped?)
#49: FILE: drivers/mmc/host/sdhci-acpi.c:465:
     if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {

total: 2 errors, 0 warnings, 11 lines checked

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 160f695cc09c..5440323894ee 100644
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

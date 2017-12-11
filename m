From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-acpi: Add setup_host() callback
Date: Mon, 11 Dec 2017 13:29:42 +0100
Message-ID: <CAPDyKFo8PXhieVZ+g72zEbp7bypuUSVuRNwV06MQB+GpBwTGOA@mail.gmail.com>
References: <1512738299-5650-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:38275 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdLKM3n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Dec 2017 07:29:43 -0500
Received: by mail-it0-f68.google.com with SMTP id r6so15330516itr.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2017 04:29:43 -0800 (PST)
In-Reply-To: <1512738299-5650-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>

On 8 December 2017 at 14:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add a ->setup_host() callback so that device-specific changes can be made
> to the mmc host controller before it is added.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-acpi.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 1b1ce804d2d7..f7445cf8f7dd 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -76,6 +76,7 @@ struct sdhci_acpi_slot {
>         size_t          priv_size;
>         int (*probe_slot)(struct platform_device *, const char *, const char *);
>         int (*remove_slot)(struct platform_device *);
> +       int (*setup_host)(struct platform_device *pdev);
>  };
>
>  struct sdhci_acpi_host {
> @@ -688,10 +689,20 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       err = sdhci_add_host(host);
> +       err = sdhci_setup_host(host);
>         if (err)
>                 goto err_free;
>
> +       if (c->slot && c->slot->setup_host) {
> +               err = c->slot->setup_host(pdev);
> +               if (err)
> +                       goto err_cleanup;
> +       }
> +
> +       err = __sdhci_add_host(host);
> +       if (err)
> +               goto err_cleanup;
> +
>         if (c->use_runtime_pm) {
>                 pm_runtime_set_active(dev);
>                 pm_suspend_ignore_children(dev, 1);
> @@ -704,6 +715,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>
>         return 0;
>
> +err_cleanup:
> +       sdhci_cleanup_host(c->host);
>  err_free:
>         sdhci_free_host(c->host);
>         return err;
> --
> 1.9.1
>

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Allow for 3 bytes from Intel DSM
Date: Thu, 20 Apr 2017 16:05:48 +0200
Message-ID: <CAPDyKFpWN-0XFg38LWu1=LC1pKoVOG4SkXvGM4zXZjU+-DD0-Q@mail.gmail.com>
References: <1492606135-4983-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34306 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946249AbdDTOFz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Apr 2017 10:05:55 -0400
Received: by mail-ua0-f170.google.com with SMTP id h2so51849578uaa.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Apr 2017 07:05:55 -0700 (PDT)
In-Reply-To: <1492606135-4983-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 19 April 2017 at 14:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
> The DSM used by some Intel controllers can return a 3 byte package. Allow
> for that by using memcpy to copy the bytes.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 57d6f50b73dc..eb3e34c7afe2 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -12,6 +12,7 @@
>   *     - JMicron (hardware and technical support)
>   */
>
> +#include <linux/string.h>
>  #include <linux/delay.h>
>  #include <linux/highmem.h>
>  #include <linux/module.h>
> @@ -413,6 +414,7 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>  {
>         union acpi_object *obj;
>         int err = 0;
> +       size_t len;
>
>         obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), intel_dsm_uuid, 0, fn, NULL);
>         if (!obj)
> @@ -423,12 +425,10 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>                 goto out;
>         }
>
> -       if (obj->buffer.length >= 4)
> -               *result = *(u32 *)obj->buffer.pointer;
> -       else if (obj->buffer.length >= 2)
> -               *result = *(u16 *)obj->buffer.pointer;
> -       else
> -               *result = *(u8 *)obj->buffer.pointer;
> +       len = min_t(size_t, obj->buffer.length, 4);
> +
> +       *result = 0;
> +       memcpy(result, obj->buffer.pointer, len);
>  out:
>         ACPI_FREE(obj);
>
> --
> 1.9.1
>

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: via-sdmmc: constify pci_device_id.
Date: Thu, 27 Jul 2017 16:48:32 +0200
Message-ID: <CAPDyKFoOi++MwDDV4PC8bCnESLpzY5wvQGf4qVoZH+TdjBcNDw@mail.gmail.com>
References: <6e5268522c9f41b6f6b6d9a3f70212b641042bb1.1500309009.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33945 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdG0Osd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:48:33 -0400
Received: by mail-qk0-f173.google.com with SMTP id u139so42269244qka.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:48:33 -0700 (PDT)
In-Reply-To: <6e5268522c9f41b6f6b6d9a3f70212b641042bb1.1500309009.git.arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: brucechang@via.com.tw, HaraldWelte@viatech.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 17 July 2017 at 18:31, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> pci_device_id are not supposed to change at runtime. All functions
> working with pci_device_id provided by <linux/pci.h> work with
> const pci_device_id. So mark the non-const structs as const.
>
> File size before:
>    text    data     bss     dec     hex filename
>    6952     880       0    7832    1e98 drivers/mmc/host/via-sdmmc.o
>
> File size After adding 'const':
>    text    data     bss     dec     hex filename
>    7032     800       0    7832    1e98 drivers/mmc/host/via-sdmmc.o
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/via-sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 6380044..a838bf5 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -323,7 +323,7 @@ struct via_crdr_mmc_host {
>  /* some devices need a very long delay for power to stabilize */
>  #define VIA_CRDR_QUIRK_300MS_PWRDELAY  0x0001
>
> -static struct pci_device_id via_ids[] = {
> +static const struct pci_device_id via_ids[] = {
>         {PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_9530,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
>         {0,}
> --
> 2.7.4
>

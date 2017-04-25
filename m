From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] mmc: cavium: Use module_pci_driver to simplify the code
Date: Tue, 25 Apr 2017 09:57:11 +0200
Message-ID: <CAPDyKFr7QLpRw4Qe=iaDBK3it8qn5dBSxkM8_dCWfBqj-mfyDg@mail.gmail.com>
References: <20170425031409.9822-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34825 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1176237AbdDYH5M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Apr 2017 03:57:12 -0400
Received: by mail-qt0-f177.google.com with SMTP id y33so133294299qta.2
        for <linux-mmc@vger.kernel.org>; Tue, 25 Apr 2017 00:57:12 -0700 (PDT)
In-Reply-To: <20170425031409.9822-1-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Wei Yongjun <weiyongjun1@huawei.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 25 April 2017 at 05:14, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Use the module_pci_driver() macro to make the code simpler
> by eliminating module_init and module_exit calls.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/cavium-thunderx.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> index 65244e8..fe3d772 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -179,18 +179,7 @@ static struct pci_driver thunder_mmc_driver = {
>         .remove = thunder_mmc_remove,
>  };
>
> -static int __init thunder_mmc_init_module(void)
> -{
> -       return pci_register_driver(&thunder_mmc_driver);
> -}
> -
> -static void __exit thunder_mmc_exit_module(void)
> -{
> -       pci_unregister_driver(&thunder_mmc_driver);
> -}
> -
> -module_init(thunder_mmc_init_module);
> -module_exit(thunder_mmc_exit_module);
> +module_pci_driver(thunder_mmc_driver);
>
>  MODULE_AUTHOR("Cavium Inc.");
>  MODULE_DESCRIPTION("Cavium ThunderX eMMC Driver");
>
>
>

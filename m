From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] mmc: toshsd: use module_pci_driver to simplify the code
Date: Fri, 19 Dec 2014 11:48:59 +0100
Message-ID: <CAPDyKFqOACKx=Kkku+J2YbLTcL0pt+Q4YUFm8T3EdzeqU09KVA@mail.gmail.com>
References: <1418087285-14334-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:63775 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbaLSKtA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 05:49:00 -0500
Received: by mail-qa0-f42.google.com with SMTP id n8so446251qaq.29
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 02:48:59 -0800 (PST)
In-Reply-To: <1418087285-14334-1-git-send-email-weiyj_lk@163.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: weiyj_lk@163.com
Cc: Chris Ball <chris@printf.net>, Dan Carpenter <dan.carpenter@oracle.com>, Ondrej Zary <linux@rainbow-software.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-mmc <linux-mmc@vger.kernel.org>

On 9 December 2014 at 02:08,  <weiyj_lk@163.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Use the module_pci_driver() macro to make the code simpler
> by eliminating module_init and module_exit calls.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks! Queued for 3.20.

Kind regards
Uffe

> ---
>  drivers/mmc/host/toshsd.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
> index 4666262..e5d8dec 100644
> --- a/drivers/mmc/host/toshsd.c
> +++ b/drivers/mmc/host/toshsd.c
> @@ -699,18 +699,7 @@ static struct pci_driver toshsd_driver = {
>         .driver.pm = &toshsd_pm_ops,
>  };
>
> -static int __init toshsd_drv_init(void)
> -{
> -       return pci_register_driver(&toshsd_driver);
> -}
> -
> -static void __exit toshsd_drv_exit(void)
> -{
> -       pci_unregister_driver(&toshsd_driver);
> -}
> -
> -module_init(toshsd_drv_init);
> -module_exit(toshsd_drv_exit);
> +module_pci_driver(toshsd_driver);
>
>  MODULE_AUTHOR("Ondrej Zary, Richard Betts");
>  MODULE_DESCRIPTION("Toshiba PCI Secure Digital Host Controller Interface driver");
>

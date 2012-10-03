From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: use __devinit_p macro for .remove()
Date: Wed, 3 Oct 2012 22:41:30 +0900
Message-ID: <CAGxe1ZHF--qR68A4PGBwmFe85DZUK3gxQWE+05PT9yKBUWOPrg@mail.gmail.com>
References: <1349270797-19189-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46249 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab2JCNlb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Oct 2012 09:41:31 -0400
Received: by vbbff1 with SMTP id ff1so7828153vbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 03 Oct 2012 06:41:30 -0700 (PDT)
In-Reply-To: <1349270797-19189-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

its  __devexit_p not  __devinit_p

On 3 October 2012 22:26, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/dw_mmc-pci.c   |    2 +-
>  drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
> index edb37e9..53a09cb 100644
> --- a/drivers/mmc/host/dw_mmc-pci.c
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -134,7 +134,7 @@ static struct pci_driver dw_mci_pci_driver = {
>         .name           = "dw_mmc_pci",
>         .id_table       = dw_mci_pci_id,
>         .probe          = dw_mci_pci_probe,
> -       .remove         = dw_mci_pci_remove,
> +       .remove         = __devexit_p(dw_mci_pci_remove),
>         .driver         =       {
>                 .pm =   &dw_mci_pci_pmops
>         },
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index c960ca7..777c585 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -119,7 +119,7 @@ static const struct of_device_id dw_mci_pltfm_match[] = {
>  MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
>
>  static struct platform_driver dw_mci_pltfm_driver = {
> -       .remove         = __exit_p(dw_mci_pltfm_remove),
> +       .remove         = __devexit_p(dw_mci_pltfm_remove),
>         .driver         = {
>                 .name           = "dw_mmc",
>                 .of_match_table = of_match_ptr(dw_mci_pltfm_match),
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

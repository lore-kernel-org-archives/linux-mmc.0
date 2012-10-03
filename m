From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCHv2] mmc: dw_mmc: use __devexit_p macro for .remove()
Date: Wed, 3 Oct 2012 22:59:19 +0900
Message-ID: <CAGxe1ZGs9yZhNX_REhzzoNB0aCDW0H65jfdevAYyfv=_66+=Ww@mail.gmail.com>
References: <CAGxe1ZHF--qR68A4PGBwmFe85DZUK3gxQWE+05PT9yKBUWOPrg@mail.gmail.com>
	<1349271927-6260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48294 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942Ab2JCN7U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Oct 2012 09:59:20 -0400
Received: by vbbff1 with SMTP id ff1so7853491vbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 03 Oct 2012 06:59:19 -0700 (PDT)
In-Reply-To: <1349271927-6260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Reviewed By:- Girish K S <girish.shivananjappa@linaro.org>

On 3 October 2012 22:45, Andy Shevchenko
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

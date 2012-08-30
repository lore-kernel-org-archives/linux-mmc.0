From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Use module_pci_driver
Date: Thu, 30 Aug 2012 11:11:29 -0400
Message-ID: <87harkquse.fsf@octavius.laptop.org>
References: <1346048822-18048-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43680 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677Ab2H3PLd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Aug 2012 11:11:33 -0400
In-Reply-To: <1346048822-18048-1-git-send-email-sachin.kamat@linaro.org>
	(Sachin Kamat's message of "Mon, 27 Aug 2012 11:57:02 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org

Hi,

On Mon, Aug 27 2012, Sachin Kamat wrote:
> module_pci_driver makes the code simpler by eliminating
> module_init and module_exit calls.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/sdhci-pci.c |   19 +------------------
>  1 files changed, 1 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 504da71..3f0794e 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1476,24 +1476,7 @@ static struct pci_driver sdhci_driver = {
>  	},
>  };
>  
> -/*****************************************************************************\
> - *                                                                           *
> - * Driver init/exit                                                          *
> - *                                                                           *
> -\*****************************************************************************/
> -
> -static int __init sdhci_drv_init(void)
> -{
> -	return pci_register_driver(&sdhci_driver);
> -}
> -
> -static void __exit sdhci_drv_exit(void)
> -{
> -	pci_unregister_driver(&sdhci_driver);
> -}
> -
> -module_init(sdhci_drv_init);
> -module_exit(sdhci_drv_exit);
> +module_pci_driver(sdhci_driver);
>  
>  MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
>  MODULE_DESCRIPTION("Secure Digital Host Controller Interface PCI driver");

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

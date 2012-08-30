From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc-pci: Use module_pci_driver
Date: Thu, 30 Aug 2012 11:11:40 -0400
Message-ID: <87fw74qus3.fsf@octavius.laptop.org>
References: <1346048957-18493-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43683 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041Ab2H3PLn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Aug 2012 11:11:43 -0400
In-Reply-To: <1346048957-18493-1-git-send-email-sachin.kamat@linaro.org>
	(Sachin Kamat's message of "Mon, 27 Aug 2012 11:59:17 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, shashidharh@vayavyalabs.com

Hi,

On Mon, Aug 27 2012, Sachin Kamat wrote:
> module_pci_driver makes the code simpler by eliminating module_init
> and module_exit calls.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-pci.c |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
> index dc0d25a..f5ab03d 100644
> --- a/drivers/mmc/host/dw_mmc-pci.c
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -140,18 +140,7 @@ static struct pci_driver dw_mci_pci_driver = {
>  	},
>  };
>  
> -static int __init dw_mci_init(void)
> -{
> -	return pci_register_driver(&dw_mci_pci_driver);
> -}
> -
> -static void __exit dw_mci_exit(void)
> -{
> -	pci_unregister_driver(&dw_mci_pci_driver);
> -}
> -
> -module_init(dw_mci_init);
> -module_exit(dw_mci_exit);
> +module_pci_driver(dw_mci_pci_driver);
>  
>  MODULE_DESCRIPTION("DW Multimedia Card PCI Interface driver");
>  MODULE_AUTHOR("Shashidhar Hiremath <shashidharh@vayavyalabs.com>");

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

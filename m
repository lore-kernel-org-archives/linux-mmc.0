From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH -next] mmc: cavium: Use module_pci_driver to simplify the
 code
Date: Tue, 25 Apr 2017 08:02:18 +0200
Message-ID: <20170425060218.GA23445@hc>
References: <20170425031409.9822-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:30016
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S980508AbdDYGCd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Apr 2017 02:02:33 -0400
Content-Disposition: inline
In-Reply-To: <20170425031409.9822-1-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-mmc@vger.kernel.org

On Tue, Apr 25, 2017 at 03:14:09AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Use the module_pci_driver() macro to make the code simpler
> by eliminating module_init and module_exit calls.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/mmc/host/cavium-thunderx.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> index 65244e8..fe3d772 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -179,18 +179,7 @@ static struct pci_driver thunder_mmc_driver = {
>  	.remove = thunder_mmc_remove,
>  };
>  
> -static int __init thunder_mmc_init_module(void)
> -{
> -	return pci_register_driver(&thunder_mmc_driver);
> -}
> -
> -static void __exit thunder_mmc_exit_module(void)
> -{
> -	pci_unregister_driver(&thunder_mmc_driver);
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

Acked-by: Jan Glauber <jglauber@cavium.com>

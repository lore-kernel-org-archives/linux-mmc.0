From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 2/3] mmc: host: arasan: Add the support for sdhci-arasan4.9a
 in sdhci-of-arasan.c
Date: Mon, 4 May 2015 16:15:36 +0200
Message-ID: <4d5ed92b-70c9-4210-bfe1-518b3954c69e@BN1BFFO11FD003.protection.gbl>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
 <1430746792-32574-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0079.outbound.protection.outlook.com ([157.56.111.79]:19456
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750979AbbEDOPv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 May 2015 10:15:51 -0400
In-Reply-To: <1430746792-32574-3-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>, chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com

On 05/04/2015 03:39 PM, Suman Tripathi wrote:
> This patch adds the quirks and compatible string in sdhci-of-arasan.c
> to support sdhci-arasan4.9a version of controller.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 981d66e..92a4222 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -20,6 +20,7 @@
>   */
> 
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include "sdhci-pltfm.h"
> 
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> @@ -169,6 +170,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto clk_disable_all;
>  	}
> 
> +	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
> +		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +	}
> +
>  	sdhci_get_of_property(pdev);
>  	pltfm_host = sdhci_priv(host);
>  	pltfm_host->priv = sdhci_arasan;
> @@ -206,6 +212,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
> 
>  static const struct of_device_id sdhci_arasan_of_match[] = {
>  	{ .compatible = "arasan,sdhci-8.9a" },
> +	{ .compatible = "arasan,sdhci-4.9a" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> --
> 1.8.2.1
> 

You probably need just to add simple of.h but of_device.h should be also
fine.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 3/4] mmc: sdhci-of-arasan: Call mmc_of_parse()
Date: Thu, 7 May 2015 07:00:15 +0200
Message-ID: <554AF15F.8090000@xilinx.com>
References: <1430937082-27149-1-git-send-email-lars@metafoo.de>
 <1430937082-27149-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0086.outbound.protection.outlook.com ([157.56.110.86]:36736
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750892AbbEGFAe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 May 2015 01:00:34 -0400
In-Reply-To: <1430937082-27149-3-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, =?windows-1252?Q?S=F6ren_Brink?= =?windows-1252?Q?mann?= <soren.brinkmann@xilinx.com>, Thomas Abraham <thomas.abraham@linaro.org>, Mike Looijmans <mike.looijmans@topic.nl>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

Hi Lars,

On 05/06/2015 08:31 PM, Lars-Peter Clausen wrote:
> The device-tree documentation for the Arasan SDHCI controller already
> claims that it supports the standard MMC devicetree properties. Update the
> driver implementation accordingly by calling mmc_of_parse().
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 21c0c08..538fd81 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -175,6 +175,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	}
>  
>  	sdhci_get_of_property(pdev);
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		goto clk_disable_all;
> +
>  	pltfm_host = sdhci_priv(host);
>  	pltfm_host->priv = sdhci_arasan;
>  	pltfm_host->clk = clk_xin;
> 

I have sent this patch already and I also see it in linux-next.
https://lkml.org/lkml/2015/4/7/21

Thanks,
Michal

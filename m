From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: add parsing sdhci properties
Date: Tue, 11 Apr 2017 15:16:52 +0300
Message-ID: <91b35097-746e-ef4d-605f-19ee1b6f8156@intel.com>
References: <1491909218-7300-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52945 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753025AbdDKMWc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Apr 2017 08:22:32 -0400
In-Reply-To: <1491909218-7300-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>

On 11/04/17 14:13, Piotr Sroka wrote:
> Add calling sdhci_get_of_property function to parse sdhci properties.
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 7797e98..19d5698 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -330,6 +330,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
>  
> +	sdhci_get_of_property(pdev);
> +
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto free;
> 


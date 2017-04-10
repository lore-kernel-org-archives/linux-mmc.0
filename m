From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v3, 5/7] mmc: sdhci-of-esdhc: add delay between tuning cycles
Date: Mon, 10 Apr 2017 15:39:43 +0300
Message-ID: <6f4ebcff-7051-cc3a-98b5-16345c4f9e83@intel.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <1490600982-5410-6-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11307 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752750AbdDJMpZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Apr 2017 08:45:25 -0400
In-Reply-To: <1490600982-5410-6-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 27/03/17 10:49, Yangbo Lu wrote:
> It's observed that eSDHC needed delay between tuning cycles for
> HS200 successful tuning. This patch is to set 1ms delay for that.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- Used a host member for tuning delay instead of a quirk.
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 8c8e147..0754ef4 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -807,6 +807,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		esdhc_signal_voltage_switch;
>  	host->mmc_host_ops.execute_tuning = esdhc_execute_tuning;
> +	host->tuning_delay = 1;
>  
>  	esdhc_init(pdev, host);
>  
> 


From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v4, 5/5] mmc: sdhci-of-esdhc: add delay between tuning cycles
Date: Thu, 20 Apr 2017 10:35:08 +0300
Message-ID: <48ff5b6b-2f6a-1312-036f-2553105e8a49@intel.com>
References: <1491887431-31894-1-git-send-email-yangbo.lu@nxp.com>
 <1491887431-31894-6-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20712 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939735AbdDTHkz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Apr 2017 03:40:55 -0400
In-Reply-To: <1491887431-31894-6-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 11/04/17 08:10, Yangbo Lu wrote:
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
> Changes for v4:
> 	- None
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 80dc802..49ac197 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -809,6 +809,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		esdhc_signal_voltage_switch;
>  	host->mmc_host_ops.execute_tuning = esdhc_execute_tuning;
> +	host->tuning_delay = 1;
>  
>  	esdhc_init(pdev, host);
>  
> 


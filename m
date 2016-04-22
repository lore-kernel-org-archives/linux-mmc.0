From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 07/23] mmc: sdhci: check SDHCI_QUIRK2_NO_1_8_V when do
 voltage switch
Date: Fri, 22 Apr 2016 15:30:40 +0300
Message-ID: <571A1970.7010800@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-8-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27869 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbcDVMea (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2016 08:34:30 -0400
In-Reply-To: <1460741387-23815-8-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> Currently when card type supports EXT_CSD_CARD_TYPE_DDR_1_8V
> which means it can work on DDR mode with either 3.3v IO or 1.8v
> IO voltage. MMC core will first try 1.8v then 3.3v if host claims
> MMC_CAP_1_8V_DDR support.
> However the host driver voltage switch code does not check NO_1_8_V
> quirk which may set a wrong 1.8v and causes the card fixed to 3.3v
> VIO un-work.
> 
> Checking 1.8V quirk before setting it to avoid such issue.

We need to look forward to when SDHCI_QUIRK2_NO_1_8_V doesn't exist.

There are two possibilities:

1. Add MMC_CAP_3_3V_DDR and support to core and use that instead of
MMC_CAP_1_8V_DDR.  You'll need Ulf's feedback on that.

2. Replace ->start_signal_voltage_switch() i.e.

host->mmc_host_ops.start_signal_voltage_switch =
esdhci_start_signal_voltage_switch;

You will also need to change all calls to
sdhci_start_signal_voltage_switch() with
host->mmc->ops->start_signal_voltage_switch(), but that needs to be done anyway.

> 
> CC: stable <stable@vger.kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/mmc/host/sdhci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2338aab..96ccb15 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1683,6 +1683,8 @@ static int sdhci_do_signal_voltage_switch(struct sdhci_host *host,
>  
>  		return -EAGAIN;
>  	case MMC_SIGNAL_VOLTAGE_180:
> +		if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
> +			return -EINVAL;
>  		/*
>  		 * Enable 1.8V Signal Enable in the Host Control2
>  		 * register
> 


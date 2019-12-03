Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB75C432C3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C052080F
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 07:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLCH1t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:27:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:20359 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfLCH1t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 02:27:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 23:27:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="213328497"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.95]) ([10.237.72.95])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2019 23:27:46 -0800
Subject: Re: [PATCH 1/4] mmc: sdhci: Add delay after power off
To:     Jun Nie <jun.nie@linaro.org>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20191202144104.5069-1-jun.nie@linaro.org>
 <20191202144104.5069-2-jun.nie@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7f95d66f-9d40-93ae-828d-ecae88463a9b@intel.com>
Date:   Tue, 3 Dec 2019 09:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202144104.5069-2-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/12/19 4:41 pm, Jun Nie wrote:
> Add delay after power off to ensure that full power cycle is
> successful. Otherwise, some controllers, at lease for Hisilicon
> eMMC controller, may not be unstable sometimes for full power
> cycle operation.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 7 +++++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3140fe2e5dba..a654f0aeb438 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1761,6 +1761,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>  		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
>  			sdhci_runtime_pm_bus_off(host);
> +
> +		/*
> +		 * Some controllers need an extra 100ms delay to secure
> +		 * full power cycle is successful.
> +		 */
> +		if (host->quirks2 & SDHCI_QUIRK2_DELAY_AFTER_POWER_OFF)
> +			msleep(100);

Please use the ->set_power() callback and do this in your own driver.

>  	} else {
>  		/*
>  		 * Spec says that we should clear the power reg before setting
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0ed3e0eaef5f..0e6f97eaa796 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -482,6 +482,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Controllers need an extra 100ms delay to make sure power off completely */
> +#define SDHCI_QUIRK2_DELAY_AFTER_POWER_OFF		(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 


Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4B8C10F25
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 12:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC94B2166E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 12:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFMfT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:35:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:53296 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgCFMfT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 07:35:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 04:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,522,1574150400"; 
   d="scan'208";a="275524609"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2020 04:35:14 -0800
Subject: Re: [PATCH 01/10] mmc: sdhci: Add quirk SDHCI_QUIRK2_SET_BUS_VOLTAGE
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
 <20200306103857.23962-2-nsaenzjulienne@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <55ef25ae-5c73-7778-dfda-976809cf9fe6@intel.com>
Date:   Fri, 6 Mar 2020 14:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306103857.23962-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/03/20 12:38 pm, Nicolas Saenz Julienne wrote:
> Adds quirk for controllers whose bus power select register has to be set
> even when powering SD cards from a regulator.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/mmc/host/sdhci.c | 5 +++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c59566363a42..c7fd87447457 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1920,6 +1920,11 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  
>  	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  
> +	if (host->quirks2 & SDHCI_QUIRK2_SET_BUS_VOLTAGE) {

We don't really want to replace callbacks by quirks.

Replace sdhci_milbeaut_set_power() etc by a common fn in sdhci.c if you want.

> +		sdhci_set_power_noreg(host, mode, vdd);
> +		return;
> +	}
> +
>  	if (mode != MMC_POWER_OFF)
>  		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
>  	else
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cac2d97782e6..9531a4e5b148 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -484,6 +484,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Set bus voltage even when powering from an external regulator */
> +#define SDHCI_QUIRK2_SET_BUS_VOLTAGE			(1<<19)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 


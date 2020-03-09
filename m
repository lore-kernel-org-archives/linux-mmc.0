Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EEAC10F27
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 07:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD5220674
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 07:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgCIH3v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:29:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:55367 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgCIH3v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Mar 2020 03:29:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 00:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="235519831"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2020 00:29:47 -0700
Subject: Re: [PATCH v2 09/11] mmc: sdhci: iproc: Add custom set_power()
 callback for bcm2711
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
 <20200306174413.20634-10-nsaenzjulienne@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <254549a8-804a-eb8a-7fce-374852bbd9af@intel.com>
Date:   Mon, 9 Mar 2020 09:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306174413.20634-10-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/03/20 7:44 pm, Nicolas Saenz Julienne wrote:
> The controller needs a valid bus voltage in its power register
> regardless of whether an external regulator is taking care of the power
> supply.
> 
> The sdhci core already provides a helper function for this,
> sdhci_set_power_and_bus_voltage(), so create a bcm2711 specific 'struct
> sdhci_ops' which makes use of it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-iproc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index f4f5f0a70cda..225603148d7d 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -261,9 +261,24 @@ static const struct sdhci_iproc_data bcm2835_data = {
>  	.mmc_caps = 0x00000000,
>  };
>  
> +static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
> +	.read_l = sdhci_iproc_readl,
> +	.read_w = sdhci_iproc_readw,
> +	.read_b = sdhci_iproc_readb,
> +	.write_l = sdhci_iproc_writel,
> +	.write_w = sdhci_iproc_writew,
> +	.write_b = sdhci_iproc_writeb,
> +	.set_clock = sdhci_set_clock,
> +	.set_power = sdhci_set_power_and_bus_voltage,
> +	.get_max_clock = sdhci_iproc_get_max_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
>  	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> -	.ops = &sdhci_iproc_32only_ops,
> +	.ops = &sdhci_iproc_bcm2711_ops,
>  };
>  
>  static const struct sdhci_iproc_data bcm2711_data = {
> 


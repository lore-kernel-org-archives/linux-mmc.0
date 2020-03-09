Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154F1C10F27
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 07:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAF72072A
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 07:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgCIHVC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:21:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:34568 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIHVC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Mar 2020 03:21:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 00:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="235518417"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2020 00:20:58 -0700
Subject: Re: [PATCH v2 05/11] mmc: sdhci: pxav3: Use
 sdhci_set_power_and_voltage()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
 <20200306174413.20634-6-nsaenzjulienne@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <92473c9e-693a-fa98-2a96-a200a86dc2fc@intel.com>
Date:   Mon, 9 Mar 2020 09:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306174413.20634-6-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/03/20 7:44 pm, Nicolas Saenz Julienne wrote:
> The sdhci core provides a helper function with the same functionality as
> this controller's set_power() callback. Use it instead.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index e55037ceda73..75fe90b88f9b 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -297,27 +297,9 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  		__func__, uhs, ctrl_2);
>  }
>  
> -static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
> -			    unsigned short vdd)
> -{
> -	struct mmc_host *mmc = host->mmc;
> -	u8 pwr = host->pwr;
> -
> -	sdhci_set_power_noreg(host, mode, vdd);
> -
> -	if (host->pwr == pwr)
> -		return;
> -
> -	if (host->pwr == 0)
> -		vdd = 0;
> -
> -	if (!IS_ERR(mmc->supply.vmmc))
> -		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> -}

This code is different.  The commit message should explain why it is
equivalent.  Has it been tested?

> -
>  static const struct sdhci_ops pxav3_sdhci_ops = {
>  	.set_clock = sdhci_set_clock,
> -	.set_power = pxav3_set_power,
> +	.set_power = sdhci_set_power_and_bus_voltage,
>  	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> 


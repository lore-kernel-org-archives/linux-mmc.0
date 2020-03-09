Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5251FC10F27
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 07:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D34720674
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 07:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCIH2U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:28:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:55270 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgCIH2U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Mar 2020 03:28:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 00:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="235519591"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2020 00:28:14 -0700
Subject: Re: [PATCH v2 07/11] mmc: sdhci: am654: Use
 sdhci_set_power_and_voltage()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
 <20200306174413.20634-8-nsaenzjulienne@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9919960a-fcb1-f67d-17cf-37b49f2a2d5c@intel.com>
Date:   Mon, 9 Mar 2020 09:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306174413.20634-8-nsaenzjulienne@suse.de>
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 3afea580fbea..c70647489bbd 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -208,17 +208,6 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>  	sdhci_set_clock(host, clock);
>  }
>  
> -static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
> -				  unsigned short vdd)
> -{
> -	if (!IS_ERR(host->mmc->supply.vmmc)) {
> -		struct mmc_host *mmc = host->mmc;
> -
> -		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> -	}
> -	sdhci_set_power_noreg(host, mode, vdd);
> -}
> -
>  static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>  {
>  	unsigned char timing = host->mmc->ios.timing;
> @@ -274,7 +263,7 @@ static struct sdhci_ops sdhci_am654_ops = {
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.set_power = sdhci_am654_set_power,
> +	.set_power = sdhci_set_power_and_bus_voltage,
>  	.set_clock = sdhci_am654_set_clock,
>  	.write_b = sdhci_am654_write_b,
>  	.irq = sdhci_am654_cqhci_irq,
> @@ -297,7 +286,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.set_power = sdhci_am654_set_power,
> +	.set_power = sdhci_set_power_and_bus_voltage,
>  	.set_clock = sdhci_am654_set_clock,
>  	.write_b = sdhci_am654_write_b,
>  	.irq = sdhci_am654_cqhci_irq,
> @@ -320,7 +309,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.set_power = sdhci_am654_set_power,
> +	.set_power = sdhci_set_power_and_bus_voltage,
>  	.set_clock = sdhci_j721e_4bit_set_clock,
>  	.write_b = sdhci_am654_write_b,
>  	.irq = sdhci_am654_cqhci_irq,
> 


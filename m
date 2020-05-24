Return-Path: <SRS0=G4HJ=7G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5C1C433E0
	for <linux-mmc@archiver.kernel.org>; Sun, 24 May 2020 19:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0812076C
	for <linux-mmc@archiver.kernel.org>; Sun, 24 May 2020 19:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbgEXTic (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 May 2020 15:38:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:57082 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387744AbgEXTic (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 24 May 2020 15:38:32 -0400
IronPort-SDR: SEN/+0Z/2lB2wB0ekwfNt98xmPW5t/aToN4CWfahQ5OlgTMoFLSjXZETqKmrnHlcynFkie3QBD
 yAa8rOJI6VoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 12:38:31 -0700
IronPort-SDR: D6wgeXCWwEmv3VEII5lXk1pCjWl3qyapQPtcA7HdVPdmCTRWStdu+hCyJf93vzY/H279TAA1iv
 ElP0q47Dj9Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,430,1583222400"; 
   d="scan'208";a="413312034"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2020 12:38:30 -0700
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: exit HS400 properly before setting
 any speed mode
To:     Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
References: <20200522031256.856-1-yangbo.lu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fef26f42-02dd-39dd-3c05-61a21c73a2c0@intel.com>
Date:   Sun, 24 May 2020 22:38:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522031256.856-1-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22/05/20 6:12 am, Yangbo Lu wrote:
> The eSDHC HS400 timing requires many specific registers setting,
> unlike other speed modes which need to set only host controller 2
> register. When driver needs to downgrade HS400 mode to other speed
> mode, the controller have to exit HS400 timing properly first.
> This patch is to support the procedure of HS400 exiting at the
> beginning of esdhc_set_uhs_signaling.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 5d8dd87..7c73d24 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1135,6 +1135,40 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  static void esdhc_set_uhs_signaling(struct sdhci_host *host,
>  				   unsigned int timing)
>  {
> +	u32 val;
> +
> +	/*
> +	 * There are specific registers setting for HS400 mode.
> +	 * Clean all of them if controller is in HS400 mode to
> +	 * exit HS400 mode before re-setting any speed mode.
> +	 */
> +	val = sdhci_readl(host, ESDHC_TBCTL);
> +	if (val & ESDHC_HS400_MODE) {
> +		val = sdhci_readl(host, ESDHC_SDTIMNGCTL);
> +		val &= ~ESDHC_FLW_CTL_BG;
> +		sdhci_writel(host, val, ESDHC_SDTIMNGCTL);
> +
> +		val = sdhci_readl(host, ESDHC_SDCLKCTL);
> +		val &= ~ESDHC_CMD_CLK_CTL;
> +		sdhci_writel(host, val, ESDHC_SDCLKCTL);
> +
> +		esdhc_clock_enable(host, false);
> +		val = sdhci_readl(host, ESDHC_TBCTL);
> +		val &= ~ESDHC_HS400_MODE;
> +		sdhci_writel(host, val, ESDHC_TBCTL);
> +		esdhc_clock_enable(host, true);
> +
> +		val = sdhci_readl(host, ESDHC_DLLCFG0);
> +		val &= ~(ESDHC_DLL_ENABLE | ESDHC_DLL_FREQ_SEL);
> +		sdhci_writel(host, val, ESDHC_DLLCFG0);
> +
> +		val = sdhci_readl(host, ESDHC_TBCTL);
> +		val &= ~ESDHC_HS400_WNDW_ADJUST;
> +		sdhci_writel(host, val, ESDHC_TBCTL);
> +
> +		esdhc_tuning_block_enable(host, false);
> +	}
> +
>  	if (timing == MMC_TIMING_MMC_HS400)
>  		esdhc_tuning_block_enable(host, true);
>  	else
> 


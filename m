Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C158C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Dec 2022 14:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLUOVX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Dec 2022 09:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUOVW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2022 09:21:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B805F6B
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2022 06:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671632481; x=1703168481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+1BAgnq44fXVNgJvDS2uu2zo7wxKsf2oH8pynii1pp8=;
  b=cvK0K1SxAD54447Es3K4KwLFQYpYNcUzqAvXveKza2MNligB88uZ5WVl
   DYq8XrApnu12siw80lMrv4Igs1qTsjZZAi40kAt3lxMX+zxOp2yCG17PL
   fyK41p1cGdRpBzBbWpQAYc4IKL8RzcbW9NqUA92fNn+8tB6ZfNTG5MDWf
   WWWYuZk+Kruui8XOyOGKaR2IeU0LiJpe6dUzHSfbXd6PEPauuOWoC7r+i
   o8DYpPv5cZwpt8YRb5D8cvhykSAqCvWh/sy8gh8+zeTHqGNO7AkWY27Q4
   h3EXpNBuAKgEn4nBIocnbK4NL4og3tahOFuGtMKoGr6H4vrWsCGPrzPsi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="321791231"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="321791231"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 06:21:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="601500708"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="601500708"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.206])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 06:21:16 -0800
Message-ID: <2e89e4e8-cac8-dc1d-9ec7-01599190167b@intel.com>
Date:   Wed, 21 Dec 2022 16:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD
 line auto tuning for SDIO device
Content-Language: en-US
To:     haibo.chen@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, ulf.hansson@linaro.org
References: <20221221112853.789675-1-haibo.chen@nxp.com>
 <20221221112853.789675-4-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221221112853.789675-4-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/12/22 13:28, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> USDHC IP has one limitation: the tuning circuit can't handle the async
> sdio device interrupt correctly. When sdio device use 4 data lines,
> async sdio interrupt will use the shared DAT[1], if enable auto tuning
> circuit to check these 4 data lines, include the DAT[1], this circuit
> will detect this interrupt, take this as data on DAT[1], and adjust the
> delay cell wrongly, finally will cause the DATA/CMD CRC error.
> So for SDIO device, only enable DAT[0] and CMD line for auto tuning.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index bf8d6f60a9ee..d6ce4c8d23dc 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -448,6 +448,20 @@ static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
>  		break;
>  	}
>  
> +	/*
> +	 * For USDHC, auto tuning circuit can not handle the async sdio
> +	 * device interrupt correctly. When sdio device use 4 data lines,
> +	 * async sdio interrupt will use the shared DAT[1], if enable auto
> +	 * tuning circuit check these 4 data lines, include the DAT[1],
> +	 * this circuit will detect this interrupt, take this as a data on
> +	 * DAT[1], and adjust the delay cell wrongly.
> +	 * This is the hardware design limitation, to avoid this, for sdio
> +	 * device, config the auto tuning circuit only check DAT[0] and CMD
> +	 * line.
> +	 */
> +	if (!host->mmc->card && mmc_card_sdio(host->mmc->card))

Looks like !host->mmc->card should be host->mmc->card

> +		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
> +
>  	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
>  			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
>  			ESDHC_VEND_SPEC2);


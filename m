Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438B1C7EE23
	for <linux-mmc@archiver.kernel.org>; Fri, 19 May 2023 10:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjESKhl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 May 2023 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjESKhf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2023 06:37:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B610C9;
        Fri, 19 May 2023 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684492626; x=1716028626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qfmmYRa86O3IofAbf9RtJNH6g7Li/YLiiKzZUrXltxs=;
  b=X21NCP4yWMnDHc0IZDFFTJW40DivludynSwPvGZot55lu+QCvE07Ye1T
   2UY0srljPOrlu2xOjIIBPssS2n0EmUjN5m50duwzvYgAYsVSSJRN2JmqQ
   wbeEyHt+QRUxNTbl33KhDeuIrDPM6Bec8ZhJy+Ky/taURyExCLXlu3/+N
   xJ3xfLTAgeIYd16FarHJc2tAc4ny6nWpzQuEiZpqpPVhI10GfDxBpfvkQ
   xVABpsxzFSZXZuo6tetMw/ilANQNFbfWreBNJ51h8Dw1uWA8Nev6Q+OI+
   M5D2/5Z1nQbIvZ5vQPYag2TtylaEjqSU5WfntxJkaHleqXPYCQ+SdBK83
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="438691414"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="438691414"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 03:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="949069562"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="949069562"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 03:36:57 -0700
Message-ID: <249e1058-790d-8e5b-663a-5ae0ceef3fe8@intel.com>
Date:   Fri, 19 May 2023 13:36:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: remove redundant write
 protect code
Content-Language: en-US
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        cniedermaier@dh-electronics.com, devicetree@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230506074037.522961-1-haibo.chen@nxp.com>
 <20230506074037.522961-3-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230506074037.522961-3-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/05/23 10:40, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The logic of the esdhc_pltfm_get_ro() is just the same with common
> code sdhci_check_ro(). So remove this redundant code, depends on
> mmc_of_parse() and sdhci_check_ro() to cover the write protect
> logic.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 47 +-----------------------------
>  1 file changed, 1 insertion(+), 46 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c7db742f729c..54531aab70f0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -201,22 +201,8 @@
>  /* ERR004536 is not applicable for the IP  */
>  #define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
>  
> -enum wp_types {
> -	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
> -	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
> -	ESDHC_WP_GPIO,		/* external gpio pin for WP */
> -};
> -
> -/*
> - * struct esdhc_platform_data - platform data for esdhc on i.MX
> - *
> - * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
> - *
> - * @wp_type:	type of write_protect method (see wp_types enum above)
> - */
> -
> +/* struct esdhc_platform_data - platform data for esdhc on i.MX */
>  struct esdhc_platform_data {
> -	enum wp_types wp_type;
>  	int max_bus_width;
>  	unsigned int delay_line;
>  	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
> @@ -994,25 +980,6 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  
>  }
>  
> -static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
> -
> -	switch (boarddata->wp_type) {
> -	case ESDHC_WP_GPIO:
> -		return mmc_gpio_get_ro(host->mmc);
> -	case ESDHC_WP_CONTROLLER:
> -		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
> -			       SDHCI_WRITE_PROTECT);
> -	case ESDHC_WP_NONE:
> -		break;
> -	}
> -
> -	return -ENOSYS;
> -}
> -
>  static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>  {
>  	u32 ctrl;
> @@ -1380,7 +1347,6 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.get_max_clock = esdhc_pltfm_get_max_clock,
>  	.get_min_clock = esdhc_pltfm_get_min_clock,
>  	.get_max_timeout_count = esdhc_get_max_timeout_count,
> -	.get_ro = esdhc_pltfm_get_ro,
>  	.set_timeout = esdhc_set_timeout,
>  	.set_bus_width = esdhc_pltfm_set_bus_width,
>  	.set_uhs_signaling = esdhc_set_uhs_signaling,
> @@ -1588,17 +1554,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
>  	int ret;
>  
> -	if (of_property_read_bool(np, "fsl,wp-controller"))
> -		boarddata->wp_type = ESDHC_WP_CONTROLLER;

esdhc_pltfm_get_ro() differs from sdhci_check_ro() by defaulting
to -ENOSYS if there is neither "fsl,wp-controller" nor "wp-gpios",
which would result in write-protect off (not supported, e.g. microsd).
So more explanation is needed for why removing "fsl,wp-controller"
will give the same result.

> -
> -	/*
> -	 * If we have this property, then activate WP check.
> -	 * Retrieveing and requesting the actual WP GPIO will happen
> -	 * in the call to mmc_of_parse().
> -	 */
> -	if (of_property_read_bool(np, "wp-gpios"))
> -		boarddata->wp_type = ESDHC_WP_GPIO;
> -
>  	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
>  	of_property_read_u32(np, "fsl,tuning-start-tap",
>  			     &boarddata->tuning_start_tap);


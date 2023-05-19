Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E261C77B75
	for <linux-mmc@archiver.kernel.org>; Fri, 19 May 2023 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjESKho (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 May 2023 06:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjESKhm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2023 06:37:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED61702;
        Fri, 19 May 2023 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684492633; x=1716028633;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BDE6vPICxTgLAPRrdZrc0xG8msLQShbdcPsC90DqwtQ=;
  b=VdemtA+HejULlmje+B3l5mPkoFBHqEVFxM/7TVwjnEQU0WpT/M0Xbkqy
   4i82ao6r4a52PvulqADZhSDFfMzwnKlY6caK0hWtw5E6ShbwrDMRaYk7a
   ZGNVjp/If0iuwJ54eDaxhLmXoeoaufYbBcoci1c/QFrsWVTt/8p3wqZcz
   U7tjD/QkkiBFwiTLnCf2WjxCJpDAnS5PIGB175NjIgqt5FbKPGyUjqBDw
   3VfmeizBVnzm/P5xGk5DdyYfY96i++0J3qWG428McrxyvTAwBwotzfnf3
   1vEC36ofo+CwuQvD46Mvc9tlaWmAnM4NgHloqFu27nKj0KmeJHXQJ93HE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="438691463"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="438691463"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 03:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="949069650"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="scan'208";a="949069650"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.109])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 03:37:09 -0700
Message-ID: <deb7bfca-0a5c-a9c9-06bd-c4290f2116f4@intel.com>
Date:   Fri, 19 May 2023 13:37:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] mmc: sdhci-esdhc-imx: remove unused enum cd_types
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        cniedermaier@dh-electronics.com, devicetree@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230506074037.522961-1-haibo.chen@nxp.com>
 <20230506074037.522961-2-haibo.chen@nxp.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230506074037.522961-2-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/05/23 10:40, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> enum cd_types is no more used, so remove it here.

FWIW it doesn't look like max_bus_width is being used either?

> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index eebf94604a7f..c7db742f729c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -207,25 +207,16 @@ enum wp_types {
>  	ESDHC_WP_GPIO,		/* external gpio pin for WP */
>  };
>  
> -enum cd_types {
> -	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
> -	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
> -	ESDHC_CD_GPIO,		/* external gpio pin for CD */
> -	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
> -};
> -
>  /*
>   * struct esdhc_platform_data - platform data for esdhc on i.MX
>   *
>   * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
>   *
>   * @wp_type:	type of write_protect method (see wp_types enum above)
> - * @cd_type:	type of card_detect method (see cd_types enum above)
>   */
>  
>  struct esdhc_platform_data {
>  	enum wp_types wp_type;
> -	enum cd_types cd_type;
>  	int max_bus_width;
>  	unsigned int delay_line;
>  	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */


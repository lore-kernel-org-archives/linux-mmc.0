Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FECC54EBE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 11:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbjAMLr2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 06:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjAMLrG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 06:47:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA93BFB;
        Fri, 13 Jan 2023 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673609875; x=1705145875;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sg5++PrIBFRggNIEYciFlB+sCEOJFUAqb77NPGm/Lyw=;
  b=Z8c4oKV1ViiUVDkB/Az9OnyOz0rqSw0/JLEP0NlpmzvkAR9bjvb2v+q8
   MpGWotnjmmpVDubo8VZj6FTQOUPHbzERQ8+IumbydZzaEOEXQJrSFEOKt
   RObtXoyxlBmK1YSkB+gY38z2tkyXQFCj5t7wlgtJLQQ0XGX8olWovpwZv
   Ka6Lr+0sESOr+ezHRMWQGYV/Dke/CxNB6A8aVgA2G07J+Otk1xrtKufJA
   mdV5djYIp3ydtzXScOvP9upS4P8+lOKHMdzF6dzdJbbkqutm5hf95E/50
   V6TgJC6fYAMJT/ChGOEnx/clV3dRJPOTk5fKHo6RRrLXpZKdK44SsFjEv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="326030349"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="326030349"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:37:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="903551451"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="903551451"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.178])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:37:53 -0800
Message-ID: <5b79cbae-7cab-a258-0081-aeb92cca614f@intel.com>
Date:   Fri, 13 Jan 2023 13:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: enable host V4 support for
 BlueField-3 SoC
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <990885f566c32ac8e6888ad6b434fb70d1a5d7af.1673460632.git.limings@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <990885f566c32ac8e6888ad6b434fb70d1a5d7af.1673460632.git.limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/01/23 20:14, Liming Sun wrote:
> This commit enables SDHCI Host V4 support on Bluefield-3 SoC to be
> consistent with the default setting in firmware(UEFI).
> 
> Reviewed-by: David Woods <davwoods@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a7343d4bc50e..49338670c89f 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -528,6 +528,11 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  			goto err_clk;
>  	}
>  
> +#ifdef CONFIG_ACPI
> +	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
> +		sdhci_enable_v4_mode(host);
> +#endif
> +
>  	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>  
>  	err = sdhci_setup_host(host);


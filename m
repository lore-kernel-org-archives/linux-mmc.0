Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD8C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Dec 2021 06:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhLQGua (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Dec 2021 01:50:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:62605 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhLQGua (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Dec 2021 01:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639723829; x=1671259829;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RHsmKGPHy5x6f6ULFp8ELEC86Lh6h4iYXmDHqIqNpg8=;
  b=bGVxkv2ts/eoRdl0hri4/xYAeimds7J6kQKQRt6GRYcbtJFh+WddXqaH
   cBIsIzSSYCS03DgNPuMjHwogJ/0znQOC9IRbOiXU7Opl8+8OKqpvHQTb0
   XJE9c1jSnnxAWi6cD1QsKgtKkI18sCU2syzl8BpZ789GCuohYpvuFWW2W
   EGnt2zn/Gz3DKFepQ6Q/amJrbOFO/wcRLJj29R1uWhJkxnBFHYGN3c9rZ
   wSJqQEHlqiHJZNhoY7u1CXnsKRVmGHNpnKi2YCPlFcDlOaA9zKrL5nM/o
   Keww8774oO6Fg6gebFl7A3yjB8OjfIt+9eU79b50+zPOSPG3efyXd/CRa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="237234563"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="237234563"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 22:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="466400142"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 22:49:55 -0800
Subject: Re: [PATCH V3 2/2] mmc:sdhci-pci-o2micro:Make the SD clock's base
 clock frequency correctly according to different card mode
To:     fred <fred.ai@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
References: <20211216060824.357-1-fred.ai@bayhubtech.com>
 <20211216060824.357-2-fred.ai@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8c19d0ed-ef02-15c4-98f0-f0a541a11826@intel.com>
Date:   Fri, 17 Dec 2021 08:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216060824.357-2-fred.ai@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/12/2021 08:08, fred wrote:
> From: Fred Ai <fred.ai@bayhubtech.com>
> 
> Remove SDR104 card, SD clock's base clock
> frequency is not right when insert SD2.0/SDR50 card
> 
> Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Change in V3:
> 1.Set SD clock's base clock frequency to 208MHz when card mode is SDR104/HS200.
> 2.Set SD clock's base clock frequency to 200MHz when card mode is SD2.0/SDR50.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index f55602609f8c..4ca1e8c5b631 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -577,6 +577,11 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
>  			o2_pci_set_baseclk(chip, 0x2c280000);
> +	} else {
> +		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
> +
> +		if ((scratch_32 & 0xFFFF0000) != 0x25100000)
> +			o2_pci_set_baseclk(chip, 0x25100000);
>  	}
>  
>  	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> 


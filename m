Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6046C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Dec 2021 09:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhLNJxy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Dec 2021 04:53:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:1119 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhLNJxx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Dec 2021 04:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639475633; x=1671011633;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=J7O3C4f35hmKzqS7hetBdqJ0+vc4PX34iw4sAtMYxYU=;
  b=bDBwzDmbRKHfdEYZh/EsHDeNx0icBZ0n9qpWOiyPJ0wbTBhn7P6I0e3P
   NPjkRyJEKseH/rFgGjbzaq18Hkigl8k+7rqN2vTWwBVpYAqb++a4AMWyB
   9jcAPiNVJwEpjzQtD43eiljLXCNTBLqeZ9KorqaFQwTMyNvBufMbUBWgp
   RAlMpVCvb7Ul6wPL6tfrAddwcQdpKh+ZymghOnbQkAFyfTOsnRVZWuC2x
   rJ3IQ5A0+grujwY/hssjnlBrpuQXHLIh2fqUyqpWFXaliWuHcdfg6KZQK
   Don9J6O3uxzZWemDyltdgDZ/BZh54U+41Z97x0Uz1xuNR52M16F25NOQi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263082115"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="263082115"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 01:53:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="465010456"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 01:53:51 -0800
Subject: Re: [[PATCH V2] 2/2] mmc:sdhci-pci-o2micro:Change implementation of
 setting corresponding PLL frequency according to card mode
To:     fred <fred.ai@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com
References: <20211206131507.411-1-fred.ai@bayhubtech.com>
 <20211206131507.411-2-fred.ai@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <beac7ce3-c807-8612-669e-3696c5e83daa@intel.com>
Date:   Tue, 14 Dec 2021 11:53:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211206131507.411-2-fred.ai@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/12/2021 15:15, fred wrote:
> From: "fred.ai" <fred.ai@bayhubtech.com>
> 
> Driver will set PLL frequency by different card mode
> 1.SD2.0 and SDR50 card mode base clock frequency is 208MHz
> 2.SDR104 card mode base clock frequency is 200MHz

Again the subject needs improvement, should have been like:

[PATCH V2 2/2] mmc: sdhci-pci-o2micro: Change implementation of setting corresponding PLL frequency according to card mode

> 
> Signed-off-by: fred.ai <fred.ai@bayhubtech.com>
> 
> Change in V2:
> ---

This '---' here causes the "Change in V2:" alone to be in the
commit message.  Better to put it after the signed-off line.

> After SD2.0 or SDR50 card initlization, driver will select base clock frequency 200MHz
> by setting PLL frequency value 0x2510.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 98c1a17eb619..4d79fda10dcb 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -569,8 +569,16 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
>  		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
>  
> +		/* SDR104 card mode PLL frequency value is 0x2c28 */
>  		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
>  			o2_pci_set_baseclk(chip, 0x2c280000);
> +
> +	} else {
> +		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
> +
> +		/* SD2.0,SDR50 card mode PLL frequency value is 0X2510 */
> +		if ((scratch_32 & 0xFFFF0000) != 0x2510000)
> +			o2_pci_set_baseclk(chip, 0x25100000);
>  	}
>  
>  	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> 


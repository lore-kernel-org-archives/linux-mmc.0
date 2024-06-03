Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837D10795;
	Mon,  3 Jun 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401691; cv=none; b=PpKqo4nLVXayPcW7CSATYwb7kAk5UjSxbSDwZcgGHy9rFRZUxhZf6Rp3el/nsoAH2U35qVvXSQZ7M9bTgM2cxLgXl5Bs1mxDQOiRaRmxTQejw1SHRG0hXaxyTFrvDFljFNnyTZyrkHWCE82sXUb+zPtwAf/FOvijFo6Wk/g4YmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401691; c=relaxed/simple;
	bh=x2gDSQW2pj1ccPUsBYdlXwrfsAKY0dYLo/EzEfnd2Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoBZ6cEno7VjiOfYu6opqdcAP1jv3twYp1beAJXYwKc+TSW/dE3DdFmQkMnLnziSqaK78y7XlLXX9PSB6gTRnlBR466R6BtFSHQbIpCaMsMxUafgZYHdAPFJC0iIiVvUthER8LKuqt+AGyvdIz0sVirmGMgPPGuMwPUJ4PKrawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1zqMDRP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1zqMDRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717401689; x=1748937689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x2gDSQW2pj1ccPUsBYdlXwrfsAKY0dYLo/EzEfnd2Xg=;
  b=j1zqMDRPrds/gu/V4WjN8oondxNtq1HceL88BbtGfYLaWIgXsRZ+ozlc
   B05jO1ccdxp7EJA04YwHsN5qi+GBD/jufKGuS0b9aU8g50ctfmnWYgg+t
   5WwlmW9c1wyUSn4dkqgKQkWbxQx77CBnXYR9zE4ESKS7+6ze49Cs4kaK2
   HfWjrgm9ttRwPcMvyxFdKtlIqPSkO0SpuPcrjWbQ8/jAOuOOipO3SMnFp
   9KrKz9ficVr1bf5+oE9Gz8zgJp0h+Mc3GSKPV/qMFeVeZip/rhvUy0ZEU
   EY+YHjaYOFC0X1OBttnWwlUwdPI+OjtaYw1c4/c7CYOYsyh8U0rGYuPv0
   Q==;
X-CSE-ConnectionGUID: ano/tOGlScWoqhuaByUEDw==
X-CSE-MsgGUID: z2omwTqPTzi/qPmNIG5y1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13694447"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="13694447"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 01:01:29 -0700
X-CSE-ConnectionGUID: aVnnHWBAR0Sb73gcRnDJMw==
X-CSE-MsgGUID: NwloJLSyTwya+l3iumyDcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36884043"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.18])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 01:01:26 -0700
Message-ID: <55cea03b-e685-4f7b-a93b-cb464417d364@intel.com>
Date: Mon, 3 Jun 2024 11:01:23 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: don't enable CQE without a
 suitable irq handler
To: Heiko Stuebner <heiko@sntech.de>, ulf.hansson@linaro.org
Cc: serghox@gmail.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240530215532.2192423-1-heiko@sntech.de>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240530215532.2192423-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/05/24 00:55, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> supports-cqe is an established dt property so can appear in devicetrees
> at any time. CQE support in the sdhci-of-dwcmshc driver does require a
> special irq handler in the platform-specific ops, to handle the CQE
> interrupt.
> 
> Without this special handler we end up with a spew of unhandled interrupt
> messages on devices with supports-cqe property but without irq handler:
> 
> [   11.624143] mmc0: Unexpected interrupt 0x00004000.
> [   11.629504] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   11.636711] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000005
> [   11.643919] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> [   11.651128] mmc0: sdhci: Argument:  0x00018000 | Trn mode: 0x00000033
> [   11.658336] mmc0: sdhci: Present:   0x13f700f0 | Host ctl: 0x00000034
> [   11.665545] mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
> [   11.672753] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000407
> [   11.679961] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00004000
> [   11.687169] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
> [   11.694378] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [   11.701586] mmc0: sdhci: Caps:      0x226dc881 | Caps_1:   0x08000007
> [   11.708794] mmc0: sdhci: Cmd:       0x00000d1e | Max curr: 0x00000000
> [   11.716003] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
> [   11.723211] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x000007cd
> [   11.730419] mmc0: sdhci: Host ctl2: 0x0000000f
> [   11.735392] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xee28f008
> [   11.742600] mmc0: sdhci: ============================================
> 
> So don't enable CQE if a usable interrupt handler is not defined and warn
> instead about this fact.
> 
> Fixes: 53ab7f7fe412 ("mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
> My rk3588-tiger and rk3588-jaguar devicetrees had an accidential
> supports-cqe in their devicetree, which made me run into this problem
> with 6.10-rc1 .
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 39edf04fedcf7..4410d4523728d 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1254,10 +1254,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	/* Setup Command Queue Engine if enabled */
>  	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> -		priv->vendor_specific_area2 =
> -			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
> +		if (pltfm_data && pltfm_data->ops && pltfm_data->ops->irq) {

->irq() could be used for other things, so checking it for CQE
support is not appropriate.

If necessary, it would be better to flag which variants support
CQE in their platform data.

However that would probably mean introducing something
like struct dwcmshc_pltfm_data as described here:

https://lore.kernel.org/linux-mmc/ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com/


> +			priv->vendor_specific_area2 =
> +				sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>  
> -		dwcmshc_cqhci_init(host, pdev);
> +			dwcmshc_cqhci_init(host, pdev);
> +		} else {
> +			dev_warn(&pdev->dev, "can't enable cqe support without irq handler\n");
> +		}
>  	}
>  
>  	if (rk_priv)


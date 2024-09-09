Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639B5733A
	for <linux-mmc@vger.kernel.org>; Mon,  9 Sep 2024 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878227; cv=none; b=AECXJ8+WB+yB3hsqFOAJNYA3KEB9XInaOuXk/wX56VtuOZ8gVWZWZto6x61Zh6Ws4l7Hz6tDE4YG/UCuhlh4tIsD/ReIp17NZlO8DvuFDXCrd1FvHvlmgp8ad0Ob0RLxL1Js58YAdVGIuqbkWetIkSuMP8qK4AmoTYI4AjrUt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878227; c=relaxed/simple;
	bh=a3X6g+r1k1SIuERnQC2a1ML2jFsiyREvYeDpvfgDQ2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/KzK/1Vhlnj8F8LfSlrd3Pos8dRHcgqi0pWal5Mj9TPM035Tn/xAwlf8AdECYKs7DsVsmdmVFYU9qQ8y6AISs5EgwPrDs2SVTUie4kLjUFfKvTmjE3VdWKyfST9jMPqkzJz2E1g6bTgDIOTIFeOsbCSR0Tr3RbJSs8Rk+5cDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jprQI5PT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jprQI5PT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725878225; x=1757414225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a3X6g+r1k1SIuERnQC2a1ML2jFsiyREvYeDpvfgDQ2I=;
  b=jprQI5PTCCKxkWRP5IFctEq5pSNbpAqBYGXNMgQBvvgjVBi+n9e6GfaD
   QOV5msxBTiZicPfVyrAGWEq8txvmJJF2dF2Sowfr7aPVdTYN5c1HyURkb
   27B0XE8i8m9J7amjVean049wITKWUFTO16l3jntliOCEgrVqcDsPYEwLr
   b47DQc3ca2wjAIADAelZGND3wSc9Gc5UrFpl38sjplVc/yv2yy1U8XitR
   QyKaGpS+jsKLCMMDyJLMCcrLH+fP8wvCmaukkxMij4XKXdGigjTgnUxaR
   GKvAgFollVpaHy9+6oh8zFE/tZnCwXturRF6SleX8wl8avrCo8aUHbz5w
   A==;
X-CSE-ConnectionGUID: 773SuzuLQz6zjTcAXV6deA==
X-CSE-MsgGUID: MSFkwdhORQa6Yiu3Pi0hNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="42044973"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="42044973"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:37:04 -0700
X-CSE-ConnectionGUID: VnOksyMWR06j+ek3Rq1e2g==
X-CSE-MsgGUID: XhcUGEzYQg+JIsbtS+nTgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="71583993"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:37:02 -0700
Message-ID: <e157fc58-a571-4e57-b885-e011b7abdf28@intel.com>
Date: Mon, 9 Sep 2024 13:36:55 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] Add SDUC Support
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Michael Wu <michael@allwinnertech.com>,
 Wenchao Chen <wenchao.chen@unisoc.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240908102018.3711527-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/09/24 13:20, Avri Altman wrote:
> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
> cards support capacity larger than 2TB and up to including 128TB. Thus,
> the address range of the card expands beyond the 32-bit command
> argument. To that end, a new command - CMD22 is defined, to carry the
> extra 6-bit upper part of the 38-bit block address that enable access to
> 128TB memory space.
> 
> SDUC capacity is agnostic to the interface mode: UHS-I and UHS-II – Same
> as SDXC.
> 
> The spec defines several extensions/modifications to the current SDXC
> cards, which we address in patches 1 - 10.  Otherwise requirements are
> out-of-scope of this change.  Specifically, CMDQ (CMD44+CMD45), and
> Extension for Video Speed Class (CMD20).
> 
> First publication of SDUC was in [1].  This series was developed and
> tested separately from [1] and does not borrow from it.
> 
> [1] https://lwn.net/Articles/982566/

I didn't actually give my Reviewed-by in v6, but I guess it can
stand for those patches.

For "mmc: core: Prevent HSQ from enabling for SDUC" it needs
feedback from HSQ users - cc'ed Michael Wu and Wenchao Chen

Otherwise I have no further comments for now.

> 
> ---
> Changes in v7:
>  - Minimizes the padding further in mmc_command (Christian)
>  - Set the SD_OCR_2T when enabling SDUC (Adrian)
>  - Remove unnecessary casting (Adrian)
>  - Remove redundant else and switch patches 3 & 4 (Adrian)
>  - Add patch to prevent HSQ from enabling (Adrian)
>  - Remove redundant variable and make use of clamp_val (Adrian)
> 
> Changes in v6:
>  - Remove Ricky's tested-by tag - the series has changed greatly
>  - Call mmc_send_ext_addr from mmc_start_request (Adrian)
> 
> Changes in v5:
>  - leave out the mask in mmc_send_ext_addr (Adrian)
>  - leave out close-ended SDUC support
>  - remove 500msec write delay as there is no busy indication (Adrian)
>  - disable mmc-test for SDUC
>  - move enabling SDUC to the last patch (Adrian)
> 
> Changes in v4:
>  - Squash patches 1 & 2 (Ulf)
>  - Amend SD_OCR_2T to SD_OCR_CCS in mmc_sd_get_cid (Ulf)
>  - Use card state instead of caps2 (Ricky & Ulf)
>  - Switch patches 5 & 6 (Ulf)
> 
> Changes in v3:
>  - Some more kernel test robot fixes
>  - Fix a typo in a commit log (Ricky WU)
>  - Fix ACMD22 returned value
>  - Add 'Tested-by' tag for the whole series (Ricky WU)
> 
> Changes in v2:
>  - Attend kernel test robot warnings
> 
> ---
> 
> Avri Altman (10):
>   mmc: sd: SDUC Support Recognition
>   mmc: sd: Add Extension memory addressing
>   mmc: core: Don't use close-ended rw for SDUC
>   mmc: core: Add open-ended Ext memory addressing
>   mmc: core: Allow mmc erase to carry large addresses
>   mmc: core: Add Ext memory addressing for erase
>   mmc: core: Adjust ACMD22 to SDUC
>   mmc: core: Disable SDUC for mmc_test
>   mmc: core: Prevent HSQ from enabling for SDUC
>   mmc: core: Enable SDUC
> 
>  drivers/mmc/core/block.c    | 37 +++++++++++++++++++++-------
>  drivers/mmc/core/bus.c      |  4 +++-
>  drivers/mmc/core/card.h     |  3 +++
>  drivers/mmc/core/core.c     | 48 +++++++++++++++++++++++++------------
>  drivers/mmc/core/core.h     | 16 +++++++++----
>  drivers/mmc/core/mmc_test.c |  6 +++++
>  drivers/mmc/core/sd.c       | 38 +++++++++++++++++++----------
>  drivers/mmc/core/sd.h       |  2 +-
>  drivers/mmc/core/sd_ops.c   | 16 +++++++++++++
>  drivers/mmc/core/sd_ops.h   |  1 +
>  drivers/mmc/core/sdio.c     |  2 +-
>  include/linux/mmc/card.h    |  2 +-
>  include/linux/mmc/core.h    |  5 ++++
>  include/linux/mmc/sd.h      |  4 ++++
>  14 files changed, 139 insertions(+), 45 deletions(-)
> 


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638B158866
	for <linux-mmc@vger.kernel.org>; Fri,  6 Sep 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621051; cv=none; b=EuaIzChAeciwOVXalmrh+ESs4jXCni9tE6nqSPABh6I1YN/n+poPXPlZllNLCHN4MltSed1KkzgF+dk0js+G5id6ZUpPMXoGxDAfn0TTL8AJkCiyHViRSVxRkh6ktaX8uEuzkJ8mwJQqpqU6bb79k2LB1Z/YRXCk2n43yqWTCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621051; c=relaxed/simple;
	bh=fzaDyZLxwbBlqiI8n+RtUW0JyXyXvcBfJdT9ZQt4Lp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWTxZwIe45RwV70kZBuLlKq5nrSuyG9br7YiLo+t7L/aG+w1MY8QKrQgEirfPx6ibudDCa6QfYVjsm9ndJ7tZVcpxrZfUwP0njQ3GlKqqlL29Pug2k7k74TZInJTVeLYw30iZjXPPzPgSVCk/efVfS2kFhfbQVl0sJ6XWtLpLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpM13lcy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpM13lcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725621049; x=1757157049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fzaDyZLxwbBlqiI8n+RtUW0JyXyXvcBfJdT9ZQt4Lp8=;
  b=cpM13lcyn/Suv5OCE+T9y3EXx4AJSqAlH8LTnhxgrs1ei583hM7dkVN8
   jjmChY1MiC15yiPBNJxd7JJZ+LRCDiDXUIRrZCJuqlqMSy6cTEx5am+X0
   isb31b0E9GwluuEq7WLoDuxSI49fRr6XStEqCLIx9I6bKnDxuK/QlmGav
   hwwrJUls/8Cj22hcNeVX7aCLXTXuTE8p11mRdviD4DIHNRhE32ImEM8h2
   O7pL02GEEwckjfnt1aIoSGwyW95Ez4TFVg973vW/W3HMeQ6qIcmgT1VBH
   YhEwNR30eQA5ZdptV2wkkmIy4zQocau4LsuhTnEIlDWBV3l9yp8QABNaB
   A==;
X-CSE-ConnectionGUID: qxjBwPtZQsSoPPnv6FEAIw==
X-CSE-MsgGUID: xBPJcopbTkOZRwJ6wDzLrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35045191"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="35045191"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 04:10:30 -0700
X-CSE-ConnectionGUID: 7y/iFM3vSbezk3AxS3/x6A==
X-CSE-MsgGUID: c/2o6rIFRYGOX5tVpdk2EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70715561"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 04:10:28 -0700
Message-ID: <1eee4711-7a42-4c9c-a092-9bb6f69ee3a9@intel.com>
Date: Fri, 6 Sep 2024 14:10:22 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] Add SDUC Support
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240904145256.3670679-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/09/24 17:52, Avri Altman wrote:
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
> 
> ---
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
> Avri Altman (9):
>   mmc: sd: SDUC Support Recognition
>   mmc: sd: Add Extension memory addressing
>   mmc: core: Add open-ended Ext memory addressing
>   mmc: core: Don't use close-ended rw for SDUC
>   mmc: core: Allow mmc erase to carry large addresses
>   mmc: core: Add Ext memory addressing for erase
>   mmc: core: Adjust ACMD22 to SDUC
>   mmc: core: Disable SDUC for mmc_test
>   mmc: core: Enable SDUC
> 
>  drivers/mmc/core/block.c    | 43 +++++++++++++++++++++++-------
>  drivers/mmc/core/bus.c      |  4 ++-
>  drivers/mmc/core/card.h     |  3 +++
>  drivers/mmc/core/core.c     | 52 +++++++++++++++++++++++++------------
>  drivers/mmc/core/core.h     | 16 +++++++++---
>  drivers/mmc/core/mmc_test.c |  7 +++++
>  drivers/mmc/core/sd.c       | 36 ++++++++++++++++---------
>  drivers/mmc/core/sd.h       |  2 +-
>  drivers/mmc/core/sd_ops.c   | 16 ++++++++++++
>  drivers/mmc/core/sd_ops.h   |  1 +
>  drivers/mmc/core/sdio.c     |  2 +-
>  include/linux/mmc/card.h    |  2 +-
>  include/linux/mmc/core.h    |  5 ++++
>  include/linux/mmc/sd.h      |  4 +++
>  14 files changed, 146 insertions(+), 47 deletions(-)
> 

I made a few comments, but this looks good
otherwise.


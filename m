Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921121714A8
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745460; cv=none; b=IyIYTFIG8z7mAvt8eRwVKoaUWG+FJLrtNZvZqr8jzv04+07GUbRqivZmIP+4Ez5HHkptWbN1a2p5BFbksjdPXOQqJcdaf27UuR/nydVb9jvJdep4drVyjzm7K9cSqhf6Rt0k3OL+5sCioWEuzJwanNpiTxYWj5ZOk14o2PA3Fgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745460; c=relaxed/simple;
	bh=3g6U6rYoiwtHS/NkOkYUE0ZjcOwMxA84nYygX9+O9dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoTem7Sl0VEiEYxS1wUbg6G+LzPVzf58Xyx02Y39j48zEQloNajUWO2p+hxuiWpu7PtnolPbcyeWhEIHgUrSXQYhMdQoWSEpHVl0kDZO3bc/mMHtDn9zEalcwQ6NmaBbar5s8fYNeE/AFdE0L2povvCtj62QpUEd/BDRECxpdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enEJ+A3s; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enEJ+A3s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724745459; x=1756281459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3g6U6rYoiwtHS/NkOkYUE0ZjcOwMxA84nYygX9+O9dU=;
  b=enEJ+A3sMwSEg3Im4gOpfRrhgXx/S527wByDM80LzMn5zHqY0B6Dow/f
   SdLf9D0o2jzrp/asOjIVhq3YwJDYINozR+AZ9eVHYDbgnRMxxtPmYpIOL
   k9CTTEdrbTsOzJCjlG2aDo8Ivgy1gntgNU+sizt0ZhxXUqtvCQkYChho5
   mGboS7KVgaJ12LaoEB7H2mb5oxAmM+rh/ONkS/DbsX0SBzary/LOUxSgm
   0zkddGpVtZfNwmyRNZ7SjRnIn2X7tZSo1DOOZK7jP0orZjiiI8Dxr4tOf
   ry4C6+v89gbEKHF1++d5RZ8FK2qRCIwpwUzeK/f8UDUa8woE1Kzm+oixI
   Q==;
X-CSE-ConnectionGUID: zlfDbSHkQA+Ox4Afxcrt2g==
X-CSE-MsgGUID: gmMTHrB7SOW8nLXsVoytlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23172109"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="23172109"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:57:38 -0700
X-CSE-ConnectionGUID: aHxSCX98Rx6ZPW4m0nyv0g==
X-CSE-MsgGUID: 3WUx+NBpQeC7g4i+JtcbzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="67696964"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:57:35 -0700
Message-ID: <cb9c225c-b5c2-43ba-a6d5-843dc2790fd4@intel.com>
Date: Tue, 27 Aug 2024 10:57:30 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Add SDUC Support
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20240825074141.3171549-1-avri.altman@wdc.com>
 <3d7a9953-afed-4b45-a209-b797634e6bd8@intel.com>
 <DM6PR04MB65756CEE03C15524EF646C3BFC8B2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB65751048E9B35CFED478F180FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB65751048E9B35CFED478F180FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/24 10:45, Avri Altman wrote:
>>> On 25/08/24 10:41, Avri Altman wrote:
>>>> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.
>>>> Those cards support capacity larger than 2TB and up to including 128TB.
>>>> Thus, the address range of the card expands beyond the 32-bit
>>>> command argument. To that end, a new command - CMD22 is defined, to
>>>> carry the extra 6-bit upper part of the 38-bit block address that
>>>> enable access to 128TB memory space.
>>>>
>>>> SDUC capacity is agnostic to the interface mode: UHS-I and UHS-II –
>>>> Same as SDXC.
>>>>
>>>> The spec defines several extensions/modifications to the current
>>>> SDXC cards, which we address in patches 1 - 10.  Otherwise
>>>> requirements are out-of-scope of this change.  Specifically, CMDQ
>>>> (CMD44+CMD45), and Extension for Video Speed Class (CMD20).
>>>>
>>>> First publication of SDUC was in [1].  This series was developed and
>>>> tested separately from [1] and does not borrow from it.
>>>>
>>>> [1] https://lwn.net/Articles/982566/
>>>
>>> Perhaps add support for mmc_test
> Actually, I am not sure what should be added to mmc_test as far as SDUC indication:
> from dmesg we have:
> [ 4253.922220] mmc0: new ultra high speed SDR104 SDUC card at address d555
> [ 4253.922409] mmcblk0: mmc0:d555 SR04T 3.72 TiB
> 
> Additionally, we have the card size sysfs entry:
> # cat /sys/block/mmcblk0/size
> 7999258624
> 
> As well as the csd which implies its capacity:
> # cd /sys/class/mmc_host/mmc0/mmc0:* && cat csd
> 800e0032db79007732bf7f800a404001
> 
> What test did you had in mind?

Doesn't all the I/O need CMD22 first?

> 
> Thanks,
> Avri
> 
>>> , and it would be better if enabling
>>> SDUC was the last patch, so bisecting doesn't leave a kernel that half-supports
>> SDUC.
>> Done.
>>
>> Thanks,
>> Avri
>>
>>>
>>>>
>>>> ---
>>>> Changes in v4:
>>>>  - Squash patches 1 & 2 (Ulf)
>>>>  - Amend SD_OCR_2T to SD_OCR_CCS in mmc_sd_get_cid (Ulf)
>>>>  - Use card state instead of caps2 (Ricky & Ulf)
>>>>  - Switch patches 5 & 6 (Ulf)
>>>>
>>>> Changes in v3:
>>>>  - Some more kernel test robot fixes
>>>>  - Fix a typo in a commit log (Ricky WU)
>>>>  - Fix ACMD22 returned value
>>>>  - Add 'Tested-by' tag for the whole series (Ricky WU)
>>>>
>>>> Changes in v2:
>>>>  - Attend kernel test robot warnings
>>>>
>>>> ---
>>>>
>>>> Avri Altman (9):
>>>>   mmc: sd: SDUC Support Recognition
>>>>   mmc: sd: Add Extension memory addressing
>>>>   mmc: core: Add open-ended Ext memory addressing
>>>>   mmc: core: Add close-ended Ext memory addressing
>>>>   mmc: host: Always use manual-cmd23 in SDUC
>>>>   mmc: host: Add close-ended Ext memory addressing
>>>>   mmc: core: Allow mmc erase to carry large addresses
>>>>   mmc: core: Add Ext memory addressing for erase
>>>>   mmc: core: Adjust ACMD22 to SDUC
>>>>
>>>>  drivers/mmc/core/block.c  | 56 ++++++++++++++++++++++++++++------
>>>>  drivers/mmc/core/bus.c    |  4 ++-
>>>>  drivers/mmc/core/card.h   |  3 ++
>>>>  drivers/mmc/core/core.c   | 63 ++++++++++++++++++++++++++++---------
>>> --
>>>>  drivers/mmc/core/core.h   | 14 +++++++--
>>>>  drivers/mmc/core/queue.h  |  1 +
>>>>  drivers/mmc/core/sd.c     | 36 ++++++++++++++--------
>>>>  drivers/mmc/core/sd.h     |  2 +-
>>>>  drivers/mmc/core/sd_ops.c | 16 ++++++++++
>>>> drivers/mmc/core/sd_ops.h
>>>> |  1 +
>>>>  drivers/mmc/core/sdio.c   |  2 +-
>>>>  drivers/mmc/host/sdhci.c  | 40 +++++++++++++++++++++----
>>>> include/linux/mmc/card.h  |  2 +-  include/linux/mmc/core.h  |  1 +
>>>>  include/linux/mmc/sd.h    |  4 +++
>>>>  15 files changed, 195 insertions(+), 50 deletions(-)
>>>>
> 


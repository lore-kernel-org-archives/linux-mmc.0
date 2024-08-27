Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF41A00F7
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758259; cv=none; b=BW4PwJOaArV0+YCuxpam/X/zkywM/kPVJ3TgCqjpTQ8erovOEda6g51XkGY1geIlWcXrXxoMalcW1YsNq6aVBgSSQ8aqCUR3iBW+fnd5rfm9f4I8WCEmo3HX4RU6wSh7I/HUYxPJWRs+ehiXEb240vMnvHgt1MobOyQW+YImNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758259; c=relaxed/simple;
	bh=0mCdzwXsoSHL4gcfUZrUAxV51fYBpt8jbO43HiFo0YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQoSwQZ58fouu3QUwLiA4Lju18IDB215mTtONLXLC/cNw5OPgJvu35Hpk92YaRMucHW9uDLKUkeYM4OgSmXCKLlUV2RKJlodI11lhY9q3c8GMAcUMUHeBofV5NRFlxkbH3o4IthK0PT/eYeLJgTTkM0nnmF+1J6fo0USRzzRT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fs0em1UQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fs0em1UQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724758256; x=1756294256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0mCdzwXsoSHL4gcfUZrUAxV51fYBpt8jbO43HiFo0YM=;
  b=Fs0em1UQ1zhwG238EXZB3kBfmLbk5LlNUIsS5lhl6GYslEks1hKD9Rxf
   MaDqUrL6gqFAyuGsgbUgq7OZFdxfAoxnaxrrqM4h/Ip9F34Q4oeCs0ZGE
   4dtNHSHl1K9gmA8H5Id67QfvqF6DwTzZCS6qKlG7C4TX+8o/yX/kxWjzD
   52Kr4YIeEaiq/GCzjEeC872st0pxbQx0wPJyqx5Vc4c4iTc/fsMSXD6Xx
   VBDSMNBRK6HAms8umPbDEqF9KVIAMbrRjSmApsH2S8inpj9tLSJfUTqnw
   suT/kCQ74iKfEcF/UleNM/WHcNlExuVR8NK0OIU8gHBbmHKcVUGjIfV6S
   g==;
X-CSE-ConnectionGUID: DWOe0e7nSh+9w0alqlcsJg==
X-CSE-MsgGUID: ycLbNs4USYmqqohzUk2X8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27025382"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27025382"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:30:56 -0700
X-CSE-ConnectionGUID: zl+PGR+CQoi3+uwTKHj8NA==
X-CSE-MsgGUID: PgaRgJEzRaWCWtvAWFd7yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62802623"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:30:54 -0700
Message-ID: <e43f6f0a-19b9-4fc3-bd6a-80c12a053021@intel.com>
Date: Tue, 27 Aug 2024 14:30:48 +0300
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
 <cb9c225c-b5c2-43ba-a6d5-843dc2790fd4@intel.com>
 <DM6PR04MB657568FC857DA6877F2BA7FFFC942@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB65752FFC3CB355F2FC704C16FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB65752FFC3CB355F2FC704C16FC942@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/08/24 13:58, Avri Altman wrote:
>>> On 27/08/24 10:45, Avri Altman wrote:
>>>>>> On 25/08/24 10:41, Avri Altman wrote:
>>>>>>> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.
>>>>>>> Those cards support capacity larger than 2TB and up to including 128TB.
>>>>>>> Thus, the address range of the card expands beyond the 32-bit
>>>>>>> command argument. To that end, a new command - CMD22 is defined,
>>>>>>> to carry the extra 6-bit upper part of the 38-bit block address
>>>>>>> that enable access to 128TB memory space.
>>>>>>>
>>>>>>> SDUC capacity is agnostic to the interface mode: UHS-I and UHS-II
>>>>>>> – Same as SDXC.
>>>>>>>
>>>>>>> The spec defines several extensions/modifications to the current
>>>>>>> SDXC cards, which we address in patches 1 - 10.  Otherwise
>>>>>>> requirements are out-of-scope of this change.  Specifically, CMDQ
>>>>>>> (CMD44+CMD45), and Extension for Video Speed Class (CMD20).
>>>>>>>
>>>>>>> First publication of SDUC was in [1].  This series was developed
>>>>>>> and tested separately from [1] and does not borrow from it.
>>>>>>>
>>>>>>> [1] https://lwn.net/Articles/982566/
>>>>>>
>>>>>> Perhaps add support for mmc_test
>>>> Actually, I am not sure what should be added to mmc_test as far as
>>>> SDUC
>>> indication:
>>>> from dmesg we have:
>>>> [ 4253.922220] mmc0: new ultra high speed SDR104 SDUC card at
>>>> address
>>>> d555 [ 4253.922409] mmcblk0: mmc0:d555 SR04T 3.72 TiB
>>>>
>>>> Additionally, we have the card size sysfs entry:
>>>> # cat /sys/block/mmcblk0/size
>>>> 7999258624
>>>>
>>>> As well as the csd which implies its capacity:
>>>> # cd /sys/class/mmc_host/mmc0/mmc0:* && cat csd
>>>> 800e0032db79007732bf7f800a404001
>>>>
>>>> What test did you had in mind?
>>>
>>> Doesn't all the I/O need CMD22 first?
> So I tried to add it, and it looks like I'll be needing 2 - 3 patches to enable mmc_test for sduc.
> How about disable it for now, planning to ameliorate it in the very near future?

Ok by me.



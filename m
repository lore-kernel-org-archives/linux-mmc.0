Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055883CC1
	for <linux-mmc@vger.kernel.org>; Thu,  5 Sep 2024 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521134; cv=none; b=ElakQv5FMmjwSD31NCZlg6DLPCnPIrhB35szlFr3hsRMI3fxIa7DK8Hw9jbgQ/EG3PjUAqq7zHQr4uuMKnLVeDjHctpcn9EbsQG5JnixzKX+1TJwPWpvJMYtkNmWU7FlN9n/UL91lpDUwdu9PLTRY5KO1EIcEArK+4natnJnTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521134; c=relaxed/simple;
	bh=TKsgcNZvPQjRzQTH2qiZfJsIVrsFOQny9c/05mI5koI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/kSMBb4uPwzhNP0f8dx++FPwANgL2BCia1F1glcQQg0VOnKkSx+Z/C5LhC2C65yQgLls0bm1jHjJDEntkBFeRT0ydt/6Zdm5VuVq4oQo8VW/qw39qEX3HrjpLQm589oi8uu/wu/Qg8xX49SG1DH9wu6GHNtjmPphDoQCXnKs+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kc/V+mlM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kc/V+mlM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725521132; x=1757057132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TKsgcNZvPQjRzQTH2qiZfJsIVrsFOQny9c/05mI5koI=;
  b=Kc/V+mlMJH+wUL1gjxzJWujT1bpv2gOS23WEaQf6c7fib47AF46DX+vU
   Eq7A4hFumPMUdhnyAtjIyw3ZsqDJCouj60kxs+17Cph149mHOv4ENicD5
   yiPzoQDGmz3SIhdKqJP1uzVlqM+bpvjZoTXjmkdm88yoFimd8tdr50MbK
   ACmdPsveMqWzdEfl8vABP2zDN6wOXdyrIGTeffCiieiRwNF/X/BCp9v48
   VlAwRlLwcJIEhiBGLqfndBHpgqNIZBUvWUg0KspauKR7tSvOsJVhsIbMu
   GsbVAX1yx97FnWld9Kg0jxr032/A9LmmrON32nmoG+90J4Z3VazjK2O80
   A==;
X-CSE-ConnectionGUID: aAX746oXQnSYLHCyE6Addg==
X-CSE-MsgGUID: 1xN82/7TRiuOU1z1MAvA6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34789598"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34789598"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:25:32 -0700
X-CSE-ConnectionGUID: YKWBHEH9QYmswUw8gh8zhQ==
X-CSE-MsgGUID: L6Rm8BHiT8uB0jdqutMrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70335458"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:25:29 -0700
Message-ID: <57c3ffb7-b5f7-41f7-b8e0-66d149226d01@intel.com>
Date: Thu, 5 Sep 2024 10:25:24 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <Avri.Altman@wdc.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
 <20240904145256.3670679-4-avri.altman@wdc.com>
 <1cfe2dc9-5525-43df-9d79-98472df1d3d5@arm.com>
 <DM6PR04MB65750F714B37FC40466063C5FC9D2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB65750F714B37FC40466063C5FC9D2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/09/24 09:12, Avri Altman wrote:
> Thanks for having a look.
> 
>>>
>>> +     if (mrq->cmd && mrq->cmd->has_ext_addr)
>>> +             mmc_send_ext_addr(host, mrq->cmd->ext_addr);
>>
>> We should check that this was actually successful, right?
> Actually no, as errors in CMD22 are being carried in the subsequent command.
> 
>>
>>> +
>>>       init_completion(&mrq->cmd_completion);
>>>
>>>       mmc_retune_hold(host);
>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h index
>>> f0ac2e469b32..41c21c216584 100644
>>> --- a/include/linux/mmc/core.h
>>> +++ b/include/linux/mmc/core.h
>>> @@ -76,6 +76,11 @@ struct mmc_command {
>>>   */
>>>  #define mmc_cmd_type(cmd)    ((cmd)->flags & MMC_CMD_MASK)
>>>
>>> +     /* for SDUC */
>>> +     u8 has_ext_addr;
>>> +     u8 ext_addr;
>>> +     u16 reserved;
>>
>> Is there a reason for has_ext_addr being u8?
> Theoretically a single bit suffices, and since ext_addr uses only 6 bits, I had that bit to spare in ext_addr,

It could be a bool instead of u8 though.

> but I see no reason to be cheap here - see the reserved u16.
> 
>> What's the reserved for?
> Not to break the packed 4bytes alignment of mmc_command.

Although it isn't "__packed" so compiler should take care of
alignment.

> 
> Thanks,
> Avri
>>
>>> +
>>>       unsigned int            retries;        /* max number of retries */
>>>       int                     error;          /* command error */
>>>
> 


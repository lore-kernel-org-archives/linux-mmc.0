Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F8349B15
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484813; cv=none; b=sePfChl1hT/FcD3kaexIYbXPwlvy3RuQIKxB4Qtcp3Na1/YgB0AmJ1kOFwXiiWR8oJSUkS0xIQlLAV6T1Euz8LcmZ3T3Ffp67KwpKqKjr2efPZZj1zb2vRy70vDUOVN7BvejWLUH3+sSu4SSlefwnoyjArReD9s0vJAcXuq+UhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484813; c=relaxed/simple;
	bh=B64kXSw1VRkVbpc37YjjVMbTpZI0DBB3ajJGXrHMlLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/ZQluOx1XdSa6TntTaNT9ma7FRhZ3qBVDisQveXb/9kCGvgihHqHLvUZfq9uhydiO8tKd2mSlcFR02aPP7BBCNFXqMCl/nUCf44HxURVxwGUsZdqrrjsSzmkrzYIZD1fXt+YsAjTnuPO3gvCgNTK650AoD7VFINzEg2qQLGQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IxOXQ0UW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IxOXQ0UW"
Received: from [100.64.233.91] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7983C20B716C;
	Wed, 29 Apr 2026 10:46:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7983C20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777484811;
	bh=B64kXSw1VRkVbpc37YjjVMbTpZI0DBB3ajJGXrHMlLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IxOXQ0UWyFstL5EzgyE0UuiAtNV+swseROLC4yGHkttAxbg5MH50+AlPYgfVkgjgA
	 kmTjOiNuumGrCdz+1ize65eWTuZBkaA5HWNqR8DHQMG1zLD7Hhe3MDZyXIfgJ5T0qq
	 nvrPKrykYfqYiFHWs6xnzgKgAOKN9dEuKhbXrnII=
Message-ID: <97e4b94c-b91b-468c-9021-2a3784c7b901@linux.microsoft.com>
Date: Wed, 29 Apr 2026 10:46:50 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: host: sdhci-iproc: implement the .hw_reset
 callback
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Scott Branden <scott.branden@broadcom.com>
Cc: rjui@broadcom.com, sbranden@broadcom.com,
 linux-arm-kernel@lists.infradead.org, tgopinath@linux.microsoft.com,
 adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
 kernel-list@raspberrypi.com
References: <20260327222150.2108111-1-meaganlloyd@linux.microsoft.com>
 <3305684d-8517-47dd-8852-2e34d40fc712@linux.microsoft.com>
 <702c52e4-b0b3-4e1e-a40d-29e136e46d7d@broadcom.com>
 <448010ef-278c-4711-a244-447a2b1a22c1@linux.microsoft.com>
 <CA+Jzhd+_CKn1X0YDsoh9-OFeCG9sc2Q0OFfphkRaXpEA647xyQ@mail.gmail.com>
 <58294850-4ed4-4fb4-8f46-186063b76a2f@linux.microsoft.com>
 <e1ba9b6d-0ad8-4336-a5f9-ad4777ef54e0@broadcom.com>
Content-Language: en-US
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
In-Reply-To: <e1ba9b6d-0ad8-4336-a5f9-ad4777ef54e0@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/15/2026 1:44 PM, Florian Fainelli wrote:
> On 4/15/26 13:43, Meagan Lloyd wrote:
>>
>> On 4/15/2026 1:23 PM, Scott Branden wrote:
>>> Hi Meagan,
>>>
>>> On Wed, Apr 15, 2026 at 11:08 AM Meagan Lloyd <
>>> meaganlloyd@linux.microsoft.com> wrote:
>>>
>>>> On 4/13/2026 10:43 AM, Florian Fainelli wrote:
>>>>> On 4/13/26 10:38, Meagan Lloyd wrote:
>>>>>> On 3/27/2026 3:21 PM, Meagan Lloyd wrote:
>>>>>>> Implement the .hw_reset callback so that the eMMC can be reset as
>>>>>>> needed
>>>>>>> given cap-mmc-hw-reset is set in the devicetree and the
>>>>>>> functionality is
>>>>>>> enabled on the eMMC.
>>>>>>>
>>>>>>> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
>>>>>>> ---
>>>>>>>
>>>>>>> SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been
>>>>>>> repurposed
>>>>>>> on my Broadcomm processor to be eMMC hardware reset
>>>>>>> (SDIO*_eMMCSDXC_CTRL[12], HRESET).
>>>>>>>
>>>>>>> Can you confirm this repurposed bit is consistent across the
>>>>>>> Broadcomm
>>>>>>> iProc processors and thus the .hw_reset callback can be uniformly
>>>>>>> applied in this driver?
>>>>>> Hi Ray & Scott,
>>>>>>
>>>>>> I hope you're doing well. This bit looks to have been repurposed
>>>>>> from
>>>>>> the SD Host Controller Standard's VDD2 Power Control to being
>>>>>> used for
>>>>>> toggling the hardware reset signal to eMMCs. Can you verify that it
>>>>>> applies across the iProc processors so that I may finalize this
>>>>>> patch?
>>>>> Which iProc process are you using? If you are not sure this applies
>>>>> broadly, can you at least make it specific to the SoC you are using?
>>>> Yes, if it comes to that I can. I think it's overkill to roll a new
>>>> compat string/associated structures over this small change, hence
>>>> checking with Broadcomm iProc maintainers on this thread.
>>>>
>>> Which iProc processor are you using?  You will have to check with
>>> RaspberryPI as I think they use this driver as well.
>>> If that family also supports it then you probably don't need a
>>> compatibility string.
>>
>> The processor I am using is the BCM58732. Can you help direct me to
>> someone who could comment from the RaspberryPi side?
>>
>
> I will take care of that. 
Thanks, Florian. Let me know what you find out :)

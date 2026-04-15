Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B3E3195E4
	for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276490; cv=none; b=GxVzZ1CZU/K0gsq32fBuH8eviuemHEsxBaD98fTvC4k0mrrXu1g0bZxdVjj1EAy8cef+sEornihKiw/KKUci426nR9MD0N2OOuZX9sEDN7ejopnF7rByn0q1xiT46RFsII4G8xCJWLMTwEwLH9XsBsPkOI4OfKu1WMsHfcjsWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276490; c=relaxed/simple;
	bh=TCV4VIJmWx9k667IW/rOciXHIeyHQuU5WisubSOrurc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dscK9XSHdgaaQG2GvhmI7U6doZAHeciIcYOayHL++QXLqAsdgqd95Geqp006uccjzLLEgK/yo/D1j9kjB9JyZbxHK5x6IMubUaGe82T9heSuqen3w1ARkPO/0zFG/0nsoNH0oZcUGD3qncC+BCBm3A2z18HK4/E8QwJZNc/kXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qxkXAeh6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qxkXAeh6"
Received: from [10.17.149.54] (unknown [131.107.1.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id A347B20B7128;
	Wed, 15 Apr 2026 11:08:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A347B20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776276481;
	bh=TCV4VIJmWx9k667IW/rOciXHIeyHQuU5WisubSOrurc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qxkXAeh6A57FRAaZ6ImQ5cMOifokZ9e36rM6iGTU6eCB5uKHnYNosUIR4ZGv/erTZ
	 p72khgsnBaQnzG9kW1IItvlE5219X6GHUaq5gtA7T4ilxEcvk5/HJdBqILP5WpcLCK
	 te89vK2aF1HQKdncjhPLcMK1ZqESt7hS29WWfGkA=
Message-ID: <448010ef-278c-4711-a244-447a2b1a22c1@linux.microsoft.com>
Date: Wed, 15 Apr 2026 11:07:59 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: host: sdhci-iproc: implement the .hw_reset
 callback
To: Florian Fainelli <florian.fainelli@broadcom.com>, rjui@broadcom.com
Cc: sbranden@broadcom.com, linux-arm-kernel@lists.infradead.org,
 tgopinath@linux.microsoft.com, adrian.hunter@intel.com,
 linux-mmc@vger.kernel.org
References: <20260327222150.2108111-1-meaganlloyd@linux.microsoft.com>
 <3305684d-8517-47dd-8852-2e34d40fc712@linux.microsoft.com>
 <702c52e4-b0b3-4e1e-a40d-29e136e46d7d@broadcom.com>
Content-Language: en-US
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
In-Reply-To: <702c52e4-b0b3-4e1e-a40d-29e136e46d7d@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/13/2026 10:43 AM, Florian Fainelli wrote:
> On 4/13/26 10:38, Meagan Lloyd wrote:
>>
>> On 3/27/2026 3:21 PM, Meagan Lloyd wrote:
>>> Implement the .hw_reset callback so that the eMMC can be reset as
>>> needed
>>> given cap-mmc-hw-reset is set in the devicetree and the
>>> functionality is
>>> enabled on the eMMC.
>>>
>>> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
>>> ---
>>>
>>> SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been
>>> repurposed
>>> on my Broadcomm processor to be eMMC hardware reset
>>> (SDIO*_eMMCSDXC_CTRL[12], HRESET).
>>>
>>> Can you confirm this repurposed bit is consistent across the Broadcomm
>>> iProc processors and thus the .hw_reset callback can be uniformly
>>> applied in this driver?
>>
>> Hi Ray & Scott,
>>
>> I hope you're doing well. This bit looks to have been repurposed from
>> the SD Host Controller Standard's VDD2 Power Control to being used for
>> toggling the hardware reset signal to eMMCs. Can you verify that it
>> applies across the iProc processors so that I may finalize this patch?
>
> Which iProc process are you using? If you are not sure this applies
> broadly, can you at least make it specific to the SoC you are using? 
Yes, if it comes to that I can. I think it's overkill to roll a new
compat string/associated structures over this small change, hence
checking with Broadcomm iProc maintainers on this thread.

Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9E40DFDC
	for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285831; cv=none; b=sxoL2eWE4qTtBIrI7YvNlCVheJ+drRJh3nIULknRZkTXehJnh5TljpvekzoQ7SeWPV14CeK65Btrq5KBYy9DRSZtWJM4UfohnJuAUJvNzPx16pspJeC0ln5iYuHMQ2xt2nTpRzVVg8taJ9BkArfvpiztV9PVF4WyxCtBUILZV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285831; c=relaxed/simple;
	bh=ecqP0UUqtJMwDPZCYVK4UWxH6P0VUpcZabGJXtC6KP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+Eny5Nmv3jOeSzmJnp5CksLt9opOrLR7iqCoChSKzUG2iLpqSMx3sl3h0+6dsrxpVeVI17pPNDjqD5uD0uxZQx/+NobG5bnFGOa9vejjNOsZqEpGRisZHF1DetydgpKwTPuxh6p/L1dcZYsW/amaw6w6RQRFyBfqp0otsurBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aB9LsrWe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aB9LsrWe"
Received: from [10.17.149.54] (unknown [131.107.1.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E13420B7128;
	Wed, 15 Apr 2026 13:43:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E13420B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776285829;
	bh=jVDNzdmCcUlsrcDPwenbU6oXuaJkJzPJ3CKGZdPSExw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aB9LsrWeWonZLUidOWbtG+WGecMNAQ0eEYn9NBQlFTgSPnPJnP9+gXG098if1T0Ll
	 frn/9fedhMNADi5Q1gSjQ9lzDqwn2CDBGr7Th+5iEJ+79wx5H5/eovbgmm+hckQVKq
	 kp2rqn8yySVuHYODVKqM3J8fz3AR/KHhBuXdQZVE=
Message-ID: <58294850-4ed4-4fb4-8f46-186063b76a2f@linux.microsoft.com>
Date: Wed, 15 Apr 2026 13:43:46 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: host: sdhci-iproc: implement the .hw_reset
 callback
To: Scott Branden <scott.branden@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, rjui@broadcom.com,
 sbranden@broadcom.com, linux-arm-kernel@lists.infradead.org,
 tgopinath@linux.microsoft.com, adrian.hunter@intel.com,
 linux-mmc@vger.kernel.org, kernel-list@raspberrypi.com
References: <20260327222150.2108111-1-meaganlloyd@linux.microsoft.com>
 <3305684d-8517-47dd-8852-2e34d40fc712@linux.microsoft.com>
 <702c52e4-b0b3-4e1e-a40d-29e136e46d7d@broadcom.com>
 <448010ef-278c-4711-a244-447a2b1a22c1@linux.microsoft.com>
 <CA+Jzhd+_CKn1X0YDsoh9-OFeCG9sc2Q0OFfphkRaXpEA647xyQ@mail.gmail.com>
Content-Language: en-US
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
In-Reply-To: <CA+Jzhd+_CKn1X0YDsoh9-OFeCG9sc2Q0OFfphkRaXpEA647xyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/15/2026 1:23 PM, Scott Branden wrote:
> Hi Meagan,
>
> On Wed, Apr 15, 2026 at 11:08 AM Meagan Lloyd <
> meaganlloyd@linux.microsoft.com> wrote:
>
>> On 4/13/2026 10:43 AM, Florian Fainelli wrote:
>>> On 4/13/26 10:38, Meagan Lloyd wrote:
>>>> On 3/27/2026 3:21 PM, Meagan Lloyd wrote:
>>>>> Implement the .hw_reset callback so that the eMMC can be reset as
>>>>> needed
>>>>> given cap-mmc-hw-reset is set in the devicetree and the
>>>>> functionality is
>>>>> enabled on the eMMC.
>>>>>
>>>>> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
>>>>> ---
>>>>>
>>>>> SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been
>>>>> repurposed
>>>>> on my Broadcomm processor to be eMMC hardware reset
>>>>> (SDIO*_eMMCSDXC_CTRL[12], HRESET).
>>>>>
>>>>> Can you confirm this repurposed bit is consistent across the Broadcomm
>>>>> iProc processors and thus the .hw_reset callback can be uniformly
>>>>> applied in this driver?
>>>> Hi Ray & Scott,
>>>>
>>>> I hope you're doing well. This bit looks to have been repurposed from
>>>> the SD Host Controller Standard's VDD2 Power Control to being used for
>>>> toggling the hardware reset signal to eMMCs. Can you verify that it
>>>> applies across the iProc processors so that I may finalize this patch?
>>> Which iProc process are you using? If you are not sure this applies
>>> broadly, can you at least make it specific to the SoC you are using?
>> Yes, if it comes to that I can. I think it's overkill to roll a new
>> compat string/associated structures over this small change, hence
>> checking with Broadcomm iProc maintainers on this thread.
>>
> Which iProc processor are you using?  You will have to check with
> RaspberryPI as I think they use this driver as well.
> If that family also supports it then you probably don't need a
> compatibility string.

The processor I am using is the BCM58732. Can you help direct me to
someone who could comment from the RaspberryPi side?


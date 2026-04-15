Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684323183C
	for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285885; cv=none; b=jCaQ9H3TugUp8sRPHlQrTznTg3+4RAmiuGs3LxEhPkR7yF37tUHxF8uF/gbC4I/ehq4DCYDp4dHAmaApDxzB6Sv07Y8Awf1imEqdCth+fEZESQ47JE+lu7BLEm+71zJBw/rEmDG3RuqlNq42gKRL1MY3HorLuSfRU5pNJvjMOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285885; c=relaxed/simple;
	bh=AUZPYoG75ewMtD5dbtoU+nBT/QSFB4uT5695BiVqEk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lp8xGH7/DnO0WEV2+PxBu/td/lXY4bmlEaRPXur2Qx8rp5UUghPABjukt/K3ApUdE+KD8pTmf+MEtj31GOpO/HRfPoLy+6rFNWGKd/NfMqeVY4AH6GM0ow5bUXodzvbz/m8V6t5XDS1xQ7isnZzHet/3cdrUuPYy7rHyc3jXdcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WG6yEHIE; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WG6yEHIE"
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-68a2f93b42eso2604294eaf.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 13:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776285883; x=1776890683;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCY2zTuKCD2oZKU0TN81PGUoMFJNm+Dpvd0IWUv+sgE=;
        b=mVLlWxIHm5dN+oxjCd8W5elz15OEOXPY9v62StrHGr8yabTGodPgXflzw0HDckKgdQ
         jGQXA7FW6kAi17t+OZBVoRXzYT0sqsdMY+LyMWYoCQT7r2ONIFf+ncqL6A2FstSStgFB
         giH6jWuAPEcrNJ7Aayvsg0nI98y5XbDXuGiAZs0Od2h998MuetxH/5EFZVrVtdP242xu
         BDYoTM4wGugdbOtnXUwm7XxZhDCeDku64oRUQJqV34vHfmhh8CMFwoNdoOL6jR5HjLsk
         5c+/LU0Dnemwp3kWP5w3CuIai6kLj23rOhxe7HunBoo9AVbkHh5QYjT2Jku8DSCHZXpo
         XjxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9INdkvhsf3f67DkcQd6tMJpcd8nrItrqCYYDvxBZBaSbaMJHJmJ0oOLgPH1g1o0q0NOE189UdPHhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQoE2m51mQ51aQOoob54GLo/XQmnJZh2kA6pizjFg5ayBOIy0
	31TkNMJClpfJ7cPxMwr6Zh/fULIE9AtEp/CDfIwDCfd3rF3aez6mqGilpIrYR/R5wtDc+GydLka
	mSjGyni6uRhSkojUs+rcx/F1w1rx6dDHU4X9TnFopR1B8V/J2FDPAcNqJhbZ8EsOIrsKAoyzUQ8
	eQt7PhsTmQfAKy4yyIvtA2Z0d8tlwt1UyjfcSAIYZe2vIfCBVwRHt1NOc8wdCsQIHBOPMlIM8PS
	ucsNqDRtwyNsY3+Em5V
X-Gm-Gg: AeBDietvoOCIBrcjkMRCiVP/s7u/weWfOPoi+iEkIk3KFyvXq3+xqY/967eOMdzH4ey
	tiecvHsPU+cSUg9IzkqGBDr2HCHhZ6XGEeJOTNA0fA12Jnm4k27RFjWy3AoNUY3gEoSI9S72RnH
	D/EqDiq+nmeBiReghukmaxEZExvpQ+99fo/BbX9g/pSxWC9FA0ofVCipDpTno+HSENAf8R9Rcre
	kbrOst4MlTZARputh2Eyv8SfUS0mLC9wGOGC3vAs/SSr5em6gEYklmk+vxN9oPri5MyACwrBd/+
	KCOcnL10129FOlDISokBcxxrU6dGWfeUZizOQ5gdbCiK1K3Bnhcyud0iZxyFuD5gLZi4bJB0k27
	4b6Xa/iuKT8w89+D2qHGUswZFV8QJrD0LetlwtMrtQDcO3QwknR7KNjTlmlzgCV5C/HTjDOSPL9
	10r/WbhTyP1KmcX3TIBzHfDb4cbUOXY5IEVCsdCtPqs9Z8B4C0ExQtUQF7DT/N6jKB
X-Received: by 2002:a05:6820:620:b0:683:1323:e187 with SMTP id 006d021491bc7-68be653003dmr11958489eaf.27.1776285882576;
        Wed, 15 Apr 2026 13:44:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6932a7959ebsm189683eaf.1.2026.04.15.13.44.42
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 13:44:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1275c6fc58aso10642808c88.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2026 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776285881; x=1776890681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MCY2zTuKCD2oZKU0TN81PGUoMFJNm+Dpvd0IWUv+sgE=;
        b=WG6yEHIEqVhDt9shgUU8t+dJ7Wn+qx60QZ/gPwLLs19+YxNutx2jusdC/Nllo7bLck
         +mfjKMhyfs9DGfTzJAMEcTyyWpaK0IwRrCwHaFE7jI+9mm1zQxGNRxqfBuuudfLIpBAE
         XIPBBbLKOjBFNJ1QYAPAfJkZxQYb1qoEy78wo=
X-Forwarded-Encrypted: i=1; AFNElJ9xuur88WfF926D9xFSuXu/XrXxVd2sFUqcXPfU2u8vkaqNW/2VRttZyae901P+VbSrxZiY9DXuTkk=@vger.kernel.org
X-Received: by 2002:a05:7022:69a2:b0:12c:8b9:7208 with SMTP id a92af1059eb24-12c34eeb95cmr13372188c88.26.1776285881047;
        Wed, 15 Apr 2026 13:44:41 -0700 (PDT)
X-Received: by 2002:a05:7022:69a2:b0:12c:8b9:7208 with SMTP id a92af1059eb24-12c34eeb95cmr13372166c88.26.1776285880292;
        Wed, 15 Apr 2026 13:44:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e61d0bdsm3503412c88.2.2026.04.15.13.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 13:44:39 -0700 (PDT)
Message-ID: <e1ba9b6d-0ad8-4336-a5f9-ad4777ef54e0@broadcom.com>
Date: Wed, 15 Apr 2026 13:44:38 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: host: sdhci-iproc: implement the .hw_reset
 callback
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
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
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <58294850-4ed4-4fb4-8f46-186063b76a2f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 4/15/26 13:43, Meagan Lloyd wrote:
> 
> On 4/15/2026 1:23 PM, Scott Branden wrote:
>> Hi Meagan,
>>
>> On Wed, Apr 15, 2026 at 11:08 AM Meagan Lloyd <
>> meaganlloyd@linux.microsoft.com> wrote:
>>
>>> On 4/13/2026 10:43 AM, Florian Fainelli wrote:
>>>> On 4/13/26 10:38, Meagan Lloyd wrote:
>>>>> On 3/27/2026 3:21 PM, Meagan Lloyd wrote:
>>>>>> Implement the .hw_reset callback so that the eMMC can be reset as
>>>>>> needed
>>>>>> given cap-mmc-hw-reset is set in the devicetree and the
>>>>>> functionality is
>>>>>> enabled on the eMMC.
>>>>>>
>>>>>> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
>>>>>> ---
>>>>>>
>>>>>> SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been
>>>>>> repurposed
>>>>>> on my Broadcomm processor to be eMMC hardware reset
>>>>>> (SDIO*_eMMCSDXC_CTRL[12], HRESET).
>>>>>>
>>>>>> Can you confirm this repurposed bit is consistent across the Broadcomm
>>>>>> iProc processors and thus the .hw_reset callback can be uniformly
>>>>>> applied in this driver?
>>>>> Hi Ray & Scott,
>>>>>
>>>>> I hope you're doing well. This bit looks to have been repurposed from
>>>>> the SD Host Controller Standard's VDD2 Power Control to being used for
>>>>> toggling the hardware reset signal to eMMCs. Can you verify that it
>>>>> applies across the iProc processors so that I may finalize this patch?
>>>> Which iProc process are you using? If you are not sure this applies
>>>> broadly, can you at least make it specific to the SoC you are using?
>>> Yes, if it comes to that I can. I think it's overkill to roll a new
>>> compat string/associated structures over this small change, hence
>>> checking with Broadcomm iProc maintainers on this thread.
>>>
>> Which iProc processor are you using?  You will have to check with
>> RaspberryPI as I think they use this driver as well.
>> If that family also supports it then you probably don't need a
>> compatibility string.
> 
> The processor I am using is the BCM58732. Can you help direct me to
> someone who could comment from the RaspberryPi side?
> 

I will take care of that.
-- 
Florian

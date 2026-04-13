Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E55377561
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102200; cv=none; b=Wwax0fuKpCAouSIp2kZbL3p2mYmgUT6zDBqNl+4OUN+K1C02uCIkPNybGmTMu4IKqH6WO+A5MT9KdY+NZCTae5PMUnRF9VV8psCCtMQyylz3e0p+KQucPd/0nNTLC1bZ3QzchujibL3kCDgWqfsP7JE94ZqXnFvLrUsa3uwdcbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102200; c=relaxed/simple;
	bh=0uFvNN2P/bHE0pioTQs2SEnHDt9ZSAxmvrsYgZP0KBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQn1m4Jyk/DdaPLS6o7zHV4y/ob/8qG6tJusOmstEBp+e09abWAsWdPLZl+qFCLp27JRRTZeMn0/WbO2EjqCl7Mvtwp7LJMKZndDeMrIIka4TNzCLU1tCQpCjxOT++qlkfPyahRuA+g4O4LIb0d8t2LVtarmcJEMEUYlgTQsa2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K7uoPDHa; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K7uoPDHa"
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7d7e9b97a73so2433852a34.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 10:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102198; x=1776706998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqcqUmMytTlyST79HXSur+JVhERdyL6edRqn6BR2Hog=;
        b=I6+YWgdTglgNtiohlO/0VlorjzT4zGYU1/hQXcQVRYOfLvJE8n9P7JpwIQucyBzrxO
         NaDyIec/Xtc6tTF713btD8mv4thOu6UE/WRbVQzmzdNpwr7TfgMJl4FYBLJchWUuTIPk
         c4RkHg04cr/e+SC2CbqkC85oXX8hLLNGqgxOAnnjRb0KhFI7trg6Gb3W4ynH/k2b+P3c
         /H2mbTjKQdq6BZjPeaS2HmWNGnb8GAcdTRV/gOEdfAP7l0FrZV9ulyNAsWjBLG6PQCnz
         57AsJXbXU7UdE4UHlUTA0lBLrvnCeahSWBCIXWbn4Z+sASZjXrQNd331J1fZwuf5EHa3
         hR7g==
X-Forwarded-Encrypted: i=1; AFNElJ+DhGIEnGu1KF2FhLcAwdKhbjJ+SVODDxk0ed3EHeP986xotPrtHokmnb/BO+/Y99njhk9mA3VsZ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzi5aNtpwKQh7oJ7lo3t1Ftsr54uTr1drNCTL1ruZFkikOSGY
	jh0qFspo42BOEwJuyepHp59S1A7PF6kH4kCzMMdC4UcTOJT6KAUQmc/3eUfjctZGncNCHr8V53d
	G63bYYgpBmuSacmCrn87M3rVZ3Rz3PA6U9QwQxY3AVIW8tz51JbGZLwrKxqHPv1+vR6MWzfJ/or
	kT6JR8Nv6ks9m1kU1NKp7uaVryv8eehToandVBM7R9nJPmK3CNkKE/sSUS7wWNj7jjw290ZAwTy
	6OQbDbeEikM3QrYj/2J
X-Gm-Gg: AeBDievz1VCz1ay9oFWwi4DWo5F8ZA5CyuQMxmgWw7feowUY1m7gsS+ewfNIAJ/pOys
	w2zC05I/Oeuq9urD0Ejfxniqnq1T1d3iduptmBx9gfP9M7gpJmf7h7BKjUWDjLYK5oWruOmg/+W
	TuyyVmJBBiuAFdF9nr95ksekOs5tui8BTOC0/+bDzPZou9KyrBj+nAdx2E3/yXpXD8kGsZVOSt2
	bOh024Bf0Lcwjs/D/xul2fdQU3aU+7zZ1bQ+O40FFukUpEaa7DBKJOVYjVVnDpoXCs5tpVDbLLO
	SXfKwf0SdiZoyUZcQo4+Aw8dkekmFNmmc9kvbapf3BbV/17JQuX5v7WlXJD8S+qsOJ8q3BIgGx+
	20JwQsLb3AhyOyIJ18f6jLHqtVmDpvSqOzO4YGTFzARNnIQCppCi4pOH13EisxPSYbkrVejxmxP
	tiwKkx73Yn4z0XufC3fSTLrnDkk0LqNP8MggAilTIr+bQhK9ZO+DX+6IorH3rFYA==
X-Received: by 2002:a4a:ee06:0:b0:67f:31e3:81a with SMTP id 006d021491bc7-68bf60f64dcmr6207561eaf.2.1776102198184;
        Mon, 13 Apr 2026 10:43:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-68bcabcd6f3sm770661eaf.20.2026.04.13.10.43.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 10:43:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdd327d970so3042587eec.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776102197; x=1776706997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uqcqUmMytTlyST79HXSur+JVhERdyL6edRqn6BR2Hog=;
        b=K7uoPDHaaeBUFFWY9myIipy/Z4+hVMQnw6avW+AAA6sNIjFnoyEquXW0sDgNDo3jST
         clNJADRjdSVEBucD5LA0pWQwpc/+9PETZnc6S7/8Anlu9t+SC99TVttYvf1fkOkLLHc4
         aJCx4/14AaSeDwrBbi55mx0sRk14GN7bCPYU0=
X-Forwarded-Encrypted: i=1; AFNElJ9ZbN9QMklbD70mgM2EXVOHyBdBqQoor6EDgDCAl8d7bEDEnPHP1axsOLRIOOeRKPn8xa8hC3yhTTI=@vger.kernel.org
X-Received: by 2002:a05:7022:ec2:b0:12c:1288:ce63 with SMTP id a92af1059eb24-12c28c2953fmr7790108c88.13.1776102196639;
        Mon, 13 Apr 2026 10:43:16 -0700 (PDT)
X-Received: by 2002:a05:7022:ec2:b0:12c:1288:ce63 with SMTP id a92af1059eb24-12c28c2953fmr7790070c88.13.1776102195919;
        Mon, 13 Apr 2026 10:43:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa586bsm20432752eec.11.2026.04.13.10.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 10:43:14 -0700 (PDT)
Message-ID: <702c52e4-b0b3-4e1e-a40d-29e136e46d7d@broadcom.com>
Date: Mon, 13 Apr 2026 10:43:13 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mmc: host: sdhci-iproc: implement the .hw_reset
 callback
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>, rjui@broadcom.com
Cc: sbranden@broadcom.com, linux-arm-kernel@lists.infradead.org,
 tgopinath@linux.microsoft.com, adrian.hunter@intel.com,
 linux-mmc@vger.kernel.org
References: <20260327222150.2108111-1-meaganlloyd@linux.microsoft.com>
 <3305684d-8517-47dd-8852-2e34d40fc712@linux.microsoft.com>
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
In-Reply-To: <3305684d-8517-47dd-8852-2e34d40fc712@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 4/13/26 10:38, Meagan Lloyd wrote:
> 
> On 3/27/2026 3:21 PM, Meagan Lloyd wrote:
>> Implement the .hw_reset callback so that the eMMC can be reset as needed
>> given cap-mmc-hw-reset is set in the devicetree and the functionality is
>> enabled on the eMMC.
>>
>> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
>> ---
>>
>> SDHCI_POWER_CONTROL[4] (SD Host Controller Standard) has been repurposed
>> on my Broadcomm processor to be eMMC hardware reset
>> (SDIO*_eMMCSDXC_CTRL[12], HRESET).
>>
>> Can you confirm this repurposed bit is consistent across the Broadcomm
>> iProc processors and thus the .hw_reset callback can be uniformly
>> applied in this driver?
> 
> Hi Ray & Scott,
> 
> I hope you're doing well. This bit looks to have been repurposed from
> the SD Host Controller Standard's VDD2 Power Control to being used for
> toggling the hardware reset signal to eMMCs. Can you verify that it
> applies across the iProc processors so that I may finalize this patch?

Which iProc process are you using? If you are not sure this applies 
broadly, can you at least make it specific to the SoC you are using?
-- 
Florian


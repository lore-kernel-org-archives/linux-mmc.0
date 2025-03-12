Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3C24EF90
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801893; cv=none; b=orwN4tJW9g2XrLteS1A6Z+zHVcMCRQLNSe+aswu+CQfyQMyzIKWvsOgW2dUPwl/dlKjIFjUXv8FRx6qXDFTM24ZTOevhM6sRL32KVZtGiHki+5b+lsDinhagrC8pOe4qhKN27AEgheEel9E1SpzTZ6ZR75U26+O3oU/mYo53EBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801893; c=relaxed/simple;
	bh=/xRe3+zdN+gRFi+1v630ZRJ/P9iKJCBzIyjIxvI6h20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtavwJPKvYzjMa23BFBUP38Wpyu61H6YtNTFFNrIDFuKPb93RrH3u/NrcSXC+ZB1XlJCnAoXFTP/jmBkbsC/KNnBHQF5hvQgGe3APBq4qStvVzIRp6Exylzy449aOyJESWzcKcpvhmUg5rpNzAfd4B4v4EJ7a18B6Q/Xl/gvh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cPjS+/BE; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cPjS+/BE"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-601a46ee19fso33684eaf.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741801890; x=1742406690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zcwbwn2lH/wq2GnjEWUj7ie3kvxE7shHftPyeIQ9m+M=;
        b=cPjS+/BEOYQLeAj8djHgTkIBUrhef9Omaac56yyWPHPful0kFIJIWUgFSkWOHjByJD
         OWv2aN51Cyix0bEgxwzEkkWr/Uy9GWY+p6D46Kr+XSElbrcPrCG1AMa5EDTdzUCE1Jj/
         cr6y1fw6cJXkr+1uUxozz/36ao05F2DDTJk9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741801890; x=1742406690;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcwbwn2lH/wq2GnjEWUj7ie3kvxE7shHftPyeIQ9m+M=;
        b=SkCz2BEdK1w8CdO0zmW9Qwo01XE6Dopt8AFeROhNPb5O2J2ExslOs9Ha+ilUrOsuu2
         SkuqZdW6E6TUmG7ZCKyPBvINlfFX0zzK4qtNKlGco6Vb/Z01rSkD47fJqvdvwWYD5v70
         GL0ajdDcUlf8KcWBffvNCt43cHy1+IEyldraEPYpADwYesRYZqG+qWIwR67X+7lKcxjw
         oyy5MHpXOA2Iybmz/igUs6eEAK2CXTttFsLJGWz3VotZzkWauC6PwOE7rM8jlWhnlJ4T
         FF+IwbMzWcfMCLb6HGxWloWh3nwm5B5girGmJhJidFE/jUBuPZ8/iw91F5iZajP/f0y0
         x0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2si4BXPnJVazJ2aQ6R56I+X1lzPey0roE86opaIGN5Gyr/LUCWNms2jXZVXxa1DJL+5Tmmr4YiRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5TpsTvxIejyjbKASFefi6gQZ/Az3+oD0xZ0XdcxaWRBFzpBT
	M90EFzKUu85yir25VcFa4xPrByK6UmgMINJ+I2Iuw4i1nQ5aYmNbaHSwrfj7ZA==
X-Gm-Gg: ASbGncscEZ7IuicvPswTcI31hDjb54S0MuyznVaZH8GHZW4ZU9Gz60LOueT3ofAvqXR
	lAU8Fms06aW/niP1c8wSf2JZ884n1C9EEMwpKKyqergoOiWh2U3UvaiStrM8SS6X75sEFnGWFW2
	1c7qnIvmxNH+FUPkC3+LQ42pRMvB/ZhK7XwjFnyrrFG0S8XGm0QAj1N69TewabFGkZnnVNieT2B
	cxEAzItsNOuenAObqWUoVz95shvFxfzfXpi3LmLoRKK+Be0iCgGU7IHCLVrLH1vs8EAEooDmD1q
	0R9TfbDXW2OMdUSxd+zLH73QQ3wseTz2XEpHTVzasCt3tJl5PgQVlPZvwHJRBE0WpP7XYx/aMiG
	MJh9e9uqZ
X-Google-Smtp-Source: AGHT+IGTe6RFQQ82TXIt6ZjT9vX2p9NsOi5VE0tMCgKcRs6lizvKwC6F5+6cc54HIilZFggI3MQbZA==
X-Received: by 2002:a05:6870:a546:b0:2bc:918c:ee04 with SMTP id 586e51a60fabf-2c26102c6bdmr13301757fac.14.1741801890497;
        Wed, 12 Mar 2025 10:51:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248de52d8sm3054139fac.47.2025.03.12.10.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:51:29 -0700 (PDT)
Message-ID: <6328fe8d-c4ea-4945-b6ba-d994403121b5@broadcom.com>
Date: Wed, 12 Mar 2025 10:51:27 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avri Altman <Avri.Altman@sandisk.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
 <CAPDyKFq1ZbP4c9ECfM1SY+MEopf+dC19w9PkqXaUjevf=bPjcw@mail.gmail.com>
 <115a59e1-75b2-4d09-bbf9-50dfcd2b62dd@broadcom.com>
 <PH7PR16MB61967C18645C64E582B222B6E5FD2@PH7PR16MB6196.namprd16.prod.outlook.com>
 <d51a9d7a-b942-4c3b-93d2-65b1bb04c8da@broadcom.com>
 <CAPDyKFrCjo8gGnxmXWP6V39N+b1o62VQH9zwMUNb2_+D3-qrdw@mail.gmail.com>
Content-Language: en-US
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
In-Reply-To: <CAPDyKFrCjo8gGnxmXWP6V39N+b1o62VQH9zwMUNb2_+D3-qrdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 06:17, Ulf Hansson wrote:
> On Tue, 11 Feb 2025 at 18:01, Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 2/11/25 00:13, Avri Altman wrote:
>>>>>> This patch set adds support for Broadcom TZOS to read and write to
>>>>>> RPMB partition using synchronized access to the controller hardware.
>>> Practically it establishes a communication channel between the trust zone and the host controller regardless of the rpmb protocol.
>>> Or did I get it wrong?
>>
>> Rather than communication channel, I would describe it as an arbitration
>> scheme between N participants, with guaranteed forward progress and
>> fairness between all participants.
> 
> A scheduler in the MMC controller HW?

There is no scheduler in the eMMC controller HW, all of the scheduling 
and coordination is left to the OS and TZOS, and other participants.

> 
> Nevertheless, it means bypassing the I/O scheduler in Linux and the
> mmc block layer, kind of breaking "fairness" from Linux point of view.

Yes that is a given, our approach favors the TZOS that has the ability 
to preempt for short periods of time the eMMC controller issue a RPMB 
access and then return control of the eMMC controller back to Linux. The 
very reason we came up with that scheme is that we are not comfortable 
with having a Linux task responsible for issuing RPMB accesses to the 
eMMC device on behalf of the TEE. That task is subject to the same Linux 
scheduling rules as any other task (yes we can play with priorities and 
classes) and our TEE team was not comfortable with that, they prefer 
hard guarantees that their RPMB accesses can complete within a certain 
time, which this scheme provides.

> 
>>
>> The interest here is for one of those participants to own the eMMC
>> controller for a certain amount of time and indicate when it is done
>> with it. This is not specific to eMMC as this could scale to virtually
>> any piece of HW that is driven by transactions from a CPU, but the main
>> application is for allowing the Trusted OS to own the eMMC controller
>> for a short period of time in order to do its RPMB access, and then give
>> it back in the same state it found it to the next participant.
> 
> Honestly, I think this is a really terrible idea, sorry.
 > > Data and communication with an eMMC needs to be synchronized and
> managed by a single owner. Having multiple clients with their own
> channel to the eMMC sounds prone to problems. Is each client going to
> have its own mmc protocol stack, dealing with eMMC initialization,
> data-synchronization and power-management, etc?

The synchronization is done around the start/end of transactions and yes 
each participant does have a minimal amount of eMMC driver knowledge, 
but is confined to doing RPMB accesses only. The contract is to put the 
eMMC controller back into the state where you found it for the next 
participant to make use of it.

When we operate with a single participant such as Linux, which is a 
degraded mode there is no loss of performance nor any observable difference.

> 
> As I said, we now have the RPMB subsystem for in-kernel access. Please
> use it instead.

That scheme works when all of the participants run on the same CPU, that 
is not our case, as we have another participant that is a separate CPU 
which you cannot factor into Linux's RPMB subsystem.

We considered doing a mediated/proxied eMMC access through a firmware 
interface running on a CPU that would exclusively own the hardware, but 
we really did not like losing access to mmc-utils and other things.
-- 
Florian

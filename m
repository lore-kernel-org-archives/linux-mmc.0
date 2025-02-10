Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B278D223308
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207384; cv=none; b=CbjcF+/D6/sTjY2X8LojBodvOgFYmuUxK5DWSBaG7ZH55Cfn/lUIAloxqR8wG95zbqRc6dA5zViafJqGF4yX7ihTwiamCEEc24IsDe0fDVBfo14FkQVMAfDizYVpEqh1qWG79fUCuMJIjhxeQREJfj87a+IyGSkhin3+DBNHubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207384; c=relaxed/simple;
	bh=xOScN2bodPrckCGV7B/z1q5PKAcxPlDYV4Vg/92EUcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFrH5noT9+C28rLAmwUqNpRLYNuX9n2nb4cIoJIfiIIJdh86frXUspzQTH/bAxyQNbyjZvUKVrNSS5JcWhf9tq3mgQe2pIi6Nevz3D444c90xE/l6QXnPuoMTyJvWec0jaYcFKjr5qzSt79QdMajoqel78F+koZpFIVJP3sY8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IW8pZXp1; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IW8pZXp1"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f3b2a18d8dso859788b6e.2
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 09:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739207382; x=1739812182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lQTe5PQLHfMGykdWvW9p6zXGCaA0hCvjKNx0WDmkIQE=;
        b=IW8pZXp1fip52HHIe/G5FiIQU+i8Yba/TO4iO6kz1Xn5L5wvvcq1OSCjOlHvS99iGM
         ct4/qAX4PpFVUjwVCYJcDfiNt0vHkaL65rLv6NStYsusn91WYg0Ihu9h7Mbo6eVMhW/o
         WoyZZQnG+DH1JTXsY4ZgWvKuYaeZjdZC232E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739207382; x=1739812182;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQTe5PQLHfMGykdWvW9p6zXGCaA0hCvjKNx0WDmkIQE=;
        b=j8GFa4sks001z4pSW/qX/tuYm/OmPol7jsx51eOt/Cf75F5USyqRrtTl2ORrXNJtZ+
         BCMyu9YU41LGRh02SbUDgYISAkvkiZE/Eavg/PtJw2KoBccDNsEAsludFZn/CJAp2jJL
         YpSFwlyYuH2c7f0DCDjLKc+DAWMvFFmd0vum11pYCLupBFUZJjLIn/79YqB+aeIxNz7y
         4TqNQYm9n5VQF1B3oWv2U2pt7uUMvOijJvPgmrCn44ZCLHcYE5ZJ26+VWS5XD9OP196c
         RetZ6A+XccyjVwgj7edjU+E8LNcSoqzRsGir4JCxXRZxhyE9mCXI0unn9QkE8yGFKi9O
         +S2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4T/uYBr6Za4EycdGW5aw09pootfkLs4/rgVsBMA2ZoPUoH+ugVHjN9w9L/ZOnAAMpo2LuSZuYfbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+0YXSjVDKnlwv4gu5IQOMOYMiYxUGtccOrbbWhdOYIdsUj44
	SmHI7nNZcwDC5IRKS2WSWILSkpRkyrvXplUjRrpX+jHxH3Y0KW6bfBt3664DTg==
X-Gm-Gg: ASbGncuZkdmq6cG8cloC1LJyKPw4DEghrElYdSi2da5U/2iUsvfr3yWJtdWPENNWu2v
	wv163mQJhqDJMuWQMhhSBsMBeD7QzVwJ692Gc2FUxio896bGkWXzqpDKn+1hjErZZ0pwhjqRKVj
	O+K+rCyoIFK1ByqkL2fQkfdjbQGnA+X0veBGYVH7Rd9JCaC54gLrtv5Tpy7Nm0JsEmoAQAmRllN
	BcunTpL6lpveJ7kw4blpdPfe3pjBJzd9ul+7/iC1qo7JizjeeA9MIchg2axelRX1bfWdma+AWW/
	RkWAANpHJWGBiFXh7dJrO+H6W9bb/kbvn0sK4hAKA6MYFpKNx+jN3vw=
X-Google-Smtp-Source: AGHT+IGbMkAByqSoYHlkURXBou8gZYgAclNItaKhRl1qDrIPhmwpsCzeK4N/g1CfrnsNmEvAMtwCiA==
X-Received: by 2002:a05:6808:22a3:b0:3f3:b3d0:bf32 with SMTP id 5614622812f47-3f3b3d0c139mr3218894b6e.36.1739207381608;
        Mon, 10 Feb 2025 09:09:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389fb517fsm2382709b6e.33.2025.02.10.09.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 09:09:40 -0800 (PST)
Message-ID: <115a59e1-75b2-4d09-bbf9-50dfcd2b62dd@broadcom.com>
Date: Mon, 10 Feb 2025 09:09:38 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support
To: Ulf Hansson <ulf.hansson@linaro.org>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 adrian.hunter@intel.com, linux-mmc@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com,
 f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
 <CAPDyKFq1ZbP4c9ECfM1SY+MEopf+dC19w9PkqXaUjevf=bPjcw@mail.gmail.com>
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
In-Reply-To: <CAPDyKFq1ZbP4c9ECfM1SY+MEopf+dC19w9PkqXaUjevf=bPjcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/25 05:21, Ulf Hansson wrote:
> + Jens
> 
> On Thu, 6 Feb 2025 at 23:09, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>>
>> This patch set adds support for Broadcom TZOS to read and write to RPMB
>> partition using synchronized access to the controller hardware.
>> To achieve this Linux OS and the secure TZOS make use of:
>> - shared hardware semaphore register
>> - a set of SDIO shared work registers and
>> - IPI interrupt registers
>> The sdio shared work registers indicates next in queue to access the controller
>> and current agent in the queue. The currently running OS that needs access to
>> the controller puts itself in its slot of work register and if its next in line
>> it can try to grab the hardware semaphore and complete its mmc requests.
>> Next agent queue state is changed under the hardware semaphore lock before it
>> release it by looking at work slot register. send and receive IPI interrupts
>> between linux and secure world are used to indicatecompletion of transaction to
>> the waiting OS. TZOS has its own RPMB driver which accesses partition when it
>> wants to read/write RPMB frames. Current implementation assumes Linux and TZOS
>> as the two work agents.
> 
> We recently added an in-kernel interface/subsystem for RPMB
> (drivers/misc/rpmb-core.c). The optee driver (drivers/tee/*) uses it
> ro read/write frames and route them for the secure OS.
> 
> When the mmc subsystem probes the eMMC card, it registers it as an
> RPMB device via the new RPMB subsystem. In this way, it allows
> consumers (as the optee driver) to read/write to/from it.

Yes we are quite familiar with this subsystem and the many iterations 
that were proposed before it eventually landed upstream. At the time the 
hardware was designed, we were not sure of the direction that the 
generic RPMB subsystem would take so we decided to add the semaphore, 
scratch registers and interrupt generation capability so we would not be 
dependent upon such a subsystem. We also had other factors playing into 
designing it the way it is, such as allowing for N participants, 
including another processor/firmware.

> 
>>
>> Change required adding two core mmc_host_ops request_start() and request_done()
>> to let the host controller driver know when a mmc request starts and ends so
>> that the access can be synchronized. This has been tested with both the sdhci
>> and cqhci access. Currently these ops are implemented by the sdhci-brcmstb
>> controller dirver to acquire and release the hardware semaphore before and
>> after access. This change to the mmc/core driver does not have any impact to
>> existing controller drivers.
> 
> It seems to me that this isn't needed at all, assuming we have an
> in-kernel tee driver that can route the RPMB frames, but maybe I don't
> fully understand the use case.

The proposed scheme here scales to an arbitrary number of agents in the 
system. Our immediate use case is for both Linux and a Trusted OS (not 
OP-TEE based BTW) to share the eMMC controller, but we also accounted 
for a third agent which is a power management micro controller firmware 
to be able to participate in the scheme and occasionally make its own 
eMMC operations.
-- 
Florian

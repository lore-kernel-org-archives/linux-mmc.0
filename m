Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFE1F4607
	for <linux-mmc@vger.kernel.org>; Thu, 31 Jul 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980204; cv=none; b=e1fJn1Qz9oQuDSeoPcFVDm9xEPz/ac0bVOzLZI/UHFmem8MRzjRjxtTZbYE7XRvsoC3LhJ7tSBdK/nwtbv7HYHgrPIHRpcJOaQOdXkTPwc3y2Q4OeRuKnY/7NWNzOQoSX5fAfRVVebtzKLkkUuuJ1MozKridx8p6gmVhCVw/ES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980204; c=relaxed/simple;
	bh=RrP+Q+3mcEk4e6dH5D7T5bcgzHzmM7Taaur/o/ch7NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmvOv2uimLOJPpgwcBpBFR/gRycmRhGJOE5DJrvFsYy3Jae3fC+Q4pSZ0g57t1brIT3WBhSxgHfl2HQoWdyN3KBVjvZskBGAaB9FlC3N6De1Cq6UmMUSk6XzmwEb5kOVItL8/jKkygFJcO01zOMvO9eEXDTQ7qCxSjv3xEc3Fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IqloykAa; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IqloykAa"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e32cf22fdfso110939485a.0
        for <linux-mmc@vger.kernel.org>; Thu, 31 Jul 2025 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753980202; x=1754585002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lbNcmxdMTZH4+4fKNLqLIFsAiyBnuQVAnpbsOwkpl5U=;
        b=IqloykAa0JmYGsql1LqXJRP3bvfulMC+8YdSY2pGn9+5dVXr83vHL+mIzjbscKYa/N
         Dmmx4pc2WJWj6hiY25E4hJ2kl6YuvAa8tQ+WsAi8aodwmQGl0UDV//84rTIAdnird+Nl
         SvWd8QjEB+c4zZXpf4BaS8BgT7bXyX0TN23vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980202; x=1754585002;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbNcmxdMTZH4+4fKNLqLIFsAiyBnuQVAnpbsOwkpl5U=;
        b=A+4298sw6WalT3g6WC9ko8sEi8AqEXSCr05uToHIAZQxQHqS4etcGUVImg81sspZAb
         3Nt8R2l2fzMErQhYYfWaOXJX2wd/ylbDZk3gbAaT6/9peTUB3pEUp8PnUfHaKqr3/tm+
         WOLDTGW6KL10Tr8cPK1X61Z1YIoLd51WUNmNjr8XI84/48sU+YKmI4bV7O3UBwX4tbhk
         5WJ47JePEY1sLMU04tSNBZtF8F8wwfcPj7OmZiSeEN6NPomERouQ8HtrLEqSNnQEo7oF
         N+YmH4uyEYzIWAVmBMw4ERblYqK7ciiANVdWzRilnyyYo8+QYv5kymL5dzgg80U6jY64
         zrZg==
X-Forwarded-Encrypted: i=1; AJvYcCWarp5lODDThJhTxpP4r8wUXr+D6qa3jdQzcN7DgRYfhwF8KLEJtLQgNPDThgOfjP1BJXZI0365juA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRKY+tB0djG7OwnrUk2kC1bAorC8bynWzP8pzqi/7Yz9BhAPi
	9LHIUNA4vSswSJyCqxNVyMzfrcKCbfhrYrcN2qh27cvxhDIWMhpYqbMdC35mKbUzrg==
X-Gm-Gg: ASbGncs6Xawgq4yEVzyEm+8g05D/QLRl1WagHns2kY+tNT8A/VFlBr3cg9xnnPjAQJA
	OPnrH+1bAYQSdVf5MNB09YJJVYhy6XpPHobNAQoKL6SqylOW6+6h9J2ZYXP5YBiOK2Yp2aPtTZz
	M4+k153QkOUIg9r36ydWcDXLBfTJDkVw3KWhREbAOJwhAWl1OSn2lNlhGViBc8le3tSG+etgmol
	6GEKQgbbGNcwJGRaqJrxuiWWR7kN8oJt1SNHuGhPvnZP3tE8z/iXVzXmA9Y/Td50EpENsOxeWP/
	GBB/rR1U/BM3TLA+YqQdyUNnRqQ+5F9r25gE20FFQmt/lS84OOucAXMvAI+0LDbNTeH9B0wxwtV
	OOzG6dnFIQcLxPP6zs1LParsjiCDSCCpSbU560etqaGUPAd1E2vI/BzczxnwFAA==
X-Google-Smtp-Source: AGHT+IEMxmTL/RtEarc2NI77icOmXLVKI0iWLz9cXU1YYoJIxr439vc8qqp/uBQFKFpa+CTDFCVyAA==
X-Received: by 2002:a05:620a:430a:b0:7cd:3b02:b6e4 with SMTP id af79cd13be357-7e66ef7f617mr1153543485a.1.1753980201850;
        Thu, 31 Jul 2025 09:43:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5bfdb9sm107416485a.29.2025.07.31.09.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 09:43:21 -0700 (PDT)
Message-ID: <f85367bb-566e-43d6-b405-b896c49c9aa7@broadcom.com>
Date: Thu, 31 Jul 2025 09:43:18 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mmc: sdhci-brcmstb: rpmb sharing by claiming host for
 TZOS
To: Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, andersson@kernel.org,
 baolin.wang@linux.alibaba.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ulf.hansson@linaro.org
Cc: bcm-kernel-feedback-list@broadcom.com, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20250711154221.928164-1-kamal.dasu@broadcom.com>
 <d542b1fa-6e2a-4af1-a14b-eee32a7f3de6@intel.com>
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
In-Reply-To: <d542b1fa-6e2a-4af1-a14b-eee32a7f3de6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/25 02:11, Adrian Hunter wrote:
> On 11/07/2025 18:42, Kamal Dasu wrote:
>> This patch adds support to claim host for TZOS RPMB access and synchronized
>> access to the controller hardware using hwspinlock framework.
>> To achieve this Linux OS and the secure TZOS make use of:
>> - shared hardware semaphore register
>> - a set of SDIO shared work registers and
>> - IPI interrupt registers
>>
>> The currently running OS that needs access to the controller puts itself in its
>> slot of work register and if its next in line it can try to grab the hardware
>> semaphore and complete its mmc requests. The shared work registers indicate next
>> in queue to access the controller, and current agent in the queue. Next agent
>> queue state is changed under the hwspinlock is owned by the current OS accessing
>> the controller hardware before release the semaphore, send and receive IPI
>> interrupts between linux and secure world are used to indicate completion of
>> transaction to the waiting OS. TZOS has its own RPMB driver which accesses
>> partition when it wants to read/write RPMB frames. Current implementation
>> assumes Linux and TZOS as the two work agents.
>>
>> This patchset is an alternative method to initial RFC patch:
>> [PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support	
>> https://lkml.org/lkml/2025/2/6/1711
> 
> Does it address Ulf's comments? i.e.
> 
> 	https://lore.kernel.org/all/CAPDyKFrCjo8gGnxmXWP6V39N+b1o62VQH9zwMUNb2_+D3-qrdw@mail.gmail.com/

If you are referring to the fact that Linux is the exclusive owner of 
the eMMC controller, then no, that is still not what is being done here, 
but we did respond as to why this is done that way, and there was no 
subsequent question or comments on my respond to Ulf:

https://lore.kernel.org/all/6328fe8d-c4ea-4945-b6ba-d994403121b5@broadcom.com/
-- 
Florian

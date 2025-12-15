Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFC31283F
	for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834669; cv=none; b=OdIUlTqd2Zqne0DQyIJ3RULTdQLsd1eiDzjpOCNQaDxWJIPdU28yUN+kbOiK1sEmR45gAO82n1jGJOMJxJFyJ6I3YOT2tYJ3rKvA24fVmbJO4T87HYfyV610sTm16pdc2PgBjiYL95bnunSigf6G2ZvD/lmYh40hm48SAzv/+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834669; c=relaxed/simple;
	bh=bnB5y473pCBpjDo3xg7lOcCbOSzgy8Gp2Sr2N4f4mk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCzUPTBvJmhj7DrEsG5Gin52N5IGs39fsn0DvYmEbpxoT0RAANFfDgYtoX+DVoFv022OYaurDBwrlfEJzuSxiDJv9IeCgbEeDWhYMF/dWMYOvLjNe9Xj3N0zcv8AbX+sP7F5O2cwkCwNBD8OLnCpgoVkaAxeg72WBOGneBN5LAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mv++GbDr; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mv++GbDr"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0a33d0585so20052595ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 13:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765834666; x=1766439466;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pyRcpH/2tl4cd7cvu3CnMf+/x/OF7RCGrUbAhUcQeOQ=;
        b=TkOeHUuFpXINQFG2Jrw1VrpedN2cQySjzBD10zGvmy7k9IgMqWa7GasnbFljH3UVB1
         MGc6dM8MYiTxuvcWOeoPAcTTtyMGn+LLtrL6fAzIuoTl5lmoacmBt03KCb6Xz3mjy5QY
         gtLZJr0AddMKOyTUVaFNiJhZrfB3Amkx9fjyw4pm7webrNeoqKicDlEZMlskItwUeI0D
         ZFydIVKBOiKZr4ZnT6RD2gienRSkFQrc+N0y8L53VoBFi3u0mZog785tRWEhs8LJkGVa
         bjZyINIcjtH4ItaOsDedjS/8x569FEv3Rvy0IF7Ij4/JOLrYr7zgN7uo5/DvnoDaun0s
         qO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTT83yQjKcCWqCV3jWSJM46BXyPjOyEpZ4P/BC3MZZifQ/H/u11pjlHU5GaEZpMcb+GTQku3YMeyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtA6+xb9gf5xpwKMgEfcwVaMY3H7LJF5st3pzC+pGLKUkU8NQ
	kyOVJN7gTKw0vNlTVKHhZMGFnmHa9nPDp7PkuHzAP1yJq01Ztbf/kR47+HVnibJnxJtJty8vxBH
	0gnIXzwPUEkRwvOcK//a2/r+qpLFxwMLixIjQlkN0cdUcKJt2LsH/BW3ByQwbPO0kAFbVfM+17Z
	WjDVen8V670A9ql5dyZbjy+95/A6t/tD5h4mqKicyyEuPISzBxjE+nM11CWUjrWfoN1b7XJpGcf
	0FMAkp+rHrObu3Tpuhd
X-Gm-Gg: AY/fxX6jwEdgWzP2aPaXYgkh0rreeHWa81W/9HJLY6E6JTQMotrhNQJVW4HGdhL8o5H
	arxOncSAsJyX0xHpJ81GTVAlvZrkSfAtw3ImHiBEq7lbFLWwalWkTx6kslVTMG3/PkEzhpKcJcu
	dhLUu9UQau0G8hcb8ODJvkDvQH/Fgjo0ChJRIkAzG2MErWFnfFyVDZMl9ozyS5eqqd6y5kB656l
	CiHlxiJB6Td02lpH7c9AMPqNS/cmngr0vGrQYNKXSV4m/ckq0sEkpnT5O0UO9M+NEduM8o/Ua8l
	95pOdEk3Q3SkDMxQjh+d5/bnlhEGtc9LhP79omOqdRSKwUeqdZHvvJXFBgK2hTqpOIe4lRV7eAH
	LMAEC05Go9Vj9gbYiYytzXVtaL2Y2mAQYf/8Fe0rQU7+/RyYSb3r1P8WuJtZl5suqoOI71MXuA3
	gL8YQOeIhP/vcOV7eZYTY3GzGFomXodU/PntajWE+UPh3DlYmvJg==
X-Google-Smtp-Source: AGHT+IF5kYVClA41NLL43/ikEKCWy2oXLIJTmXIhIitIyT3OsWp7JEERItWCzcQe8tQ4JKt22UE8b1ppYp81
X-Received: by 2002:a17:902:cccf:b0:2a0:b467:a7ce with SMTP id d9443c01a7336-2a0b467ac28mr70196955ad.36.1765834665872;
        Mon, 15 Dec 2025 13:37:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a0d7f6e200sm7436725ad.30.2025.12.15.13.37.45
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2025 13:37:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b22ab98226so1239537185a.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765834664; x=1766439464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pyRcpH/2tl4cd7cvu3CnMf+/x/OF7RCGrUbAhUcQeOQ=;
        b=Mv++GbDr/XFmBs6OK0/kWrUIfBjsBKvHIRxCDS2+My0ImbdVqqhKHe5FfX0rIppTDw
         vAfjxznZw3yW07wiDsJKVvXaN3/qjVP3ORhAwOqpXd1Mu7mVozTonyodGGLWG5W+UlEW
         JTzWWL0Fz2vMp8EtE0shELC09wADw45VZLev0=
X-Forwarded-Encrypted: i=1; AJvYcCVap2B84OWy8b3ehdysOZyArNBH6NkRe/PsEjVNBw/Z7S/iwiIYJ6sJWBk/NF8GHk3R7KYcyXP2iwI=@vger.kernel.org
X-Received: by 2002:a05:620a:710a:b0:89f:7109:185f with SMTP id af79cd13be357-8bb39dc3e95mr1812351785a.31.1765834664561;
        Mon, 15 Dec 2025 13:37:44 -0800 (PST)
X-Received: by 2002:a05:620a:710a:b0:89f:7109:185f with SMTP id af79cd13be357-8bb39dc3e95mr1812348685a.31.1765834664146;
        Mon, 15 Dec 2025 13:37:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be304dea8esm40611385a.8.2025.12.15.13.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 13:37:43 -0800 (PST)
Message-ID: <30d6512d-9705-414f-b2ee-3e9283968348@broadcom.com>
Date: Mon, 15 Dec 2025 13:37:37 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: Allow "dma-coherent"
 and "iommus" properties
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Saenz Julienne <nsaenz@kernel.org>
Cc: Ray Jui <ray.jui@broadcom.com>, Scott Branden
 <scott.branden@broadcom.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251215212736.3321550-1-robh@kernel.org>
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
In-Reply-To: <20251215212736.3321550-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 12/15/25 13:27, 'Rob Herring (Arm)' via BCM-KERNEL-FEEDBACK-LIST,PDL 
wrote:
> The Broadcom iProc SDHCI controller is DMA coherent and/or behind an IOMMU
> on some Broadcom SoCs, so allow the dma-coherent and iommus properties.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

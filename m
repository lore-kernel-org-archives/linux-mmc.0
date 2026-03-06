Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285EE1E3DDE
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755619; cv=none; b=OqiGxkJtRgnFbWMPZLXLeEWMAvhn/3NgUuxs11XC8mg0NWkoV4mUjuLLtvmGHL0Ts/gDVakV4knJWmsshymYMarUCL5lWEfXBUakQ3yyVyp7mONh7TamJ6CubArL3ZtFZgi8ms97iW8W4yY34S5NzueeAiyoSz/Q2fsFZSwKOLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755619; c=relaxed/simple;
	bh=JxRomFxd9hv3/gLGPTurxi21vnURD9r8HgTYeDAO4G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff7q/830WMMr/S+V9xhH4/A3bvm1mien70bcqLx0bVY8mvwK9sCZ2WWaxjI+75lAHlVq0hIDr91AQRkqrRNJJAyaASdv6u19Q8roQouduljZUuQb5RuaHqZ55RSwE5Y6VVVi0eUtK4x8/b8hLHzJBogeup39X9xE9rVIA22toI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TJk3ADQl; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TJk3ADQl"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3599126be32so2817463a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 16:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772755617; x=1773360417;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=srEQihf2AwIrKjTWa4x/q2bFgNIgWcLV50aWleEKnus=;
        b=agHL2uwIk1mXYWCxmGpBcawLuxY6u2asNls6VWx3e3C7GHPxBt2pd1pso5AAe2R34Z
         Az8qFSVmGps+ZoUy0xfgYafK0vzDcUmGjXNMUp5lfg9IM9+gi8ucOiTNG7/FlK+8OcHZ
         0bqcbYNwO/JkaCjRuo3/Wsb4SuMCl9t/NJup6vlPGbD888JiVHid6g0DGeduKEhDMjeH
         fqcQp3IXh2oQTWElefafDgQy0gODL0iPsCuXl2Ftt5kebyM3uZiC+g6COVmnWWrFG0Gp
         +tqQP7nE2tqps9RhcWoKPCaPmb/dVJFwubIRywnIlUCI5k90UwKXsNw33pNQz977U7Va
         hUEg==
X-Forwarded-Encrypted: i=1; AJvYcCUUQLuaAamIM5nwAoAikJN+1ypmCDGtyhiZwULYeKLKv7ofzZK6ivzYiW1RPjn6DvswhbZfx1errqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1l+0u/vNxUi8YHQgNT79xH5lUj+NA8cVDHG/mrAN+VgpNMsq
	e2sZVZrl93hoEJX1yl+vAqZaPZUY4KoF55eGHdgKp+Aevrn4J0xcYIblih1+gIZLdt1zefbQfv4
	zfPB9eTgPdk0CW4PX9GkSCOznSK0xalPKqUq5fGz3iu9mD4QSIWy9uG0Ayy0DT+QsmBWLlMZla2
	T3QGM3qMRkV+0/wYlL8rG++seHr9BIz9Q4+07bYm9ihKR/IsD7sylqLiQzVwKmyyfRJfQT0s+bY
	ID3QLgaFRAhmAPJTwLs
X-Gm-Gg: ATEYQzwrnZnOxqELG+E4u64jadNyI/oYbkzDFC+4dMxMxZSayjMe29Y/PzMkHo3SXlb
	LxRsuowKyLOZDJ+La3JPm2fzG3q1t+Z6Bqtx6o030JfP+RstHNK5SyISZL3Uvw1t9T5qFVGddrJ
	avWod32o2fGTdWx7KBMf8s4LN8nT2aE+02IEyvRJVJF7Ve5/bmBMiQTOo4Y5E/p5dsQZQIEA6m0
	dG/vWQyMzBhBRDr7nBnbFobpgCj5SdoHgk+6anJ8r8RwoZw3P7I0RjaBpmXBOKQBXPVd6oEkqq3
	t7d/B7RWXAK9eEAK2DHwwXxFO1qVpJuJshhW/hJWM9sDXsJJqbYp2LedM8s+CY0zdjWggr6UhhV
	29M9+gWHDSXmCntX37WuRX5C9wHYPRR2u9IRY2v1xSlj76lwsKdtam/qHEwYpIyNgw4e77wsRua
	bK0o1UtJ47d2k4CR8KBRbIg2aS2WELdbuAtvMVrmbm6kCBvvaP4hWhpJ4LR1/5og==
X-Received: by 2002:a17:90b:1d43:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-359be344adfmr185909a91.17.1772755617398;
        Thu, 05 Mar 2026 16:06:57 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-359b2db0a64sm405642a91.3.2026.03.05.16.06.56
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 16:06:57 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12721cd1a2aso129697592c88.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 16:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772755616; x=1773360416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=srEQihf2AwIrKjTWa4x/q2bFgNIgWcLV50aWleEKnus=;
        b=TJk3ADQl3Hql+OMshQ6mHA5LN9gOnbdUT0Hw1vuF4yVji8AvewsymjwspoHd7ujnF9
         37KoZRRSgI/LsFZupecon/nJ2mGRiaLkxS9L13Df770zuq3bug+XBb5kLNRDWDS2uF9N
         QqdkmSD1pPkbMr1FgEARxyJs0DbRKzPpU+UpQ=
X-Forwarded-Encrypted: i=1; AJvYcCX2+9AuZu71+TsAReTOI3YSfcaXepD5VVbkD78tgDPf47jBGLYbaOlAGNdj5g1I35K/7u4gErZLeZk=@vger.kernel.org
X-Received: by 2002:a05:7022:b8c:b0:123:3461:99be with SMTP id a92af1059eb24-128c2e7fc6cmr125909c88.21.1772755615647;
        Thu, 05 Mar 2026 16:06:55 -0800 (PST)
X-Received: by 2002:a05:7022:b8c:b0:123:3461:99be with SMTP id a92af1059eb24-128c2e7fc6cmr125902c88.21.1772755615073;
        Thu, 05 Mar 2026 16:06:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43a18sm28026987c88.13.2026.03.05.16.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 16:06:54 -0800 (PST)
Message-ID: <13fd194d-dbf7-46f5-907e-f1b64177ed14@broadcom.com>
Date: Thu, 5 Mar 2026 16:06:52 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: allow dma-coherent
 property
To: Lee Yongjun <jun85566@gmail.com>, ulf.hansson@linaro.org, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, rjui@broadcom.com,
 sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 nsaenz@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260305234703.38490-1-jun85566@gmail.com>
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
In-Reply-To: <20260305234703.38490-1-jun85566@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 3/5/26 15:47, Lee Yongjun wrote:
> The Broadcom iProc SDHCI controller supports DMA, but its binding
> schema does not allow the 'dma-coherent' property.
> 
> As a result, dtbs_check reports the following validation errors
> on the Northstar2 SoC:
> 
>    mmc@66420000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
>    are not allowed ('dma-coherent' was unexpected)
>    mmc@66430000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
>    are not allowed ('dma-coherent' was unexpected)
> 
> Allow the 'dma-coherent' property in the schema to fix the validation
> errors and accurately reflect the hardware capability.
> 
> Signed-off-by: Lee Yongjun <jun85566@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE82D8760
	for <linux-mmc@vger.kernel.org>; Fri,  3 Oct 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511387; cv=none; b=FxoNbN8mErXTzP0yeNDD9iNYmTTrJhN6TCWK5Aj5+P6NmjUWWJFg1CKl+2vhmEGiGQ1sAZTCbnjqeBmW6JpNaAbdmuy0I/pwXV2lob72sD2ZeOoDZP0pbIN/14YfcdKtwy4JRayubb5vucd4cBC3oYhCh9ORS6ITNvfFKKfjlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511387; c=relaxed/simple;
	bh=5Z1/gl8Vildjdb9LI4vL05a94ASK0LMfvbSWas9aGg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdOaZzI6QGH5EKksFWSGT6MV3uDkLJHFk03kdquxd9c7nINep7mJwrLmfI0jICxseyQLtgJ36SOYRDoej5V9dIjfjaq2R87RF5lu1YSUeoSljxSsQGb2bTzbADVfCJDMWWyBr6HospRl/TcJcSKTALOeQpkDH4Dv2RqciYIeuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Az4vYIaL; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Az4vYIaL"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so23910966d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Oct 2025 10:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511384; x=1760116184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rhq5Xd4Igc9fjcR+TCYBH/u4+ukG5nbOgfFURkP/fuM=;
        b=BuCuUkHK8R/vmF5nBzeXvO9hEbHwJ3GJF40TnlSC2azuBg0jqUawdcx3kHg8l8crmT
         +euVP4ncvERsywvWF3gSKNzkjtLOsE9zmrMlmRoy22kYShCeBDdPI9Vqo6IJxXwABjz7
         q4YphvmixftfnTCCy+oMYFNENkn9tnfy7TkFWxFlDiPUImXehGXkYITLLS7HmPBvM4j6
         6uMmfKXFgwj0mwycMZ3l9/jH9+HHR8h/HeLyHSv1AJrtZ+vkb3RVH8kDyl30k3MTL8t2
         LAXKQ0xEsDDnD6pD0n2qO0O1vkrxm4h8I5vi7FJDLzU3gjtOpq/CXFR8GMxKu2lJbnVT
         RHYw==
X-Forwarded-Encrypted: i=1; AJvYcCUX5p+Rf+P+CtfkZ7F6xlogZZ8cHXmNF2b0VMNw88OuWK0Lr8HBqp21wxiY7b5p6wIYL248ZQcSPoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuXS/5EsiewQ/YyFtIsWFLrfAr3XMnS/4d7xJg9wo4CdhamCQ
	udhM2g91xUaUl9kJhAiuwImYftMJd55u9OK7hgMKnUa+gISZn3dSwdc6yYI6FNSGjaMjUMBLcVK
	GbzV0tbjdWFzPHEIp+9kx1zH0+xEwtQ2l1i+6NS+BcSigKWWd99a0oysyBSmq6NjFtsLUS3HqRD
	C6oP3QDLKHkPEDsTBqIC8n8VcVkAr0s8LdQ28l8T8LPy2RlzgvF4MiByUH2Gca3NS2rn4pcw1Zv
	bAvNKgTvVbIvtFmPVXd
X-Gm-Gg: ASbGncvmpc7oAjRoSqtiBJ/JAyIUP9VOXA7dgAI3ToK1rBQM7jiSZG2py+zzMAz0lfF
	IcdyZd+ADzXnb21Kb1YYkl3uLK8VHPdyAEtafERRFi2XLbeKk+0N7QBMgZWKIyVeyZsqWASW3Rz
	QG5b8bWnWFLNn6rKx8paSUG+RhvkuQBbIPUYW/QLvj99S2waj2pBnOJHs7CaGDFrBKPjFGSTSYQ
	KxW7eSCzztI7fm9XfumNb32N69i7pW7xYZgRrE8vsH4nYntYZN/ZksdjYKhnodwVbTjMWImA8Cj
	LM/PfmJr3OLl0m2jS0iYLcvoOM4D5MT0tXjjel6yJp8OOxK4s86HSWG8M43mFp7gymbVoGPYory
	bLOja8b9Eq/NGRREzuYjABLiu3182LDfJxuRvZAr2E/vSMBs0WoKmLxWxvj6l3VxKS6w6S99l2q
	OSiKAnyOiZCfWj
X-Google-Smtp-Source: AGHT+IF0rXvEcDKCD2ISO/QHLmIPhaU8CwqK++gFKNBFR9rl3FV4lJ2aoT9ysbQ+Ruh+wP+Q5OgMpmsoodI0
X-Received: by 2002:ad4:5e89:0:b0:70d:6de2:1b2e with SMTP id 6a1803df08f44-879dc86d253mr51555206d6.58.1759511384277;
        Fri, 03 Oct 2025 10:09:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-878bda73490sm4074856d6.19.2025.10.03.10.09.43
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:09:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ec2211659so2355594a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Oct 2025 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759511383; x=1760116183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhq5Xd4Igc9fjcR+TCYBH/u4+ukG5nbOgfFURkP/fuM=;
        b=Az4vYIaLPQENxx7lbM5z/Mj5zGy5rE59RvI1fK1IjUVV7VQZDHnedP6TP6pXO8ZXYp
         RZBQaFBeOS7rP61UekccNfzQhBIhCW9HBiPTAFp/ZGbxEducMnjdRCjBWgbEQ0FHutQf
         TGoA14N6i6Tpb3nbK5TSy6imaQg+KMnCzdSBU=
X-Forwarded-Encrypted: i=1; AJvYcCWcOsPXNVVDpDRb7qVIUbn/z6/zIvY3YCQFyBcgyXin5iKvUT/fCkm60lG+ZrvCxujQmG4QtxZR378=@vger.kernel.org
X-Received: by 2002:a17:90b:33d1:b0:336:b563:993f with SMTP id 98e67ed59e1d1-339c27b9360mr4610183a91.34.1759511382732;
        Fri, 03 Oct 2025 10:09:42 -0700 (PDT)
X-Received: by 2002:a17:90b:33d1:b0:336:b563:993f with SMTP id 98e67ed59e1d1-339c27b9360mr4610148a91.34.1759511382294;
        Fri, 03 Oct 2025 10:09:42 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a19csm2669228a91.7.2025.10.03.10.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:09:40 -0700 (PDT)
Message-ID: <72d1e09d-f30a-4f8e-95c3-b9a40e1e1b73@broadcom.com>
Date: Fri, 3 Oct 2025 10:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add support for BCM72116 and
 BCM74371 SD host controller
To: Kamal Dasu <kamal.dasu@broadcom.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-2-kamal.dasu@broadcom.com>
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
In-Reply-To: <20251002210426.2490368-2-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/2/2025 2:04 PM, Kamal Dasu wrote:
> Updating compatibility to support BCM72116 and BCM74371 SD host controller
> similar to other settop SoCs.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A52D8782
	for <linux-mmc@vger.kernel.org>; Fri,  3 Oct 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511457; cv=none; b=OcU57XcxDkFTLGsOV3h3FcG4B4z7T5ijuLAiIO6auImvDNOBD66Yyw+JvLs2ZGOsLrCKMXlkh+LL9woXyRvoNWrObrQLtITKwlb9wdadQQzdHrNYrtOTmM+sADXdFWwPc+WrSHlLAmMdw0UsxPpzT8Pgvlp3pcKCSBAs4b71NhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511457; c=relaxed/simple;
	bh=0Q5R+tGH6D7U8akAyRuu8yHM8SEXa/50GdWiqwiumDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLLUSvrdmrDwUFXYtDWpJOky6jpnaGWPmp1/EOvBzMopqQysKeKUnVO8MiI8iwdm0NCvO8n+ScrfWOhoZ5/7YRVSfOK1aeUxuLyN7P41b1VSsiCePY4FImucIt1r1xKtxTwZL7+DlBblNf3jvOPRq6hHvuJ9yddeuWwvUtEyje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eBvNuTzh; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eBvNuTzh"
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-5d128733742so1036093137.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Oct 2025 10:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511454; x=1760116254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BRqPBk1106V9u0XllX+MkRivNo9y7LXj3s6j5aNCv8=;
        b=UE84+9P8aQL8eh2Nr432iYfEOU8DLuyODlKxs0AVDLsjswh3KGtKKPcdgXUa5QpinZ
         5FT3uvx1k7ZijKjLnIq4bvL26frinF1tGr8HmVYuAMwOxUsHB03jv7m7XJX99F9IpMBN
         pQu8FZ3geIP2V1yvA+/4rpXPIlZrwYN4i10HHConT0THTTRYVGd9tvyQy+ZUFDjBFPDq
         yxB57dpyK1sjeip2w8n7jLMN6dRIyBuolDoGIrKrsspGV8tNImwkq25hCDYhpCBQVItW
         H187TjwmyOzAVcvveReVEy4xkEvw1jktVDEWxUnTj8Zka0ycMiHVgcrMe9QhXcJmvgNP
         xW8w==
X-Forwarded-Encrypted: i=1; AJvYcCWcToWMa+0CkUsaxC+fmaAo6j19DaiBQmFmEOx3IUwWVKVLraBSFTDjfVBoHzq3+aXfniL8MKML7jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPEylqh5MnyAc5sYOjwngZy4RH2xV5NsYPKAs/dW7yd3965Rr
	jfIoxJSKh3a+yXZzrutKVNZQ2NIeK+9XEXNF1bPQYLf6onO3hMbZ5Gr2EXVFsJdpm77w/hYbHWU
	IdfH5QbzMcQ7iZiHk+x/ACpWhQ9oDFtgOyBI9lOWkA0+BUR01DpxIBWcfl6Cy1tRQW6Kdi3P7c6
	7Lp4QdXUApI6m+LKaI8pGHBoLS7AyQ34nzxdg9uPvxTU5lJKbxhwKiPDLtPvT73qPc3lDeCXkpF
	/xXXk8T8kox/HRiljJa
X-Gm-Gg: ASbGncsGdfDX7SV/vnpCnX3nyHoGVmSnW7RapETVMEweY+m0LYl/jQOYnyv3FdglXHo
	ElrA7hqIWJBLPGXW8o9qNEqh63DylURn7A+ZFKyZP+f7HnCdsG2rJIBa1UWHir1d2X7FHqdmcGM
	HLR5O7BhgsLRUDTL0PsZtrfRTRfKSb0SWi0eRbJQ06btlXWWN/uRh176twic7et8NPD+DSazlOf
	BlxTqkwoCQ94HXeUz0hwzfGmOasIznVK8lc/UaHeJXCiLZY/VNGx5WxbLXX46pRrLsJRxgm81fp
	SSpTA0gi9Ihz6fYNGqU0jZN0RJsVxI1jwyPjGrkM1k4E70NCno8AWiKXi7QDAegXjB/7OPgSOTU
	q2w55/9yeZw0XQHFaN5RNLW6tCh+8K3Dh69zPRHK1mq5s55rFnWvyD4SjQp6xFNMqB0akbX04pV
	I7ftD/KKczrLX1
X-Google-Smtp-Source: AGHT+IFx5LBz+OCMfbXANGfFXfo94shtKcv5YIBSAc4LClOGjcy+T1bVKE+9spezyrzT5tw5BapQz0pq3usS
X-Received: by 2002:a05:6102:8092:b0:5a3:3af0:36df with SMTP id ada2fe7eead31-5d41d0e86c4mr1578390137.17.1759511454396;
        Fri, 03 Oct 2025 10:10:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5d40c8658a0sm484267137.3.2025.10.03.10.10.54
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:10:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26985173d8eso38609125ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Oct 2025 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759511453; x=1760116253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2BRqPBk1106V9u0XllX+MkRivNo9y7LXj3s6j5aNCv8=;
        b=eBvNuTzhneWHhjqPx3Nner4SJmW9r2Qi4vq2tmu2q/IVOc1+LQAr4jBvhYH+bd8RbM
         5ylAUTJ/XW8U8yP98BhEBLjcfxerfP4vcwF+A6+u6qfLkeV+HF8ZeTDBlVynKqZmu8yl
         R/Aiz//rL6tJi+4TEa40BtJisMHRHSVw9oiyQ=
X-Forwarded-Encrypted: i=1; AJvYcCW8KVPs9ETHPaYBSW8tAdKScLK+ABxe0hBGMaXVdmyDTIAb0VgciKBphRP5BJkjXL/lbXNh1yRAz5s=@vger.kernel.org
X-Received: by 2002:a17:903:1b24:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-28e9a58b709mr42967695ad.18.1759511453113;
        Fri, 03 Oct 2025 10:10:53 -0700 (PDT)
X-Received: by 2002:a17:903:1b24:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-28e9a58b709mr42967435ad.18.1759511452713;
        Fri, 03 Oct 2025 10:10:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87dcsm55356295ad.90.2025.10.03.10.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:10:51 -0700 (PDT)
Message-ID: <a0c3a056-0d5d-4201-ac97-4becc5c61d47@broadcom.com>
Date: Fri, 3 Oct 2025 10:10:49 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
To: Kamal Dasu <kamal.dasu@broadcom.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-3-kamal.dasu@broadcom.com>
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
In-Reply-To: <20251002210426.2490368-3-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/2/2025 2:04 PM, Kamal Dasu wrote:
> Clear SDIO_1_CFG_OP_DLY register when using HS200 mode to be
> compliant with timing spec.  We only need this for on BCM72116
> SoCs.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


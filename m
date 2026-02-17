Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4D374726
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354049; cv=none; b=YUWnP03QczCSiR64CVkii/VlP85pP5f5Hcg/8ktQDKgOAwrFajjS+sLaWodn7nPL+Sjie5vfOUzoTuLCJy7IO6p4wnzraMyQXPXu6X+r/q6SzoTKKhgAj29Td5/LAfS0blNzWSLWI4AH/rd/QShLX+UwJw1BAQqnQmWaLZuBxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354049; c=relaxed/simple;
	bh=fDbglYiqsCTg4EPvuE+VxHQYlVs3a8fvqgDhDZPkEc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGTEaSkrxE0HnMI6Z+NuQPukBeEYmUj0KDeylrra49E+SSlTw9lnPbQFjBTvg3liUNN/Mgvn7nZTkYhLRrGLeGKQnQdtmYYMCSZTAovFU+RmAlsbYpSbehDevZ/f047fmVua3c02YqGGKR2aL9gMZ7hyYRDywWJV4WFLKCdCYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dm5U4vKc; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dm5U4vKc"
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8cb420f7500so456542885a.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 10:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771354047; x=1771958847;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bsx/C/z6cBL786ltmFv1u8SmaC8UkSjwOZGPBi68EIc=;
        b=KvzAXaU8RvKYkdJZwO6QKRadzU0K7YKZK8G4ZrLPX03j5oJGv916hE7z5I2om0uggD
         fU34FrywWJTcYqSTuO6nXIfdbGDMqu5rB77o2sebb1KFgOmXPQQmQ8squZuXOd1HZYj+
         JczXHRpiC5bAbEyOl9vQB3Hia31Xxk2DBpIpnbTtvOW7Q7GG4NESDBzNZAmCNyxTDxNW
         hA0oLO0UnU6SrAjTrCH0FlHabP2OrkHdF1qDDdQquPdep0KGG0oZLqn0b2QvOrs2FDfG
         RX7dA0B30DFmbIQrbuHwxOsxSM/IhybFt5rfy+c/ub+7A1rAf31AbYoDr7RU28i6TcD/
         ZQkg==
X-Forwarded-Encrypted: i=1; AJvYcCUvwpiHc/jJNbHCnnytpqWjnzo0/nv/feK6gkAfhx0gSoszidpcutKWMaMDzwMdqcme7k1aWxSjRng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkF1F2vNh4ymkpWuojFPDxv1j4PMwChB/Z2RkhXO6NK0T9dRT
	C051LWB+l4JfqEVSIlL+cOov1q95ESaXM5/fYkbX2tEx3aCLfdnSdYCKrhAkbWkzXP2qsFRpYP4
	0KFP98OprAPI2NHRa+2lUQ4Cz6RNMG/QMZ6dROlnM0jgkuA2dc4yUOUABPUHwaJn7fPClc0umbZ
	JTyEpFz7G8LhoQXs+uH12sOA2D66l7uhxQoHtncOIcUBPnXQRgH0IlYig5xHQmv5nUtin6k4pxP
	uqBQdTrftGPPtfXreSp
X-Gm-Gg: AZuq6aIomYa6klzBwE9KMpC4/Wc2zWnJmTIAF98XPrh3emz2OHjbipRq7SIvpjA2GXV
	YulVVpu3ioz76uuMvlLWckHIuPprpsde1caAu9HIaDUm1mXYBYqfjDloO9YT40UFFpgAVRxUzLu
	Ub12NM5DiTE+quvpyEqDstUkHaBafTyP6jKcNW7kjH6af64InrLkhC36RXLQI5uBGCkJvEG/Hfv
	YLjF5WHAIopHxuvA5I6TLR+BYHM2cgHIyiLxrMCbvYVkbLYKMYjI3zvdGlIWdszSQGwdLPLJd4G
	KBCfONSk9TDF3CV+TSYu/u0D26mwThyUx9NSqBIS0gC+4QA4Mly8jp3C63gOxOQ8ydNCBDqhe2W
	gLY45latGhT0hB0SGgUArCms1l16WCS8uUyq7Vl6y+bQZ2hxHdPkzft8/6jx+52Zotj8ivqhwj9
	9wGm6s4utyMKvxhNudaG+j8PkwENehzV/IEFP3+eTtTsddXODAUDVLWxqneVaaSg==
X-Received: by 2002:a05:620a:1a0a:b0:8b9:fa6f:7e8d with SMTP id af79cd13be357-8cb4c039d7bmr1464135385a.84.1771354046860;
        Tue, 17 Feb 2026 10:47:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971cc7a8dbsm25648156d6.2.2026.02.17.10.47.26
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2026 10:47:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c881d0c617so2780785285a.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 10:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771354046; x=1771958846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bsx/C/z6cBL786ltmFv1u8SmaC8UkSjwOZGPBi68EIc=;
        b=dm5U4vKcfZYbh1g+yIGUBgcoDGP/xvJXlz4UMcMOk5PYjfhcrdmwoGiLaYLp3GhOFz
         BFcvkJelIoZCpMZBbae47l47U/Pr6+dnY+xBil520jmev5FB9rcwB3W8QubC84V06Dj0
         SLLg7WM3CjFsnrq5yKhwjvZkHpqGZFtms+VBQ=
X-Forwarded-Encrypted: i=1; AJvYcCWEeyHVfmUtyG3ycJTkrQEU849SvpAGwTkkUQg+aDnUfAnvDf9bYNZC+/keTZwD56v5wjJtZ+fS1HM=@vger.kernel.org
X-Received: by 2002:a05:620a:1711:b0:8ca:457f:a1f with SMTP id af79cd13be357-8cb4c03c2acmr1626746385a.90.1771354045924;
        Tue, 17 Feb 2026 10:47:25 -0800 (PST)
X-Received: by 2002:a05:620a:1711:b0:8ca:457f:a1f with SMTP id af79cd13be357-8cb4c03c2acmr1626743185a.90.1771354045401;
        Tue, 17 Feb 2026 10:47:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0ce73fsm1714775685a.11.2026.02.17.10.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 10:47:24 -0800 (PST)
Message-ID: <dd8c6277-9ca0-4d9f-88bb-362c5b96843b@broadcom.com>
Date: Tue, 17 Feb 2026 10:47:22 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-brcmstb: use correct register offset for V1
 pin_sel restore
To: Kamal Dasu <kamal.dasu@broadcom.com>, adrian.hunter@intel.com,
 ulf.hansson@linaro.org, florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260216191543.2514647-1-kamal.dasu@broadcom.com>
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
In-Reply-To: <20260216191543.2514647-1-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 2/16/26 11:15, Kamal Dasu wrote:
> The restore path for SDIO_CFG_CORE_V1 was incorrectly using
> SDIO_CFG_SD_PIN_SEL (offset 0x44) instead of SDIO_CFG_V1_SD_PIN_SEL
> (offset 0x54), causing the wrong register to be written on resume.
> The save path already uses the correct V1-specific offset. This
> affects BCM7445 and BCM72116 platforms which use the V1 config core.
> 
> Fixes: b7e614802e3f ("mmc: sdhci-brcmstb: save and restore registers during PM")
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Late to the party but:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


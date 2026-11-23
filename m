Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462335;
	b=cYBmOEc9BQ41HNxOMHRlSYUBAufusvyvkgYIsrlLEQR8olNJ8vsBpDnYzBHycyl6wfoK
	 sjbHetCNiGNRdl2nKLSRGNYxRM9+qJsW3TAZgdr4SeC6uO8zkXKWhtmTabKM6SwtcmCcy
	 9i/7BKmKCA5SPctMgrW8879RBOBjX8JSff8vPOVItm1hQcKgpddByEwXlYeD5cdBl+RTH
	 jfyX02BAOkKPsSjN3fkloMXE4m1C2omnLD9xFjZkdmd+5vXyJiHzuu6umF+CeWF/E2Taq
	 7DK5oiYk0MFUjn9OARREFdaQ8twhkC5Vz9mARxg78NdON0Mhn/f2xqEsM5yQZQtkbFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462335;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=ZhoRZJWv5WDLgSJ4NW+wzm1D4iqQUFLyqGAdX1OGoBc=;
	b=S6D0P/Sm7M4vyC9fq051BVrdHnLU1dH6/K3lvSje5dFx1k6ZaJmU2m3HbJ52cwmHmrcm
	 CZRTGjvHbVv5a+pT3sYc27S3LOXGiYR2WmEpxnKmvE2qsJFRwOoHwyywyui5f3dkgJJeP
	 WOngjY5p6wjQ/4hkx1m0et1vMDLG1PyMJ521K2htdRBb3yn0aTXcKMYq4NahK+Z5h9nz8
	 +NVq77v+u8e/5IDwK3gRu9g77DvaPCBKq2Bs83a2gGSWxm1Zv51tv8WXgtkisIaA6fCW6
	 NqMpStvYACBkjhVsu2lEYtC0uZdg3O0Flsq7HE3iDpwA7shyv45O21wfyG7DGLSWg9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=D8IR7l22;
	arc=none smtp.remote-ip=209.85.222.226
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9180606A31F
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 19:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9180606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=D8IR7l22
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-9497a167a6aso574669085a.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 11:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462334; x=1796067134;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZhoRZJWv5WDLgSJ4NW+wzm1D4iqQUFLyqGAdX1OGoBc=;
        b=zyCg1D7veg4kK7jt3ZoZkTmhOqgUZE0q4n53R61QU2nYsDuzcr2qF+3plBd8IUlYhA
         J2a9ZlWU0rkCIYPcq8cRQ2g1bCw+xrhOx6bRoY36kgMD1N7BSFWQ+HjXS+M6QlMoaPG1
         b0UlnIraUAe1nzloj4opgCjQJG64PYgwvadNmd2xT9ArdEpjQ7Yz+gsx3DgMHzPXjSwf
         91ZkwlwnE5xL4pKd5GMFflSQ8iyYoBlnTrxhz6zr6M7JrXHCzyB2tEW8jj3enr/NG9D9
         JRpZDpVGMAnDEY8zwsnO9EETZVmKAh6EnTcrAf9cuoMPPgMK/sbtCDGpgD0eTpu3hC1h
         Si5g==
X-Forwarded-Encrypted: i=1; AL+hErEMOJrl2xQ3dUg5WW6+WKEESnsQWLkH2W00uyJ3mfTLP5HUzDaVsaxSKNBW+TyEpPEDud6fSn+3inE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nuXJA0fsJOi//koGUNGhCHxYQ7gZWx11XpE913RH3yKkRIEPS
	exZjTbcYFOxoWyXpwGQyYN7aEIJO/8f2Vguv2X6ErFcXKcx9fWjWR+w5HGYodCEgKy+uOhW8avq
	RnLvxXZAIWebSZcXRaAHYEZcXWFWZBWfMUuitHBZjnUTsV7faXwS1W6VhvXvJwJUpGftmmRqeiH
	g/rW2lL5UajuoW3uH8zMeKNYr53WszaLOfxEBPMYv4P9r76TtolXbVkpGRtDc6Y9H2jJ7h5WLWm
	CkocbRJc7L4PsWlskpo
X-Gm-Gg: AZFdTZeMDxWn3iWpLTmEKMT5ctQfxa/eYz+mQcbx5VQvcvEQV/Zo9CPUz6DtZ1S8E5R
	nhLR3pxz72RGlsapacX7WYhzTJfrQdCTdcIPH4njv0DPD/Mivu70akVkQNGL0xRGb3r4erHZHjg
	AoY3HbDHxpP12rKZx1Zpg2U/v20wOK1Wq+8QqNpum7qEshs3xjnGwpuxMlYqmhX8ZwbM44+fl8J
	6vVmTWiu461/JgVW/cvNs4XdNZJSsLwdeXSeAAQ929cuycf9KcLGh2oDL09rzHX7ST9nX6Fy8wa
	kNVve+HX/luKLpS1tqcSAg09PJR/sS+mD6ziIXcNf1lbPAvZjIb0im+L0UJYZSSJzHEvrwWB2U1
	ZM9S6abRV9mb1XFWk8Mu+fcVRFu954YWk7wQ1Fa6ok5U3wfuprt+79Eq7MJR23QxyaolmUJ8/4B
	8nenI3O3+IgGyx52SaX4bRpp2U8m2WVJeLiZGYagt/
X-Received: by 2002:a05:620a:4720:b0:93a:1196:ce5 with SMTP id af79cd13be357-949b362497emr2264680985a.33.1795462333539;
        Mon, 23 Nov 2026 11:32:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-949baed3b2asm70725685a.0.2026.11.23.11.32.12
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:32:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3817a0ffd5eso4542602eec.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795462332; x=1796067132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhoRZJWv5WDLgSJ4NW+wzm1D4iqQUFLyqGAdX1OGoBc=;
        b=D8IR7l226jkbPt2XLGzFEHKpeTcJaBjbSqQsPqZ4b+DQwih2VLzrUFRMbRraJLMovl
         HQiaquV5UJtPt5sWGhLWFQKjTH1xYDbOJ9fl76z0bqCCbgp/epo72Jc1kJY/iT4nkJj4
         bltyeyFPizUCr+Qnt1NacASIfizPqZyw+2iWY=
X-Forwarded-Encrypted: i=1; AL+hErFiYtDGVJoS9h9Km8JPWU+p8F95FjWzFvsQBaMTIGLOvRi4yAfHxgnM32f3dq1bMe+Xxw+MmXpCMW8=@vger.kernel.org
X-Received: by 2002:a05:701b:4550:10b0:1b5:337a:6456 with SMTP id a92af1059eb24-1b55247eff6mr12630857c88.5.1795462331722;
        Mon, 23 Nov 2026 11:32:11 -0800 (PST)
X-Received: by 2002:a05:701b:4550:10b0:1b5:337a:6456 with SMTP id a92af1059eb24-1b55247eff6mr12630821c88.5.1795462330903;
        Mon, 23 Nov 2026 11:32:10 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm42340205c88.14.2026.11.23.11.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:32:10 -0800 (PST)
Message-ID: <60b6bd4a-c508-44e2-ae22-3f8bcc594457@broadcom.com>
Date: Mon, 23 Nov 2026 11:31:49 -0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] mmc: sdhci-brcmstb: Handle absent optional
 sdio_freq clock in probe
To: Lee Jones <lee@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261123191703.179283-1-lee@kernel.org>
 <20261123191703.179283-14-lee@kernel.org>
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
In-Reply-To: <20261123191703.179283-14-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/23/2026 11:15 AM, Lee Jones wrote:
> Standard MMC Device Tree nodes may specify "clock-frequency" on SoCs
> that do not provide the optional 72116B0 "sdio_freq" clock, in which
> case devm_clk_get_optional() legitimately returns NULL.  However,
> sdhci_brcmstb_probe() only checks IS_ERR(base_clk): when base_clk is
> NULL, clk_get_rate(base_clk) evaluates to 0 and overwrites
> SDHCI_CLOCK_V3_BASE_MASK in host->caps with 0 MHz while leaving
> priv->base_freq_hz non-zero for system resume.
> 
> Check IS_ERR_OR_NULL(base_clk) and clear priv->base_freq_hz on the
> fallback path before jumping to add_host.
> 
> Fixes: 97904a59855c ("mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0")
> Closes: https://sashiko.dev/#/bug/linux-88799a75-1ece-4f9d-bdab-eeb713627ab2
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Not sure this deserves a Fixes: tag.
-- 
Florian


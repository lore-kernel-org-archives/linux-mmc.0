Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0F315D33
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925317; cv=none; b=Ag58DChRQqnVjQrKk1gQaalPPttbGPK06Um87W3VYf2bU8ngmRfaFjQojkXWTEjK7Pofw+INaS5jmo3QX5mxQ/g42PaLrI0oUVnZj7JR/Klv5+KcmXtNe4Qmnn81TzkF4IiA17KiBuKmLAsqq2YC0VMycvGpz7ZWny4slwAQEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925317; c=relaxed/simple;
	bh=jS/81g50QX1pwl3mCuVBsyIxC6RqiiAm1chmDMbCihQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YMVPcSlvKNEPt3lUx/3yLchuj0+1raGopEso6suQiw3ijvHquLmGynZrSzwUKEeF2SqcR9DnOOF76kAutAyQ0iWLKxXIg2AUesut+qt+sAW1LreXqr3Xzd/ntNZ1GMOmiJ1a7TJB+Jnzm+jOYNjJiMLCu161tIgHmHmz7zAAYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ad7yFIc5; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ad7yFIc5"
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-961556c15ceso2744463241.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 16:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779925314; x=1780530114;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Mv6i6uMQFt+ebplIQhhXFo6hUBIl29bTG6d6cReoRs=;
        b=P4irHNYX+6QNBBhJVUDchK9ZiJXekb32+Jcq9FIhFC5ndhBQTH0z+ou1JtvGflli8/
         N90nKdY5860sH06qL2kX+ekIUxjIOIWBb32T4xCCV78hjKtwX+PcvL0cUAhk27mQRC8o
         adibfe1BZvPLCYYOHi2wHx3ofIeTkLX+dC/R7DvsUKoiM7Rhj2livV5uwE0NxCo6VzIb
         Z865D1SFoJLtquN3umxb6WGdBb0r4dPB/AHoQSspXlQ6m/vQcNKTGpUjwtPUPx75wQqR
         ZcW6D2ma+1r/czo2TXVo4lloHqDsrKZxQFY+GJJyR6OsmdaktHZBwsx5Uo3Z8sV0t+uo
         hiow==
X-Forwarded-Encrypted: i=1; AFNElJ/5qo3gQ+koRecVC+mUDIS61j3Vmz3huNIhbDdOWIFz5Xqx8Q69OWvkG6HVk9lydnE83e5oKHw62ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7aS/PYVtguCK2JfWNWiPVSDvp0/k8Jw+9QkpvDwbdzBCckecG
	97OZDTZgtx82qhTe+ve0jODuHRmkxhxlMm3gy6eHz4E25uiXVxPR5z7thoANISEZQEw/S/ElTFD
	w8oNtJ6UbEmyo/JnI9L2HvctM6K1bq8JcAAdoCJ6vvuXvFp6Oe0tWQ7trOU+jqs02IJULjQDVAs
	tGHZ//uRNGuL525hGvKIkZMWNcJ0TRYwfgX98ZuEH83THkYyhYaaBRMMDnxFJA2RlvlJmp0dsy2
	QrVSDYwrIGMbanjjM8m
X-Gm-Gg: Acq92OGTRYWvgQ4/V2OkI1XPz7kTkgDsDLwkQAN5R0vS4ckpkMvBX5aWn4puNgbu2cf
	jLTLAsDr1eDVCEpOe9Qow3CBd8pSt32SioyApevD03GjYWvLOqpp5bX+BYvsbYhclak/kpP3HZV
	FOHj7fBz1oJ560WXtzAy7O4NsRT2JwQkuoMS//MepCnl6IC0QqUY+SFuEs43Uq+mRnqlFnWuA95
	ZzZa3U6OVAh7NalUtQDKaMlUwFE/OLVvWl9u5nEFe5lzOYqd2T0YpxoApNs96n1AMlEtsMkDm4E
	MQG6Kz3K73YSqx2mdQLN0o7+wvrKzRe/0R3ymTbfzxZHPWeczo3p/yBxTn8fQ92h7QtxrztE1qq
	QHm9ZSAu8e81ZujzC/vezsHE+OOsuBnb31hK08jqmNqM9XZj+wplg/ViC3oQ5iqv5ZNjYoQ8EZJ
	6rGbMeReZRGCRprcfkyeEdP6OicRnNDFeleER0XSY0HGLiJ474LHUktGItmdLGKNN9UdnCcL9Y1
	lM=
X-Received: by 2002:a05:6102:2b8c:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-67c8398fa78mr11609066137.22.1779925314319;
        Wed, 27 May 2026 16:41:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-67ff5f18c89sm1180108137.20.2026.05.27.16.41.54
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2026 16:41:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-90fb4c8390aso1225612885a.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779925314; x=1780530114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mv6i6uMQFt+ebplIQhhXFo6hUBIl29bTG6d6cReoRs=;
        b=ad7yFIc5KGK3fLmTSUa+wyJrKPjDIYns7g01wsjcd16rbOH9Ov/xxcqm1xTTz0d+Lq
         aoTxTDaImjzmr43Mv01rKh3lRQCB7Tqj40gHCuX4F+493mf9DMngbgszwGYh32L2tnss
         AxEfA3cj5Hv2pxemwbtGwapdgKf0a8OVE5TFI=
X-Forwarded-Encrypted: i=1; AFNElJ/dpjKnQk1r5lE2Bhu+w2Yb2rx/H6D/b/EHkHN3MHEjFCIiyFHtNNoJ/zzEx5h/Y855rDAuzGoCo6k=@vger.kernel.org
X-Received: by 2002:a05:620a:2955:b0:914:c01e:6f82 with SMTP id af79cd13be357-914c01e7f27mr3159227485a.21.1779925313582;
        Wed, 27 May 2026 16:41:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2955:b0:914:c01e:6f82 with SMTP id af79cd13be357-914c01e7f27mr3159223985a.21.1779925313082;
        Wed, 27 May 2026 16:41:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e8e1esm627408285a.7.2026.05.27.16.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 16:41:52 -0700 (PDT)
Message-ID: <fff11e26-9c50-4a99-bd63-47b10687fd38@broadcom.com>
Date: Wed, 27 May 2026 16:41:49 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after
 SLEEP
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Avri Altman <avri.altman@sandisk.com>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Erick Shepherd <erick.shepherd@ni.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
 <linux-mmc@vger.kernel.org>
References: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
 <CAPDyKFooAH=Z2BEHq08Fu03uidgjuaDbwM-Y3Y3Xa8STV+ODzg@mail.gmail.com>
 <1d583be4-b1cd-4226-bdbe-5ebd275de9c2@broadcom.com>
 <CAPDyKFopEbm6z2-AVmPQr5csofNew2nWpzGyTdBK24w+5YD-PQ@mail.gmail.com>
 <915473f9-64bc-4630-9c82-41fcf4401042@broadcom.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <915473f9-64bc-4630-9c82-41fcf4401042@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/18/26 20:27, Florian Fainelli wrote:
> On 5/12/26 06:33, Ulf Hansson wrote:
>> On Mon, 11 May 2026 at 18:01, Florian Fainelli
>> <florian.fainelli@broadcom.com> wrote:
>>>
>>> On 5/11/26 07:18, Ulf Hansson wrote:
>>>> On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
>>>> <florian.fainelli@broadcom.com> wrote:
>>>>>
>>>>> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending 
>>>>> CMD0
>>>>> which prevents the system from properly resuming from S3 warm boot 
>>>>> where
>>>>> the eMMC is necessary to pull in the boot components.
>>>>
>>>> Is the bug confirmed by Kioxia?
>>>
>>> We've been going back and forth with them without much progress as far
>>> as a resolution goes. Since there was no progress and I would like to
>>> get this included in downstream kernels at some point, this was 
>>> submitted.
>>>
>>>>
>>>> If not, can you explain a bit more what is actually happening during
>>>> system resume?
>>>
>>> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mode.
>>> When our systems resume, one of our hardware cores driving the eMMC (HIF
>>> block) in command mode will send a CMD0 command for the eMMC device to
>>
>> Is the CMD0 sent solely by HW/FW before the mmc core executes
>> _mmc_resume() during system resume?
> 
> That is correct. The sequence basically goes like this: HW sends CMD0, 
> then FW pulls in boot code, identifies this is a Suspend to DRAM, does 
> its steps, and eventually Linux resumes and calls _mmc_resume().
> 
>>
>>> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than the
>>> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block does
>>
>> Can you please clarify what tSLEEP_EXIT refers to? Are you referring
>> to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?
> 
> Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.
> 
>>
>> Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
>> optimistic to me.
> 
> Fair enough, but AFAIR we wait up to 30ms before declaring a timeout, 
> every other vendor we have seen exits and acknowledges boot within 
> 1-10ms at most. Similarly if the device is not in SLEEP, then it 
> acknowledges boot within 1ms.
> 
>>
>>> not see the Boot ACK pattern in time and does not service the read
>>> request from the processor that wanted to read from eMMC, we get a reset
>>> of the system, rather than continue booting.
>>>
>>> When SLEEP is not enabled, the eMMC device responds within tSLEEP_EXIT
>>> as advertised and we don't have that problem.
>>
>> Okay, I see.
>>
>> In this regard, it's important to understand for me how the mmc host
>> driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
>> mmc_power_off() from _mmc_suspend()?
>>
>> Does this turn off any of these regulators or what happens to them
>> during system suspend?
> 
> We don't have software controlled regulators for VCC and VCCQ and our 
> reference boards using that specific eMMC device keep it powered on 
> through suspend-to-DRAM. This is the very reason why if it stays in 
> sleep mode, powered on, and then we attempt to boot from eMMC we have 
> this issue.
> 
>>
>>>
>>> So I suppose I could reformulate the commit message and give some more
>>> details here if you would like?
>>
>> Yes, but let's discuss a bit more first.

Ulf, did you want me to re-submit with that kind of detail added to the 
commit message? Also since this is a bit specific to our devices, did 
you need me to scope the fixup to the ARCH_BRCMSTB platforms somehow?

Thanks!
-- 
Florian

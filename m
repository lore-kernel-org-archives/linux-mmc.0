Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215C1A317D
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161246; cv=none; b=bmrUwBPtG4h7SNGbJtDG6kezIv69MqsnGUgLiHNfwbbcIeO/GzUxiLjbQ9tV8LMAyjNp46SVrtk+OQteL0vkNuRk5tGBm87+5STMXpyzqIy+DqkM5vUK8+RBKwtXLm7nNsJVlhSYYTd/iS6mkc168EsYdNwCDRfzhnkKpl0g87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161246; c=relaxed/simple;
	bh=mckvljpkiZyv32diFnBL4b8wxgvOgAIMyZwIM9ldMeI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SJEYNHZSRgQG+BhTlz6fUhVGIvvJ9Dnw1WG0ZHZ+e38ClUPKaD8XO0YcF08+tbqzlgo0LEKmQs1P8TWHWCaNd+SKhhaYwLacR4bUyz90/LCqUJCIy/4EsfQ8x29d4bmxenV8ilPXoa8Er8CBSuF522er8Zx7qzpJCet6vT0cjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N/bMRO/a; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N/bMRO/a"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-57513ac61f0so845107e0c.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 20:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779161244; x=1779766044;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQGt4mWhMMY7Z1K5w6wcjOVSnTfzObwojs+LR6HJAMY=;
        b=jZAKghanjneFDgaH3qOjcYImYv01YhoX4yn8x4MYzQ84qz80/zlriPa7WhWUAVL4kN
         Pix7fXzRK1QK1paUkdQwksxckn+ndCuZH4M3BzHwV1CWeYWubUJFnEdKRcJ7PwEd942a
         +3gEqjVJIDMa6VXeas9oX74vK2X2zc4+3PKHnRLVAIYVfNpsiOjztIkrNfywH3Dh+3FC
         Xjer+GDjmo5wntj/C8Wfa3r5ogP9x78fzgbqFufoq/s688QRFbmmWLhfN/oXzzvbyu9h
         znZG4XL1ZVoDNSK2UaCODrjoiNIaHBfRJVoMvJ679zKDe8N+CJ+9xCmWM/wPAA7sjnLM
         K+vA==
X-Forwarded-Encrypted: i=1; AFNElJ/0nl/Gsynd36BCfsSabqO1MtVCR5ILhSWorkB5Bgjd2VnTGyc57vWG/skq7hCCZ6RxdwQ/+fHsz14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZTdoVsDdSvPj1BooQAVji6bFW5CEQ0eJdVkeOzwmEsxCIMix
	Kd/TtQJYPm7homTaUDdvsD0+mseJnR4nZZXVBvqZy7MxvcdBLoQqtq12kJA+QCn5q4kugplPprx
	XzN7GQRJr7AWotQbiHx1lrproF2X+4SjAMV0lXpPwkE7JSwpVSiFg3R3ywAjrsUrOdcXmUeuTih
	iSidkPsSN2/ZjR1YlDqnfsK6+CcCwNASEvtrzmILtQ8IsZ6YZ16QEH4wcprqoi7MYm2Xg20JrfE
	gjlOTrhf7dKROa942fJ
X-Gm-Gg: Acq92OEbqKKbbkcc1d/YehU624DFSqZ1142b4dneECJ7TFpAPsBFeG1Jd8jWu3Ir8Wp
	efzs96uXh5ArVrSih2cI6G1oyOWuQEAfywu494e6uI/HF3SgVoCtJ+WKqlInG2swI+X10Ng6FhJ
	8oQI9VTHjgyjPye9YpHSIUE0HP/UgZsdobPGu7YnQGZNRDufbWMLnDo4eeQDEtEualjWEuoYkpO
	GcC92mf6bdg0DsvERWUY0hqWIPoCLFrNstQc7wX3PI7XOwuNPKeolJ33h4MXOIFRHwkaG7/KVBh
	Q+f/UHnOkXnN2KuPTer9N4aR+0hENv0a6rTuhrF4lGBvUSxjBQpyqw4Y1xcHjlSGHN7/N/KTFg2
	Al/CV3NBiQ4ZP0UPh8mUuK+OEHTiOia9U+lp6JEv3UdsqhUAlQmTP3JUaiQsolc/hz6CCH8YLQ1
	T86qbO45CyGh4BI4sLJFS0DjOwyFJffJMx28hfMfCMrDcXRSXoY6xX6ceT4MM+xg==
X-Received: by 2002:a05:6122:3412:b0:575:33d4:d100 with SMTP id 71dfb90a1353d-5760c08e3b6mr10321607e0c.13.1779161243654;
        Mon, 18 May 2026 20:27:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5760f5745bdsm934543e0c.1.2026.05.18.20.27.22
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 20:27:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-303b38ec2f6so4198396eec.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 20:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779161241; x=1779766041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jQGt4mWhMMY7Z1K5w6wcjOVSnTfzObwojs+LR6HJAMY=;
        b=N/bMRO/aAXqkVAWFHUTua4PomDrQNUIXjaIluAfb5ecptmlD6gZ1zMWcgCHsO1xtwu
         AK/tAjrJ2ZfCYzLl9PRMReXTbtqlXwc9N9sif3ff+cOhU4ZOBFaE09tfzHRPhLJEiOwx
         Tjkui36OLdV4AFgpmHZou7fw2A3knsJ/F11Z4=
X-Forwarded-Encrypted: i=1; AFNElJ9XYccpiuG57LBOeOw0g5hNAVBa/y+L/HMhwe8PkNrXzS+2D6HgrfvkRqR4p2RnkzMDUYrjjL8+9IY=@vger.kernel.org
X-Received: by 2002:a05:7301:2907:b0:2d3:2983:c87c with SMTP id 5a478bee46e88-303981710b6mr8062995eec.1.1779161241534;
        Mon, 18 May 2026 20:27:21 -0700 (PDT)
X-Received: by 2002:a05:7301:2907:b0:2d3:2983:c87c with SMTP id 5a478bee46e88-303981710b6mr8062973eec.1.1779161240920;
        Mon, 18 May 2026 20:27:20 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm15047859eec.12.2026.05.18.20.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 20:27:20 -0700 (PDT)
Message-ID: <915473f9-64bc-4630-9c82-41fcf4401042@broadcom.com>
Date: Mon, 18 May 2026 20:27:18 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after
 SLEEP
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
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
Content-Language: en-US
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
In-Reply-To: <CAPDyKFopEbm6z2-AVmPQr5csofNew2nWpzGyTdBK24w+5YD-PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/12/26 06:33, Ulf Hansson wrote:
> On Mon, 11 May 2026 at 18:01, Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 5/11/26 07:18, Ulf Hansson wrote:
>>> On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
>>> <florian.fainelli@broadcom.com> wrote:
>>>>
>>>> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending CMD0
>>>> which prevents the system from properly resuming from S3 warm boot where
>>>> the eMMC is necessary to pull in the boot components.
>>>
>>> Is the bug confirmed by Kioxia?
>>
>> We've been going back and forth with them without much progress as far
>> as a resolution goes. Since there was no progress and I would like to
>> get this included in downstream kernels at some point, this was submitted.
>>
>>>
>>> If not, can you explain a bit more what is actually happening during
>>> system resume?
>>
>> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mode.
>> When our systems resume, one of our hardware cores driving the eMMC (HIF
>> block) in command mode will send a CMD0 command for the eMMC device to
> 
> Is the CMD0 sent solely by HW/FW before the mmc core executes
> _mmc_resume() during system resume?

That is correct. The sequence basically goes like this: HW sends CMD0, 
then FW pulls in boot code, identifies this is a Suspend to DRAM, does 
its steps, and eventually Linux resumes and calls _mmc_resume().

> 
>> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than the
>> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block does
> 
> Can you please clarify what tSLEEP_EXIT refers to? Are you referring
> to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?

Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.

> 
> Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
> optimistic to me.

Fair enough, but AFAIR we wait up to 30ms before declaring a timeout, 
every other vendor we have seen exits and acknowledges boot within 
1-10ms at most. Similarly if the device is not in SLEEP, then it 
acknowledges boot within 1ms.

> 
>> not see the Boot ACK pattern in time and does not service the read
>> request from the processor that wanted to read from eMMC, we get a reset
>> of the system, rather than continue booting.
>>
>> When SLEEP is not enabled, the eMMC device responds within tSLEEP_EXIT
>> as advertised and we don't have that problem.
> 
> Okay, I see.
> 
> In this regard, it's important to understand for me how the mmc host
> driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
> mmc_power_off() from _mmc_suspend()?
> 
> Does this turn off any of these regulators or what happens to them
> during system suspend?

We don't have software controlled regulators for VCC and VCCQ and our 
reference boards using that specific eMMC device keep it powered on 
through suspend-to-DRAM. This is the very reason why if it stays in 
sleep mode, powered on, and then we attempt to boot from eMMC we have 
this issue.

> 
>>
>> So I suppose I could reformulate the commit message and give some more
>> details here if you would like?
> 
> Yes, but let's discuss a bit more first.
> 
> Kind regards
> Uffe


-- 
Florian

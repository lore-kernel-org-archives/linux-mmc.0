Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A13EDAB8
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778225; cv=none; b=GGxStw4J+o/URN8jlDQVnZhf2Ey4biVNFVIucMmBhL1Sxd6AkNxtmh/qqMj2Yj+R1IP4T5v0oiBgvwt6CDKRxohQeG0h/nP/DraI1gstddBOq+c9CidbsYJ2WgtLlzmoP0ic52d9MLvSiSafPTup8X/g6+OqCbP4muNGqGWe/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778225; c=relaxed/simple;
	bh=g5QV0DNJ0M38lfQ4M6JFCCPyPsTkOYXBJoCJm17U7DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+R/0ggDSfxe6XsLmRd/mgGjHy8RTKeMAHyVdQVqbydRk0sqB31TabfdeTozpCrUZAsDmNZdCalLkkquGSXDf5BkxrUmBxlH1BfgqWNPm8R5JehWocPFiu5wl/lXLzvBoZJvCv6jIpqJ4qF4W3Qz9mzPqTX4XKCjFGhtjZ1m1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BlIK3DNr; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BlIK3DNr"
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-30bd7f4fdffso755696eec.1
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 03:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778215; x=1782383015;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lM1uM7r315pMC+4nrsi/s6l4due5nJ2aAzSq6CW0dg0=;
        b=MFuGzBogVBQPHO1zctNxkOWbm7FAKn4MuxRhk2cYjQNUP++cR4zicIE7in1PBO4f8c
         3h9fsK5mIBq5r35RgST4VsDzDya6eKetNM76lwVGZDJXaFO/WI7cFCm527WCPD6Os8X4
         A3wekVBpMkJcipT0uTNNxvdf+xqNv3YPxgSykEa+gQk5Lj3grrn1L47F2I39IV4x5bNg
         3XnL8+zg4VkM+MPseBJJSt872F3VypGsEfzSl6x3AcQT+rOIVqe6DsSImNmtRMCBe6Hy
         8cqKL/aGzEQbAoQUHFIT9Jkq80yW+s95rXPiKM+6eBtvS/MqjR27LiTfdV0Ed0ZWsbss
         snQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8dyzC2uv4wRHUnMPjfoJlJprwAU/ahBfZHkIIigFo1Uyyp4UUoBfr0VeNF70RcS6gh+BUcyb0MwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsYCMzV2sTCFTf78AYUb03LkMwbgS0X2LSbazCW8fu5QhvkNKq
	li/gkq4ELTNqkuaAmbCB76D8smk5d7zmHaatVZ3TOEnrcMN+C3HfVsU0otd7EA7yN6qNZnu5UX/
	D/xyYyjBCZtyxelivx4/eJ7U05wXvUlaYRKfFug4B351SslTcdNjKbPLWAFBqof72aSDiusZZjQ
	c45BLx0E/Fi/Rix0F2+wkOBerMqe1D0Qnv+iYgYdM4Mxyh7i90VIZUi3ZA8AuD6ACWM6nWBmCt7
	s9KNTkw7re3G0PhdeyUusE=
X-Gm-Gg: AfdE7cnLLOjbGNeXXCRcJ2NSfxbsxYNtMI8NM72Zo6zzIRGst6H68Y6KjhFHfK9tL8I
	ssm3XFHBAuWL89FWMHIfJSnnNwNKMROdIonGJ9wmA7d+4olqFurQk3YSBPBdqevEYiyUjOqzKwL
	iCxnac0P4+IG8yWSBC+IInDg7zOQov93X6VwJgh9WBHEt6CNper0fbamzXSRHezJjOnm8OhzeSt
	fnuZNTvnJyJmnCym3UJaxrfTxK/zKMOuRcWqhVQxUcrbM0DhrX1W9LONBtuIl3Is2bFV94kJ31p
	O60XlZDIdH+QoiAw/P02TI7C9xlJippobpM+yDk9Bg51leIUGXyJnJQFtTIQaBRv3u/ItpI3Qd9
	JRJaUeE3BsCXJrjCswraJUHOuw3FHxw2nFDilXhfu8uKnOE1qIEJosVHR5u9Fmw1HBGIcHcUIg0
	C0260xH4YJC5fwPgL+ES7/VKIgMRZpBXhdsKoUp82LT4xRRfUphdY=
X-Received: by 2002:a05:693c:6392:20b0:30b:d79c:e1d9 with SMTP id 5a478bee46e88-30bd79d67dfmr2227961eec.30.1781778215032;
        Thu, 18 Jun 2026 03:23:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-30bfea465e1sm16616eec.9.2026.06.18.03.23.33
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:23:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-462c4593a33so587677f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781778212; x=1782383012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lM1uM7r315pMC+4nrsi/s6l4due5nJ2aAzSq6CW0dg0=;
        b=BlIK3DNrkkXPOkPfLWDLvidLPlhEjLLLzzugGJQdupIbus+/oV/rjX1E38leJSmIq+
         GpAa7mSgevhNI8z5qJYrcZ0YFZ8gnV5yJAmu71CLbDXD08U3u5hfQ5eMqig1wCxRpPm3
         O757ljkJdaEMNXLEbaIQsorATeNhoDI7D5wRg=
X-Forwarded-Encrypted: i=1; AFNElJ+rC1k8xySXXXFC4p7pCruwf7n+Qd8qi4LjvOt2/PoEX/vZ71bxuKynZQeT5FmyBEc2B42O7YV0pcE=@vger.kernel.org
X-Received: by 2002:a5d:6285:0:b0:461:a159:48e9 with SMTP id ffacd0b85a97d-4623fd872bamr10398788f8f.17.1781778211560;
        Thu, 18 Jun 2026 03:23:31 -0700 (PDT)
X-Received: by 2002:a5d:6285:0:b0:461:a159:48e9 with SMTP id ffacd0b85a97d-4623fd872bamr10398714f8f.17.1781778210909;
        Thu, 18 Jun 2026 03:23:30 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b1056sm61664653f8f.18.2026.06.18.03.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:23:29 -0700 (PDT)
Message-ID: <487cf4a4-218c-4a6c-8eed-a4ab170f01c6@broadcom.com>
Date: Thu, 18 Jun 2026 11:23:24 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after
 SLEEP
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>,
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
 <CAPx+jO-qQ25-BDnFmCDf+WYpKPHATJjSDMEz=8Wh7pAFdv0v5A@mail.gmail.com>
 <CAKekbescGNw_HjyAOizDz0ZTBTrOCV6=DC_kyQD2vd917HR=SQ@mail.gmail.com>
 <CAPx+jO9-WOUib2Px9e7UZ8urKEhi=OXPurvMZ-fZjYsJSoRw-g@mail.gmail.com>
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
In-Reply-To: <CAPx+jO9-WOUib2Px9e7UZ8urKEhi=OXPurvMZ-fZjYsJSoRw-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 6/17/2026 2:49 AM, Ulf Hansson wrote:
> On Tue, Jun 16, 2026 at 8:58 PM Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>>
>>
>>
>> On Thu, Jun 11, 2026 at 5:53 PM Ulf Hansson <ulf.hansson@oss.qualcomm.com> wrote:
>>>
>>> On Tue, May 19, 2026 at 5:27 AM Florian Fainelli
>>> <florian.fainelli@broadcom.com> wrote:
>>>>
>>>> On 5/12/26 06:33, Ulf Hansson wrote:
>>>>> On Mon, 11 May 2026 at 18:01, Florian Fainelli
>>>>> <florian.fainelli@broadcom.com> wrote:
>>>>>>
>>>>>> On 5/11/26 07:18, Ulf Hansson wrote:
>>>>>>> On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
>>>>>>> <florian.fainelli@broadcom.com> wrote:
>>>>>>>>
>>>>>>>> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending CMD0
>>>>>>>> which prevents the system from properly resuming from S3 warm boot where
>>>>>>>> the eMMC is necessary to pull in the boot components.
>>>>>>>
>>>>>>> Is the bug confirmed by Kioxia?
>>>>>>
>>>>>> We've been going back and forth with them without much progress as far
>>>>>> as a resolution goes. Since there was no progress and I would like to
>>>>>> get this included in downstream kernels at some point, this was submitted.
>>>>>>
>>>>>>>
>>>>>>> If not, can you explain a bit more what is actually happening during
>>>>>>> system resume?
>>>>>>
>>>>>> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mode.
>>>>>> When our systems resume, one of our hardware cores driving the eMMC (HIF
>>>>>> block) in command mode will send a CMD0 command for the eMMC device to
>>>>>
>>>>> Is the CMD0 sent solely by HW/FW before the mmc core executes
>>>>> _mmc_resume() during system resume?
>>>>
>>>> That is correct. The sequence basically goes like this: HW sends CMD0,
>>>> then FW pulls in boot code, identifies this is a Suspend to DRAM, does
>>>> its steps, and eventually Linux resumes and calls _mmc_resume().
>>>
>>> Okay, so it seems like this problem boils down to the fact that the FW
>>> decides to send a CMD0 command for no good reason at system resume.
>>> Unless I am missing a point here?
>>>
>> The JEDEC JESD84-B51 boot sequence is normative.
>> The host sends CMD0 (0xF0F0F0F0 / GO_PRE_IDLE_STATE) to enter pre-idle/boot mode
>> Broadcom mmc controller does not skip CMD0 and has no knowledge of the power
>> State that the kernel left the device; it runs before DRAM is initialized and before Linux resumes,
>> before any kernel state is accessible.
> 
> I understand the CMD0 generally works to wakeup/initialize the eMMC,
> but that isn't really sufficient.
> 
> Please, consider these scenarios:
> 1) If the kernel decides to turn off clocks/regulators (VCC/VCCQ) at
> suspend for the eMMC, then how does the FW know that it needs to
> restore these before sending CMD0?

If we had such capability on our board designs, then we would make sure 
that there is adequate power sequencing within the board design to 
guarantee that the eMMC device gets powered back on upon resuming from 
warm boot. We have a variety of signals that can be wired-OR to relevant 
discrete chips, or use an external PMIC to achieve that goal. Your point 
is well understood and valid in general, but not applicable in our case 
here.

> 2) At resume the kernel wants to wake up the eMMC by sending a CMD5
> (awake) instead of CMD0 (not implemented, but since it is faster we
> may decide to add this at some point). If the FW already sent CMD0, a
> CMD5 path would fail.

That assumes the kernel is the first entity involved in interfacing with 
the eMMC device, but that is not the case for us, see below.

> 
>>
>>
>>>
>>> The problem is that the FW doesn't know what low power state the
>>> kernel decided to put the eMMC device into at system suspend, hence it
>>> should really leave the decision to the kernel to wake up the eMMC at
>>> system resume.
>>>
>>> Would it be possible to fix the FW instead?

This is not an option for us, see below as to why.

>>>
>>>>
>>>>>
>>>>>> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than the
>>>>>> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block does
>>>>>
>>>>> Can you please clarify what tSLEEP_EXIT refers to? Are you referring
>>>>> to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?
>>>>
>>>> Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.
>>>>
>>>>>
>>>>> Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
>>>>> optimistic to me.
>>>>
>>>> Fair enough, but AFAIR we wait up to 30ms before declaring a timeout,
>>>> every other vendor we have seen exits and acknowledges boot within
>>>> 1-10ms at most. Similarly if the device is not in SLEEP, then it
>>>> acknowledges boot within 1ms.
>>>
>>> The S_A_TIMEOUT specifies the time the eMMC needs to complete the wake
>>> up from its sleep state.
>>>
>>> If the device isn't in sleep state but fully powered-on (as it seems
>>> to be what you have been playing with), the eMMC should just respond
>>> immediately as with any other command when the eMMC is in "TRAN"
>>> state. I assume that's why it works if we don't send the CMD5 (sleep)
>>> command at system suspend.
>>>
>>>>
>>>>>
>>>>>> not see the Boot ACK pattern in time and does not service the read
>>>>>> request from the processor that wanted to read from eMMC, we get a reset
>>>>>> of the system, rather than continue booting.
>>>>>>
>>>>>> When SLEEP is not enabled, the eMMC device responds within tSLEEP_EXIT
>>>>>> as advertised and we don't have that problem.
>>>>>
>>>>> Okay, I see.
>>>>>
>>>>> In this regard, it's important to understand for me how the mmc host
>>>>> driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
>>>>> mmc_power_off() from _mmc_suspend()?
>>>>>
>>>>> Does this turn off any of these regulators or what happens to them
>>>>> during system suspend?
>>>>
>>>> We don't have software controlled regulators for VCC and VCCQ and our
>>>> reference boards using that specific eMMC device keep it powered on
>>>> through suspend-to-DRAM. This is the very reason why if it stays in
>>>> sleep mode, powered on, and then we attempt to boot from eMMC we have
>>>> this issue.
>>>
>>> Okay, thanks for elaborating.
>>>
>>> So you are mixing the system suspend/resume scenarios with boot here.
>>> Is the problem for both?
>>>
>> No the problem only occurs when we suspend/resume if we put the device in suspend as per spec,
>> subsequent resume fails.
> 
> Okay, thanks for clarifying!
> 
>>
>>>
>>> I understand the timeout problem, but not why the FW needs to send the
>>> CMD0 to wake up the eMMC from system suspend. In regards to boot, that
>>> is an entirely different scenario.
>>>
>>
>> Vendor datasheets implementing JESD84-B51 quote from spec :
>> "In the Sleep state, the power consumption of the memory device is minimized.
>> In this state, the memory device reacts only to the commands RESET (CMD0 with
>> argument of either 0x00000000 or 0xF0F0F0F0 or H/W reset) and SLEEP/AWAKE
>> (CMD5). All other commands are ignored by the memory device."
> 
> Yes, that's correct but doesn't explain why the FW needs to send CMD0,
> rather than relying on the kernel to do it.

See below.

> 
>>
>>> Does the FW need to read something from the eMMC before the system
>>> resumes? Or that is just during boot?
>>
>>
>>    It's just booting up on resume and reads bootcode.
> 
> Would you mind elaborating what "reads bootcode" really means here? Is
> it reading data from the eMMC?

We have a boot ROM masked within the chip that interfaces with the Host 
Interface (HIF) controller which drives the eMMC in boot mode in order 
to allow the boot ROM code to pull in the subsequent boot components. If 
that first access fails because the eMMC device is still asleep then 
that boot ROM considers it a fatal error and will issue a chip reset. 
 From there on, this is no longer a warm boot, but now a cold boot 
because the reset reason changed. From a system architecture 
perspective, a warm boot is similar to a cold boot except:

- there is a reset controller bit indicating this is a wake-up from what 
we call S3, rather than a cold boot

- DDR contents are guaranteed to be preserved by having kept the 
supplies on, therefore we can restore SW/FW states

- there is additionally an on-chip memory RAM that can store persistent 
information, too

- first stage boot loader identifies the warm boot condition and then 
proceeds with restoring DRAM calibration parameters, and then hands off 
control to the remaining FW/SW running on the system. Eventually Linux 
resumes and can interface with the eMMC controller

> 
> To me, it looks like we may have two ways forward to fix this problem:
> 1) Fix the FW so it doesn't need to send the CMD0 at resume. If that
> is possible, this would be the best option.

That is not an option for us because the

> 2) Instruct the kernel to keep the eMMC powered on at suspend, while
> still doing a regular re-initialization of it at resume.

OK, so your angle is that we should not focus on the kernel sending the 
SLEEP command, but instead have a notion of "keep eMMC device 
always-on", which would also tentatively address a board design where we 
could turn off the eMMC device voltage regulators?
-- 
Florian


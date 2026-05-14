Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C5224FA
	for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778738199; cv=none; b=d20JQpmDv2QVKNXU+RiirXUx1Vn4z5QGjqGFsJOSxihOLPE6SG7X0c1uE8XRFW7zJ8he+60uL2ZAkiFySKRz7QXjx/y92L7Y4A5PLc4/MiGmA4Xy/dAgpAkPk2VrjMi455PWxMnPZMzi7c4+gBfqlaRXPl19ww6yrU09ZYHjCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778738199; c=relaxed/simple;
	bh=OyvyYG8eVOpfkcYx13oFyb0wTKeRoDELWFxoA5xkHBk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=t5eaPQkTBnEl9388CL9TuRfF+6k+AgD7pEgaugT5N54x0Yd/hPFioBH5dBhzxXc0D1SH6ru/VH5be13aDBkiilJJKxhiIy4eJvkqaKe1mV/OWBCyZ+E4LnOnM9qdy8/xgiZtdO9R21N6TJ0GZzEDoDhy0C2CDg/lwLB3mKfBvAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxKOqD62; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZYM2BXFG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxKOqD62";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZYM2BXFG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E1qkQp1762764
	for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 05:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbu8y1N4/izX+twY4zjfchArelElHS5wVuKE8gdKOzk=; b=BxKOqD62fH2UpzLZ
	+SW7mdu3h6DlZQ5yMmHIPs5lYo1LFg2QtEhtOXVe3A93XFOiVZ/+Gw3p0mtbUiJo
	cdaz8AAjll4irHuWamsG/PlI51X82p7sAhWyq4AAjG4xQMrsA4HjNDAEdAjwMhhz
	GqnHOVf3FFjcRKKPo7aIgyWCSZ1qSyMpnHOXMUkX0TVnZxEsp+JAfx9Tg8yPgmTF
	PJl/e8MSNwExNOUiFpJzc9jiON9LFL3um/gn7/Sd4o/8ILsPfc6HQEGnkMtYV257
	vOLcUXKQvggZEucAf3FNwv6uh+FAjlrQoibMVMvgElyAHzZk8XfdHBtLnLHdiYW9
	MA1Gsg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e554a8nbp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 14 May 2026 05:56:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so4638048a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 22:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778738196; x=1779342996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbu8y1N4/izX+twY4zjfchArelElHS5wVuKE8gdKOzk=;
        b=ZYM2BXFGgeiJj0OkswSl36kNDb1TePnChtX+EHpyRV7zsMs3+vFQifzxNiyN87VQUK
         L0UGMsbGJOtl6ItkFQf4/AeJRS38I7EtCBVnqY87P7YsmZ7S/UH8to/Ndz0PTlwMdfRX
         bFt2W5lu19OdQLTCBBVdhrj8KnQJ1niH80R+Mt7DOnuwdJcO9SYSpqf6bvRA2PhXQaUO
         Q7aIfyZQGidVRLwywv9x9VX+BVS3jQG4/EQIDukKrWEfRhlnE7NLes23LSImbodYVR7b
         MY516U8iKx1xFdBqfI6Nv2nFrb1npVLQgukYIHoQ2Fr23kPfLi0rQPeUZBPpyQ2j9GU0
         G7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778738196; x=1779342996;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbu8y1N4/izX+twY4zjfchArelElHS5wVuKE8gdKOzk=;
        b=iSjcZ8gZ6Oe0Q4+l17RKvnJpep/hFWMM/lrupzSG39FBmbxhQLZWA6WL7lJxwkO+W+
         iB2MsOltFUoz2j3HZ4hzj4IFxlCc+kuFbiLrs7I0t9wJdvcOEZwNz1Yc9CpFgV9xAKn2
         3ipeNf3Bo+CEjis/cYi0vxxRuL1omImmN6GGYdQHFRveSqmkXpex+MhzGDyJ3V9Nn7FK
         BAxUhT70lwM/62L01ZjKynLurwSp0RTwPRYGy4QknfDij87qnS7RzNQmWr6ufCxYaC5O
         JWDgfT9aecPE/ryS0awCdv0ksn6IIyG3MR6LAv+BtIfTbyujeegzb7JoXPLAKH8BcJWi
         Hhfw==
X-Forwarded-Encrypted: i=1; AFNElJ/Z4T9oHEDUQr/PpA8JU1rGO+PsmSC+Lv+qK/RpWRKhOWQ9CuYzx41J2xYj7Oc4rJw+LZlsPcCSQ0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi0YsDTUPCgPSW/f6DGx6h+vDGehW/P0FRq4cjLobE4HMFp0wa
	nRJQA1Mv+HnQO50glCnuUdSIVj72Nz1tmGr0SnUTGhZuGLCViLL5KQhS95w5lCeDPwYXQVs8nfh
	rXqvhdlsJkxXfb7a5hdjv9BNKzWkB/00jcT+QxG/I6J8eGzasoYWExvyQ8vRe0ug=
X-Gm-Gg: Acq92OFlB7WCM6XbqC9T0+WD6nbHzK9aI/xSo2/YFQFh+LBMzKiXibLfc1K5Z+eP/Zn
	3l3n+qCCAdjoFdV3Q65BLjBalpimi+T+Yac2bsP9tKwTck1/znJFJ5ZPgvofg1niB89Ip+tQzhJ
	IDJaPkvnn2HumuG47Eb4CooPHm+1bIzCa+xrVjCcl0aTDd6FmPmbDy2YHFX7oJGb8IBP41eO+Pm
	9uFsgyhx2vY3nfIjk/zpbwEl9gtAUXvdbG9OERHzSRZzhGOOwaGKK5b6IUHQu6z0/vezXsdfUxX
	e8xaCR2f0a6vD4MClRtZk2BbAVwnCb/NNLWVSE8ll8wcr//I6jbYQh0wqkA2xJZJ+SG/HxaHbwJ
	UqTKVjFycO8FKWgbjp3Y/DpcFSO6Uhk/duWV5Mk6caKTkJo4+FA==
X-Received: by 2002:a05:6a20:1589:b0:39b:fad0:6edc with SMTP id adf61e73a8af0-3afaea339e1mr7391332637.6.1778738196225;
        Wed, 13 May 2026 22:56:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:1589:b0:39b:fad0:6edc with SMTP id adf61e73a8af0-3afaea339e1mr7391288637.6.1778738195657;
        Wed, 13 May 2026 22:56:35 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062a2bsm1288045a12.7.2026.05.13.22.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 22:56:35 -0700 (PDT)
Subject: Re: [PATCH v4] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Ulf Hansson <ulf.hansson@linaro.org>, Eric Biggers <ebiggers@kernel.org>
Cc: adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com>
 <CAPDyKFrOHqStZbsye9Quk71UGkzUxOkwG9yAGYFVvt+=nMJSyw@mail.gmail.com>
 <20260122011417.GB946159@google.com>
 <CAPDyKFoPVeu3xe7ZAxBTNFfHmf=f7OZ3iUG=pRG8mD=UOGNVPA@mail.gmail.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <3e04735c-ce0c-b2b6-508d-57ec363b8894@oss.qualcomm.com>
Date: Thu, 14 May 2026 11:26:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoPVeu3xe7ZAxBTNFfHmf=f7OZ3iUG=pRG8mD=UOGNVPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ziDSOlpce5ClFjXSQ6iPxiQw8eZYN7zo
X-Authority-Analysis: v=2.4 cv=Wag8rUhX c=1 sm=1 tr=0 ts=6a056415 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4q3zvkj2iR-HDjvw7cgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: ziDSOlpce5ClFjXSQ6iPxiQw8eZYN7zo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1NSBTYWx0ZWRfX3o2ew2TjUfQq
 YXUOvSG0WBg6gjLYq/JW2GjdmQcbST/hRZKp2qaYnwCdNdUPJbu/3QO7Wvbskr+158RHaN3XLPp
 aQkHiVrlV+Lk0+VbE15b5cRTHWtDmQTTWntLEifu68A/+zfZTK4J1hL/pCQsXnz95Cvz/Kc0RDn
 E2VNcOMFN+WLcFTmf+YbilzFfVKtaWW/IVYZIpi1+XfSOPQ2Bh5cqGzJa40M88NAyQdx0nixE1Y
 TdAFoEfpaiZLitNAKCPYmnSCER5C980hsfKFUASpM4rYTHMZR2HuqgE0bmR0robWaqsXiPSqB9n
 3gGDLkzHLwhMmPtYQND2zez8pODobinncpJdrL/pobg3R5wFKRk5snSF+FGW6unXS8QOGHdoPUw
 rXC901uJv8pFWB4O+WESXXKuHOJewMVffT4piyYgCzafL5JP8cZ5fTIl13gJKIAcRD1K5LKniln
 jOngma97sREbTO3oUfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140055



On 1/22/2026 3:44 PM, Ulf Hansson wrote:
> On Thu, 22 Jan 2026 at 02:14, Eric Biggers <ebiggers@kernel.org> wrote:
>>
>> On Wed, Jan 21, 2026 at 03:12:43PM +0100, Ulf Hansson wrote:
>>>> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
>>>> index fec4fbf16a5b..a5a90bfc634e 100644
>>>> --- a/drivers/mmc/core/crypto.c
>>>> +++ b/drivers/mmc/core/crypto.c
>>>> @@ -15,7 +15,7 @@
>>>>  void mmc_crypto_set_initial_state(struct mmc_host *host)
>>>>  {
>>>>         /* Reset might clear all keys, so reprogram all the keys. */
>>>> -       if (host->caps2 & MMC_CAP2_CRYPTO)
>>>> +       if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
>>>>                 blk_crypto_reprogram_all_keys(&host->crypto_profile);
>>>
>>> As far as I understand, calling blk_crypto_reprogram_all_keys() would
>>> only be needed for those mmc hosts that lose their corresponding ICE
>>> context during runtime+system suspend, reset and possibly during
>>> ->probe().
>>>
>>> In other words, calling mmc_crypto_set_initial_state() from
>>> mmc_set_initial_state() looks like it's a mistake, as it has really
>>> nothing to do with the card's initialization, unless I have understood
>>> this wrong!?
>>>
>>> That said, I would rather make the mtk-sd and sdhci-msm drivers to
>>> handle this themselves, by explicitly calling
>>> blk_crypto_reprogram_all_keys() when needed - and drop
>>> mmc_crypto_set_initial_state() altogether.
>>>
>>> For the sdhci-msm case, it seems like the only case we need to care
>>> about is for the reset.
>>>
>>> For mtk-sd I don't know what is needed, but possibly Eric can help out here?
>>
>> The comment for mmc_set_initial_state() says "Set initial state after a
>> power cycle or a hw_reset."  I relied on that when I added the call to
>> mmc_crypto_set_initial_state() back in 2020.  In the following thread it
>> was also discussed that the code was intended to reprogram the keys on
>> reset, not runtime suspend as that shouldn't be needed:
>> https://lore.kernel.org/linux-mmc/X7gQ9Y44iIgkiM64@sol.localdomain/T/#u
> 
> The comment in the mmc_set_initial_state() is referring to the card
> and not the host controller. There have been some similar
> misunderstandings in the past for other functions in the core, sorry.
> 
> In any case, I have been trying to understand where the ICE context
> really belongs and recently Neeraj answered that question [1].
> 
>>
>> If that is not what it actually does, it probably would be appropriate
>> to replace it with something else.
> 
> I agree, the comment(s) could deserve some clarifications.

Hello Ulf. Do you expect modifications in the comment for mmc_set_initial_state()?
I am sorry i did not follow up and assumed that no more changes are expected in
the patch but i stil see it is not yet reviewed or approved.
> 
>>
>> - Eric
> 
> Kind regards
> Uffe
> 
> [1]
> https://lore.kernel.org/all/e1f689d0-523b-5842-3a6e-10b431d617ce@oss.qualcomm.com/
> 

Regards,
Neeraj

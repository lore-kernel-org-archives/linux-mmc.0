Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96733239E9B
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477187; cv=none; b=lP5icOD0/toIPFl4KeJDcF4vEfRa0G0zWGItuTinC1u+wvlMKd+vTVXipq+NVKRhouWAiSgmcDB9fChaNVUYhHBUc/EbIcROG9RA7E7XvsuSE3wRd4McWMhq7RCRho93tSX/f8nimaVaw6RMCupINiVbUYdhCxg0oEltZopSvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477187; c=relaxed/simple;
	bh=vpy6xdGN7rrdChF2u6c8T/K7jhlzFRZYBy+D+Mbc5Vw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ruzpuuIkOR03AJ/ZthOe9gzhK5c7RTMOhJyowHLzMZlOo0fUpvhh1QsTd+tumlM0b1gYWQah120rvbz3UQi20pic6aAQ4b12pe7DNh9qQlx00dtG3ktjawND91NJ+n4MpvLn/TME6nbRosZfOWTdpW25wBWpQCqhV+eOggTI2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXMVvYAl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RYrlFdi3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXMVvYAl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RYrlFdi3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5F4Ur028605
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 05:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QdEo3sXlneRb8+FCJZTqiVYriegj6muf8pmwtU37L7Q=; b=nXMVvYAli9wMqo0V
	5t0qCMLEBYn2BxkfPupUleVPBOHl9vfCxbUZ/WHtTzjexUEfDA9UZttYjVbzaoYe
	P6FnXJ15dT9XmCOZz0zZmmzUBsdKhn74AAybgodWW6VVdkAMwQ2xq0VuSJWmKe3y
	ttH81t7nc7OfXuap2h2pGBE5R5HTsRFGcgdsR4YAa0gkdTxVm4UuPxyfmUwNae1P
	2j63U/jSIFjiW5hFV4ig/SyK1HuYE+VYLWdga2SIb2cl+2v+nh8R8WbEVnKpv+mL
	UYttA5vd/boYhr9kmbyOEJANxrKV/5DUoNTCfHZku6KnkuvFaYBq8TqOlZjeKVpj
	T+ZvCQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frnd5841h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 05:53:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dff6253so13675975ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 22:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785477184; x=1786081984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QdEo3sXlneRb8+FCJZTqiVYriegj6muf8pmwtU37L7Q=;
        b=RYrlFdi3obDQGfEjljIeHMy4ZO4tJ8oZX6s2ufrFgI2xKs0juresuCazAfTP/ZyC3M
         4ZmeWMFzKzzk6NAtPWex9rKCL74Wll8hI641/OU+KpbFfmbwWER/rbWgdenzbB0oSRNE
         //RE7+9fELendgX5MRHeprOdNowGqpO6DbgVFxkDnaKJTFYpkbK8R2YbMnK0R+4QYP1n
         HTd0HnprSJm1h7noS7aR9t8Eae9KRcl0nVgLDVz6sjmebay7wgl6pm19urg9bchvqntU
         N+/9SROzzYFZOQCz7kxlv5NDAhlA8o4gxGxYDIYANn6YYAdoQt9uIL3l8jsjY1PH8W9x
         VA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785477184; x=1786081984;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QdEo3sXlneRb8+FCJZTqiVYriegj6muf8pmwtU37L7Q=;
        b=bFnS6I8cu/xkAQwJdqsiFyX/x93mPgtkd+Zbtcqla0LXC31VFKBEsVW5D3ylE31Wb4
         XnrbTlcmH7fhOICx2n2aiR+DWD3PWSRbqq9QoX5Bv/DFhgWOGn4EljzWJ1UEoupdO7og
         M3qQ7Imrrls4Ai0CMuygjhwYLcrDH65MGNOHpb4gswWupgM0wKZvgD4UQQDgRk6Vx8B/
         qPukSko3mth5JiFq7eleQkIGVnqzp5g4yAzeeqVMy+0JPsMCQK07cssqmo7uYtGnw2oq
         5z1wBPtfANyCoEg5n0aSUZLYN7U6SU+4IL31lcIV3RdgxGzyHR2DE5gWqzE/xFK1Lclg
         4s1w==
X-Forwarded-Encrypted: i=1; AHgh+Roph13mw1SLLF3cZHyx9L+59aHqo6CQIkclmodDoKEvEY98mWrUzNMTB3JB3ag5tUKT8SKy/Xl+Exo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUY5sDInD9KgE5jaJ3gInhQMSyJ0s2wGiCCY7etQeJOW9T+y1
	BE6+oaGe8LbHjVZBqvFtW2O6dC6s/PveZa8/emroXbBM1phcTvNyi794/AuQ88G4VwSyZTPGuco
	uEiMLv6ugg61hfUJvVd/MttQuU+sn8ujhXsX0Q+q3prHTnfyXykm8M/P2QKwIoej5NnPa13c=
X-Gm-Gg: AR+sD105Ku8zzl9+x83aNFYLTUQno32nRkaHCayqOf2hEfgcogr18DQZx7uSzMfqamq
	Eo45cO1cmsJhOsdPBAMDID40t/1fzitL4uEo6VixX7MbWEzlYaXZkweE1ULrSnzd8WjGj6Q54Tz
	zx105/OlN/cu+a1KtLLS2xjKODqqcUsfqn85KQG8wuksmHQnUlypaGop/F1F425YFGYmTpCS/Ym
	JBdAYR+RD4pkSavIMPaEDqUiiHiyTsUDPz4MmlYd5t3VpFf2HyuMtFyOXxxxoOhVoI1MH07otlp
	VrxsuvZ3gMihRPdWNT2gW733fLjMC46Kp1UZw//AteXabwRsUbS3AL2HAX+s3oVJhntz0cGqRWP
	ujHfszsQJiHL0z8aZOkqrNyy15dw=
X-Received: by 2002:a17:902:e5c4:b0:2ce:b43e:44da with SMTP id d9443c01a7336-2d0483abc4fmr4124645ad.17.1785477184088;
        Thu, 30 Jul 2026 22:53:04 -0700 (PDT)
X-Received: by 2002:a17:902:e5c4:b0:2ce:b43e:44da with SMTP id d9443c01a7336-2d0483abc4fmr4124465ad.17.1785477183634;
        Thu, 30 Jul 2026 22:53:03 -0700 (PDT)
Received: from [10.218.4.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b15c176sm491125ad.77.2026.07.30.22.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 22:53:03 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] mmc: Allow host driver to control the
 re-programming of Crypto keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        ram.gupta@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-2-neeraj.soni@oss.qualcomm.com>
 <20260730190346.GB3139@sol>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <2f502fd1-1f24-213f-11f4-ffec024c9b02@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:22:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260730190346.GB3139@sol>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -TJMd7BcmZj-2LoysRC7qI8Ftw7-G5jx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX2xqK865xACjd
 6tCu8RmnU9ussbzAYsFi+UOribqPyF8Ae2KrZbQEh8eneSPwFTynXDUrAV4hWWCg9SMGJRImGHt
 8pcTsGI6a8aRwnaLKUgE7FcuCfypOWqeWkzVq4hpLyVqoHmJfpYoWefFRDXu9z8TPxZpvOrvra4
 8tHS3xwMv2bxDpkd6MPIIXNmS/LdiT+GsBSMa/khzENJuBrYptFYpLMkHGATbbhnF6qjxz1rD9c
 6LBVA3sz8QCnmmYhqgISOqxLHx9QGvfBWVrqlrF9W2oNzshDIoSTWKdRP+xJi+08jFjXrng82oA
 9FoC9nOhwMRRSMN/SFR8NZJpxuY7e38Yc4qUZZ7d3wN5HsW1XwFXIXsn+CLANWZVYIE1XherqKv
 wILI8sR8iZOJkjfcn5xypUmjLVb5fY+PjXyh/D6MDlLhBk7ggnXwB5IGkMpZzjEKfQEFlrsQUM6
 xJSJ2X0xS+gm6GqEL3w==
X-Proofpoint-GUID: -TJMd7BcmZj-2LoysRC7qI8Ftw7-G5jx
X-Authority-Analysis: v=2.4 cv=MLBQXsZl c=1 sm=1 tr=0 ts=6a6c3840 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hEwqdWZ_t5p12PLCf_IA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX6ckVyGfdwk0T
 QE2bEFwAXnP0D6IfVzX6CX7IAyreYPe+ryT0Y/oTRHngavTin+sSOLAagi2XjSGlkVmwb8wmMPg
 PKX3PvEfSwmpRC8Zdfy9unAbiNedxEI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310038



On 7/31/2026 12:33 AM, Eric Biggers wrote:
> On Thu, Jul 30, 2026 at 07:38:19PM +0530, Neeraj Soni wrote:
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index ba84f02c2a10..83d92fb64417 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -457,12 +457,9 @@ struct mmc_host {
>>  #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
>>  #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
>>  #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
>> -#ifdef CONFIG_MMC_CRYPTO
>>  #define MMC_CAP2_CRYPTO		(1 << 27)	/* Host supports inline encryption */
>> -#else
>> -#define MMC_CAP2_CRYPTO		0
>> -#endif
> 
> I'm still a bit confused why this unrelated change is included.  If
> you'd like to make this unrelated change, it should be a separate patch,
> and the mtk-sd patch would need to be before it (not after).
> 
This was included as part of clean up suggested by Konrad for
MMC_CAP2_CRYPTO_NO_REPROG here https://lore.kernel.org/linux-mmc/a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com/
but i understand that this is unrelated to this patch series.
I will revert this in v6.

> - Eric
>
Regards,
Neeraj
 

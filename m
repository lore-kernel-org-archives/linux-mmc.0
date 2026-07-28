Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED12E091B
	for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218518; cv=none; b=keUPAGg0jocNhH0mmNtM7TsuYnOIRghp/jzw7C8bSj+ey7Bm7KamHO2tSBRmjVc8I/6Hi7gOcrU8KUCjPvkVnafeAerGi2Rvo97z0gbzJtLVO/imeLL9Hz0eANBTq/a0zEK+Pt3NeJqViHB9/9ziviAcUe63Qa0fyPlkHD+XQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218518; c=relaxed/simple;
	bh=ht4dFTn1af7WNkBp21IoLEeINKh5Y0UfquRQ7bAYiM8=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SE2FkjPoPgc9ezdtIMiCQD+BRPAXiFS/cd7C3Ah9BXNLJmusosg0FcX7va7jspX1drX9v+5crzq4m5Rq0ylyY3D91lfi1IZA1myXZ/NjS4DfNODmjCMHB4n9aYjPI7YWqckL4rp76f7gg14RsWsKaZTNPDxt78OtKORlXZphI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ajjyX5VB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BXLcssCB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajjyX5VB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BXLcssCB"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3aWXT1467070
	for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 06:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nLrCL3Oj1fQvN/kgUMrm7+U1BzpmnMF7CdGntISZu30=; b=ajjyX5VBZFtNt1km
	fbBP9fhBjP4d/lzdlVbaqESaubJdh/2YxXS8FFbEronC7EpO2Y2Q80n6mEpC5cq0
	JiFoWoD5lRCi0x6Q/6pXQXVzc4zIAVpkeYnCQtF8eoYd7Riy/J9Yk/tR0ePq7xoK
	RcMNqInSM/zhAL3XccVfAiOBU52s+M0RpbvipnAmM/U2mq+y0vvczRk+LdMIdz0D
	UEG3eAYhFaJmzyyol2pYAhTlQROUJn5tWn6vQx/gvp8WL9C7n7dlFHWKggy5Kd/n
	G8kP7tjVtZnuYbdtd1ZmEVZYa0XCcyfmxFYQvjn9S77AWe4OxbcLx2N6YPvPyW4S
	p6YMjA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbvrxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 06:01:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacd6d37edso50821695ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785218513; x=1785823313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:references:cc:to:subject
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLrCL3Oj1fQvN/kgUMrm7+U1BzpmnMF7CdGntISZu30=;
        b=BXLcssCBrwgU6YOCvOzX9DaJkO1ugjj/CoEZ/JUTS6kDpVOPF3zrFN9XTZr2ZiFi2B
         mDDaBqzNIitAGEp1AfZrYpkPL3k7EW1rW7AQR8iNMHoUdqP09XhmSsVE9dzakVMl+nX0
         f9qiN+ozSWETktGIfXi/DVkE/6QbswRY0n3dm/DefIjsic7gsSUZ4RNldmpWiWHlvjOf
         RH/4ltpvNEGMBxFRoVFCT/a0nCng3t+0h54up28DRTJVdQqMQt1a00O87LbkmjQcrW51
         sMeZDae7aPW5WwOvytMIdSaSBllKLKavzVc8C/htVhL63kqSJ0WrnL+xrGZXFveMjzK1
         Fi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785218513; x=1785823313;
        h=content-transfer-encoding:content-language:content-type:in-reply-to
         :mime-version:user-agent:date:message-id:references:cc:to:subject
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nLrCL3Oj1fQvN/kgUMrm7+U1BzpmnMF7CdGntISZu30=;
        b=Uq0j9hGx8mfP3KMumYQT2nW0aKn3ZYRyAA37ZT7WXVdN5dYshUPg+E8gSgqWwy+RhD
         NkNAOc/z+eoVwdMGL4pH0UH15m50g9UZoIoUeVbqucD+nJki2NHd1ryWE75SvdIAACiQ
         gwTfCLWVcDoQknzqM8R2A+7FNz1k2bILI5hzZ6ZVlHXNIcx05LWAWg7lmTd0b11EV0/5
         lrnVAI92W5j3CU8SIDyO+THHmHoc8Y4Q08HxaRgv3PuuAx7Pv1LRUnFQkYoQ/UW2uEud
         6rQkAAxXROLk2Fe9T576f+fANllUkmuxDdMR0Pjcju5SjKLpv6DnbfTv7x0zCooU1XuA
         FYYw==
X-Forwarded-Encrypted: i=1; AHgh+RrqJRd2u16F6oR+bpecXykd9QrjyeFrQ45wU2Y8trLzsex8DYf631fXznJ3wET7WEnF/Vlk+TpAv08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bqKBFVXSi2dBuU3p48EcGZUp5CxQKq47jF6L34gZ95Qvtaiw
	xYHvpJBg1iRidWmmHjGNw2VKyu2VPyVYw3c0sqqaL7PA7DzXqSgY3JEpx5tmoiVEMUHJJQ0ocLa
	lw5PtItnwIZyv/xA3hD8M71ff/zXY1zje2FXhn2QSj123Mqg+d7iYDOIGNZ8EkHE=
X-Gm-Gg: AR+sD12E4M+YB1++SBn8kafOoqno8qTBb6XTaP0Lu9gZlSFLEsxlh+8DryZorj769LM
	VjMGaNxZAfI1w/BQAdSJkMT5/eNOkZsuG9LZn6GmhY95OPSU04XxjsNU441i3FnjaMsJsVKw+7Z
	jP0+chhye1M01TMdRf4gc9tLzhOx1y4GsUTh1RDGpfSEDCrbRF+ggdKnwWDacHF0oJsMg2HDD/o
	O5pQUmWQQJZYNyAL7FxVZTpL6Y7Jc38t1lOCsK6in4dwsRaZ+1SzDEe8AxDSqSowVXGK6cmPTmT
	AIDisncngTKniT+4NXPhd9auMKmm9IgJOkp4kUIy+L00ZczLOh8nftGVt+n/zJLcKkNzskqAuvQ
	6dvvvC0HqtYkl3ynfzTEcNV5hlqg=
X-Received: by 2002:a17:903:166e:b0:2cf:7d44:e14f with SMTP id d9443c01a7336-2d015d44a72mr11854975ad.26.1785218512704;
        Mon, 27 Jul 2026 23:01:52 -0700 (PDT)
X-Received: by 2002:a17:903:166e:b0:2cf:7d44:e14f with SMTP id d9443c01a7336-2d015d44a72mr11854435ad.26.1785218512213;
        Mon, 27 Jul 2026 23:01:52 -0700 (PDT)
Received: from [10.218.4.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm41610785ad.73.2026.07.27.23.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 23:01:51 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v4] mmc: Avoid reprogram all keys to Inline Crypto
 Engine for MMC runtime suspend resume
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jie Gan <jie.gan@oss.qualcomm.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, quic_dmukhopa@quicinc.com,
        quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com,
        quic_gaurkash@quicinc.com, quic_sartgarg@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260529092612.1749752-1-neeraj.soni@oss.qualcomm.com>
 <e9cdf8dc-40ea-49f2-a655-b99ed0707a8c@oss.qualcomm.com>
 <66caaafd-cea4-b624-57a1-f2cd04d109b9@oss.qualcomm.com>
 <20260723230104.GA662946@google.com>
Message-ID: <43722458-a767-ec08-bb14-e26c219fd70a@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 11:31:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260723230104.GA662946@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: a9MCrr-TZrl3X9alG2TDgSsBodEPF8CF
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a6845d1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=2C7CbUiZDh1uNymYRTAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA1MyBTYWx0ZWRfX4pJNavfNLi6R
 j0r93v9TqBnYXEWnMr3gV04K2OQ0gfzswA5494e0JBEKdmMdu6KKu5n0Jp5bj+t4ZwM8qEvTwY2
 XGYlghDdhgW1ELlG4qG+1f3/BpfinCc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA1MyBTYWx0ZWRfXzOYYcdgq9zuM
 bM48oEwqTkIQ3VLyaSqhN2RSY8E+RPME5XVzn6Ba6XKcR5HFkwAgYKOh6VegPQES71l7HMdQsTs
 KVxYUVeQOWqcfnLDMHuwzDg+SdwMJGkcrsK2TeNfDR/PsHMhqnZHsk16GNW4TLfSm6OKpji6sRq
 9n3PQbXjUwfnLeweXq7e7aoCwuLdo4EHJLmSUAKZ0yzPDK/1Bouo2HYs8fVHhaw4fYWJTOJ+499
 b3vbAP6HxeZ/uFx1HM26tcMQOF9DXbzWCvrfITFmIhgTsy3XD7XBdbP1axew9AEcuMGvM/1JT+i
 9cP7X/CxT1nAjQF03ka/4J7U+TjhjjgDJjtXwZhnkZCW7dO1VpMoMTOsTiymZ/IwAmlmloQyMKa
 fpWUcC90SI67N2E17BvYMTDNlKpRnnm8oRUvXo3ftYE1b6AmL26JVsTU0G6TMt2VNFeVBebzChR
 Ho1hsjki6nvL7qB6Xag==
X-Proofpoint-GUID: a9MCrr-TZrl3X9alG2TDgSsBodEPF8CF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280053



On 7/24/2026 4:31 AM, Eric Biggers wrote:
> On Fri, May 29, 2026 at 04:05:52PM +0530, Neeraj Soni wrote:
>> Yes for cold boot this is true and Crypto reprogram is not needed. This patch addreses the use cases like
>> runtime suspend resume, deep sleep / Quick boot (DS/QB) and suspend to disk (aka hibernation) use cases
>> where the runtime context is preserved either in dynamic memory (DS/QB) or in secondry memory (hibernation).
>> This is tested internally on SAR1250P chipset for hibernation and DS/QB.
> 
> But sdhci_msm_gcc_reset() is called only from the driver probe function
> (sdhci_msm_probe()), before MMC_CAP2_CRYPTO is set.  So Jie's comment is
> correct: the new key reprogramming path is dead code.  And as per the
> following comment, key reprogramming is still needed in some cases
> (https://lore.kernel.org/linux-mmc/42797330-868a-bfcd-e0bb-b5f0dd3eeb16@oss.qualcomm.com/).
> So doesn't this patch break the sdhci-msm driver?
>
Yes, re-programming is needed only when the host is reset while the device
either resumes from a known previous state (like in hibernation) or is
already operating in a known state. I understood the concern regarding
MMC_CAP2_CRYPTO and will move the reprogramming to sdhci_msm_ice_init().
This was also suggested by Ulf here (https://lore.kernel.org/linux-mmc/CAPx+jO8rUwYV6q1-RrA4aZ9XnomSf82fgf8Jh2fUC0fE03RFPw@mail.gmail.com/).
Will post V5 to fix this.
 
> I'm also skeptical of the following change, which seems unrelated to the
> rest of the patch:
> 
>> -#ifdef CONFIG_MMC_CRYPTO
>>  #define MMC_CAP2_CRYPTO		(1 << 27)	/* Host supports inline encryption */
>> -#else
>> -#define MMC_CAP2_CRYPTO		0
>> -#endif
> 
> Because of that, mtk-sd sets MMC_CAP2_CRYPTO even when
> CONFIG_MMC_CRYPTO=n.  That makes CQHCI_CRYPTO_GENERAL_ENABLE be used
> even when CONFIG_MMC_CRYPTO=n.
>
Yes this is unrelated but it was cleaned up while cleaning similar change
for MMC_CAP2_CRYPTO_NO_REPROG here (https://lore.kernel.org/linux-mmc/cead2d86-bac8-2d4f-1a7d-c9b90dc05a7c@oss.qualcomm.com/)
Konrad had similar suggestion here https://lore.kernel.org/linux-mmc/a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com/)
I will fix the mtk-sd driver in V5.

> - Eric
> 
Regards,
Neeraj

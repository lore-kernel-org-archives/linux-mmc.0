Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB51537C6
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838971; cv=none; b=Fxl1UhQf18n7YFgwUHgK0OJE3gNKr/9cxFUsE1ZWDSC8IQRyGtJ9KBjFNoWNcRXK4dfUTv08CU5LcdnNkzN8QqEsKIW90XFUPFtmlsUPSTeK7rBxEfROXg4cEP4iS1/H7JYmDOR2kJOqPb5qCbwVbKNGGoXUJF6NxUTCYPXysHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838971; c=relaxed/simple;
	bh=9LDK/QKPWZKQXdNon4+5Vf1nRHt0rEU96RIWKx4oniI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl01205R9zYBhSfjUL6SIFlwttBDlzP1XXQnpVnvtjBFHaIMFQFOpklMjx+5ZNRkT/BgzW2EDcPzI01b8IUGlbTxwfou50FKi6AMVSkiuCD0U0rn6kfN/eJyzYS1rq5CI+p4gKkaRS9qfO6qONM2aws8b6EGvhk/WSNu4Wkd6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Km/MRYd+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Km/MRYd+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XIIG024751
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 14:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wzz8YAG+jzGwPnznc9rRApuGlOIZqX/coqLODea7HoY=; b=Km/MRYd+hcUDDrDD
	y2JpRVEC8uUzuLODglF5ZCmkBbVr0EFGud/9aCGtCxGjUPQsyXiD0gNLyl6UskEe
	Up++paC6g0Ah7kj7zDJX8mPwBb/W5DVPWMWk+p4RSdADVkdW8Lb3nQaNiUqiNVqy
	xD8Bn1RqvaWeXLg0K1yNheHjuA4IKODc1V4T3ZD8GvhAj4CpA4BVCrmnsn4gBRci
	nDyEC1IWHCU/NU8+Dn7UvntEpM3RUAeKIYZsBw4+VJqqUdZ9wA0yo+p0E5B+3tsd
	5l2WIy/F1ZqjiAvUnhoho8ReIbcrPCuB51zsJibIQnLExs3oGsVykdg01zFiLQgJ
	1b90GA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4u9ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 14:49:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f8cc1c047dso63304846d6.0
        for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 07:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747838968; x=1748443768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzz8YAG+jzGwPnznc9rRApuGlOIZqX/coqLODea7HoY=;
        b=fhXgwK7b6RE3dsh6wXL+Lj5mxYBfgsUJ8egXq1Drr6nYC3TUlNCdOSXBdbgZ9tHSes
         3AOiOz5/Dm/0RVq9znbxESFU+0KhVer8j1B76TSBFFiSADcJjEqC4Lhwl2Hyvc95GbQg
         AGnT39Z+w9DlqgTipIUvybzqr6nSC/OQs/aAas+P6su06bkO0Cz7laKgVwC3dXeNmwGv
         qxRhwBzRyX/7XNy0FBPAtLbQb3NIZx5w0E4E5OI5cuvIlM8LjhgZA1jNbrytULC+PNwJ
         Cyx02rsS6eB1ZA1JqJctm0B9BTBEp5Ks//YcaZa0g5T9nF6p2M15Isg0oosyrzZb15z7
         Wbhw==
X-Forwarded-Encrypted: i=1; AJvYcCWl2h4WuNATGVQsV+VMM0BxMhLALqQzF6SyPqWWHRBgMrCQl+nMt5b8JniCUuVYG25B79ad7pfrG0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzft+6n9yfiorpI0RTTirgmr7nvk8AyREKBiCNap4ZZ+7DPzqkb
	XsNx+LDAZLr/wOeEmPj8OB2G6ZjD47poF3lYj0pmXiEKDfOJ7BnsYLCMPQou8IvYMVx1wK0U6sI
	ZZnrvtUMsghcBZbEUgawvWiOOPs4PuZges0OTQXoLhhb9VYuPwewupSCpuvEs7sg=
X-Gm-Gg: ASbGncu0ol2oNs7dZHCqssbK8sPj72TLpDGdgDpnseTH0wLArgIEeQ8ur95VC5G1+1N
	gsMk5/yXSEa4nNp/KL1CGxDGXThFCGCl3LyDDz5frHzeSe5LrLlkslqDt4VKS2aIPyx1k/1wCl0
	sMR2Sjy5C2dDK6bS+ZBzsLbnsAShKzdvtlwsVcvikkLVEcXbRheTbJ8HKyu+9eNyGlpXG3TwGwc
	WCXqbKoofH3/xg+u6uTDeyVTVJdS+UTo0lo9yUSG6DxrYS+bF33hvscVmREDQp7fnBEasLOCh1j
	cJS2GW8EyxZhGAiAIAX/84XqyzQkWK1QUjaj0wht4mAbnQF74jjityu8g8XbzP6WvGyeDbee2KK
	wWd9r6qarXeRWlytEEvb2756byaO47TiM6A4PkV8OuDglUgIl4ypBtP3VGncXgoUC
X-Received: by 2002:a05:6214:f05:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6f8b08d8672mr389818406d6.32.1747838966235;
        Wed, 21 May 2025 07:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGADVYs6P1p5D3eHx76IOayTjYi+ijzrqjc/PCEns20DtYTMFID31WEtYs4tZlh7+gviqZqpg==
X-Received: by 2002:a05:6214:f05:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6f8b08d8672mr389816406d6.32.1747838963560;
        Wed, 21 May 2025 07:49:23 -0700 (PDT)
Received: from ?IPV6:2001:14bb:c7:69ba:b852:d3f4:8957:5a1e? (2001-14bb-c7-69ba-b852-d3f4-8957-5a1e.rev.dnainternet.fi. [2001:14bb:c7:69ba:b852:d3f4:8957:5a1e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-328084b30easm28014581fa.6.2025.05.21.07.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 07:49:22 -0700 (PDT)
Message-ID: <c1ebdaf1-92bb-4f73-bca9-35246d7c10e1@oss.qualcomm.com>
Date: Wed, 21 May 2025 17:49:21 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@quicinc.com
References: <20241104060722.10642-1-quic_sartgarg@quicinc.com>
 <konkbi4hvd7qc4rhokwrymzqntroy7gijk3ndwv5rluswdrykp@xsafrtrjzmuq>
 <10c90fee-ce7f-4034-9028-4252f19cb67f@quicinc.com>
 <CAA8EJpoLLDXFQk-ViuaioKrECzMV0aUrcOj4v+Ufs4oHY53mrw@mail.gmail.com>
 <064d3eed-c2ea-4b41-85b2-d2a5a922f8c7@quicinc.com>
 <ehgjdszjr34xppmkrkicb4pnq326nor26tqu2ekop6ew2j3y3h@pm45aiipzuc5>
 <48c73675-a73f-46f1-81a9-f701a2cf00a5@quicinc.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <48c73675-a73f-46f1-81a9-f701a2cf00a5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 50hu_FiaxsS2oTYsBh6h7CpA3_Z8KLrv
X-Proofpoint-ORIG-GUID: 50hu_FiaxsS2oTYsBh6h7CpA3_Z8KLrv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE0NCBTYWx0ZWRfXzeMDo+lnBYj2
 CIuz9jtlZiQ2khrtKs6O1PGey7tIILBD4VlS+VlHC3Q7oKv1fuNxfb1/8GL8S35guih+c7fS+GF
 FpDzza/oGXmEdPycDZWNgCFWphe54xUF8dba5IZZCmWDM8/ZQUkrO7xHKkYpp8Dm7XM6z+u+oJo
 5ku8/lzqQasy19ibLy2MhJRXt3aQeA0K/RyBo2Gw9VmSfEECUP4ybB0rILI7DCJwOachC5I3Lok
 Dzsst3fbjQHCr7/Nxf68puPwCLQ0zRjmP7dwBQWBUxlf7L4Oza9SbL8vRY0nlgkn3PH4E4lecLK
 NyTSRXLiBu1sKeNBvsNGsU7FayMI7AurYUr/e0NYB1I+1cmZ0+7BdpR3d2VUfqEog+4ioZXb6xG
 aZsYU8Ps6vltBRe8yxLQa2ZbefBYDB6YtD3HERwVKwk7PzaZYhuhl6Co6yiULoYuwVTYT2Ii
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682de7f8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=3-RhneuVAAAA:8
 a=JVpan6spTK3LsyV6_coA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22 a=VLVLkjT_5ZicWzSuYqSo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210144

On 21/05/2025 17:35, Sarthak Garg wrote:
> 
> 
> On 5/21/2025 6:25 PM, Dmitry Baryshkov wrote:
>> On Wed, May 21, 2025 at 12:46:49PM +0530, Sarthak Garg wrote:
>>>
>>>
>>> On 11/15/2024 6:53 PM, Dmitry Baryshkov wrote:
>>>> On Fri, 15 Nov 2024 at 12:23, Sarthak Garg 
>>>> <quic_sartgarg@quicinc.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 11/4/2024 4:19 PM, Dmitry Baryshkov wrote:
>>>>>> On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
>>>>>>> Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
>>>>>>> This enables runtime PM for eMMC/SD card.
>>>>>>
>>>>>> Could you please mention, which platforms were tested with this 
>>>>>> patch?
>>>>>> Note, upstream kernel supports a lot of platforms, including 
>>>>>> MSM8974, I
>>>>>> think the oldest one, which uses SDHCI.
>>>>>>
>>>>>
>>>>> This was tested with qdu1000 platform.
>>>>
>>>> Are you sure that it won't break other platforms?
>>>>
>>>
>>> Thanks for your valuable comment.
>>> I am not sure about the older platforms so to avoid issues on older
>>> platforms we can enable this for all SDCC version 5.0 targets ?
>>
>> No, there are still a lot of platforms. Either explain why this is
>> required for all v5 platforms (and won't break those) or find some other
>> way, e.g. limit the change to QDU1000, explaining why it is _not_
>> applicable to other platforms.
>>
> 
> Thanks for your comment.

No need to.

> I agree with your concern but for me also its not possible to test on 
> all the platforms.

Sure.

> Lets say if I want to enable this caps for QDU1000 for which it has been 
> tested and on any other upcoming target after testing, then how can I 
> proceed to enable?

Let's start from the beginning: why do you want to enable it on QDU1000?

> 
> One option I had thought of was to implement this using compatible 
> string, then for all the upcoming platforms using this compatible string 
> as a fallback.
> But this doesn't look optimal to use compatible string for just one flag 
> and also this capability is not platform specific and we will be needing 
> for all the platforms. Please share your opinion on this.
> 
> Another option that I could have thought of is using device tree based 
> approach but seems that was not accepted earlier :
> https://patchwork.kernel.org/project/linux-mmc/ 
> patch/20230129023630.830764-1-chenhuiz@axis.com/
> 
> So it would be helpful if you can suggest some approach?

Worst case, just tie it to the SoC-specific compat string that is 
already a part of the bindings.


-- 
With best wishes
Dmitry

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6721CC59
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842095; cv=none; b=Lvvhhj4tWiHfTXHxbSX8nf/n3pPRsQdW8yimIm8UaEBqeTQfOkVoZJIMWbVsgIa+Y10SOcgiVsN2ZYpgsWlXjBqc872fTBkgw2zVH5Lf8fjXGH0dDQqvnfav8ca2A9RthYpYygN/QREMSRWEdZAk2K4rVCsFWxmTvKNT3ykCAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842095; c=relaxed/simple;
	bh=0Hm0voyeDVNLto4h3bUVaIJA2qzEuKKWBY8Rt1tYC7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzLwZxa8Tj2126XndIF7Uidt4CKkEpWBEWZ128atcwc5uMfXjxUqLqGYuK+Jk3pJMKv68YEbhL7HyczYkmXw1q/YIVV08IaDDbUC63KBYwY0PXwYBqJdv2zNMRnqyGUq+610cUbqB+xCqY9MZXSZh96iF/PosEk1hOXGEnVEpEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B7IMEbTG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B7IMEbTG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XLEY013519
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 15:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	11xIrqs7y33esKOfbwtRMscbBQ+xSYJyjFlpp1MuMfc=; b=B7IMEbTGShkwi76/
	Ixsqiho8zgp9Eae1mE6FPZiZayqVcz9zQ9p9WgC2WgMqZd2drKbPeGs5swIsjhFP
	kvh9G8MbVBxKyNAvisHQ2XeS5rtedgq+iLDdau/SWbV/y32cyzNgJzi3HbwTR2Q/
	65pwKZMuV+ArOrAQat12+JNHl9B8fnW3MpR4VFXMOvN6K+WdrDIxkl7sAWRbm0P/
	W5CjVMHnW9GrVRQDaB2KIZM0NpbUwdpt3feL+Sn1x8b8NwotyDqJkqTvJ88YfYrB
	/8IUAuS8RAbZkB2W2ABwNj3DTb7ePwaD+ua6Vxhqz10GwkjfRaBbMJc5oS+vnMef
	+mo2PQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwh5bgpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 15:41:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-478f78ff9beso212691321cf.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 08:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747842092; x=1748446892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11xIrqs7y33esKOfbwtRMscbBQ+xSYJyjFlpp1MuMfc=;
        b=X0Sq+8bXY1wOewRI22zWdrX2Upm9Biq40TyTl8vXx2tb6Gd3aOhOo36jyjusD/6nGI
         ks05jnWrMsrgwUG/aJr/KTRARXsOt5nfcbv/7grQQmotLqlLNcSY+Q43muVPwycQrI1b
         Nss9IKfFUDr4e7smlm6Dom1H/qHi16NVbMvefVkI1cBknTiDrPqjNXoazpP1idCyoWxy
         NzlggchehSXSGahCHZ4YAyRw7BTYBFk/PlyrBotihyVpqYv3FQHbR1h89WiHkBbdIEYK
         AUYzHL5UdYa6Cj8q3F9GVzoM91Mk6yYGkKeRu/pPtzaREnzVXbq6cx3xlmhyNA1OYnCX
         J6vw==
X-Forwarded-Encrypted: i=1; AJvYcCU2PABIqHD3z43o59DvOXF0qQBIxpgaOjj5pd4WkotE1V5Cv77CySWi3nzd1/9dKV9YLxFH+gEwwOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIJ6Nf87GAWHMtcIevUol5dXaOVTnB1LB2pcs0Bgf6hQ3pGiw
	EWvqwH/ySCJMKGXp3kDMc2eoy85quWjgZk1yToDLqNvnA6yllpak+3G6usF03lR2nm0QB0aH4uH
	c0XoUkjwclR4pdYJFQvn2iHqtSL2cnfPqSKfeHx1S/qeOgSNF3ixpe6lEoRS5GF4=
X-Gm-Gg: ASbGncsyLUf6petS47qm72PA6zgHpZgK6N6xEOXevH1/LTQMBOqBqsTZZuWKgZ8O+Wm
	Rh44pFYIFCvDiFvwTc6S/EXFDto4tkK1iSkOZRhVPt5uWf2itxPoXtd8qc8qoKsdmRpflGtSRMS
	ojEGpQUaU/7MA35OIbXgg1R0IrtPvb7HJsDJnk8LudRP6GDZ4dDXN1L837f+i92jhKcjeZnpLFW
	BVgdMo5ryVKKTObEhkt8GMgL37MX+lHjboL56N9tGsO3Tzn2qoX6nLivnKdjPNVTaTa7hT8LvHM
	zQtPIMR3VeDbFyMqA2NtBoApcC/8fdbi4t4CgHjkfHGLs7GQpvLn+Q6iqB4B8kRVgxSxdyENeki
	AGZWx+O6MvQ1Q3djaQlmQVSfZRs3OdsD2pr4oetb8U3N+mSwOQoRc8inZmhnEVaJ5
X-Received: by 2002:a05:622a:5c96:b0:477:64b0:6a21 with SMTP id d75a77b69052e-494b07d98e2mr375789601cf.23.1747842091614;
        Wed, 21 May 2025 08:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzymVPyAEezG0iALlrdblH7qdHofBk2xTG0MRCZc7og2yUqLNV3+TUUJqDglHgQSrVGu3AZg==
X-Received: by 2002:a05:622a:5c96:b0:477:64b0:6a21 with SMTP id d75a77b69052e-494b07d98e2mr375789091cf.23.1747842091152;
        Wed, 21 May 2025 08:41:31 -0700 (PDT)
Received: from ?IPV6:2001:14bb:c7:69ba:b852:d3f4:8957:5a1e? (2001-14bb-c7-69ba-b852-d3f4-8957-5a1e.rev.dnainternet.fi. [2001:14bb:c7:69ba:b852:d3f4:8957:5a1e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55208f7b362sm389589e87.236.2025.05.21.08.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:41:30 -0700 (PDT)
Message-ID: <1a0a5178-fcf0-49b6-8e4c-1393c0f4f229@oss.qualcomm.com>
Date: Wed, 21 May 2025 18:41:27 +0300
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
 <c1ebdaf1-92bb-4f73-bca9-35246d7c10e1@oss.qualcomm.com>
 <ca83b841-aea0-4233-93fe-02a7b5985af4@quicinc.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <ca83b841-aea0-4233-93fe-02a7b5985af4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE1MyBTYWx0ZWRfX3f3VIUJZPanA
 kiyFlCdVbsxY+CErqBqL/jQdIe2mhjH6ziCdDF2vr6jVb6SvFl/It94HRZA03NzgxEykhFtytgJ
 nGc/0GF4DiDBqhXn3KrEY280/+X07z0VXbGVnEENcJHp5WxhSLplr+pfehDJDNVhZwsUfuifTY7
 sFUjasySVWnthZD+OR2bgkECdruBY5HyUAARFp/SEeKwjpUEDL5ZExLN1uq9k+JwXCSFDkvws4V
 n+NXM/gE5ySMF6VG9grEnMh6//gG2nQBKeWRCkKPlgam0s+T+izi8vd8q6qPg/9zv0R0KBOnpja
 6HWKQCA4UO5PYg0cm/dWjtIB/3kO6U/6vLtLu5HtMAgx7w1uct5YImu0dukdbXDaxD5e6rreDqL
 JMcv3LFdp5JeBXibSgZgngO5WwUFwosNeBht0Iuj5M+8FGivhvnx+HD0U8Q8XUuj1e4o8r8T
X-Authority-Analysis: v=2.4 cv=XeWJzJ55 c=1 sm=1 tr=0 ts=682df42d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=Kn0oP55XQ_SHoSlfIoAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qp34FJM-lVILNGEZvzYpdWYo8syRdqGk
X-Proofpoint-ORIG-GUID: qp34FJM-lVILNGEZvzYpdWYo8syRdqGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210153

On 21/05/2025 18:36, Sarthak Garg wrote:
> 
> 
> On 5/21/2025 8:19 PM, Dmitry Baryshkov wrote:
>> On 21/05/2025 17:35, Sarthak Garg wrote:
>>>
>>>
>>> On 5/21/2025 6:25 PM, Dmitry Baryshkov wrote:
>>>> On Wed, May 21, 2025 at 12:46:49PM +0530, Sarthak Garg wrote:
>>>>>
>>>>>
>>>>> On 11/15/2024 6:53 PM, Dmitry Baryshkov wrote:
>>>>>> On Fri, 15 Nov 2024 at 12:23, Sarthak Garg 
>>>>>> <quic_sartgarg@quicinc.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 11/4/2024 4:19 PM, Dmitry Baryshkov wrote:
>>>>>>>> On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
>>>>>>>>> Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
>>>>>>>>> This enables runtime PM for eMMC/SD card.
>>>>>>>>
>>>>>>>> Could you please mention, which platforms were tested with this 
>>>>>>>> patch?
>>>>>>>> Note, upstream kernel supports a lot of platforms, including 
>>>>>>>> MSM8974, I
>>>>>>>> think the oldest one, which uses SDHCI.
>>>>>>>>
>>>>>>>
>>>>>>> This was tested with qdu1000 platform.
>>>>>>
>>>>>> Are you sure that it won't break other platforms?
>>>>>>
>>>>>
>>>>> Thanks for your valuable comment.
>>>>> I am not sure about the older platforms so to avoid issues on older
>>>>> platforms we can enable this for all SDCC version 5.0 targets ?
>>>>
>>>> No, there are still a lot of platforms. Either explain why this is
>>>> required for all v5 platforms (and won't break those) or find some 
>>>> other
>>>> way, e.g. limit the change to QDU1000, explaining why it is _not_
>>>> applicable to other platforms.
>>>>
>>>
>>> Thanks for your comment.
>>
>> No need to.
>>  >> I agree with your concern but for me also its not possible to test on
>>> all the platforms.
>>
>> Sure.
>> >> Lets say if I want to enable this caps for QDU1000 for which it has
>>> been tested and on any other upcoming target after testing, then how 
>>> can I proceed to enable?
>>
>> Let's start from the beginning: why do you want to enable it on QDU1000?
>>
> 
> QDU1000 is one latest available target where we have enabled this and 
> tested. This has been enabled to save power.

Isn't it a powered device? How much power is the save? Is it worth it?

-- 
With best wishes
Dmitry

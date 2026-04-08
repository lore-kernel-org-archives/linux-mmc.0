Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5C3019BA
	for <linux-mmc@vger.kernel.org>; Wed,  8 Apr 2026 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622250; cv=none; b=S2o9DNdkudO/qGQg4qvuyXu1JBp04h26qRTknb36zi92qZB51baixwH6Loc3G+84rkouI5lHlt3rZo5xXGUsHM/B6gm6xfFLl2lqP2vYgEMPnuw/d9H8Ux324e+Odg+Vn6Lkd9rhHj3RD8WkV1BZ7uF0Kox7c2WQapJuvEMtY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622250; c=relaxed/simple;
	bh=IJOgYgOKLfzsduMNOuNRKBK2CZadWAfXKCim+jSb6Mw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aoQgOdxBwf0JGCR4rxdLmztGg3oHqaJ+vlF2Uet6nVl5xgBFVbQIMnKdoNq4oYXfwfG8PUCENPtDZSaaWuROzgS/Ezid0oB9TN1CgeAHp4x8+fjs1VrMNThg4VKAVV3pC9rIjiwBAu3RVU/QWV3OPuP2qX2zrjVqs1qoYhjLRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KWJ1oFDv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dj/acHfi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KWJ1oFDv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dj/acHfi"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637M4PTN2860735
	for <linux-mmc@vger.kernel.org>; Wed, 8 Apr 2026 04:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PbbVj97jX5V7I3ImftwwIPW7XZwhvJYdUHnJ5ygLavk=; b=KWJ1oFDvBOEaTnhR
	BWmB1yLCX5RwdWjYBaEOGjFZFIDqkb8Oz6GLfMN9BBOC7FtR7ZspZqfxiOnvWH59
	/iQc6FMDBeRamRknp7VJNNWfBbpIe5DkQme18WyLa0w4CqSWky1+2XwXCKiKslK1
	bI2MES2PDg4Fyt5eUyL0/kHWzX3f+F0XLL2pqCC2idhRAaih8DbE2F0uanY76TRp
	4aVH8X0lQC9OtcLB9I5KcXHTdYRsZk8JaWBr5OS34Iy/9wAXQWq0GocGPFq9HBSm
	G9TivZd/0fZXx75KMp13yMT4C88mGY9ZyBXuuXOqiSRsp6WEjfp1KoPrRWqGVSlI
	VvET6Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddad8rx6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2026 04:24:07 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76c2bb3149so349543a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 21:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775622247; x=1776227047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbbVj97jX5V7I3ImftwwIPW7XZwhvJYdUHnJ5ygLavk=;
        b=dj/acHfiAJNkPMNOt28IUVg/46tuwCEJy2tFE54ThTD2nQBnvjYYtSWEKZWpDC+Ksp
         /dk1h/0PxqfQiCtoaVzBhjrG7els0cHWw4VZ/NJLgifpFcHQH0ai5Aj0+faOASz1aPrz
         p7rMVDo4UlYRVb4khP1hP6Wd1pgnZEjwz9lvYQRG36KNkGwl1serWXc8tGems3Hv+nv9
         L08Z5vZvWfaWEVeG8A1A/1zEmWVJnH4POLhNgZn2KjjxsbSHVxMZ//AVRwZBtqW7cLLK
         MQ7EEraesKTGHRylKqGcbu1dekMlS0MDVfioViE+JXIrTbwe5P0Cqu2+pJVBSqg6NIgX
         2WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775622247; x=1776227047;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbbVj97jX5V7I3ImftwwIPW7XZwhvJYdUHnJ5ygLavk=;
        b=DnAB4h4Dl3P5ODaBwQmV9RWByBfXb6fuqs36hWAW7zgSPecWh5uiQxV5aa/sTKVZNt
         u8xDCEObWpjmCJPePAqFY9YlXR9OM/hIf1Y+E6tsC/eHKAZHVEq1Ggt3bxnzXC5v2bHM
         LOoYaxmu12dKOz0WTKzsM+ISRRuo7JPld215xi3URCO5rOEjC+aALJsRhkenYr+dsQI0
         XChKaNSYTWzlUC7VGLyPApGBkcORK5ZlN75NKcPJCjAFIg1eBSZCUSUcafutLdj1ySu5
         SPV9QMFT/3BvpFzJSRwKKRUr29eRyx4aLfLk2TY7l1qourM+FNy9aOlpQMHqeCLMUXLX
         UjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV+30t8YZmzWbJnngxez4OTJXY3AoHurPXUE2Crfav4eCcewCreIpvRPQMeHAd1NdcTP0m6Gi2uoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJPFBZLNVVjX457Pz5YRJWvk8JQ0HwivQi4gAHTxeYD0xq8M2
	B5ykE1rNKEMlKobkR8lYPX2G+lUlVEpW8WGupJChr/l8oBS2yK8Rqe1bRoNgpoqYMQ6sEMa3vYk
	P5MIr7twOlLPgved2+1Ii0gqbnqVPDUEWB2RKnq6IbtlE+fUpv1d88BRBoyQkQ24=
X-Gm-Gg: AeBDies0911y9l9vCAOnSW57RwNZDec2jgvMtVxzi2sQ8vKE/TJPfsw1pTZwq7TxgRg
	XRC0KCS1rLy8Y2U1XZS/VTgB6MRPuB6MIDh2r6XoM+oAhK/35sLDecXOrBFSDp5BhJm230505w0
	qey9wXpbkBzJd8hKp7GKsU5i6aokS3Hxk/FrsUkRRo8zdH91nn+NzNMzQzwoewxi9aU2PIkiGHB
	wyoyjMdPBV+rU7h2ex/P7wbZLC3CygmJ1tQ28/UHfwFxPkcDzyNWJHqncUSBCSOljsIGaWYb9Gn
	C3/dGSa+bhDyBpt0WgWab5kNN9Bntwpu53mDk6F65ZxDMBEQVriyZyIfst83DxUREZeNzA9tI3W
	zXDzf0ELaWbC1I2k3XncudyAvX4RVnrGwcia0KYJsD/YmHoKRUA==
X-Received: by 2002:a05:6a20:a109:b0:39b:897c:6f8d with SMTP id adf61e73a8af0-39f2d9e7529mr18743270637.16.1775622246693;
        Tue, 07 Apr 2026 21:24:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:a109:b0:39b:897c:6f8d with SMTP id adf61e73a8af0-39f2d9e7529mr18743247637.16.1775622246199;
        Tue, 07 Apr 2026 21:24:06 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563597sm20655477a12.16.2026.04.07.21.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 21:24:05 -0700 (PDT)
Subject: Re: [PATCH] mmc: host: sdhci-msm: Fix the wrapped key handling
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        adrian.hunter@intel.com, ebiggers@kernel.org, abel.vesa@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com>
 <x2mmttyg5t5qjo2tyrwqbynqylqqlulu7fhoyxl7vd54geubqx@qna6vzzr765y>
 <dd2c0522-91bf-5375-f5b6-7c9ff5304fe7@oss.qualcomm.com>
 <CAPDyKFpXRPx2Z8Ro3f3BU3ApEn3rHtXhkO09-qjGjHwSEH5dmg@mail.gmail.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <f87029b9-eebc-a947-dfb5-1ab27d9b54ac@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 09:54:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpXRPx2Z8Ro3f3BU3ApEn3rHtXhkO09-qjGjHwSEH5dmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TWxZd81mV5-TwcO7_9P7GjGTQNIvU0xb
X-Proofpoint-GUID: TWxZd81mV5-TwcO7_9P7GjGTQNIvU0xb
X-Authority-Analysis: v=2.4 cv=EoDiaycA c=1 sm=1 tr=0 ts=69d5d867 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=asX3J4iNEGbadXDLWWsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX0tlZ7GQ7MwBK
 0iztxtyHL+0ni6WYzVIKlIm2Rs+gEIZlmPzi0+gtGmRYR90XdQBG+lmgfVmQEj7ieZ+B4Zn22gZ
 q71KhvD+fp3UFawvuklR3/418nHFPxc4+ydKIa0pr0sBavgWFn/l/RI/wEbuZs0V/lLgh8CJF3E
 Ix0OStlwThFt5awm6VfA5NAXM+PHBq5zaf68uA6+s72Y/AWEwbjn3LLtHU+MA7d015mS4EBsbR1
 BuXhj9zzOoCtPnF5K1HLmupYGNUAI5ohIpJYd5Q64PI1VJUmvAU+6eXis8K9PsdNYty0ftzGcK6
 ZwtSDB3EwgcfEijyhf0l+vHuPI6oRoV03Bd27cEGxgAYvPJ1uEUXV+23+YVgaS95K8pGESnNM8v
 XSP9SiRgZ6gaGrRbyLFw0vSj3i65LujKQx6paTcQQte0RVyx3KmVwHHxdPTgdj9R/8BHkcJMCZv
 atLEkBrh2MkQ7VdlAiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036



On 4/6/2026 7:17 PM, Ulf Hansson wrote:
> On Mon, 6 Apr 2026 at 09:29, Neeraj Soni <neeraj.soni@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 4/4/2026 1:30 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 03, 2026 at 04:29:49PM +0530, Neeraj Soni wrote:
>>>> This change was originally intended to land with the patch series:
>>>> "mmc: host: sdhci-msm: Add support for wrapped keys". The fix was present
>>>> till v4 but was accidentally dropped in v5 while rebasing.
>>>
>>> Don't describe what is being changed or what was intended. Please
>>> describe, why you are performing the change. I.e. what is broken.
>>>
>> Ack.
>>
>>> Also, likely you missed the Fixes tag.
>>>
>> The SHA-1 ID for "mmc: host: sdhci-msm: Add support for wrapped keys"
>> is not yet available in tree so i did not add the "Fixes:" tag:
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes
> 
> The commit should be available on the next branch in my mmc tree
> git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
> 
> commit fd78e2b582a0 ("mmc: sdhci-msm: Add support for wrapped keys")
> 
Ack. I will post v2 with "Fixes:" updated.

> [...]
> 
> Kind regards
> Uffe
> 
Regards
Neeraj

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483797;
	b=ea9lj/uB/7g/rLEjKu2eyDuU5lhX6fWrpKjsSgoBvnHekP4k6Ii3h2+vkCvJnMIBTo3T
	 Ka8fBCxHolqNzrR1R2gutsoXmW6S7BA9EI6twY9LV60zJdgC/bJJaFAlemv0dCYztj6qR
	 88VQvrSeL+b3/Cu4oMbBPoVie52NnvMx/PukfEv9BRUXPZbIxLWmXYRcdZwsrh2zEkdtu
	 YRi+BmIBvMBaDd9DGLbZpUAPenX4SqtlIu/d8jCgJX2JZI75uYcB7poGx8nWNtgOHBTx8
	 3uFsq5RuZCHlV6ZwKUW7+yqXzJY4OWjxyQvlgIs9HwqEbRUFqqQ/zLCoEKHwuCthgGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/UsmZJteRaFetcrcRELxgEEeGkrhNoxIFJFDkJKP6UA=;
	b=NhIhF7YQh7nGWLwzudNhc6j5VvmQ355lt1kBuEjgK8iSh29QUKb4CRd5fTmOyxT11K0a
	 IJOw9qzRQzGBVfse5LrGg+N6fOLC3hN2WJp6AfWx3lkNHUbwAV5FR8p5p4UF6K/NTP+SI
	 4S/6kUuVXQM/rpDx9wk0/PSba5RwAaNd0lt0PpUQL8Nx+qSkRb+kphwyDF+opZpJYXoZB
	 1Rtk2uwlh+QDEI4hnQBatTo7apgh9G1Uq23fyO6DACObJ87eTxPATWfvvybzuC8D9v5iQ
	 99R3vnFebEkrKVlwnZvQDRTM7bPJ/hy61BrHoaW84XZeNMeadb41UrTrHDaxLmqmPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jMyJkN6c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dlNsDC7e;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE589606A33F
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 11:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE589606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jMyJkN6c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dlNsDC7e
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAmkDN2555413
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 11:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/UsmZJteRaFetcrcRELxgEEeGkrhNoxIFJFDkJKP6UA=; b=jMyJkN6cn3Pey+t6
	4FJSf4pRce+aHImgnkYtusCwP5HDljsirOVP2QTdMrAV6kBAr7289H+ZHBoKdeOw
	9IWJZJJX/jOgqMN0zxnghXIn7ThYL2KLzrumuYKMLIPhEPlVW2HDS8u/Ao9M7zj9
	zrNIOGksuyAkbXeMV3mRZK9RS8YQEcRsnb59S9hhkZBhOoyaCHqJps38hV7qG/J3
	Xe0tX2YXi7UH3Cq9zjlNgVKQMzG+DERrpC6OVP6dqGgR6AaNYZ6S4DQuO2Z7Nnq1
	eKTroqerpmhAOp2aF3PGjbHQPNv4WxucwcLMG1jZyIt/5SI/oJ/pHcvdMri8hA3T
	4qeRqQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwc1j05nb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 11:43:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0c7ab2427so3516628a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 03:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794483795; x=1795088595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/UsmZJteRaFetcrcRELxgEEeGkrhNoxIFJFDkJKP6UA=;
        b=dlNsDC7efncryoB6kjy/7n+VYE/nkSwEwEj1uVqyFzjCB5/N7xOeOS2SOsotpnsmDs
         /zBKWzphEipaPiGEnIWVzkPXo+k6TR+iTJTXyct9EynZ954r/O5tKIkYlLXOlckIhDip
         mTihcpmqA/j8CmzG6aFa3IxqmQW+P6hwwURZKdpt+fRvg4ullNRNV5dmkq1TwSrX58oS
         qEm2sDrdgYS5pD0l3sLul99Lgp0i/jLys5hcOtpu8saC4qtWbaW7ozwhAI3dtPfRWQA6
         YlktiKdzCiFpAyygV0I/FDVdYtuq/+7XoV9MppP69D80tNZyf069PhumW3fwG6SmZD0u
         wK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794483795; x=1795088595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/UsmZJteRaFetcrcRELxgEEeGkrhNoxIFJFDkJKP6UA=;
        b=xGdOU3N7IOhDdeE+KVu0RpwzxhwU6Pe2xuFOVcWaXKrOtjtCj2m1qzwqC3WvXPxXNd
         mwfVNW1v+ulfzs5eo59LS0GyDkFCYTxS9SYWOXlmWQMAm90vKHNwj545gwx+CjEME0Cc
         3ee7gN6SIn0hOvz6DiMbVESjp2bSOkqoZRKAj5LOtlkNt1IdkQyULbKyZ2XIqq6RjG2G
         lNEsR49ZRrQ2gZI93BT9bWsvuITHtPo/nUoYnggIpDDL/TlZucQLYxAK5dtd/1OSozCo
         G21HlfjzMDDaf4/mwPLQgsjHIFAU8VGSS5YuymJ94XAT1fes+OLajZqgFB4KewxYRwyC
         /l2w==
X-Forwarded-Encrypted: i=1; AL+hErHG99/YG44JrMjh5xvNyroQSnWU/ZA/JYo9qCMUucsDmcreuJ1qhIFRrsv5Bta7hf0AdlJBaNcX0+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pBiwSok8g+NkqfFmcIPMmeu+HVsgd7ZHlJu5ftOayRDAnyY0E
	bFwGOOC8WrHZvlMLSMbulT/l7XPxLmY0I6HMwjf7qPn4o4qv2WVF7ZK2QBsU1hWYR6kbRXi9+9L
	LBpOD5wAptZSkOlN9La3hTFo9XxAGfa8yO1lfCf6xRS7Z7cXcvgL5YtGNeoyn1tM=
X-Gm-Gg: AYBFou1RFzMEK1Zav8j8DBY1huhJtuUuLpptPg22eZxfMlubPJKV71bpDY2cHheSSMo
	hbA/HnSxjRg/2fOh5et5MdaTm53iHHzz+4wmmjjrq8VcZiRyHkJ9KaYZTmPX/7jBa3u8kEFeKsx
	d9BaqdbyqBoSp32PtQx7jaUbHfWFoKc9t+r6zRJpoPMQUmHftcM+ZKZkhF/CtoixNJWECyzkPsl
	QhxIX1l/Jdv3HssX78OkGg3XEHcZWarietq9lFUBJ432klGwlK0x28sb1uILI/x6P1nlowA3uSv
	fwhR6Ir0JckvszsPuN0fMvu8s+jBStenqJCztE4RsSmpJ7iCiI9DAQCRRCjwPPS7Wd/lcWDgqAu
	t68hCgEqcDHma3+jKbCYlCsTGmc/VNQnzvSM+XZtO3wR8ufkte4TcyZQ8oZTdKKXEWLdlHzTcP1
	gyTe8=
X-Received: by 2002:a17:90b:3c06:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b182df2f25mr4726546a91.1.1794483794720;
        Thu, 12 Nov 2026 03:43:14 -0800 (PST)
X-Received: by 2002:a17:90b:3c06:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b182df2f25mr4726519a91.1.1794483794297;
        Thu, 12 Nov 2026 03:43:14 -0800 (PST)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b2cdsm4350657a91.16.2026.11.12.03.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:43:13 -0800 (PST)
Message-ID: <d60b437e-b1df-4a9d-be3a-a53c2a369f84@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:13:07 +0530
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
Subject: Re: [PATCH 0/3] ICE: Enable runtime PM support
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com>
 <CAPx+jO_ywfJUAGs6Zo8yJyTpqui=qN-T9qqWN2hKCyeegAeF=A@mail.gmail.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <CAPx+jO_ywfJUAGs6Zo8yJyTpqui=qN-T9qqWN2hKCyeegAeF=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NiBTYWx0ZWRfX10V+i7ji8hQu
 4P9ewbuHpKpFVdgwt3El/pEaCKzfG03SUvWrB2cJ5yHhAl6KaPVhWaXKfpD6W8cXgoLtU2ixc6B
 hLIKnADVmokH6CMvZlvOXq7Z+P3Upwo=
X-Proofpoint-ORIG-GUID: JxK3nsK1rajQAfBvYfKwHwevixBC_Ubf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NiBTYWx0ZWRfX1mkk+LvXEy6u
 lnBB2oSZiOX3SkLhPtqucDvABbbCuNpG5Jzg/vihWuse5e70bT7BtxJBV8nfgR4x2vShniu6ji8
 pz3jtmi8o05mhd4UeIA5uoqJNeVEIHy9/Ng1iSRfD+Ued+VApGCP/+LJv2i0C02JW9XDEOhdw8f
 6JPDf+zReViMcLff7GTnBVcwTtmB+7i0+orJfEb4qfF9Z08AyLsOVfMZ53tyjRfX3l3sNLDhNzv
 Sdc235ShVFvvX7f+lMRKI/w/fjA8jW08bWvxBpTBb3a/KSup8hIXFjKq9T0Y5Dx7gPZrxVW5tfu
 P31WKctJ7jf5KOUuo1rleRL23p/J/sVBQsPVFZkYUTxO+3lwWwReaIcuhWDT84KSGfqOVumJRI3
 7QjX16vnqaFQLCGmK8yZOx9E2wVxuO8S1x2ov/QdO8q9q4XK924F69wMwk6NOVuE4QuLNYhph8q
 kfJNZ/wpCrcsos5A7Hg==
X-Proofpoint-GUID: JxK3nsK1rajQAfBvYfKwHwevixBC_Ubf
X-Authority-Analysis: v=2.4 cv=Vqe2kO2n c=1 sm=1 tr=0 ts=6af5a653 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=wrTd7Yo2M8a-6LQTD2sA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120046

>> Merge strategy:
>> Patch 1/3 and 2/3 are storage driver fixes and should be available
>> before patch 3/3 lands otherwise will result in bootup crash.
> 
> Then it's perhaps better to send patch1 and patch2 first to get them
> landed as fixes and for stable kernels, then when that is done, please
> resubmit patch3 separately.

Sure, storage fixes are currently not tagged to stable versions in
current series. Let me add tag in v2 and drop patch 3/3 from this series
currently.

-- 
Regards
Kuldeep


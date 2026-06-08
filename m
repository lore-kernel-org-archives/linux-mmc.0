Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FF38F64C
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915501; cv=none; b=MYGHAC7IcGNicGuUbL+ivZgK9kruvHcPId5n3LT1HlbIAqNgpTMFMppSGfNgtRClh6WwzGdksD1k5qK7jf6kPi1ie/8OWEYaMdNYOWFelDEW/RfYgE1zO6THHrYm6pRawKH8tyivHmbnlnIfgEYmGbIQfT87TVYoTtSN/TYy3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915501; c=relaxed/simple;
	bh=OQ97Cl/j+8mNGrPW+dDWj5Pi8p/nlY2y0qd6lnknoRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE+DdqBP352Hoa0E0yuX3NNv1DdL+iNcDDxr22lr7nQyJJUzqxJMHvakup9qBR4vuun9MwMC7NHgM2sLOAyTVup2ruN17ePiNZbQkS8yp/mB0uHLqiq1gSRZkgf8hb5vh/b6S/ILI8OPztpVs+GE2jYhU2K340RXmIs6amkRS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nrDDqden; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YrsYq21U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nrDDqden";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YrsYq21U"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Oes22385883
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 10:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41jb4hFcUfRoTHuONKjpdm59JB4WXIc01LJAry3rtD0=; b=nrDDqdenRSeY3pXx
	5CZfMJp/i7PtpoAor3mrjCDbtVylku7vRpGYm8pQjGrQ5nnm1l7ReHFEbNfZgq6z
	HylNp6B9dB7yZ3qrkfO4et2+s1SHMmMgAKrmJHwhjL648ISp58XxV5qkOc1Rxgd8
	+Nbuc7HfUv6QGrCYwCp/p/Bha4q+lFNEsZmHC3aFQQX9nNTBfGbdCyy1ErQfzITc
	+Ca4IqnWz9GaQ41zH+m6xU+MJdlUkGDMB7cPxG+e3C6HrHg6jZ8KqquFQWzijD0o
	VG+gzVFvpXiT/TU5tyfdy9Ng6E/g2s2jsQx7VZWvXsmNgTB20avQMhrWUvQGIkIC
	URIPwA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8y86s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 10:44:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5178ded346eso7810041cf.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915497; x=1781520297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41jb4hFcUfRoTHuONKjpdm59JB4WXIc01LJAry3rtD0=;
        b=YrsYq21UMAig6JYV1O6wtRI/HJMfZNm344B+DjXmBmZw7daJlGBzMV3hEvL9oYnHUE
         nxOtTi5mQPL3l6T9OieM5S3LmRP0iy43bAZMKMWIulUexMVtzTg1DLUz89bIWvd8WlDp
         FSb7nPSwdz8FI6F8oMBfXqzVHIz36EqgqWU41NvNPBrdlyIYTPt2xn29vx25qVVb1ti2
         3rAF0qiqbjasnUI17YrKlz1yFE0bH8QGBlCkQGYJPb84mW8Oo0Ri2aE6X2TU2ksZswYJ
         2lFJixplWc0XeB8GpchzR01NWXtpXZMDrhMyOft7H9+IKDRiexoUt5KHykXZ7z0AGbGT
         LV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915497; x=1781520297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41jb4hFcUfRoTHuONKjpdm59JB4WXIc01LJAry3rtD0=;
        b=RkqltaeVdxcBmd7xxAErCn5rffmaZ+0jtZMF3kx6vD2e/bQLtIXoPfpWYhC0Et1l7h
         /beNsCC7KuRyoMl0lmoxld4EISgkAAhHGrNJfn/7c6HfP/iLNqs8QvHfEV2T1RJrbFp6
         c2RjAmH6ju2rf0/MAe/bghex7wBXv0qWl57E0CCa0PLD+49bGFjQ9I4qEW+qYYAFaTeu
         h3pSqWJPJqjXoG3ghI18OJd5o1dXq86SnrEloZLJYnpZUVVp5X54/vr58XdE5dYe4n6q
         +TeAtIbt4TbhVtsiIsvPYc4phvGaz/G85D+yGS/BVChGiSN8xD9kWwkbMCtj9NhppN7i
         U88A==
X-Forwarded-Encrypted: i=1; AFNElJ8R5HjIX1S9AWCJy85lBXJSH3G5KyDddYdElg/8HqrdUhk7cXLFlzVXNbp00zYa8X8e7QmGfhfnhHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfdSLdR0fuhVQwVHre/8aEu/UbzA5n3/qbsrqdFYUSZA5Tmyc
	2NjEtOCss3GE2/odGQxVy8xIcDxE+bFKgHlijk1Wjkm+glpJlCDqalyubD01DpWAhovqJCVg2OA
	FAr6ursYAymN7mrlwMdJoj7owAOpDt+n6cdz/LhJG7kT978fMdYXtJevijIP2Mjg=
X-Gm-Gg: Acq92OGsKaYl61lWo27Z9bYI9Be8weHkBj8mGutF9Y9OsdOYgGeky8OFvc9vZBN6O5E
	aZ/QOcNRRdpy8RNiuLtvY3x7FXn7jlBtsLYxFg9wgKCG9ddRaiJmC6FBphcfSMDuccSXsl1p+L7
	4SLOeWMoFmC6CfzasJoqpk0lydN1pAb4ULi0i2l84MDGWgIxFDFBSrInjhzAKYtLgJNo4WyNrlG
	agk9gEpJytT0J0OvOSRunX32tJPYoC9hbKWIBAFqdgbSs5gHssZkTvxt6YBi/TAGBh5CE+62cPi
	8/MnyG91UpPaIXXC8KXOreHjrn0teocB+gOivWvaVAGaNRRf2f6K6CC0tOq7fx6FSYzAPVZx9Us
	bwRJZ2QhKmdEjBs7oGpJBklGha+hPLdatBaTQJQounLMU7YERrxL5YWss
X-Received: by 2002:a05:622a:904:b0:50e:6311:7380 with SMTP id d75a77b69052e-51795c0d8bemr109932001cf.6.1780915496974;
        Mon, 08 Jun 2026 03:44:56 -0700 (PDT)
X-Received: by 2002:a05:622a:904:b0:50e:6311:7380 with SMTP id d75a77b69052e-51795c0d8bemr109931761cf.6.1780915496521;
        Mon, 08 Jun 2026 03:44:56 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65b58596sm6943544a12.30.2026.06.08.03.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 03:44:55 -0700 (PDT)
Message-ID: <18f5e5a0-de70-4d6a-bc5a-93d402059aff@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 12:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
 <20260522-shikra-dt-v3-3-80ffde8a3dc4@oss.qualcomm.com>
 <63752557-6468-4aef-a847-06aa39ce108d@oss.qualcomm.com>
 <3758be2d-4553-40b3-8ae6-bc3e502d0531@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3758be2d-4553-40b3-8ae6-bc3e502d0531@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jS4hyT5_QPxiawV1sxbu30Z7aLH16w-G
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a269d29 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jymwzkz8D7XtJHPt1hQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX4a6o+8vEekHi
 yOEK6Bdx3K6UhEc1JrzmXy0/9QfO7lacARrwiaojtRUr2KoMr9zxKaEYy3IEvdXA30xZDuL5FRo
 FKpgvajStc4ZfZe3SAHHK2kPKXuw3WyxpOJEjHX+JnpJhzR0z1FhEPwgkeu3Jc9+A1KF888sea1
 1Cc4gk4qW+W8GRn/RwiNPL972uGqpghkU7QnJlYQxbL71hRYyDR6U/GWZi0YX1/+YJkdyE5FKW9
 4gfFrbdoFwH5qlZUhYM0mfGAnRShs065DvorB2UQ2ibBM0kD8k9jsNEJSxLwWzYfpwXI0fTlBgM
 7hd1WTt4JiQcFWCzv0zA54RsLRZUx4vjQ4Cblk7LvkaHEhqqF5zTKokiiEkeawx5sf+FgSI7O6v
 Y6WIq1+cEX13GobIpH4s1JJT/Ue3G6Wu30UDmpP/Hi+4bgXsKtu1ZlwtsVUTDbSELL5ulqG5BMH
 3iFGQVUoUuqWf5nd4Mw==
X-Proofpoint-GUID: jS4hyT5_QPxiawV1sxbu30Z7aLH16w-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101

On 5/27/26 3:32 PM, Komal Bajaj wrote:
> On 5/25/2026 6:46 PM, Konrad Dybcio wrote:
>> On 5/22/26 8:02 PM, Komal Bajaj wrote:
>>> Add device tree include for the CQ2390M variant of the Shikra
>>> System-on-Module, a compact compute module integrating the Shikra SoC
>>> and PMIC for IoT applications, designed to mount on carrier boards.
>>>
>>>    - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 and PM8005 PMIC)
>>>
>>> The DTSI includes the common shikra.dtsi, adds PM4125 and PM8005 PMIC
>>> regulator definitions specific to this variant.
>>>
>>> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>>> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
>>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>>> ---

[...]

>>> +&pm8005_regulators {
>>> +    status = "disabled";
>>> +};
>> ?
> 
> Already there's an ongoing discussion over the thread [1].
> PM8005 regulators are controlled by rpmpd so it's not expected to be enabled here.
> 
> [1]: https://lore.kernel.org/all/20260525093453.edmqryggp5kcqxxy@hu-kotarake-hyd.qualcomm.com/

Right. Downstream, MSM8998 (the other user) binds it to the GFX CPR,
which probably has the benefit lower latency than if it were to go
through RPM (although I was sorta hoping this would be an instance
of cargo cult that we could just rip out..).

If you add /omit-if-no-ref/ above the definition of the pm8005_regulators
node in pm8005.dtsi, does it get correctly skipped (i.e. if you do
dtc -I dtb shikra.dtb -O dts | grep qcom,pm8005-regulators, is is there)?

Konrad

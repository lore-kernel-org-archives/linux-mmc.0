Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77E382F10
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651492; cv=none; b=pExGCoAuJjeFEqTZE4rlKKkIvb8HHIquyCSzqMfNICNoSAkieoAqsdHYk9CQmIDUz9BORb5I9cZj+yZMCsBcls2WV55uaE/wK3LeI2seipmI7Wl5HnyBsR9wpR3yzTYnz3GtgNJINvZcaezfffIUg5mHs9zwj7DsLgfXpj8z7E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651492; c=relaxed/simple;
	bh=WYEOtTpKJKbVcM32oVrlyRCNjAkwiCmSqVpChK7R73M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sd93aG+DLK3TzDcKybqw7HYWvIOlI0UwpmiO5RKOzG8VhhV/xXrLMuZeRcZx+MVp7yohOPdGmMLdA/A4XEBzjKa94EH91d00hTSXq4nkrfQUOdGD31UYFT5BvsVSpkV7k/FX5B9ISHK0uMaLm+SwfzwfKpeBPhTt71E+zPvSIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CEX2PrQp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RHQmr/Mr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CEX2PrQp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHQmr/Mr"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64cmN3777642
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Ew5aCzTfbJfZsbqot4EZ7SeBCdkQpT3b6lAtmV991M=; b=CEX2PrQpnsH0GmTT
	DPYwpfXotdf94WuXr9weW7ykDEqYV97/z+IN3jWGhHEZR9N4DZ6k8OSNTXAdxoUj
	ywFNYavlXfakz4FrdBYdZ2CAPJ4kUJ8YkhWyjs6daN/X1Zrz5AwQBg6T8sOPBxrE
	nc8LoM+mJfR1ev0p5Y8adF6y8MiktWyTcSdYVNz8dYysV5l9gLfrCMuDTv/y5ill
	srIEd21eUoaLFWseoqAJNS95KadaEe0T2xdsgta1y7TZJBqx5vbD1kv2gp6bRb50
	oIZ7rUuFnrHDLCpQqFgURkVsiYtnpL60awQ2jzqunzj5dLcMKvo6U6NqMD7LP38+
	/ZgjUA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0y7vt04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:58:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aecaae9506so45881255ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773651490; x=1774256290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Ew5aCzTfbJfZsbqot4EZ7SeBCdkQpT3b6lAtmV991M=;
        b=RHQmr/MrGkwHQ+Wd2ciVJw1x3Zg80YcSRpq8o7V4iFz+oOZoEKqlFL3b/URvzO9syo
         3kAUnEvk0CW4n6WPiaxfkdZMu8H06tLpnW7FvSJofMjepfPXlyrpMF0FYG1Yxxn0IU62
         Q45sHHytRBJORC2A1Bn/G6h70rgg46EGX10lQsCQJB8LgW7Oz4XT0178Eto0IiiJdkJT
         fy0ABapIO2ST5qJl9+Cp/kNYuN113oXdA62rxntvIl3dUMAA5uJYP4skJAo+9oA8VLCc
         t8LmBVo4B+NRMKrJ0hyh9Amt5lLHryoz7JDazu66uk56Fv/YWxmYQFyMUIL6pjwRmnTB
         vzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651490; x=1774256290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ew5aCzTfbJfZsbqot4EZ7SeBCdkQpT3b6lAtmV991M=;
        b=nDLSMQo05Q2jCtppTI/AJ9T9fKG4pE82q5PqU9TWs8BPmX29YG40neIDMj57lauIQx
         z1VSksFcfdDNlbL9UQgUsEWFjPb8r2l5gZNoVUde8dCsti3w0hs9kguRcQquY4oVwh8t
         MKAJeAA2YGRMzV+pVcaBVYcW12anvt9IpiIL7a3f4CnPUHIEl2pW5XLsVgrStPIMxK3O
         Rc5L2oCWsjU4KCriso6Y6AvVMBAsiGVbvA4e0hGsrPgyh+7kltaAklP/xPivn+wz+KUF
         Pzu657K7tCCeO15cMvtl/a9RSeP0CT9TA1xvSWtQ5OPcIu2xE6EUkwe9jTLmkCYMMCIR
         kEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcpxHCdYi6zWGF0LEqYhOatn2wziCq9/A7+6umvKNQ88lRqQ5uOXFNtsrZ0IkJ8PU5i5Mnuy7Gs60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGexvyMHra1y3dET7p9+dLPxJyvwAvFJTSDx5kWgFvgU/7LYr2
	U+SAH/kyd13YwKPc7TvAZ/QbjNxl0wFNNRgS7boUV0MH/wnm+ZUiZ1vd79U9TU0UDBKB5kSujrl
	QPE6/qzQopH911KyEi+eLRPJMpQeP0qraKodDkjaaQNPcW6eQe7eDhSk+6YM0QVw=
X-Gm-Gg: ATEYQzzRnH7Y/AjKwSDXROHzFwfpe/NJDUK+2JfGtM3u6VZygVzdKaNWxzn5ns/F4E3
	pbGguvnoKumSNNqeoBZLFYFpq6rnUq+ehYvQZnZdMIzfIyS8t/oub0KHBvmJlFK8EDznoROxEGU
	iYnMy+1QXON4kJt7wNdjDGqNLiJb7xt9yYVqYD8L/u/sZCd7oREGOCnnf8qS1psDOR2k2m+2+R2
	FhkfTwxXhl6MLLPNhBb84ydoSeW1fWIeIEnQ8GK1eFbv5a0OISVny6BaiUvXRn1zGjQCCHiC75e
	OzgNN7pQat9BRvKhsAIZd5qQlMikLapS3fKdUXhUFZM+9iT3qSH/uUMt0jtEtENXWQBoZxyAWyT
	zXM9e4P8EdOjQedcKVcsXvmF0zXTLnL7mDJ7d8Nwji5gaO79UHefLq4m7ZDMjQs8WUg==
X-Received: by 2002:a17:902:b946:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b04f162497mr29871045ad.16.1773651489975;
        Mon, 16 Mar 2026 01:58:09 -0700 (PDT)
X-Received: by 2002:a17:902:b946:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b04f162497mr29870745ad.16.1773651489142;
        Mon, 16 Mar 2026 01:58:09 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8363b4sm100193485ad.76.2026.03.16.01.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 01:58:08 -0700 (PDT)
Message-ID: <1eef0fc0-d33a-452a-9da5-3d0903b1712f@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 14:28:01 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] pinctrl: qcom: Introduce IPQ5210 TLMM driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-4-fe857d68d698@oss.qualcomm.com>
 <05a1dcfc-7df1-4b20-a504-468814a87b3d@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <05a1dcfc-7df1-4b20-a504-468814a87b3d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8-5KWwOxkb8OatF-9GwIrQ4z0s7cipyJ
X-Proofpoint-ORIG-GUID: 8-5KWwOxkb8OatF-9GwIrQ4z0s7cipyJ
X-Authority-Analysis: v=2.4 cv=D9xK6/Rj c=1 sm=1 tr=0 ts=69b7c622 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=B7sYG0t6GpuNDl58wUIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA2OCBTYWx0ZWRfX2RTGre8smiII
 oXl8OixoMnDNSrObIxv5pdU4/51dmbtWFtGa+ZWFUwnhOSwKIIzUMwOPpaoUzwI6hjofS78Z1VJ
 tY41YYcbteGYP+y9DStHIcD71Lz+gmFbtpvpAfTVFtE2pVcYVixYC4Ai8zMTVP7G6nXG+fY7Dok
 7Aqg3OM+41gP92YEZJBAqu0HOr4mbB2DLY3rj56vgwwToICWII4m7pmrsPVdgoubIYpQSlfbCab
 HR293dsjj0RhzzbMLtXjmb70wSFvYsZStGfJiaLbi60X1bhIAdr33H5TUSuK2H6Rn9anjlnJy9J
 M16KxbhXhIzuPcjDWhgo55nsTTDM5EgNIAbkw06Ts4q957TJ55UaoHJzjLtSVlHKPulqLqlcXPS
 jRk6fI8qyyXc2dcV5iRw7oGQTwwp+PIl5Q69sLz+tR+PjexXumHI0X4tNnSnfJ0XUYZ8rn5uHQR
 b5hzsPzlnX1xI1CKLgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160068


On 3/13/2026 6:24 PM, Konrad Dybcio wrote:
> On 3/11/26 10:45 AM, Kathiravan Thirumoorthy wrote:
>> Qualcomm's IPQ5210 SoC comes with a TLMM block, like all other platforms,
>> so add a driver for it.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
> [...]
>
>> +static const char *const Led00_groups[] = {
> odd uppercase


Yeah,  in HW document also only this name has the uppercase. So I just 
left it to align with the HW document. Do you prefer to change it to 
lower case to maintain consistency?


>
>> +	"gpio23",
>> +};
>> +
>> +static const char *const led01_groups[] = {
>> +	"gpio39",
>> +};
>> +
>> +static const char *const led02_groups[] = {
>> +	"gpio6",
>> +};
> What do these 'ledN[012]' functions represent? Are they muxes for
> getting activity/status signals for eth/wlan ports?


Yes, that's right. These LED functions used for the eth/wlan status.


>
> Konrad

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F01352020
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191504; cv=none; b=s/ImgTn+qG5KtVj0OZpuxCgUdMHniRYuHbr4+RBfhohxUr9406xtoQRuD68j+x53HJta2JFcztzv6AKAyXPSGJ1fp2ShrM3d/RgcztDMDcGLx2dSGp7W9JMAKZmemiFm0wsXs0osR+ESr6bMD2vzM1p/XcvoFf42apA4mbR+EmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191504; c=relaxed/simple;
	bh=8886y9OK7rLNEr2zlaE8SlacINuysTCFqKQRD3SXm8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFnQOS9WPqHXpJbxZxCFJzybgnGzAqT0wFxWi/v7/xyyWK1QKEIqxscs31PlrA4hdJ08UjrivU3KaHKA2Ksa66hzWkOf47zzrjQzBIgbuZYEnM8JsVzHUQBHynVMiyhP+ydJadzcGMi5q07fPOTCF9J0Gthoy1IL0rEDGVnmXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQ6smCqC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T0yHjBsA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQ6smCqC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T0yHjBsA"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9lCF41258570
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8886y9OK7rLNEr2zlaE8SlacINuysTCFqKQRD3SXm8g=; b=KQ6smCqCRl3S4GLo
	oL+Guj+g0A7gNDWly4GVS3iiDLztIRrXwGpR+txIWbKYvVgXy3j5MJU36QgqkYdG
	Dvtge95w5RUfAKhT/t/mkGJf5f4X/We4YVBhPZUtl4xT3Gs+r3RcmX8gKrZN+DZz
	3lnZK1ytX4FYhoK3dvJUHiwr1MQsMhVDDEovCmzohqmca1Hz7xkAd4yMLyYUoIUD
	0m71A7WMIpAvYeYHarzElfnmr34YXwePzqEtAoC4ySz5O/nP5hpFT4GjnwaNMHJ4
	7AmMa9mqBJ/ciqFpEWwfWKnuLfX1nK27d1UQCmN9a1/WFIM1ecmadUDv0YSOmcx+
	5e7AHg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8nhj8etg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 11:51:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-910552aaff2so46890385a.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779191501; x=1779796301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8886y9OK7rLNEr2zlaE8SlacINuysTCFqKQRD3SXm8g=;
        b=T0yHjBsAOyXp07WDqjSiZAQ2bwmIsHsaY/rAdVpJKYKD/hSmFnbiQJtUy6owDTyoLj
         kOFgKUqsOfz6Zng04jzj8NBaaDqeulfuUlsh7z7pwIMejJ8UKPJlA0iEy6ornogBGHwZ
         yS2qcQaK3hPpmjiqd8yP5chSV9uokM9XM50GRJAUHBM9XEBUjwjVEF5LrjXSObqgGfvz
         t9UbcKV7QDgI8vIkC2Ju0XqNLJe/nTpOh87YIj0MeoK0dMzsKL/TfMnvy/9j84+8X4F8
         8Tg70izsg1WqpooPGuHiVcrxA/L/67m+Ce5hVSPmXE+DbziMeIXeLJhG3PmpsMmze8Fx
         Xklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191501; x=1779796301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8886y9OK7rLNEr2zlaE8SlacINuysTCFqKQRD3SXm8g=;
        b=RIuqOd8tzXZlcmylaAL3kNDPZYHFtsHHU/6XSR/pUOgYcRALNc6zMbtzYUmDEwTdeQ
         a/4Ae0SA1/IckrgezIz7bY6/hKdwA1nviGe28Vzbx3jmzAVObgGTtpPTP/Q6xwwmEZwp
         wx5Nz2XC8LL63afGV+yfStDIkzda9ium5jSUn2Fpf7PTPy3FFOg3Qz30yCOD0FqbK8iq
         GB1adshFPSnR0WxhPpvKjKINyCoJBKEqHZqs2Xeaine15j51nGRI7Rpu95K4KfTHxGSF
         bbEb+UiuS+e4fkiJvhuzKHoyYHqU8/PWgqAchZHqsubw/XNvEeVynP8iAZb30uKFbC8U
         rpng==
X-Forwarded-Encrypted: i=1; AFNElJ/a07jELWdslhDOcXpSQQ5l2jmOxfe29J1yhlPxGTuFj5xKZlcCdWJxhM0KRT/3TcL/TdtLiZmSDLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkTGmUfR7Z9zGJ2b3tRwdDN8QS+j1BIqjTb1kU4MfBCwN/7lic
	Jej6Z0crZ3JFBygk+oyCeP5EC5W9ikPmvG2dZzDEzDm7JLRD6Nl1jcPelpqEAAHP4wzfhL1eQuX
	01cUvl8bgL/ROl22D5jHq8Ab4x6vppB3pKY7VeGT5Qyb9tPqZhkrwDDTad6KDVQc=
X-Gm-Gg: Acq92OHnnTH/tD4nyvKYAg4dtmqoPiq7iSmUoSWUqBLeGTdftZqqAy8qtGTIa+9N6Zh
	swAkBYAyR18cd4J1mcVccSQe3Po0fBTVssBPkin7i4hl2WlqowYTbJOFwY3m08PXiSIOnJ3C4Vv
	DiWYddnRQ/S6Tk8CxCN41YooEm0KJr3M9OC7Sf70+OJBvGRIbIBOPUhVJDOrwKfSKglj1hiGNRW
	VeyRMY+3daxhjEVILdxnTIr39Qmki21mzZLC3QRRYFzFxMTamxpS2KyEv7s6i9ruTs+gQVJ5m8e
	sNrXaiuqVwuJ94MRCIn4F3kkSxFKTFYrcD2O28ecxoNfl21JgOsTYvF9syhlPgjeZq5OByxrvie
	sffRIlRu9DP9Gwq7oaQEhy9Q4SwJkdGd6qvI/u/QbKqU31JAWEebNzLNguAXf0QnvKp2dlgOEcb
	az0l7o85r8l1UvAg==
X-Received: by 2002:a05:620a:1996:b0:8ee:7878:af34 with SMTP id af79cd13be357-911cda511e2mr1962910085a.1.1779191501622;
        Tue, 19 May 2026 04:51:41 -0700 (PDT)
X-Received: by 2002:a05:620a:1996:b0:8ee:7878:af34 with SMTP id af79cd13be357-911cda511e2mr1962907685a.1.1779191501253;
        Tue, 19 May 2026 04:51:41 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d58df1sm6536454a12.13.2026.05.19.04.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 04:51:39 -0700 (PDT)
Message-ID: <0b1c66ba-d841-460c-b702-8b4530d56f73@oss.qualcomm.com>
Date: Tue, 19 May 2026 13:51:36 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: Add Shikra CQ7790M SoM platform
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
References: <20260519-shikra-dt-v2-0-c01b90fb4395@oss.qualcomm.com>
 <20260519-shikra-dt-v2-3-c01b90fb4395@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260519-shikra-dt-v2-3-c01b90fb4395@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LCy_D0VrdKWLoRSBzaNBq_KM22pcTwDj
X-Proofpoint-ORIG-GUID: LCy_D0VrdKWLoRSBzaNBq_KM22pcTwDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExNiBTYWx0ZWRfXyc0mV/mkziZ6
 CZ9HK6BmQtnBQ390IjZETypPqKHgBOZtR9ESvjExStj3DFK1TPwppLAWULUYfuUrSkkH/UKDECI
 8WELRiriUOis1P3M9eWt1fhZYqdNONhh6eRrsTFnuORLrgicpcMYlUq5SmclTZIu1Sm077j+Wcr
 eBP87DqlBcFeo6mKSa5viEoM5SnKDPTICd8cOYrbf1MmTmvlBGy9aW23xLDt7Xo7bvUX2Va0+CU
 iBIQdQA56N7Waj5atjvKpOO0K0JG7YGIxrtnjPZd2FnCtcJ6WuyThuTj4jzYpd57owqKtQjPrOS
 pr3bvp6HbBV1stEgUqg2rcAPu1eeQ/suWf+kEAG7gNHeI6Q+SLZpxtwVK1KK1SAuRCx8lnGzEto
 onGzHDf/M8cw1p7kkfePQ1rmQQVrw8f7B9MCKvMmAejoq/bKatBkiIwvgOzfQ70PzQv8i7vuy25
 5XUa0SguXw0XRPFrvJg==
X-Authority-Analysis: v=2.4 cv=ToTWQjXh c=1 sm=1 tr=0 ts=6a0c4ece cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=INWPgVgdgEZSfrFqjaAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190116

On 5/19/26 1:21 PM, Komal Bajaj wrote:
> Add device tree include for the CQ7790M variant of the Shikra

I don't think CQ7790M is Shikra

Konrad

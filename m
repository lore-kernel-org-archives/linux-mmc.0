Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1219D070
	for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641631; cv=none; b=ra6JqkxNpNJjjoIYdQcX+RShIiUfTqqXX/Z8W28SKbTDqL1azD1Gpr+o+9ipXFh5fHrKvqYs8L0CErG6HrBxt85l6KfAJ/g+KjK6H9HMkKMYdLO6fJFCSzPjWmMSKJdTK1xSioO3XskjwnCBB7wLBuZITzlHgWiGF8dpQIFwxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641631; c=relaxed/simple;
	bh=f96R7in9nBzMDU72jjLsX7VaIEl+bGsVnCVnVDlJZSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHKkrMxPOiDYD+WmmP1qUbGkTrzn5sLn6BTPiYqRts5W6wgir58f9YXYw8DvxR82qccS4Hf2P8LNKBiqbgRVJd7XqqUw9z0rdpWNC9BR1OdHPh4rc+qj8rZ9pVdP2omTVj8arF8qkal3Uhm7W4fsju7/fcs/l32awUPmSHuycPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HChrMzh3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HChrMzh3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJGIdEe005306
	for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 20:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U2VJSATUssS/d5iFW3jDdxPp50juAP2YhPc5I0LZEQA=; b=HChrMzh3v+QYpCq5
	aRnI18juuzO2vK3Cg5Q/KXhSzlWkHZLfUiMAVZFKIh0cKDBry7hqcAk+Jru9W2Gv
	eS57i5s1h+qGkYDyMhL0Be9MXBF87yRXb/ZUS7GSEqzTvj8Jn3x5eSfmEf81u2oH
	3RwkngoK0Q4+m2yj9Q9yD1Hxbqzb2wNuEgPoAFqC5i0L265vqlejUCWVz7+ZfI6A
	j5H9OyzHzMF1MU+UpAXdd2OgZWBFQBlP6ViI2L7LtJylD/8dveNGwyZ6uwA05Qq5
	Wp/kPCOGjyi5w/NOCW4vJfQ+h/Jrd9zjuaCAroW2H4w/MPcYAwz2Jipm8RJ4qZMV
	YuBQGg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mpw60mqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 20:53:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4679d6f9587so3048071cf.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 12:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641628; x=1735246428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2VJSATUssS/d5iFW3jDdxPp50juAP2YhPc5I0LZEQA=;
        b=UwspLZet5JUn83nq/xxMBby/NVRF9CjdXGzC7yI0tPem8AvSxnqdD8Zu7NDkW0N2br
         xsDQlC1XRkzZA4MFz7TTRU0juBs/RaMFrm6lcfcigXkt9Iw6tuQwHzdbfmTJ+/eKY/nz
         489alBqPSTCSyx+tAUVd2q8bc9nNJgpRx9nyAd2v9dz3b927GHmR7RprsgKmRhcC3i85
         IHyUn3ODZIph2+mEB6IpUOjZ2XXWx5lwhsR6ck3iyYszp94NW9BF66vt0uoRcvo1oxjG
         p4va5Gx3uoH6hwje3pH3MFT7uwN+T661ylk23FyeRbnxMF1v7xMjjMc0/x6cBU5fhuBS
         eOlQ==
X-Gm-Message-State: AOJu0YxcFcXrk2erRTNIE449MhT3w4TXr/SOhUQrZksvuyWYl6kvspSH
	pO619yuT992TeKPXmSfBHTMzo0GcnrrU+dv8sPVR/wKqYHaPbg9boq/chPX/iQNz+m9SUaB8TOv
	/rXLZdv/YYUw7mJLno7T1WZcCyWww6LL248X92bIZ8CJFJT8xINejJ+umwTo=
X-Gm-Gg: ASbGnctNPBYnMZi1BOIXFExDXrg/VZzZcwthCrf1pukL27CGnTNN2mtABE9n9/FQtkh
	IheJWuFOlooyeGPSe2xZFPZSqvpd/JdXS+Pe50OdpQK4EoeytNlc0SoXNHwYJ8HDouL5uYhyb5k
	OIC5VkBN6LZMVLsBz9ghVRGMOnv+zMtgrvHhlhqaNgyGddotWSykkTQvdeccT4Zld2oo0HjgasG
	836aGr2O81y94JGqK+SR655CwwJkrZDp6Rb3un2UZCrdw6gMmKQkPE7AOTo33FgtpNNuLHs6hA5
	F2Mu+jsmAkz543gSqWpXnraQTm0cLIx6Tx8=
X-Received: by 2002:ac8:5a4d:0:b0:467:5462:4a14 with SMTP id d75a77b69052e-46a4a68fa9bmr3137071cf.0.1734641628297;
        Thu, 19 Dec 2024 12:53:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSKSE7Qna0FoEqgf+pCWhHJkBcq3oXpQgHS8U8pdEpYIb4w3wO6U/+yOm0/K+TI9Ep7n7vrA==
X-Received: by 2002:ac8:5a4d:0:b0:467:5462:4a14 with SMTP id d75a77b69052e-46a4a68fa9bmr3136941cf.0.1734641627924;
        Thu, 19 Dec 2024 12:53:47 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8951ebsm101166166b.71.2024.12.19.12.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 12:53:47 -0800 (PST)
Message-ID: <67e5e004-7345-49a6-8e66-f2fa4faac788@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 21:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: qcs615: add SDHC1 and SDHC2
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        bhupesh.sharma@linaro.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_tingweiz@quicinc.com
References: <20241217101017.2933587-1-quic_yuanjiey@quicinc.com>
 <20241217101017.2933587-2-quic_yuanjiey@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241217101017.2933587-2-quic_yuanjiey@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tEtjrfGehaGACTJlpIlNPZnQLK45xwFg
X-Proofpoint-GUID: tEtjrfGehaGACTJlpIlNPZnQLK45xwFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=839
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412190165

On 17.12.2024 11:10 AM, Yuanjie Yang wrote:
> Add SDHC1 and SDHC2 support to the QCS615 Ride platform.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

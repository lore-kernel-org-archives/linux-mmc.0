Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569772036FC
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881637; cv=none; b=FidxqjCopWVoNStd8ldTNB27iif6ckgAEVStHYt8kf90fRMNKb0EmghE4ArP2dwrwcUruXVhz0PG931tStCfa2aFnFAZPqHkbovUAgQeTNtEVg37EeHo9TPBu0uvvt4jDLCAEOzeJi86uF+NTvMQFe6BbGezlw+SNg7lGI3K6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881637; c=relaxed/simple;
	bh=pHSh3XPSaFVV84kA7tilhdhkPW5JX36He6gVwTk2sUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqzWy6LbLUMbGDFZ+YLB5eNSMzZbp9myvnUh4KLx3BYSnwebH0GElE48DPNAaG5Ub9SmKwaYHQKuW93vzQpoeSDPJMNrdAMUDDTsWcn5IESYQdnEz1JYeywof3+ChJUV3GjNduyH+MHuImdI/Wh74k5I8ecfyKHC2K7rI48P+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVS1VXkm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVS1VXkm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PB5oit015410
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gVvgWoKlcV9LtUsUs6yWkyXRhBCiJ5gKYOTtTqqtPO8=; b=kVS1VXkmNnXzZMXO
	RB96+9SH3GtfraqsLuzYUkLUGIGlGiZbu1jkPwiAFiyHPSv5YUs8L9BLxA28bAIx
	vyxVRwKHa3G1ptCi9MnKnvcGe8ZYL1E72zpkRvfaWGLMt+UCf1IISoMHly0RLDk2
	+su8DJr8YA1P0YoWd6D0tlT/lQbiNRH7F40s24miM7hlNQkQwinjvg67ndtATaCx
	xc+dyeVsqgHbNC4jCeHgMieMq9sBkGIIZMoM5U7bMklfp98weGHF0Ta7n+tSd8BA
	Iswx6CsLF9TwZus82XfgwGxgkYGicL7eueSSqDUIZTxiDHkQg/sUhgCo19bGVtIi
	8m5drQ==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ga5jsbbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:40:33 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4d8e3c162so2702775ab.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 11:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881632; x=1730486432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVvgWoKlcV9LtUsUs6yWkyXRhBCiJ5gKYOTtTqqtPO8=;
        b=d1/Nc6Xuu9+H+zypxd7qRg3IAos0i/xIl/04aHtOMt/TNZKy0RWwgdxxr/0aaZc9ha
         0mdp8Y1UAbnh3/08TFU4Ha4wI1UEXrohdzQUv94qBrK8vHAd68EkbrMb0BYRYcoFWf75
         bMPO5mwtwiAVU38AsnmUrq7Gu4cJIO518BD1AtlyjmF/lEnxYveCS40nx96b+tJgf0Ed
         KcJlXW15Ntjd9/ugkw4ZAt5Slim/m6qYO8SR0ZzMO2jVgX0TyKujc73zTU9uCOtRCvg/
         zmOvYnqOCxXNUOaSekBzQL0uQu1wd7PxCKiVrFiH8DPuNHkzbMwermCsWnSVGaKG3MQI
         vO9w==
X-Forwarded-Encrypted: i=1; AJvYcCXeHno88kFApLRFos1YU2QV3BT7klMBmNbcuX3remGd/276jAa2p/D4ZXAx7XdSBpC9DfiwsF0dVM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWldEvfV9H8ZOswu1JeJWy+YQhudTL1pBFw+0IjZn4B/Eq9c67
	+8gOdVmsao6E8ZQkTZ/LdVxZQnazQWIBcmVSXQNUPc47qqDxKYVfz9U9e4O3PmO2upFVMVqHudh
	lfPxNXeSqXeNxduqxifFSwHqcO7J6xM/A2sSAXxYKGny5b7FxH70CPIx6s8o=
X-Received: by 2002:a05:6e02:1566:b0:3a1:a227:c8a5 with SMTP id e9e14a558f8ab-3a4ed31fea8mr360495ab.5.1729881631808;
        Fri, 25 Oct 2024 11:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjSzBGiWU/ckW48xJT/7uhrcEOsittz0zEh+q6ENMSKuiPW4j11zulREu0udCO3SUIwIwiUw==
X-Received: by 2002:a05:6e02:1566:b0:3a1:a227:c8a5 with SMTP id e9e14a558f8ab-3a4ed31fea8mr360375ab.5.1729881631352;
        Fri, 25 Oct 2024 11:40:31 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631b0bcsm861369a12.60.2024.10.25.11.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:40:29 -0700 (PDT)
Message-ID: <fae33f7a-aa29-4254-a846-cf90d49e0193@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:40:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: x1e80100-qcp: Enable SD card
 support
To: Abel Vesa <abel.vesa@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241022-x1e80100-qcp-sdhc-v3-0-46c401e32cbf@linaro.org>
 <20241022-x1e80100-qcp-sdhc-v3-3-46c401e32cbf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241022-x1e80100-qcp-sdhc-v3-3-46c401e32cbf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: L0PgoPqUJWAJAf-neuEemnB7Bb0gajDo
X-Proofpoint-GUID: L0PgoPqUJWAJAf-neuEemnB7Bb0gajDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=700 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250142

On 22.10.2024 12:46 PM, Abel Vesa wrote:
> One of the SD card slots found on the X Elite QCP board is
> controlled by the SDC2. Enable it and describe the board
> specific resources.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

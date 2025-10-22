Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F21F4190
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153600; cv=none; b=N++Ew4UBjAKr1d8yl+NSJuP53+NR7n7cIzylHHW/gk4Btb14Y+qJKrAScoRj8NkJLbA52LxQvX+/vFR1LOACLc2atbSmDIftbB97VwH9L9zpNC9TEjKr1F68GnBOXTtpl0oeTuzTxTi/3GfLDJV++HZ//22zMmgcK+YynCYxDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153600; c=relaxed/simple;
	bh=p5nAGxvrAUP5cnUmvYosqNhypEEgsoHxE6IFoeIxcbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2p5zKzlxGsRzHvtdFpZUEXSGwRqeNclNiB5DC5WorUVCjqwRHtRMmvZLsgASNG7H+px3nJ94mt8aoE9kels9O04JjmneeRvu8t8aWkfkzWQuzy//STzS/heP4M1u8U+D9GWIavTPGrvyNCGwrbFnTkGNJaH3P8kptKP4d9ZBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Thifikf3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Thifikf3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MEdnWE012568
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 17:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SUfkHbNbJjInMBUp59+fC5w+6y+9d0fh7BrDW/sPOT4=; b=Thifikf3LnJuWReu
	Oms09SqNSFn85KENiEgeyFlT7i/h4ffoZl8TTyenEG3/svCbOpuyoAcFS/Z7WjrC
	XkzihHx2j73/oxs/t229GgqgJvRtUsRk7dzOYPrdLcDm2WiwYGxrvNTynD26Mm00
	zOQp3mozMppiiz9p7Oxjy5gDk7fRMY2bra7mwUIoelplbkghJ/okSXMdvDirHh99
	+5bDJqa9yT4ZAkcSHuwVobSMpOSHUvei7uhwXTyxpLZpwyF/vUAXCAdK3+H04A08
	gS5yh0qG1CWv3uO+wcoPY5wMvdjZpR1wwV6dCC/Zks8brZoTLPJPudRK8RixwMbt
	AfHO4A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0kby0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 17:19:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c1d388a94so23351466d6.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 10:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153596; x=1761758396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUfkHbNbJjInMBUp59+fC5w+6y+9d0fh7BrDW/sPOT4=;
        b=L7cn9rvIgYM1pVfrHS7MR6WJaHhZt0ixIyb+G36iaYA7cGCdkuHu9FyLW7Ja0ceKSc
         rNjjofELJN/0NiFUWzVjc6pSxil0se4WYFRUOSjfPFGuLgvyEYt+sgfEyUNuJ1GAU+L+
         tXLdT1GTUBNNFEVwu7IdA/ZnCw7zCsQvn8KOC4eKTVcMnN34lmtf0TkzGGNCKde54+ho
         hPzWpMLaYv3YkJTpHlp5YjUjAsq3IoHUnGsEe7Kz900fATQUAwe6rKdZW3aBMcBmaj/e
         sG8+oQucf+ZYM4qMrL8hyDQvb+obA7YK4zPXYMSKWUgjtVsiv5eelzi+bVxQW7Uc7Q5H
         Jb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyayg7yi3JFcH1qQYP3MB2STBLQtZJC4Zm4dyBDmlC9dUlU0bZjJYyB3mdXaiqSdnPfGk5Nv8jQ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2odw3w00C9oV7G8OEYbRmCIiRbhSrcxDWPkbR6eN4xdnxC69
	bzDAfWsB5/iYW55SBKr7ffz6FerW3w6497IqnWDgeVvJZkiKz0UXzf5DtHa3Z2kxVk8Ic7K7+OB
	IzgiyBo3VRROqCYqDg+lPUYwQfvBb62F5XPMoa3OxdrYA6GBgZHk5+H1X6GiHjvE=
X-Gm-Gg: ASbGncvo2kX1T3IPKTIPkfyu8gc1u1O22r/jh+WZku/2gnsdd80sqp9gnJwzwe97ko6
	jEjyXBzJYH+V1Y+lD4lT8Y7Ilm6nWtqOqwMfXDQKHixWsirQIb/a+1CYDrY9+Ihpw5cOcckjUYl
	+HRO2Zbsje25damVfgp9/bqxTkB77a0IQoxiRjvMbv4o59KhkjhKCKFLAvfEVejsn/Oe6uux/Bc
	b9r5M9dNQnNE8aL85UIh2aPScoBjS0iE+9BFFzfnby8aQIPyi77yMBVYr36+c+uF2Sr6SP+fWCL
	+Fu46jj1V2MmYhkzlvEfkLgaCPg7hEQ1w0tirW2l7Lhp5t+Gjs4caaCUQ/84RMICj3mHpGvtptx
	8C26PfAJpuWUn2mPTZzbfVLffEgNG02Lt7oEmO+W7IYRP7pnzMulYa6c4
X-Received: by 2002:ac8:7c49:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4ea116abda8mr69679951cf.4.1761153596321;
        Wed, 22 Oct 2025 10:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoDqiu6KupAbR/QDMwKjaiqJhOG1EKNGUxTwxB/cS9oa2UhBHiyfq+I4SkjnmLz6AmKkPWeQ==
X-Received: by 2002:ac8:7c49:0:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4ea116abda8mr69679481cf.4.1761153595715;
        Wed, 22 Oct 2025 10:19:55 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526490sm1376226466b.65.2025.10.22.10.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:19:55 -0700 (PDT)
Message-ID: <6235f1f0-6ae7-43b5-a881-d5bb7d8bb8b4@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 19:19:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dts: qcom: qcs615-ride: Enable ice ufs and emmc
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
 <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-5-2a34d8d03c72@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-5-2a34d8d03c72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfXwEgMKvsPLWxe
 NjIRbVLSBheKbRqiIAzRrhenyuWMIRbhqW00vuicgAV6M0g3YPup1ZFF745Tl2U/w2/AUQNKKs3
 gkJgCcoeVw2nfDeenzOM54nAeUjBkYSEf6UQoeO7TnXm8WDfPGahbFgRmP52vy5spiQXmseE3Ql
 B7bdkG0m7H4l0M92SuNbNTXquhLOWvD81abI8MDeO941u7YaeXscUBhIbuz0lh3GbC8fbzWFfDj
 rJ395ln18izrd1IUzQRjYpEIGr5qS2jRE18iqV5GVYaA+KpOhrfwwV/EcXQOI18p/7lUj39J0D5
 Mb8za271NbQIDy2RTH/1qpHIVt5+TiWVLsHwoc9j1wpMMA0zjDdKXVWsf+JxioiS98W9LgOTYzo
 k40zPo5nYEC+xFsrRw0UsBUnyp3QmQ==
X-Proofpoint-ORIG-GUID: exP9LusidteObhtXffQMFEaxOCApCrk4
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f9123d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=67M-hd6uxsQcvR6J9HkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: exP9LusidteObhtXffQMFEaxOCApCrk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On 10/9/25 8:18 AM, Abhinaba Rakshit wrote:
> Enable ICE UFS and eMMC for QCS615-ride platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---

Is there a reason to disable them in the first place?

Konrad 

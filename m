Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918272036FC
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881266; cv=none; b=EwNyA+eUs4CVO3OybQhyxY0NiPOT/GgFy43giG/eOXbaajwFcg2xdYi/eQhFAqTK1Oft9n71pT/atXfQatsQF0qkPv+jfmbFYyBMcH4N26a+uNsEyBkhdzxJ6Iquti3DlAPRRYZOSVWLI/geXkDmiNn/3rwPyGM7XO+QZhFQzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881266; c=relaxed/simple;
	bh=TawUIkIClOyW0NcS8ogjUlWhLRiE3hDxiyPongegp20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzYQ9ZW/XEzWHjFy9sTNLEFHwljiDUojw1XeDW4x/e+82cfcqboDV650/NFEtYOIGTPfF8EVavasE6wcJKih0CM/AordXgDNRavzNaetuXHHW12hlXJc64SOHx2QKXv3jisbiAWWuCZgfz/uwUPVNjc2C29lpCT2FWA/V48QWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=he7ufaXy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="he7ufaXy"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAhRb7007715
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RBPuMu5XPFYH1SM96cH6+OkUhbMqPRIe9igYWGS6g/U=; b=he7ufaXyOrAbE4/b
	aIbZa6PvhGnbb1TQt4o3kE++2gL7MENsRCXVsJN6g9WCEUXF/QzfN3gljxzALrFK
	c9n+zdva0Qbn6VIKMgWXMeobeo9yAwNLiRfSHFPOOpKa2p/JFa1rI9d8Om2tPafJ
	u/p15u1Mil3a/Rb69DHyk67t4KPmxvGf/fTiHncNsYaipwaZnlBXP7sh3Npgya5J
	udFrvfDQL0/2n319BCGuAMJtq2XFhanIgSuH3FaoFMZWaHZLLdWC8N+mbJAobpzo
	0z5SAQuMwNYs0ljPDr7KrECri6hoAROL6SBGxdA9XjzoSHpNXRL0E6iyJAtBLjIH
	k26zNA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fk52n06n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 18:34:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cbe91571easo6977356d6.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 11:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881263; x=1730486063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBPuMu5XPFYH1SM96cH6+OkUhbMqPRIe9igYWGS6g/U=;
        b=kK+SR5RUX31pHhXhMH+693kVa0F97IBS46/9jfeLpZhrV6oTdaK/EAPvWKPR7aEG0A
         OkxR/i8jzDHXrHMF4bowpU+xYjxPV6ZKFrdpt1E2KQKm0p/aplcW+TWgmgTUg9iiFWtP
         QE15kmJW1WMe95JF6+MnBTe8aJNiuuoX5ZY3BI2VZn4kYWCJpbBpkys/dyAKszO+yTF4
         v4bmOgifWMh9nWgaXD4o6euoLd1fCDxjtlA0WIRlFLAqbYmzGZ1w1fZ2PFdErdpYnDfh
         QGJBcwJQ4NRp22rF6uMAk1bo+3gR63hmeLDf3fFQyOmATFWgFLyu+rSnlgqALguiDOyS
         rxGA==
X-Forwarded-Encrypted: i=1; AJvYcCW2A/WZkBFQfYqBfLSph3Ojz/n78YB0/loXXHeuSqWtvd9kolpG2IR6J+hUCT2wRyHM7vW2Jm15h0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTV0jnExDcpzWf/AHWC5/F7hxnHZ7A0D4xowgdw0b2cBNDfyC+
	MBQWZ9L0fluH3EkqzFy1TPnAp3C3OASnqTboFHNP2ggs2p5baFck/kp9Sp5eiQvenfRr77iNUwu
	NRd0c3P2W4g3PWCGR4xLnWNOS0Ww+AWkZQH5AqEHD7Al+aZtUY0riuMWEZyE=
X-Received: by 2002:a0c:fc48:0:b0:6cc:2295:8724 with SMTP id 6a1803df08f44-6d185682eafmr2810476d6.5.1729881262855;
        Fri, 25 Oct 2024 11:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF61L5EfYNf9/oSt0smG+n/0pYUcfVzej6NMfQVtt3nnetsN7IJA4e3ZlZemSZfgjy4kVi6jA==
X-Received: by 2002:a0c:fc48:0:b0:6cc:2295:8724 with SMTP id 6a1803df08f44-6d185682eafmr2810286d6.5.1729881262480;
        Fri, 25 Oct 2024 11:34:22 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b31bc028asm97796066b.177.2024.10.25.11.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:34:22 -0700 (PDT)
Message-ID: <a282021f-5e61-480c-84c4-272049e28244@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:34:19 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: x1e80100: Describe TLMM pins for
 SDC2
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
 <20241022-x1e80100-qcp-sdhc-v3-2-46c401e32cbf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241022-x1e80100-qcp-sdhc-v3-2-46c401e32cbf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ES-Ab4o9tzpWr1scYCBQC4tlvWENM_Vb
X-Proofpoint-ORIG-GUID: ES-Ab4o9tzpWr1scYCBQC4tlvWENM_Vb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=841 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250142

On 22.10.2024 12:46 PM, Abel Vesa wrote:
> Describe the SDC2 default and sleep state pins configuration
> in TLMM. Do this in SoC dtsi file since they will be shared
> across multiple boards.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Not very useful on its own but okay..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

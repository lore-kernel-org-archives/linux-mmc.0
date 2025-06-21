Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E961F4163
	for <linux-mmc@vger.kernel.org>; Sat, 21 Jun 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750501431; cv=none; b=DQl7/jltb5iX8T96w8xIYSZiy7lPc7Akr4Qfbg5OgPr6wF21bwOppNijO3EuhUYjMd/FyhVWiiDfz+eQvL7bDBqeOwnM4PMZ105cqvwXxCJhXK0v55WFvF7cN9Uj8Y111U3WczC6y1V2yQ9q1OydX23eHstoJvmShiNKUiWBvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750501431; c=relaxed/simple;
	bh=TpLdTFKcF/XRek+8L18J0nRWqX7kggdzEKxNv+QMNmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxM30ufaL1dvs3Wtt1WEv7afJmHE/gl+8mbXV6rTshrW3TMXHde+yVKoT2YLITvvxuaHtSLe9hfKp1E0dHWo0HeYagf3llGOjMqB6F62yV80mcGlYpt0tNmveGH6sfurG8cx1m0Ph4FssqB7kwT4P2GfqWWCEDAYXsLE4X/Sj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lt7qSfxI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lt7qSfxI"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L5aXIk028862
	for <linux-mmc@vger.kernel.org>; Sat, 21 Jun 2025 10:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TpLdTFKcF/XRek+8L18J0nRWqX7kggdzEKxNv+QMNmw=; b=lt7qSfxItJQcd4bj
	vkVgf/RGoSAPz8F41MaQl7WhZSQ67RRy7fVew8ndOkOj11gX/ZVjAySh05frYJUW
	UbNQryYQlCEBVDPfVl3pi3B88ck31hv9uX7TB1OA7Y+aY6X8Kz25HvZR4jii2OXz
	VB5da15mzbdIAnD1/050Pk5hD+L3KMWRVSQXaaEHq/uOLZDpaXnTm1cCDAJA/llc
	4pEy7QREE4P/lIutk0v66Zo+zCP/8L7Ja6np/i4JcmSvTkw/w704E9zOOfKlorXJ
	eqhXBJtySnILOmhSCQa8i4jlAfmH4YIIO9vv8xn5JKWGGG+49OXiXomgtbNoUo/y
	Hb9qyg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47dpqtrbsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 21 Jun 2025 10:23:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fafc0e703aso5174296d6.1
        for <linux-mmc@vger.kernel.org>; Sat, 21 Jun 2025 03:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750501427; x=1751106227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpLdTFKcF/XRek+8L18J0nRWqX7kggdzEKxNv+QMNmw=;
        b=r6KZE5XWNKpTcZIVU5IOJNXDbvCw2hmAiUiMbf7dvu7qKbEJVj9a97mbT7lfcCjvbW
         X3+hRfxoBD7dUD/L0Foe5eTOIueYwvKQAbKNZwyuK9TfM3s0wl3yV6ilGEcSgPgbl3N9
         WEwo1R0/3yTMWUMQiycPnAAuq8Um/tyE2WF4Qtknf/MgWMEM15l4jrQ703YW54dmPQXb
         IbrrWae/DA+OsMuFJPxi6XzrkFp85YaFxO6WyzUuNJrMbA4lIcr9qosDOkcAiGD9sNpt
         f+Os/sMhdRv4TMrj6RTIlPylj9nOpr6o8yDa/K4AtFDRv1Cm5KN86npxloo2noQZQb9r
         IZvw==
X-Gm-Message-State: AOJu0YyBEMW15z1cSXs4nfofu6k9+ItJEmtm4aCCG9kK6zl4C6Au79FY
	D1nJVTWzU0TFwk8NExjjXcCO0yoqyPevo7YcWSQ7iG4bAF4qGRaX+vJ/9TJou6dwm+92RQ+JEdl
	6pRlmH5vzSeFvzRw6xmA7ylOjOAkfJJFFWVYdR0kMSwlWtoOArGo2H7ywnA3v2/0=
X-Gm-Gg: ASbGncvqB7febv1UW1CARbrzf9a0c9S8E1no1My6e1GjxjlZwhkm14jAlQWfk7AoBhB
	GXqz5qW0enqH/OqHzdUG605rWGL5uZQDu0ZMrbUhjiaI0DFYncaOydYb3/LJwK6nwdrq+DgEWmH
	evGYu/u1Yb4ymw39SJsmmQgdIW7z+qe4u2FXAmptt5B7fISRpsF85r60MIOmsqPIg+PxcoiaPPh
	wpW+JO+HSkep4ZUpDKq5vCYHveoBMUxiVebeg8YLNfY7MALL6zclJAMxTA2QZfKZCjzLU0mfaXA
	1c1hN9iNQRMM6KO7W+A7yIF0cOVHNIPHsq7CwfZHk4KkSHi1dkpKbiOq9GpOA9ULLT0xhzqep+m
	eVy0=
X-Received: by 2002:a05:6214:d0f:b0:6fd:cfe:eb69 with SMTP id 6a1803df08f44-6fd0cfeefd6mr33144156d6.0.1750501427583;
        Sat, 21 Jun 2025 03:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL7MibXEyP9F8lz/Y2lKLYp1eoWNqfrsGdvD1Pks6XZih0R0EqMtTrZY6/uhIV2aRLfbEu9w==
X-Received: by 2002:a05:6214:d0f:b0:6fd:cfe:eb69 with SMTP id 6a1803df08f44-6fd0cfeefd6mr33143996d6.0.1750501427186;
        Sat, 21 Jun 2025 03:23:47 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae05392172dsm338550766b.0.2025.06.21.03.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jun 2025 03:23:46 -0700 (PDT)
Message-ID: <5af406b6-cc31-46ef-aded-7c0de3115e52@oss.qualcomm.com>
Date: Sat, 21 Jun 2025 12:23:43 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: sm8550: Remove SDR104/SDR50
 broken capabilities
To: Sarthak Garg <quic_sartgarg@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
References: <20250618072818.1667097-1-quic_sartgarg@quicinc.com>
 <20250618072818.1667097-5-quic_sartgarg@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250618072818.1667097-5-quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA2MCBTYWx0ZWRfX6Ny3X4NPnBEi
 U9csoxLtM1tLqXS1lKrHWQXfiK9NkbdXnIyNtVRfshQl72Qd9SQqLlbalc2O7NnpxkKE9kxlhVy
 ZDaAwfetPaP8UZg64622p5d7IwvokAI/1IYURZoA/L3wY3iIOOpRdk0LlVDeWjpdRUyef5sQUyl
 xsMxCUw1H7DWtADm/Jmk3fF/VHnR+tkwadytYyo1834D+hlWyyG+cIvZQnUAP3/LehD10GbIKxh
 qyqiNBihIvq7C3ea3fOlC5RGp6rcZ6wIxrP27nEkTJooRmYC3YAt4NJB4nU2C68aBY/AqNh0D0z
 CUIcX59KRTI1al1opJ668Qfn7wt8QmglrefIARuvcTZaB5EgqwFcLFq/cLLfNbUHwGDCtSUcZp2
 EmSqvHSTobmt3bL7ZaX5FvRdl49fO7h+dmo8pLmxnH9BRK7n/BUTRqGvPBiwPB7T8Unz8b/Z
X-Proofpoint-ORIG-GUID: Bt78RSE4xrNwKGojhI48sl8dpNe-tvwy
X-Authority-Analysis: v=2.4 cv=cbPSrmDM c=1 sm=1 tr=0 ts=68568834 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=5CWsPqat_0j5EhUDu1AA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: Bt78RSE4xrNwKGojhI48sl8dpNe-tvwy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210060

On 6/18/25 9:28 AM, Sarthak Garg wrote:
> Kernel now handles all level shifter limitations related to SD card
> modes.
> As a result, the broken hardware capabilities for SDR104 and SDR50 modes
> can be removed from the device tree.
> Additionally, due to level shifter constraints, set the maximum
> frequency for High Speed (HS) mode to 37.5 MHz using the
> max-sd-hs-frequency property for sm8550.

It's a little bit
hard to read text that is formatted
like that, please stick to ~72 chars per line instead

Konrad

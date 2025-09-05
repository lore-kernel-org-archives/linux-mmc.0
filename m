Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BF3451DC
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074127; cv=none; b=Zj3gDIjkSQa4xmyJpsb9Ts8TruW5p2aS66FN0cBAsrALsvndHBtzdxvxxb7cPWbKPQF5xZUqhOl8DE6Kr9IJnToXm5UQUAi8j2gNq9BXSP7fYoFJg+BB9eNXLddTXeqjwpe8PIUd6B/BhSL7dtj07zdpf6ewN0UAcM0FAJZ2AdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074127; c=relaxed/simple;
	bh=rbDWYSVIc+S3ABYMQqky0vWnAX9+AFD4sL9me57s3Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPy3Z4AYvtOv9+6bUZuldxYIltfSiapwDcaAG4yWctK8vkZ6fe5vBOQ2xX8gjbmFPcqDQFisUtI2xQisptRokJ09B5N+KYSweNhoiUJpie1qEWN85nUnLJOQ9+Ou2ZJerVVibZrqPM+JLJUfZ5hVa0mGIo78jblK1KV11UbUZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c9jG6U7q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c9jG6U7q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857K1uU007609
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1eIGHZDbMCTDRlP1TpKl2lygJjT6lzTuIxUng9v1BgQ=; b=c9jG6U7qi/y2Akcq
	/aWaJwz+hlhRm8vaLj9iyFX4qrzwpdL3gprPhwBGgsPJkzeA9TB52Zs1+YfWrGuc
	/w+oj2c1Q9pOWjv6TDVRf09cz6Ltm2DcjtFvcCB32uTcOBLI/ijYs0+jYAmlnVsj
	kCFkhNma439xkpYjyavyIRf6P1Ff8cI57/VqPSxA/iLzzJAsUgII/GacdlLbXkNC
	IyN0xvUk7DFXI/AjfG39pxn92/udY4s715UZcGJ7Be4tZnkBcMrizpzv7mn3oQs+
	sZgH/BCfwB0WiPkvVLX9crUkdYJ/qlbtS1DZQLOoXRO2BRuk+09gpGIOf0gS30bM
	C+4aVw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura92xd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:08:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso9492801cf.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074124; x=1757678924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eIGHZDbMCTDRlP1TpKl2lygJjT6lzTuIxUng9v1BgQ=;
        b=lBJwQqgqASROUOnhhFfmRetD2LXlmQQloVOsXe6YYjP/4xnuO+Q/9qZ5E1ALs/Nmtj
         JkJoU+pVXARjJYfykoLA6XEGvXzAB/K33Y1kFdg4DHdoSU3AQF7DFHxllKfwmIZ6sDR+
         9LvpRIi+wIOp6jhkeH7+lR6qlpupwkgMxLuB0GR+1nNkuyZYFhIHtlEoNIXTJwR3Weiy
         l1CRcHVQpGZyajP5TU3MGf8wUpzRs/umvO0ToA7/bEeWdNaZslZJgWHNNY+MOF32XKVv
         HwZ4ElxFe1L+uXyeamQLVZ3uUU4TxRtepKh4rgVt4cE3DMtWjuCqi0sYHzW2SXJ9i5WM
         VBMA==
X-Forwarded-Encrypted: i=1; AJvYcCUNlFQWsPAyg1jHUdA5qZ2V/wDnNRjyAYQV6dhqcr08CeLzf/xsf9rDl3IrRT7eRZ0QAzkgVzHu/84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Xtz2Hjff8SWqw1ZogBHQCAPUE1VPRSyUocWt9dAsLPifzccP
	IlvRk2txSXX/d7S5eKDFBhAU6gA8KsbNWJ90e7XUn0zqtrcCHt6WPWbjvcmQwhzAsD2nMCm84fg
	Xgt3Jb/Fi9AOjlvJI6AjHlFNpVzXLV20l6WArcDtIRyNS/Xs4rXYtZFXXIS1+lEE=
X-Gm-Gg: ASbGnctV5M4BtsVYT1UqqMvOt1A0J1L1D9XDM2DOpR3jIFGFkmGrspiC1kV85sqOWx1
	Gg7/yAPVpjb89hSl6bQT3MPKgLlW1K9104Dd3ok2J1iryShBssJSbN9HpHze7smY8kJ8wSLItqX
	4tQZuWx13hHROG3h4RAjh8ihKxy4Otxu9ivTAT+zBreigX/HX00VQtxpIg4kNOurAdpYW23TFYY
	4Mnr71G9/qsKsx3R3eIgVdd7xymcCj4vWSJ60K0Djj63lCj3ORwiXL8wsIyLdP0Ne/sDb6QFgH1
	a9BUdtoGfINS4o64qhaKJExWqzUZf4TEueKFJXqj3EdGZakSB7IlYePlaGXIpODlnphehUxwylP
	LEJ8NAglMOh8Y7PtJOQFmvA==
X-Received: by 2002:ac8:5fc4:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4b5a0fb5d54mr56116311cf.1.1757074123756;
        Fri, 05 Sep 2025 05:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGhLb6AyLTtxi6It/6ZDvuBl0OtYQNFkjfz2TPhZg6tNQSWGAKLOvNvVjqsEPiE59zf6K0vQ==
X-Received: by 2002:ac8:5fc4:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4b5a0fb5d54mr56115811cf.1.1757074123024;
        Fri, 05 Sep 2025 05:08:43 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0079183496sm1557522966b.13.2025.09.05.05.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:08:42 -0700 (PDT)
Message-ID: <cd40b690-69cd-44c6-82f2-39703beb1801@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:08:40 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: s9gtxLtxym8uGmGnu-QKSSUnZhAsiCpx
X-Proofpoint-GUID: s9gtxLtxym8uGmGnu-QKSSUnZhAsiCpx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXwVFGcCV28FP5
 poU0QheU12dehpIO3437BMaRPXHTeRM3L5ogf3l/KXYu/oPheZpJcWRZtSGEDjQC5iCbSSJRxqK
 tNU8bflZ6oOzChlHbo8TI5897cTTF3gjW26NhVTq3sscUH41KyfkI5U2yz5/tx+aU1VC4wxpMBs
 MU+fjMERCcc9bDSN+sji4fu5L6MYCs+j5SDkPm/c7QoVEf9NqHAREVIVDjaGxhMx+J4aYWutY36
 UODUmeSLRJd8isl1HECYqSLs70oCRUGdSHjcui+2U5z1qmxV9lThdcKfJRBEt6DUKNwJPVZ0pAk
 EcqsJlfJv3hoq41jOKwPiuwRdb0b8eIGa1/aUJatRuNlQB3/99uTX/NJpwvOqIinV4If76lfW9M
 Z/pdt6/O
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68bad2cc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yPPeNZB_paKBOZgJB6kA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Vikash Garodia <quic_vgarodia@quicinc.com>
> 
> Enable the Iris video codec accelerator on the Lemans EVK board
> and reference the appropriate firmware required for its operation.
> This allows hardware-accelerated video encoding and decoding using
> the Iris codec engine.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

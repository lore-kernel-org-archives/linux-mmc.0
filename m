Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14BE366DA4
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827798; cv=none; b=lRKzwGW5qJbvps0x8Md0PJCR9ha50u4IzgKkyxAE4SuCG19gOOvAEMSGbWKFgGHMfut3iF3Rzm477vORFP/pxFa9B2eCFCSCRQ8SflZ8E8r1Xn4ifeXFATeiSM6O/rIpTuT3n04WIUIm2ORtidGCNYurcAUW3POS0L5/In1TlEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827798; c=relaxed/simple;
	bh=LhKngGkLwz8BGAapm36Snr8y0ch/mF0ff4cMVKXpjNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOFWC5emuXP6XkyefggWluLLKC40MxdsAj10X4bterow3gmCErAQBz0462FP5xfdgaAQYATKV8ucoe9sNxCv02tSCnkyjEb/b4pV5gf/jf4ia46DvUBRyenEZHJsLgBCUPtI/UA87SG1dVjXMVjkcJoTvxd0yK13vvo/8AH2ZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NGGViOlP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G7WQKQb9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NGGViOlP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G7WQKQb9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n0Nx1613515
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/C4zaqYyFJx4mzZ9Z7Dko2c5OkhA0oBA3/TFBdaRUc=; b=NGGViOlPZ76GUZb8
	MKhJBB8USm6CVidhmHI+UCpzAQwlh556ekgfW+GQf6zeCcYhhWNxp98XaAfDwIMf
	7KO0I2KM1fCrNZsX8sVTm9GXFIgZejKodSsku799SpwTFdIF/MS2bN9XEkta1tnr
	yktHuMaSzvhyvxDh3vv61o17mkUfmW4ZnRlVp/M+yzMlsR4uJj2qHM1+brGwZR85
	3lCTcwtGqqUg0gFMwAyyJazBKUYdJQ9obeufv/B4c4BAhp4MPQmP5+ju6NKWuW8s
	fuZwMl7xDPVOd4/PNPdMGB7aCCoPguywFkBxis0Y3S2aPylAqBYF8+PzcBxk8qxz
	iQCgmQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1cv70w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:56:35 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-96917d46b8dso211734241.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782827795; x=1783432595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/C4zaqYyFJx4mzZ9Z7Dko2c5OkhA0oBA3/TFBdaRUc=;
        b=G7WQKQb9pK9ZgQwZzBES87qk0T+UQyfXpw88/u2PiRuW0Y4MBLK2gcrxkfQod72CTv
         yS7xmJ8YqkLly6mmuq6yrPW86g1Y2WBymUeKh/1Lcnd8QZc/T8z1XtTs30mDFuqOeNKy
         yLpnZ86HGkRDN0VcgXbcfu7BhHZk+zev8IwmK3pipWo7MxTiXBMlxyoVvjQTXq1KSuya
         uIy9GS+rDiL6BiauOFDoTd0US/HwPyhLm4h21tL4hobjATyXLYw26bbDUyPO0tWnPcwE
         J9zXixNsSmHRM0gi1nTQRpoT2W8+WIEPuVhVAvIrvByp6QV1BW++tDh1/zMa2o7HquSE
         DJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827795; x=1783432595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/C4zaqYyFJx4mzZ9Z7Dko2c5OkhA0oBA3/TFBdaRUc=;
        b=EGDqcLfYEcBhOzjT/3eGb1yByAfoGG0mlZ1HQxIDeJjEYG9sTaNcQcQfcVPyIKrVLf
         2/9pVi3M+N01kUDcJYVKWxmNFi+ppe5DwoX0q46/BeUYA/nKlx8S5hRubAMJn/SkvfgE
         U6Xepq4WtQcDHhxMq2gyvCa9cDg2yvYn0IcZK/IvA/bKYT7is1PU9WTg3Kle6D8nUFCG
         MFRg8gsz4h5bQaHZhkN1f9eZRZIWtCKDTkHeV7Qno8Ubvz53bvGt1UWEaAez5mL/ruO8
         bBfhB0qsssZJ8YtcoeVEq5d8sBVgP22FvpZKqb0DzCcU3SkyYp6fngvIgJNrEWuBQCof
         YvFA==
X-Forwarded-Encrypted: i=1; AHgh+RrLVnFY/WqM/ghOEW9o6+/3XCg8zV7H39qqOcuh2NidbCQeeEftrNny5a2ME3w7mPfE7s/jYh0AsxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy992JvyLrcoH8aU9mvyGzOAQwDa40Bno5c6IOF4y86siz9rjPe
	nodrMjHIKeqCgDolIP781HPj+v6mFFCOxx0fYD6dpFS/ml6uJC8ie7NP6B+3dUvAcjC3mC42hLA
	iVW4in9iCtgYT8NadIYGLy4oKJGvXUuvjo+s8o4jH3IMIgczdPRJ7jqkXQ3MAsck3nyXDDzU=
X-Gm-Gg: AfdE7cnDF7o/+PBTmRlY8ynDCdMRb4q+rhu6KajMXnjCBVbRtl8WhOixuEJLBGyHFi8
	373Jn9ApCky/x80IjP0UI7z5j8vTB8heK2xoCQcroxBEe6twKuDD/hAjqHkn1h7ASonuVmCtDo2
	elHQBV2rNGzGNB3lrReNpxzZ6cKMBF4+W5Hhox5WJEUZuMBSLdHY1D2RnZRhKtu4eTl3IsT1IGW
	0sXGpFdN9Fyg2aqkubtEbNHC8oH8NQafxvsSX3UR4qlLPjb+kiBH7Pkqxtnu5YWKH0wiy6Df4FC
	Av44GeJvVDLotfqlUtcBtsWHo8hXlwo5CA77pdepT88YuKCMQAyZk2ZwpfutXQAKe2x/Ab39+1n
	DK/uCU2BIWOXkap9W1C+/+Fcs1d6s77Oiq6s=
X-Received: by 2002:a05:6102:290a:b0:738:b13a:c810 with SMTP id ada2fe7eead31-73a365ea4cbmr656458137.2.1782827795249;
        Tue, 30 Jun 2026 06:56:35 -0700 (PDT)
X-Received: by 2002:a05:6102:290a:b0:738:b13a:c810 with SMTP id ada2fe7eead31-73a365ea4cbmr656449137.2.1782827794804;
        Tue, 30 Jun 2026 06:56:34 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3a3d9bsm1292012a12.4.2026.06.30.06.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:56:33 -0700 (PDT)
Message-ID: <f3da322d-48ed-47f1-bcc0-50161514d390@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
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
References: <20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com>
 <20260527-shikra-dt-v4-3-b5ca1fa0b392@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260527-shikra-dt-v4-3-b5ca1fa0b392@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMCBTYWx0ZWRfX1GK7JBq/voEv
 uQsELpeCEi8mX8f8IT0eFwQ+CPoIwvcEIyufSBlICp8FK5DtM5gbKYs/9lta0db8Aze1WX88BGT
 4UpQxGHesGtJAqPNCU/I/CQMtGnbZLu83PkZpDQa8QHl2UsJphQ2s4G3QAfQSipFFxLnnZyJ6Ue
 +V6bgK93OsFhHVyPhkTQvuIu+aOv9JhlHwE34tuUZ7uI0wc5Q1EBKxLZyeNhf9FeKzsSfz2xsZB
 rZDrVHTqoZeknKa7MXJ0aA2m/QZv1aZvyXaFYL12B+PBT5su7sA1VDafu7zGtedbC9HlCk7HWKI
 n99IWCfpYGgJJtYeLN+Iqlg7uU7bb5RjWTG18gl/V5XRlnV9Yojo2tepgOwVTLk04J8RGmbSf4S
 3ZFI9RK2WV05ptJ602JdlSi9aZeQrdkOA2M9a6zSjSUHKpYqrHp8iYrnZK+0blainMLvtHfVabc
 EeTTz4fonOzaPkQdXyg==
X-Proofpoint-ORIG-GUID: 8mlhqDfFfiO8fwL3y8mYu-vua2xvbZLh
X-Proofpoint-GUID: 8mlhqDfFfiO8fwL3y8mYu-vua2xvbZLh
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43cb13 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=djcwQD5uGQ3GNs8by1sA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMCBTYWx0ZWRfX531Os8nO4lUn
 8ZRT4AYrkLgoYJivf76G2MShhxWZTcori8cGvW2SzzlkcXfK448BZ9oacODN1dNvuD1sP/up0Ym
 UUKjkWIYGOL5BSkvZIcoAtW7wMAiGOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300130

On 5/27/26 5:53 PM, Komal Bajaj wrote:
> Add device tree include for the CQ2390M variant of the Shikra
> System-on-Module, a compact compute module integrating the Shikra SoC
> and PMIC for IoT applications, designed to mount on carrier boards.
> 
>   - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 and PM8005 PMIC)
> 
> The DTSI includes the common shikra.dtsi, adds PM4125 and PM8005 PMIC
> peripheral definitions specific to this variant. Since PM8005 regulators
> are controlled by rpmpd, so disabling the pm8005 regulators.
> 
> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

I'll pretend I don't see an issue with a volume button living on the
SoM

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

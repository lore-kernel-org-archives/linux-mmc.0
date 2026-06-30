Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D0334692
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827814; cv=none; b=pT4o3sjFzluSVXDKk5xIzlkYu1NPsvrJghmH3xs263Ct4RHoCEM7mZYH85ObXa4qDh3+LRFNBzM/HgOHxillLFQTpUd4DsO0PA6DJ3AN3fNfolKOaQnNRc6Q/VbDm1zsxDw5TB0O4uAfexS5/qZqYbCaIWM4TTRNBoycIaB5e2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827814; c=relaxed/simple;
	bh=5Y18P1OXhI2wNiiZ3URLaQNonWt7gRHonLAgtQlX/aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUxLbjIAdwAZw1P6aHkfkeJERGg4ezjabyimFmKw/a/lkIwijw/8vshfd0kTyG4A9q9Rzbs5PHBRedFUkO5+E8eW2w5TKr/6Xym71Q6BvlepzilzQaySAMeQFs2BCCbg+feVB72DEDZkKBMfgELtu4QylXoMmsPlZOhETRctvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pV2WMVe1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VL9a5PYK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pV2WMVe1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VL9a5PYK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n0O31613515
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+TMcA/OjnsdSU9logLGCJgI1OcslBQgls9mCJLwsRoU=; b=pV2WMVe1L3loPsAs
	KfJkGEDW2Zdz1pCIvj154ylHL+vt/ybz7ynry38mHjJVtcjLrr5uVIdDrsB5YICR
	sekLeWXV/TP+9fQS03XfdjemuZimlCBZBUyXNh8+IR19MQmM/MVJ0rShZ8uoupLP
	Yx7BbPsrOFBjBgVY6cfEhZGv45EboeGyh7pmLzXQrvc4Yf4bhlJ6R0zy5OIZJTzu
	o96dZa+fFzqFboIMLRgm3/5PNW4MZINW2nuTEH9X2/OK2Kmae1jOPajonOfmiD+O
	2sYsmzTIWjdstcw769qaCIduQbK+4oOVYXpyMQRaIe5CxhShYGkDgl1+0jnx9JKw
	DkBuuw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1cv728-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:56:50 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9691f63552fso157412241.2
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782827810; x=1783432610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TMcA/OjnsdSU9logLGCJgI1OcslBQgls9mCJLwsRoU=;
        b=VL9a5PYKL8X44wGBLZGRJgQTtcPZz/lEESqgBjojXgyMHt5UX3CuIP7rBN1Ks6AVsN
         tW0PFmsRQdNk4cE+y04hOcwoAKmDQvRFroOZbk1sCMlOMGQnbjaQazH3LJ+ACzoJI3gE
         q+JYXB6tsOqfibcdAv9vn+iPFfil4aNS+ZKEXFzpkX70e4pXSiVsZG75YoAhkU9n/4Fu
         +retVJUOLgQbpRLYPEo+rw2p4D7uSduFzs5gk/IFmcnMnzhBouCew2pEVzcZrZ/Gfidq
         qUcVsTdNJMxtgAhHd4bnvJXGbldNHLxTHRjYxMGWb5lZqkGGAR09Q7ygT8JW6YZbCx0k
         sdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827810; x=1783432610;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+TMcA/OjnsdSU9logLGCJgI1OcslBQgls9mCJLwsRoU=;
        b=Hjnexv3m2QkvCKsZ0lkNmq9yiyeI/R3xN3TiVQSbo/FRkjkL0ONWrHJBj62jghrGXL
         6vFaQ62t8Sh45A8pIzFuc8z1xxo7LH3rOoNGHP+IzKc1rNlTltRamlvZyytF0ktpOt+y
         tJQzVXd+a5DybBK/TuQaaymiKu2RslhyOq01Cyz3WOHBhLN2Z+OV6Mk8A6G+njyHsPUn
         zrwlDhN7pgi9X45hc3RYN6T8G67F/RRpljmepzcDz1hBHBsAsFGvhFGFIzh6c7EvzjPB
         IAcU/P141WXS+D1qgvnqDvP8Qc5FJFvZm53jrhyGplN0DXeH4WDquPVmym3d0bJJas8Z
         eiqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPFUYfliNYeU/bd5+R8//EVkOoduNvTj0ZA+7YEQYSyG46msVBNXRvdwQtW19AokO1KEQzivDOixE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FJ6dXCzrbbzukFgKapqRcCe+1ZXpbvXXLUKczQEJoYb+0SAQ
	z0X5GEeZHW8XEJh2/mYdo6FH8e/xK8T3iKBCSAtubCltzOQzp+L5UX3lSmjjgxupe15hmROgviO
	1FLtbo6F+v5W52GucG9MsJJMUlRQMzJHOd6UW3AqDCVXweT2ca4Q/L5jRvqNfgPk=
X-Gm-Gg: AfdE7cnJJlDc+Tq5BE+S4sTEfxjXMn0bbYIDRn20RSTtRmPX4URxw4RuSeRL/L/Ncj3
	3QX9N5DUSQ3cBg6CmJvCgiuB6PwqAfy/XQA6e5/MdwsLJcObmcvR5z72reV+i93nGxYuZ2Cgzbx
	9m0sFNnOwcgloSFirKQXG5mCjb9aZfoWtYanoRWTmTdjcLmZGTZc8BypVqUd7nuftB4EitT723q
	R113OZGRuLA2S2jVwwacA2ZtBWqEu1CT1w9qdNQMoZ5HMYQ30KiQcPpHr2RFM3vtgxbvzdAhqEi
	w2o4tofK5jcEaC4nkVfNq3UmwifQMIo9tA2kLFsNuxn8CZTUWgR/7L2SE1SkL/RPko7nIOPxK3A
	4G+UAhdDJiTNGY79+XjWanNykRcMoBFibz+4=
X-Received: by 2002:a05:6102:5986:b0:739:b7cc:3ce7 with SMTP id ada2fe7eead31-73a3934de72mr602369137.7.1782827810169;
        Tue, 30 Jun 2026 06:56:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5986:b0:739:b7cc:3ce7 with SMTP id ada2fe7eead31-73a3934de72mr602366137.7.1782827809802;
        Tue, 30 Jun 2026 06:56:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c93cacasm1328329a12.18.2026.06.30.06.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:56:48 -0700 (PDT)
Message-ID: <e29d7898-a439-4e5f-bdff-0e7daaf23c4a@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:56:46 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: Add Shikra IQ2390S SoM platform
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
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com
References: <20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com>
 <20260527-shikra-dt-v4-4-b5ca1fa0b392@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260527-shikra-dt-v4-4-b5ca1fa0b392@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMCBTYWx0ZWRfX1tJuN2p7P/XP
 bLZNeaYcyyCPzklN1i6sjXJFQDd/68XPjfDIy86AA1sfDYnfmcs1P/V9Ea2zQxjanvjwria2O7W
 gzRkw693zRDmy1bkYsHKGEFQ++HBI6t1Hg28nyqBncViQ/qxF8vYYgy9eYq1L6fEjE5aC+er/JI
 5wGivjtMFE7K2HcaAqeo6rHIkKabG2QTx/GVPFHypwZPvyfN579jIfB78ZJ4P0Bo0+0h9yWW6RX
 +ZnhCfKR2hHKI7qGknh3rvF64R5H/BDaKYym1/jivnYcMVyEL0/ihLV5ah68I+isQwXJ414LGHE
 ekSnVW52WuWNTXEjRCFFamoMQxGPbwVUdhucmkL1+PKHN+dbTzfzNYmkhfBFmAzWb8UD4L4ay/a
 nIbvqlnEXwDDSst5nGGzn71w0fUfLK3SRiqfNiOzBkp8LErMz1I7soCTRurhBYT0giGOnIFdiL7
 Pov38kkxx/sNxgje7AA==
X-Proofpoint-ORIG-GUID: -zLsMAs4beLNMJqne7ynfdlVv_0ABzvy
X-Proofpoint-GUID: -zLsMAs4beLNMJqne7ynfdlVv_0ABzvy
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43cb22 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=MSeU50jLikp4iQrAx_QA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMCBTYWx0ZWRfX+ffNdkA3SYvN
 Fw2izvDYbhsHusjRR/kmB9S2BWVAjynhcJkfXxcT1Iv8MWL+kD3pNIZFWsO+ZNGEWSiXSyxLHOM
 42rmSIqMGEVEUq2PoDWFU9gxYKsO4sA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300130

On 5/27/26 5:53 PM, Komal Bajaj wrote:
> Add device tree include for the IQ2390S variant of the Shikra
> System-on-Module, an industrial compute module integrating the Shikra
> SoC and PMIC for industrial IoT applications, designed to mount on
> carrier boards.
> 
>   - shikra-iqs-som.dtsi: Industrial SoM without modem (PM8150 PMIC)
> 
> The DTSI includes the common shikra.dtsi and adds PM8150 PMIC regulator
> definitions specific to this variant.
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

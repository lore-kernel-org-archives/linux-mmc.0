Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47434F24B
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384965; cv=none; b=rIm6ROY23Iv+q+WGy+0tjUE8WnvQPi34jJsL0TzeNo3icnn8oO3vMhNHLOIw2jR17Bw2H5dFb3h6y/zjfxem5P3zW/ncxkqkUPGy9T5oKdnhGm1qfvOG+fS1aAto5mJnn+2ahBTsgIzAqyi7E8exZCFcvQ1uAxiMRcbGZyhlPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384965; c=relaxed/simple;
	bh=uF95rIddmYlrMzYa9Kf3n/hva62Lji7bAUf8s7PNsYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1VD3SePqv4v6Ng07dIQxVg6ER7GnufVFJjZ2PusEQpdW27oSdAjE3F0Ld7drIpXqkbvJM8cdgt2G2f8ALQByuAWTrYSkKl3/tsMwdQKLWBVa5dADN+tU2Wv9rRmvov9bER2/servnCEU51BTHCM+iQj4kv1I9GhywxSurS9iqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eL6cErav; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=agrBEDao; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eL6cErav";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="agrBEDao"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5teqP3844060
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 06:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPZfbfumfeK3hXgzqvEDf1QRNXOajCPeUAJoFy2K1fM=; b=eL6cEravUWJWbYEV
	VbW+jlgiN3+63IntwGwDr3LN2mB4Vkc0EiP6+MUO2h4/alASxQCagXzp4tiNK7Ya
	9ReVk9MPCCUKIZ1H0G37dqwrJ0HdLa0JwoCCZi3wtIjt7aLPEoq0rcWms4Yc0zQm
	QpkINSixvQ7R6BD59yxF98NFm/5HrQZGu2mpAQSQoCwFd8OTxCYqBgsEGbPvCrz4
	bXMEg+jemy0PRhU11qXhGbNcYqqA6T3KojQtL7AylzjmkRGUDD5uCARFE+i+lRTB
	QlAiig/bcfO0au9Ot2SQJcu1dCuecEnpA1/bqpr+trx1p3clrKlvrwmHC9Tjy5IL
	UpjWbw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh54vtdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 06:56:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aed37d9310so490505ad.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773384962; x=1773989762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPZfbfumfeK3hXgzqvEDf1QRNXOajCPeUAJoFy2K1fM=;
        b=agrBEDaobD8iInpIavWXRC3SR7Mcp/mEaX0Z+fAVLpjqbADsUGspwVjCu3GOcf51M/
         ZmtO95Bb8BKlXjrzWCplT2Up5NMMA6JooevEU/jHnukqOpBpTbqwb8DT7Wj7Uhj7+L1J
         dmSy759NxjcUGckSmQfNdXb9Pz88KcI3KEmTzJ6rX0S8fDmJYYA+9l3T0fXQaf+PEqYE
         P/Exoos4e4a5HNqDYyM1HY+2B0QXdFP8bGtRTxeTrR2Fwep1dq5BVy8SjY6zmW7PBMX2
         oTghkgL9dWhrFkRK78MrH7TnK72ig+XvIZi+HrWCv3nA+FqEouQCWis2pt27GxCOXs2C
         fnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773384962; x=1773989762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPZfbfumfeK3hXgzqvEDf1QRNXOajCPeUAJoFy2K1fM=;
        b=U0tsiVeze8I/KMnS6r+ViAp0xeSQfhRvLvBzmjcxn7MJCJdj0vb80Tw1yj6lB6PbP0
         x0GOexU/Cmp8R+sRcZoKmwN8yG4Mo9s+VYYYgubl9nvqrxZfWO753au5bA1VmhDQuwwE
         W9AqXGABld7Am/8jKvhUELF/8G9GQjiwSMYHZfhQjEisErx3kIauS9QMwVjfXiKH5jeW
         BU5nI5IJnZASNafO+NXtS15Y1SPeFCPhCEIqF65TSeRzYF9E1vVu7jEDNm/mZ3wGjzsl
         SGjMVM+XOnpWxSr9MpKNvdJzslLWbxaQXDNGbzg5xpJwy6hl0zxEmUspkSEGEsAKtNTh
         oEvw==
X-Forwarded-Encrypted: i=1; AJvYcCX1gzMS9yu0ywku9ODncmU9G/N1iHZWq5IGwtvJ8Y5St9tKk3aiMpWPjizOfCkQY+NHZ/i7OuHNKjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmioTJ9Fwb3DpVBSjrLIqmaQCZODSaQ8hwwZcMdAJRNr2ZCZ0c
	+hHz2qgAlc+wUnPVo2ClBm6Ww9V8xq1G21X1FE/LN7pswtU5uDMlei2k8lrsGOO2rfz984G7DUa
	7H7oB+A8FG2AniaZUpGm8Mguj40jkbu1e+ITitHA8VoOiY/mDZQP4UX35HBhRyaHlmKdAm5k=
X-Gm-Gg: ATEYQzxMRXaIHNVfWuFC9LyWlKdQ3lZkppRU7M2EFaFdVd1M7TCElrOg2GHbU4CM/zW
	2hXvvPSISe0H71PooaANwuKtH/Q9SL9CeelQLPBvLk1wP7Hazs3I3ZeF2B6+YAIsBGxkkoZQ8Qd
	bomtniEMurHXA84Uo/uBa7BMHLJ2O+EgRiNCU9DnT9nCqyIZKswXFVDGBnfUCD1oGCa6hcN9VCr
	Vg6A0N53tHSTLlG60FygE8UQiPeJGXyXqgtSw/qzqjOPQbRMNDnPiDqEL1AVi4tZHwFc3bhknJ5
	OjTuMNKxAtcnDoOHNxQwlS3Za5jyg1ILE//GMA2IpCyTgNrRd/AuZAGx7E0k2CH0RNaaS8d1W7Z
	q9hsM31NdWg2P0NsoTALYvPwZjsYDgW3lDS9eDdBkz7oQvbxjqkVZGPJzZx9KtwpbSA==
X-Received: by 2002:a17:903:2b04:b0:2ae:ceb0:d5f0 with SMTP id d9443c01a7336-2aeceb0daeemr10380235ad.47.1773384961684;
        Thu, 12 Mar 2026 23:56:01 -0700 (PDT)
X-Received: by 2002:a17:903:2b04:b0:2ae:ceb0:d5f0 with SMTP id d9443c01a7336-2aeceb0daeemr10380035ad.47.1773384961198;
        Thu, 12 Mar 2026 23:56:01 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed9cdsm11279715ad.60.2026.03.12.23.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 23:56:00 -0700 (PDT)
Message-ID: <0a8996ac-a9ea-4c47-ae44-246d8ec93b4c@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:25:54 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add minimal boot support for Qualcomm IPQ5210
To: Linus Walleij <linusw@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <CAD++jL=P+0nY3yVM9MCrRfG5xLtg=R6Xgpi1xrbzzLPD-Y8KKQ@mail.gmail.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <CAD++jL=P+0nY3yVM9MCrRfG5xLtg=R6Xgpi1xrbzzLPD-Y8KKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kN80NNTjXuo34dl5BiPXZgAbKgOT-ny2
X-Authority-Analysis: v=2.4 cv=BNG+bVQG c=1 sm=1 tr=0 ts=69b3b502 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=TA_BZAN9T5C4Y3A0SdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: kN80NNTjXuo34dl5BiPXZgAbKgOT-ny2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MiBTYWx0ZWRfX8hhqlOQWGTW/
 9gTNkZSqSauCYMeY1oooNYH7E8Bg1tQn1Q/R9CqIaNMAPWnlAOZB4KIIa3qT7Rn3cUelcHpwExV
 tE3uDfa0s/JX9N/gQq2wJlT8FIeHOrL9PUpo8pHDCIoZJfmBOAsqCsL5yNlXuoAzmrU/xwSNAKB
 sbWFSO25J/79YM6tPRKuDd73Zx9ikoRxd/VKKS+somGiFUVi+1POb4+Kpe6OPXDQ82s93D5ALuA
 xaL4M2LXH/y5cw7yHUeaYSeIUFRgHpExfqITXtOYfwHPrglM+7zLDR/sMIf03QQtzJzd00gRqwk
 g3erWvMjA+YlLO6atW1xeUN3Kg17dMq/+jVocBtP0L7u/vvUEkn+HyHMSLSQ9iWGFxJnYYzP29S
 4rIQ77+SB9vevNnVA+mE3ejnq/4IkVbSHPOS1tXWxoB85ESicJ8pTw0ZaC93cnVKhG3D9emh80j
 rpRKt/C9ztMyxaG9fYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130052


On 3/11/2026 6:31 PM, Linus Walleij wrote:
> Hi Kathiravan,
>
> thanks for your patches!
>
> On Wed, Mar 11, 2026 at 10:45 AM Kathiravan Thirumoorthy
> <kathiravan.thirumoorthy@oss.qualcomm.com> wrote:
>
>>        dt-bindings: pinctrl: qcom: add IPQ5210 pinctrl
>>        pinctrl: qcom: Introduce IPQ5210 TLMM driver
> Can you send these two separately?
>
> It seems I can just apply them to the pinctrl tree after review,
> no dependency on the other patches, right?


Thanks, Linus. Dmitry has reviewed the driver. Should I wait for the DT 
maintainers to review the binding, and once it is reviewed, send it 
separately, or would you prefer that I send it now?


>
> Yours,
> Linus Walleij

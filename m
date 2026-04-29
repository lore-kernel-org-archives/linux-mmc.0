Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1739D6CB
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455083; cv=none; b=Mgn9DrHl1sz8TeI0gkVqX4TiHLcA7JzR7klXmPe/StUDiidhPyUx+8A5jZp1NULh3QX5wFAQORe1WCBKjrDvA7hhKHHbVdGuYuEs+kwpMP8hTq7EEdlistiWuDZZq19vCnJIDentyL0KlHJOzUUpEW9ARZFDDsyJVMNcos/jdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455083; c=relaxed/simple;
	bh=dm+dFwxdW3sm7O8MhecoTv5j4K6D1iGc6ODb47RC1e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcAhKiHtu58W7KgSb2enf7NKIUW+5QlP0LL7naowJW0plfVdRl/vl/1UKe5q6Kt39pg/QCu3rV3NQ2NMvnn0/SJAL432FgIbvWjy7Mw3RdcEryz5cs3SLAuAPfapjJ1HWNKfyNhVJHuyfTO9VIy0t+rXPjy+hvHer3vHxIyzGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYEMryoF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UxVcAZMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYEMryoF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UxVcAZMR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8pxOf963223
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=; b=GYEMryoFXAFAlD/r
	JQitAg82qq4PHjoHkSE55CsuTKzpGQUiy7rQ4Om3REMbKJz5QB7BFnkvoO1pnfSP
	D7SaZE4jl6GkEvVnOb3lLu1B1h3Olq1gHBW/DB6dHat1v7r6hb4jGKY7Bc133C1n
	9Fq8uy8EKP/D0F/UZNBc2d8iJSVSLLUGDsiyeVZPa8hPSrVFSxzecAzI9Rq8wyWw
	7w1OojyVxAHVt9MWsToAYKpb3NHdrefL/9F/gSkLvemplm6pCGe74AUsIpt0yJ+Z
	1CxRYMd0VjerRP4J9xDaJOwDdhjBcDs+/YT5Irq8WWFF868FngTnJ426wPF29Bxi
	J++cXQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4tqsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:31:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d45ebdbc9fso252042685a.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455079; x=1778059879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=;
        b=UxVcAZMRoxQFFUSoaNJKcxm6IoRSu13yEDXjb+2JiSkk6atr+Ij0jAqwkLDf4UJCUR
         YtfvpNvsIU450ihHmyerBupVG3g/E5dHjnjnnpm+SlcSEMiJ1z1V/OoVppFcVkffOmA8
         D8sl46UdArSC7uYibdsY5diuNDMbeLoGp7yttlQooc+RqXzt0bnnr6Dfrf7NcwQWPRRy
         IVFSc32tFRKuSeHR63tN5qAJZQ71/3ZV8sCM6OneIrrc+rIZAYzFzzWft87KEhnGbXli
         M7PPgUogDa/elhlA3M8BWxksr2UGEbcorvZDuNeBS8t7Qm7xXx8xMtF11iiJdf9q//Sa
         1uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455079; x=1778059879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnlJIbBYZuUBdNgE4J4nsbuVUbF37SJm8P3L06tNvnk=;
        b=ecUW4XJC5LM/Z1HIvje7W/yuHsXV8d61rS8hPKWnXpsMs6zpjV3kKBPYb6Ojj9qKXm
         iyusmNcPsVvDE7xvzjW/mR51m/lC0fMKsaKf4huprfh853SmF/ypy2KX2sF/uV31Z3DF
         69hnLGwJtEHCslIDDAmqmLeAEQSFtqluH2G/GUre6dt/qxm80VMiPvyJbIEhzrpu/kPP
         a3NrTQo4yVhUAZ/dCstz0r2rtQTPnkaUQl2AQsCIg5/JXdrC7aeYSs4jMXbLkZ+iqgV1
         BcNeUlGTRh6CpZ1JPHNmDE1y+/ECtMDv7dm12lLWHs39BPsW8vtbI3a3dPGpgkihY8Ll
         4ylQ==
X-Gm-Message-State: AOJu0YzMaS3sfo2YXbJDXNKYYNFH1PDf5ymRHdWxjQa0i211yH5yushm
	IDzqmYz+aELS+D447jgaa6WepoYYENHfDd1LyZo38JGvhDxAnAC1MipRVM6j6fv8McSGUThCRDK
	7U3JXmxmCoHXyW4/u9UQD8bZBsoT61J6NRZc2GFIqejR6Ihy8g+06yOdtqbTrzGU=
X-Gm-Gg: AeBDietVDB2gzvJjARmiY2F1CyvV4KjCJyRnHdzNrofarK12PDbS0H6H0BDA0x3zvQS
	pD1ZcZkuJLlflsZI9mPFaXjZFKCRKsq/ixNR523oHT3vBLXJZjR58DzzqLwUWii32zpWDGav7jd
	+wtsQj3wIDldHvLtifUXFjnHChJBwDN8d/wpsofVID4Hbr5FfmbJvpQjozNls/oITCEJbuv//Ho
	/XlPqRNN+hw6SskMAyK+NL/ubPD97oqVxGllZY3R9O/7MUy01cgwcbl7WtikaoFIVtLrvCiB9EJ
	xFz6AGMstDx/Ak5KznwxR0jVK9hh5NzabOjWQvj8sVCcTvhAVLjesRE1LOoGWzDkYR6I0GtOowI
	QC/bZdGF+N2LMmZK5asTfoXVdhOcq0xSRhb2k6gIPhfzQr4kf7kVHU1YbiU6RIZZBzqg54mSvXX
	Ui79sToFdcJTXF0g==
X-Received: by 2002:a05:620a:2692:b0:8f8:6b36:fad3 with SMTP id af79cd13be357-8f86b36fd47mr469938285a.8.1777455079081;
        Wed, 29 Apr 2026 02:31:19 -0700 (PDT)
X-Received: by 2002:a05:620a:2692:b0:8f8:6b36:fad3 with SMTP id af79cd13be357-8f86b36fd47mr469935785a.8.1777455078612;
        Wed, 29 Apr 2026 02:31:18 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22154e9csm478955a12.15.2026.04.29.02.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:31:17 -0700 (PDT)
Message-ID: <3c6308f9-3758-4bbd-ae24-d9a02f0aa241@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:31:14 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] dt-bindings: net: wireless: qcom,ath10k: Add NVMEM
 MAC address cell
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-4-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-4-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfX8jfeJI6dE/P8
 WSBSB7gEqnUDXh8qzeLp+V11TrmWWramIldeULUQyxnV411Y7D1Co/B6+TZ+ALA5SlTBqgRLVh8
 NNVt3rym1U6PvHLL5DYHXt4vq81H8eyE6Oq9lQMvgp0olgYbhgRLalYhkGK3/OVnHI/Mo1dL80Z
 Qw+AjNYJGJbb690pNYERfuwYUhNWkoXbDZLzvT0uQY5sZQAibq+fUGGHQnNC5C0cdc4v6HZIT8I
 Dkp9rmlaLPl2LMQ6Q1gpZpCZb7mNSyzoTitbNaTLzmaFdFL4tctcu32DK4RTGbOUoo/zySqEDBl
 +F1l5JrO8DFM1c36jrbC4U/HCvvYsYheyvF6gfBvA7+ybhT+zoS1fe9siFjg7WXDZZVwGPYlcvH
 z4bpyHCfJWO2TNHruNUjOtbcDhOkB4g1wVbza1hhh2sVjEFoBjMN6XjKS6UiXjKx18N7q07+1f/
 Sc1NgrkYhaml/bxvFqw==
X-Proofpoint-GUID: -56GvxSEh9qauyFR13iak7nXNqeORvV6
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1cfe7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=jzu5v5LO8FXgj-oZCtwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: -56GvxSEh9qauyFR13iak7nXNqeORvV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290095

On 4/28/26 4:23 PM, Loic Poulain wrote:
> Add support for an NVMEM cell provider with the standard "mac-address"
> cell name. This allows the ath10k device to retrieve its MAC address
> from non-volatile storage such as an EEPROM or an eMMC partition.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> index c21d66c7cd558ab792524be9afec8b79272d1c87..7155d8b15cc145c3a7d703db0c9c3e056a54c07e 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> @@ -92,6 +92,16 @@ properties:
>  
>    ieee80211-freq-limit: true
>  
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      Nvmem data cell that contains a 6 byte MAC address with the most
> +      significant byte first (big-endian).
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: mac-address

This can just be "const: mac-address" if you don't expect any additional
entries

Konrad

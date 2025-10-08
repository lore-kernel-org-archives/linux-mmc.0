Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE91F5433
	for <linux-mmc@vger.kernel.org>; Wed,  8 Oct 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925876; cv=none; b=aPx+BOhkRUfCME4XLUMRmzakFlkdqQekHwH//O1Qq5Ntf6+9Uid328AH1mXhq9XMAiBf/bk15OFktWAIB6SMQerINTPMg0ax7bwdOFh0psxetcmaBrwMBdJqBjBTpGN7VoGPgtvG3d1NW36sQcJ0vols38VHVZUEE/a0K1O0bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925876; c=relaxed/simple;
	bh=PVHRpg631XDxnFVtcCZtQd6DaoP/boLeDvf5wQFW280=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyCR80cWLKYJv+Lilo7Q8YRk0W9xMiphFdhi+n5zhP9kIMYt3wh9pRlasY+S38PWGfXIi+rRex7Oub4+5uIPwfgWRO7GYC7sUF13QibevQ0krb6l/Ad1pgm366kJGXU9AlamULFE41ev8+cgzcNAIeeaZPRIDEW9UzrEeFcaCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMpM7mc4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMpM7mc4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890O5f028792
	for <linux-mmc@vger.kernel.org>; Wed, 8 Oct 2025 12:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1X/DVcD1GjvfXhX2ArtmK5xnsWxolZ/LvXbotElllEo=; b=mMpM7mc4ZencBVWk
	Nv5V9Y05R0y1ecRzZ4bpYaD/OD1Fn0qXgKmTlgTNNXZKF1sG6twp/5MgBOFbG+UV
	JVaU7UoSGKAgOxBfkOe+XDlkXiK5mr9QDxmhm9w2I3QN7U9YWfcSNWRfK2P0bE1Z
	UJvK9GItUZaarBr1I/fnd9k2IIyHhRl6eE6pe5c1+kN+MunHsnvnRKpBW7MPr+jU
	q93JpaFFrDPVRWrE+NJgnSWqjbtMLq7d28iKesqEKKE7gpQ17tTbYzHwH5QGt05e
	yXQRJM0cZjJV+o3eGmFS4L5sqjGVUmzwrNdmf5w9aHV2y+wR1lDcbJrGEXBIVq0/
	LRyK+g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgtdrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 08 Oct 2025 12:17:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-798447d6dd6so20465716d6.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Oct 2025 05:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925872; x=1760530672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1X/DVcD1GjvfXhX2ArtmK5xnsWxolZ/LvXbotElllEo=;
        b=hgUvD819c3t0JMcRejUpgaFoIR+UVcPh01zaDXWSZaO31drLRV7+ZDkjX7i5dNZxJ7
         9VzKnVh2MZC6TnhBGoM95lOkQVEzyWxv/zBj4mSwCrIukMNcwgyNWRp+6GlzYd7uQOfK
         wbd5vsHS56O+ymfzxYFmJbco59YWob10APu+iUyhyOjaFXw38zObcgc8xTQi5JiH19X4
         uMIPSUtLjKWqpmEj6uUoaU7vzWtd950PAPfc8ikViIw5QINks4X306/0MicZsxTgTQZX
         jnAqwjSc9R5d1DQRuwyPB2n37PNvg4Zs5HjFMhfAXk1BvyCzI5Ssuj2OA3X6ivwF7aAl
         flGw==
X-Gm-Message-State: AOJu0Yw4iudM+lKYYymiS5nj36G+s7wLiu3i9oUH4IMZml+GNrFIS1MG
	03r95IR5FAfAGD6cWbyl66E1G5hRYnZTkDRnzcuTkUpA3a0xQUn0qbv48+tkjPItn2nYuJGjgNX
	zUCr8KqC5AmZuppLeGDRLfMhU8hsevYI8nVnONLykSUsP28/937UJuKCFdSsdBRg=
X-Gm-Gg: ASbGncufqIAFx2oZqxOB1kJzZ7jzYs/IgOp8Q5lV+3RFk6SeGsgES/GHxPrDZJd7/2K
	dI9SH4Eiezo9ff6T2q/Dmdcj8UUuOR1N7n5jGXonockbvtWi6MkISLSO2Bc7eGFCTJ+3ZcG8BEY
	+brkD7UaGdzHX8uvg7TICup2AyC81rET1jjnN9oQAwaRUdlskdItJ28D2R7/PB0b/ISssR6lVUL
	Lu/cI0DeQ8TtRkMMZqgYmKTKCdcZZc0cXnC233zDrScR5a/plUAF6zTM8LK72v+BPeZoY02LWZI
	3NlU1lVRPDohSNKwtefoTsFQyYjfwE2qRFHYwnoIjEj1RiycIk8QdBhekaqMP2QPC0PUoN/rSrC
	/pfSs5mYEHW4UPLTI+0hKVhwxPfo=
X-Received: by 2002:a05:622a:cc:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4e6eac002f8mr27371311cf.0.1759925872528;
        Wed, 08 Oct 2025 05:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE6rcrDHWT7DP/F4+y/G3pwK0hzfh73g82zoNrFA5XNDYX6nUSTfGMcfiA0x6v/CXm74kh+Q==
X-Received: by 2002:a05:622a:cc:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4e6eac002f8mr27370951cf.0.1759925871973;
        Wed, 08 Oct 2025 05:17:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865f7420asm1632686366b.43.2025.10.08.05.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:17:51 -0700 (PDT)
Message-ID: <d0e2b0e3-4e32-4cff-81c8-fe943084c570@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:17:48 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
 <20251007054445.4096630-3-sarthak.garg@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251007054445.4096630-3-sarthak.garg@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfXzpy20GHT2BlY
 2MkTC5BNaJbLuDIw6Ff9JTlfv9bKvATDcpY1fnjg3MM+0HZOtWGIRB7CvXJg0mL/BT7XDGxqDhU
 1IUEk3GPW7BcwoUrGTZ97/sKY0dH9LInYHOuLLabS5DFtzvM4WowVCLmmQY3rLTwyMMP5xvKMq+
 Ap2UDTWt29aO/hwrfmwUITMKLYAqmmei1GHBFkXj5/cMpLWLjyRkmIq3IaTRjJ0ifjt7UOFsK9U
 Br4YDHeiMm++o/cfdVoQEVagZscfGP/IfFT+PjDlpw6x12Iydfa5l5ipqaNgzDeZgEs91Sp0Nyc
 WSJlomUbxZ+uOkwIwEASMh+nmScfXOa021fhCo2Pt4KV1jcUMD79KSArcfS5ieHW/IxfYplw3Xm
 RM93aDP0Wbk3PWctMN3GmcuykeSV3Q==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e65671 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=17NNhpa1916AHXIy7EUA:9
 a=lRRPjgcFXaC3W-_4:21 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: GjCrgufK6zuKrca7H0m5Qm0pJvY9Xj8u
X-Proofpoint-ORIG-GUID: GjCrgufK6zuKrca7H0m5Qm0pJvY9Xj8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 10/7/25 7:44 AM, Sarthak Garg wrote:
> Add SD Card host controller for sm8750 soc.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
> ---

[...]

> +		sdhc_2: mmc@8804000 {
> +			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";

One a line, please

> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				<&gcc GCC_SDCC2_APPS_CLK>,
> +				<&rpmhcc RPMH_CXO_CLK>;

Please align the '<'s

> +			clock-names = "iface", "core", "xo";

One a line, please
> +
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";

and here

> +
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			qcom,dll-config = <0x0007442c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			iommus = <&apps_smmu 0x540 0x0>;
> +			dma-coherent;
> +
> +			bus-width = <4>;
> +			max-sd-hs-hz = <37500000>;
> +
> +			resets = <&gcc GCC_SDCC2_BCR>;
> +			status = "disabled";

A \n before 'status' is customary

> +
> +			sdhc2_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_nom>;

This can work at SVS_L1

Konrad

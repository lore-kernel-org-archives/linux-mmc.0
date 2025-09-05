Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F738DE1
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076413; cv=none; b=iXPYz3IHEDqaO7Rmz9d0FDh2SJZPe2N+07Aq5WRztiQWbWbkQwDvmYaFydO4KejKvQEiPc7nH2JZv5amH4W/ni1SANEhesVJqquihUF3OuqcZOf9UwOlgJWbmhsIu0ICJKtTET+TDAj2S5fZlaW3HA6DQBCDBJUmqN4+Qr/BHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076413; c=relaxed/simple;
	bh=WdzrylW6D5k/Tf3MlXm009pxRMhKTuh6CF95xa9C5lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHfigLz10TLhfx721glpV4TOQHOozwzT71BFTjXn+FMaBJ3XpO8+5diAtuwoogH89K7K3/aILidJpEcZaTLiT07T6LF09w5UPqfs4XlNXVNpKpVpSxfShSx5oKqw5U7YvWpqHKEGKQeKBatojX2xX0zTrpyYvrPqPIZAKuP8x6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJrdYtEt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJrdYtEt"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585B12HJ017419
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1SB7U/jII62BtLsfK3kvMJLkTFF545hw+zs878TRZ3c=; b=YJrdYtEttXAITCPY
	4qYd8AMnHHfAG/l+5jjnZLO8fLK6foNRQnVcZp67dxmdhGF0v7r/eqgP3l46j1sl
	f5jXTVz8d87UBAyagvT9l4cMu2QYvBRN5g2ECHq9bD8vkEfaGxuIJUri/OKQ+q85
	QtWaRis+ADqBGL6KORlALm3UJHwlYbMylZ+hmz5XPCoCFfcEc49ZdUQm8mstRF2W
	4BSiMS/mdr8nHL41mM7cHXDtjDBjwK/G6kiB/rF21aGgz/90cbrKk82TNLYJFmgy
	/9BIYzY6vn1BDyOuw8brJPIbvKsudX6L/f4iZ9XbZtK1P++x1E5r1SlDlIxMhjM9
	5ZH+Rg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9b0r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:46:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7f7e24d88acso60972285a.0
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076410; x=1757681210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SB7U/jII62BtLsfK3kvMJLkTFF545hw+zs878TRZ3c=;
        b=LBIPXWu8/QEBjDoUNHGtoqTHvetY7GLz9X7WP3ywATnkQbIV+PN+tCuBM+LxB8QQPz
         Vr99dFZQFIPznl45AxvCkEP43/6pJy706+z8WJ+8DrGdUSjEXSzQ85v1IizGhY+8tzxs
         b3QMXDv0VGfbqh78L2/qmCM1w/ZDRcqZzb16+aDs9j0slpRiH+gXGHK4V/iDlGmMWX92
         PGAc/9H48FDzHPYy1L+9do2+0mJN6L5Fx8VDZ2ZgXVJSokaJYUY/H7ywOFYd9JW8vJll
         FhrWu3xJD8DQiYjLgpX2qc/g1NjkPp/VmUqk0hPfEsJHAOAgwFSPlYcWJr0Xod8grI6c
         bRVg==
X-Forwarded-Encrypted: i=1; AJvYcCU0OsexxWNwL/Kn0KLnf4HKxVM9qn8RHal0iEhyrcR5qbUdETL5b/haaBWJf42KseVXvbhJ89CTmag=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTPbsizkHGjb0QdK0w9m24TivSqRDrtzcqpWSnWQnO2WLnvBa
	GNIGU4D+baDOKe6eX12MRPQAEvmCp0qOhhhNXxhUiMGTtmsHWB4X+uxNVHqNSWuBiRp7P/b/S+l
	FFWcRiMp+esckb+MZ/67BwjqGagduKLzUQ5zOuknvsvQQUOSZVnjCs+N2a91yb5g=
X-Gm-Gg: ASbGnctoZ1pokn+MX/m/YqcvAb1SSg4ciwg7hpq2/+hZLrSyHzivSYzjTy2T8VoGEPT
	sfHsaVvO7XHq1+If/nro/Gbkdgk+Z1pijTQeRkZ9agNjTeOI8AZyar1OuewEub2RAYzJ9wlFW08
	PxjgGnNdv7lrlatBkqsA9TCYTTNBE0YClWL8VlgAEfrL67gY2O8VIZ9yKT0hiixEtUbcjOF+wOn
	A3BJkX6oSNUBw/3lm7En+5l0XKkuw8iBPDOz3b1ZgsCh4QfMCDepCBLLPV+bwwB0moHRit3xH46
	dT3WMy40VxdHxX3KTfR+gvk71A9w29GLZzyiRNUS+zEVTRld84ust2TXoAlEgrCgNf/YXEznUoU
	4tVNrF23ztUY9H8fQlzJZeA==
X-Received: by 2002:a05:622a:50a:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5e9b60fa0mr18609681cf.7.1757076410275;
        Fri, 05 Sep 2025 05:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED88BDkAu3hHD2gZnrUFPzTysohw+/x37Lmb3zruLYrQfgSkQsU1HdrPUH85++Pzq/cKzFMg==
X-Received: by 2002:a05:622a:50a:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5e9b60fa0mr18609281cf.7.1757076409449;
        Fri, 05 Sep 2025 05:46:49 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0cb2cb07sm1727752366b.16.2025.09.05.05.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:46:48 -0700 (PDT)
Message-ID: <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DLBIcR_nWiietFnEYybBQ66axY0F2Ebo
X-Proofpoint-ORIG-GUID: DLBIcR_nWiietFnEYybBQ66axY0F2Ebo
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68badbbb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3WfgD9H-dY_QjJaUS7MA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX0zZtmo1TL7cO
 Aw8Y1KemeXjVz18GDpJO1BjzRYFOjMbbzPsNcRxP1rWVEPcY2EJWwYWPHGX4kSnN+OOv3rI2gJG
 TgAPZqJa6ibiXfgixbT/ul5WSHGKc7axsDk/+98WFeNtsPVoT4niBjxA0kZi3Az3PnMmcntG1PS
 r0UqD3oEDxxWmcgfMofNjjuA1Ge41+KwRAig04FFCj4ZgXkvA5SGkroEz8WsX28aO837AMQ+4IB
 UupuSrvpGz/DudiU1ncV7htrtNP5ICPqZ6Camn4jzGoVR0Q9NiEZOX62wY36bKPE42LBxU94HFh
 iPXXgf3hWIT4MQQB/4yk8pfrJ4HPnJnP6MLkCgFcGVk9ZwN8EfmpqX0LdS3VpVtuFr9OuCz+fhh
 J2Xq2Kan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> firmware.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 17ba3ee99494..1ae3a2a0f6d9 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -425,6 +425,36 @@ &qupv3_id_2 {
>  	status = "okay";
>  };
>  
> +&remoteproc_adsp {
> +	firmware-name = "qcom/sa8775p/adsp.mbn";

Are the firmwares compatible? The current upload seems to have
been made with Ride boards in mind by +Dmitry

Konrad

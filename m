Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A43C3452
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042348; cv=none; b=o2OetnZphY5tl/21WcM3JPKkS5UO57y36nUg1iuUMjz0rumVXjuvwXHdytpA8FL6XaETp5ZhKDt/L2NgmgUtAa301U7dExQqEPh8KstSqw7/8JFTklGWHhNxwiHEDQvDWhLAGGahqmy+Zu4JxZI/+4/Yl95JdivyFASqF52LpBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042348; c=relaxed/simple;
	bh=C5/4AuL6dHCuR+PvSd4Li62LFYfLWCvoVixDNatHrQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3oFHUigcAEIMGlWdRfbsWU+ZoLlQWYBM4sezHZXXZaq9ejD2B9du4Ayv4gzB9heN2zCZC3n9HCsJzR/fiabs75/ppVYtcGZEvjnqW9MjunsL3sdKVZLtV+glYytll3QWrqIw68hvGkS8zqUc+FJ/sCGlou87BqPQIaOop6Vrxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mAmwSLz8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GbVIfd7U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mAmwSLz8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GbVIfd7U"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HCS3X73512430
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 18:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0hIgd5emPImxsCYoDNvc3nRtQaDZundm1lfilHY8CfE=; b=mAmwSLz8eHCshU3L
	eVkVOLIP4k8QCd64PSX3UV2BqIP/+5RGoRu4VpWbR4zqiZFT4utbPSj31iqzKLDG
	rQOYJkV9fv3zZSOz6DLJcG67gLeulTtC4TegOYSv06GcGxTAmyxkqSYnySHzNbO0
	np5Dcu5glYGjMQCeiWoWdQt1JSp44ZPmqnEMQq7a2IEDlMv55M8UH2t+IMKVSUkF
	58M+j9wtnu/8fpsHUvOauNw68pNLVGZwgcjl5OMkM0LU1c+HETUZwGZ99nNo2wD4
	0hyT6fFxAn5gBagZ1npAsWXPeGzg5k0tije10qv21chQXHYn6MszILHrIrHV5Q1d
	FPobaA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gx6ub91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 18:25:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36781927b4dso3174283a91.0
        for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779042338; x=1779647138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hIgd5emPImxsCYoDNvc3nRtQaDZundm1lfilHY8CfE=;
        b=GbVIfd7URe/MPK2mdspM8c2XzfNfS3esaSilyc9rbYmR4+MBBXU83d3ulo2qSIygPN
         0GoPJv93ILZh9uyE0DNpn5zbcWxoXKquVakZnGF2u5b5srHHvb2rS8WWjnmIRt10LfVE
         tn3FlyMHWNbpi8QtbKeMKMojX/oDP95jr0HAf6NORYKMiBhm8SrJP/oaUf3xfEHN24ZK
         fht6JZn5I4DlkdMbkKv+srRkxmdZgX25jHkOUA5tEZZZ3EDGb1bUGCZ20zI2rKxCSq1s
         BqgIOQCYewAMVyVbG+2Ht2m+WMutO1+ddggl09vHxLwRdiccmcqNubHoxLCySqAlc8qj
         Su3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779042338; x=1779647138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hIgd5emPImxsCYoDNvc3nRtQaDZundm1lfilHY8CfE=;
        b=EPsq819AHndScyMdcsgx0TeNQeUDbNoRvQNtVNZ4hHyv3H4Iu8rMEJKOwQyqwU5Jm+
         2dMgysCKcKg5QcJZwbMXNk9RD0enieqKbYHlkCJ2dmE40tLPt8ZMXmiek2TyK5oMXIXq
         gXAGTO4DGFArPua7fr5IlBqsWKpMSKMbQzz0k6Ij+MLM2kbTbdkPw9aZ1p1EN6zDzILx
         lXxQSOdCm/GqCb55kZKcobt8n6bbGiUal8PntiQgTydJNYxhuxa6NC/b670ClMip2PPM
         0KQLuG/Z8dLdM6ISEln7hT912Efwvcos+C1y0UXENyB24svUznWji9NpkSa5Aj3R9bNQ
         G2Vg==
X-Forwarded-Encrypted: i=1; AFNElJ9YWnOVq+bOrDbTJ/lGOTx/aaUSVUMWObtOq2lzRBXXcvxAf5aHsVhDAdRLRwS7/zB6g6KzOpgGGBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0/e4HpuUFSdAdouaILORVSRBBYE5qETXGABwBtiqw6PFA/rH
	ToIJHbeZQOnWnqb1B1s0EYXTh/3wPuREIR0S5NiW6E6ltBWCdUYJA7n+vnluKhUWMA4ERY9Y6Qk
	DEIQF/sYS7NBLTbpn4M5/u39+wtM48wT3OoCkwdP7+ZntHu9eGeMmpdGBmRqbZhI=
X-Gm-Gg: Acq92OGF8RSgVCKoV2BXDd4u5/1gXzOG4I/OTgcTGMEPwbBuReJdfoAs4lvN/y2iTRT
	5KbHbB5JBc6J2Uz9CCQHc8zonmVT6EtWEnKYgSPYwZod5lNjVdNstLLcaD9e8GYhRlU2h2sRw3a
	+MU/bAZzrszuB4ZE8HfUKynRPxRUKIJx2qXEwaxOeTC2zwVANRu2PHYFhGjHlu71LCynoG6yGkM
	jzPsy0vERJnG74gaHRJ+9o92/eF+ySfF2sDSFyzRd0xoJt2stIQWtcGZ8YJTzKqIewQ8IZu9Bik
	9tTjjyFDlkwE3E3As++2typVq+zTEhTQv7oV92FFWyt5oacRDZTwNmrQ4PVmf7b2ys/yyWIRtix
	FNZeaoHFaIa6OAgLHOMPNMINhVBh9bKr3gy0WboTLTNRH7PXmWjE=
X-Received: by 2002:a17:90b:57c7:b0:365:7e4d:bcb8 with SMTP id 98e67ed59e1d1-369519cdb59mr11841965a91.1.1779042338041;
        Sun, 17 May 2026 11:25:38 -0700 (PDT)
X-Received: by 2002:a17:90b:57c7:b0:365:7e4d:bcb8 with SMTP id 98e67ed59e1d1-369519cdb59mr11841940a91.1.1779042337545;
        Sun, 17 May 2026 11:25:37 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.235.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951278e7fsm8478759a91.8.2026.05.17.11.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 11:25:36 -0700 (PDT)
Message-ID: <68dc84ac-794d-49e5-a834-e7a582753b07@oss.qualcomm.com>
Date: Sun, 17 May 2026 23:55:25 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: Introduce Shikra SoC base dtsi
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
References: <20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com>
 <20260512-shikra-dt-v1-2-716438330dd0@oss.qualcomm.com>
 <ced00124-9ba2-49ca-9200-62abd6ac3340@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <ced00124-9ba2-49ca-9200-62abd6ac3340@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6oE9FZKi8RqNzdm8H9dpJwafJF0tBO1s
X-Authority-Analysis: v=2.4 cv=f614wuyM c=1 sm=1 tr=0 ts=6a0a0822 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=g4/7f0GlZvY0MGcqtTB0Sw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=91D59dQ6MEgKE8FQPpwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 6oE9FZKi8RqNzdm8H9dpJwafJF0tBO1s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5OCBTYWx0ZWRfX68jqEfO8vSmA
 zB7TwHPMyIxJpDFohB1KdP6CoWJu/GgNLsNBXgHyDzvDjrQXOSfgJlkuuphx5rLRRfEBq0RsxNn
 hHXc7OtD9pVMPZDBirQn2NSjiOd//Ob0Nfq034E/CIxo46iHg75Ah5p/cXHIcSxf49s35qhy//N
 LDRGieML8P/dMFx17oVATY7hmfl5pyBKqwBLdBY/GmlgXbmZdWdGNhkcTLey9vkHPi34RHPGbGh
 m1b/EeKRk9MnILxuKSq1w0AnYqk+35G4F1kIXL6wKOPzGoJ2t+MtteYTcmdJIfPTtWXqGO66/Zi
 5AdPm8SOxwcW77YEOAYd6iMfBcrna2bNhIiW4cVoLo29n7W8LxSSblNNKro8URhj47gFpS4CD6q
 JLn0cPGHtfoOmYYl7tQYAuVrq+03ZPNvZYyARHqfCrSTbDVLQ7p4OzQEWz6d36nfFeODDlf0Fbc
 N+Uej0a//0SgnfhJ+/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170198

On 5/15/2026 4:07 PM, Konrad Dybcio wrote:
> On 5/12/26 6:08 AM, Komal Bajaj wrote:
>> Add initial device tree support for the Qualcomm Shikra SoC,
>> an IoT-focused platform built around a heterogeneous CPU cluster
>> (Cortex-A55 + Cortex-A78C) with RPM-based power and clock management.
> [...]
>
>> +	pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> Considering there's 2 core types, you may need something like:
>
> 9ce52e908bd5 ("arm64: dts: qcom: sm8650: switch to interrupt-cells 4 to add PPI partitions")
> 2c06e0797c32 ("arm64: dts: qcom: sm8650: add PPI interrupt partitions for the ARM PMUs")

Thanks for the pointer. I’ll update this to add the required PPI 
partitions, following the SM8650 approach.

>
>> +	};
>> +
>> +	psci: psci {
> Unused label, please drop

Sure, will drop it in next instance.

Thanks
Komal

>
> otherwise:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad


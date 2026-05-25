Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899C382F0D
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715005; cv=none; b=bvXuLMyLPA0KSZKNW/Zaj7iq1S9h0ZwKo9kWcGR+MIkAZ44hgTt1SmtWQwcwrQmK1OaauxK/Sfn0+1CfRzHd2N4XcgXiBUOc6yhImOp6vYJ8vji+ArZFW7RwrhLw8WsLthDg5kUCrz20j3JwnBqHPQuYmKcF78WQN0OWtKt5NMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715005; c=relaxed/simple;
	bh=S852ehqBfb0/5Ul5U+y7lcBRcWUwtf9wkT0ZuTEZgNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjMOEabGin/OXdoL8qFiWOOQP9U8BJzzgsWsO4sfD20ckwDgL6NLF2qjg57i7uREyvXkYXvQEIQe5TgkgBunzdSF8X2V4rCJy6xWhGXc3Xjw2NT1QuOOPr+dJL5WvNyE6XVev5YYVPM96UrVnpQgPm9UMjJWvtXpaX7wo9J3PqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGUebKqh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jbNmHusD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGUebKqh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jbNmHusD"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P7QTgl3063497
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u97YqLbcmLlh10lDQSuWmKtQsqDRCwVMztT7iDYcshA=; b=pGUebKqhpMtm76GN
	PkCzhsWW3B2/l2VJDFTjuneFWyarLhRaSyY8PP8GOiFzGcR8v7mn4M6SbCBDo6sX
	vvFrQ425kV/00V/BOLOLaZbqeObzbbm/xImzFRc+mECF1ygDNcvMh6Tpta2KLxsi
	BpWTVMQDHTJpDpmUSLvCJ3+InbnTMy9kWHP7ByoU3lkFFo0oWpik7kPmneIkIZnh
	xQrcpO+eysQcryLvMjnvKw46BEQ2MHiJcVy11s17VksXFOUKONQC/adETAtVKhpW
	p2opz1ulAE5ley0WGUObrVekuyuEYJA42q6doNi0TfAENVzwxAGLSNM3L35WZjq2
	oOY+mg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecj1gh7ch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 13:16:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-914b79adeb6so69832785a.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779715003; x=1780319803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u97YqLbcmLlh10lDQSuWmKtQsqDRCwVMztT7iDYcshA=;
        b=jbNmHusDqDGh/7Uks+j1Vi+nudP0JcAMtW+O8cfqe1d36s/xFTQ9Y3gXo4xZYZBEtS
         GfajkXABH/Tt0d6PMEc8O/C7ck552wzaujBf8HDdj8TB+N1Asz8Vu6SiX04s9jIr1ipl
         ffzuEmqI6aqI4EnemJiRbtwAAUM236PL42wwxJ/LiSrd3UfeMviq8b7RPrAg4BAwfRWE
         Wlshjk6jiHtmgyy3GaIxz6FuDjPeCoYhK4hiCcZKwNo2/crHFc7dvauwqyCKZMsa012o
         1moeUZp0E0lQTlkntu28lQ/Zzw2kfJKsHcN/KT5wXBwH/dnXOJ5wjS9dXUepygfPlJ0e
         i6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715003; x=1780319803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u97YqLbcmLlh10lDQSuWmKtQsqDRCwVMztT7iDYcshA=;
        b=aXuO88e8Piajbcfowj4Vv1+jS8tDOxJHALTD7maYHc3Trxed7VsECfSKsja89FeQ7N
         SZDga2SOKqbRKct1iIvrrFaviINhwqeElv6LqAD37oD3Va5SYXtLq6LmAsCwvknhGX0U
         jBWXnkc45wieGR+ZKWXCpQtQCe4KGadwRIG02dfBUC/hsDMqrVrhze0D3DEGc1mt2Ezi
         OhKO8BmGjuLogNr0paU5vs5mFVw+pX6ksUGlWmgHJFYKCVun7kUAJZmgnYOwvvTbd35N
         cZKsbOX/rle1za2ax7n2Kp/4FSr56tmiEDSl23DA61kGtn9D3E3ZuSi6B0Yvud4rdGQX
         bjig==
X-Forwarded-Encrypted: i=1; AFNElJ+aOthjw1kAa/zlo2aficRXtVo47Esfzra3xMLEwSzTYb3F/ArwyozQVXxlHjnOWbQWRTt8cyZM0dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTr+hqFn2nT6+6U1QWlR56AbddfI13hqtlZnoeDkV+UqiT9cxV
	8CBYNaTIXB//3342QD/xGOW7pCQvOVgUU8328jhTIe8ffuUuVe1SKixOq3vTaDZPXzkiKG2iOEh
	rR0WWACnZBVWrdcH7G7vdB64u4m4k84UbKzLYQUT8vKw3JDz8BKWTHJRUZQFaUf0=
X-Gm-Gg: Acq92OEQ0BP+Td3w6Vqrwhqa/5eq9eRPatWbC4L2MEPQlg4oquooX+dqTYMWm9fXYNX
	a5IyyaIyDpbw0aZEPYGiSvUD3yly0aQi9HO5DYIQ9otoej8x4XxaDqXDvZQoVS9WZQcwz8thLsw
	WhFTeefsXz/JwDbW9G31f9eBP+E1xPTPSfaBcKHorySoLQk2eGo9iIkLTN/wYQ0W8w5mtBYydBh
	zKMEbPHbnNT0gAQZ0A+H4Gsasvag10LZ5m5TcI/dVWuw9zEXd9V/4jzjw6+IK2bRjKeY0OjbtgK
	6rgCcl2aZLHSPg4GlFNz3oDvSk9L9mXB9/jrVNYkpNocAG7SB4uf/upgAf3g1GBWqATzsIL+Erf
	BcdZGaMavGgLM4g1gnRy8FLgh9XD6By+pIgu1HzOIe0F4gQ==
X-Received: by 2002:a05:620a:2813:b0:908:a758:baae with SMTP id af79cd13be357-914b49fdfc3mr1377839085a.6.1779715002359;
        Mon, 25 May 2026 06:16:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2813:b0:908:a758:baae with SMTP id af79cd13be357-914b49fdfc3mr1377837285a.6.1779715001935;
        Mon, 25 May 2026 06:16:41 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b72cbbf3sm3903115a12.0.2026.05.25.06.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 06:16:40 -0700 (PDT)
Message-ID: <63752557-6468-4aef-a847-06aa39ce108d@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:16:37 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
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
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
 <20260522-shikra-dt-v3-3-80ffde8a3dc4@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260522-shikra-dt-v3-3-80ffde8a3dc4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KwNUYaJuh0a4fnXmnnyqmVcD9uvuytcn
X-Proofpoint-GUID: KwNUYaJuh0a4fnXmnnyqmVcD9uvuytcn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzNyBTYWx0ZWRfXxOV2S09+JhYS
 fLkNOgV1C7L4SoHjeQMmKi5QTdB9JgciDrUTXTx4biIJzIAGsoWCF7QjDDy91vbmwAo144pJAQV
 mfCT4h9h4a/QVZIlwdckfohOTaGkn9Lsevn/na8Zt/3sFnI92xCOodvNcxTIZ/EXNAlAuDhWl7L
 /MPqQoXlyzn9HogRye2d3Lk2LUqECaovDPxvtu30U0ncuxhMmuwg9xauKBLUIQMkB0svZt4qPvT
 a6cF8hMzARQiGVoiGzl1/uEe9JnNoz9KT6U4qAbzoT2c2oUb0oCNX/4Fs+/X/ScL3EWXT6qc7Hk
 g1KZL3h7RRirOFroVhZm1lp3GE4hyRjtZ0w915yZuYHYXzGZtxuLIGeMdRWmDW9geIXPufyBVpw
 1KSZIrl2tQ74HrUuTqt1AApcJQyg+t/nDNT7LbY7TmMKZWbeduJihZaI+tPBp04JX0zjnKgdk8K
 ERHE6kRIyQw1TmwGjpA==
X-Authority-Analysis: v=2.4 cv=D8F37PRj c=1 sm=1 tr=0 ts=6a144bbb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=I9A3L-BP1q0m1wO2EfQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250137

On 5/22/26 8:02 PM, Komal Bajaj wrote:
> Add device tree include for the CQ2390M variant of the Shikra
> System-on-Module, a compact compute module integrating the Shikra SoC
> and PMIC for IoT applications, designed to mount on carrier boards.
> 
>   - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 and PM8005 PMIC)
> 
> The DTSI includes the common shikra.dtsi, adds PM4125 and PM8005 PMIC
> regulator definitions specific to this variant.
> 
> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

[...]

> +/ {
> +	gpio-key {

This is usually 'gpio-keys', reglardless of the amount

> +		compatible = "gpio-keys";
> +		label = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_n>;

property-n
property-names

in this order, please

[...]

> +&pm4125_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";

A \n before 'status' is customary

> +};
> +
> +&pm8005_regulators {
> +	status = "disabled";
> +};

?

(also double \n below)

Konrad

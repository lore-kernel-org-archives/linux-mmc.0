Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449A3ACF14
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818448; cv=none; b=OYGIeWNJRzrx4YedZQdm1Oo7rEj34AoS88yZccr2qOo8TCSAOnVQbafk5VfGbVQCYM/RRmU7mgX/fgXymgp0hmYGXoIuCoVxBAHgfm9Q5CVejwTwG7zYk/FIhijOqadQeN4/6UgMIawIk6SQqOqxkTGpNfZ8lmzGSwpFK+/b7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818448; c=relaxed/simple;
	bh=g4vDsx7AAeCpkibFY7xmrW+P9uLh9E8MtiKJ9h0jWFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G704U0QTdT9mjTMVixcgRVgpAxUqkrX7uNVgoOi5Pd04p3Le1PhVCPmRJ3rZG0gakBWRztyW8e0VPxtBDxbff1DOScA/BZopV5ffcwlRkcljzNISstth0kcbItuxeLtWwEWS6uppRyBXj5Ns7gwauay5XzhPBuH8zWJt7mv4vtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PI2wsrZm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T0Q8CKmV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PI2wsrZm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T0Q8CKmV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AA5fV61498649
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 10:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T+T0pbPrCFK4jJi0PBGJd5tN4NDcA3zu0rne4iUcOJ0=; b=PI2wsrZmhb06nJHk
	ixSERcwKR7VoHMq5XbS22tdm5yrkvWrvRSPtYIMxPsG98HNSKGig5N5SneTqiD4V
	O0tFxjI5cs5otUqvx+3fQNoPKfQMVjW5lgtMdKOnOAMjbeeUq/6CTuMOEAgA7/tx
	juB2fczNkQmTtmp5/1CHgCofb0wPHHDx79kBtAvxiuG+7fHuSgw7G0QQvN7QOZ1N
	Dgq11cyBaL4AH7nwJYluA7o37LmeN0/TtuDFWSSO6GHbmGjAR+2EV9VgsXREdsDT
	erE9nrZloYPURlGNGm/epf29KKRifpnWq7FwZcO2ibA3WGO6ufIL21IwFOxtWa5r
	z0++/Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5b05cy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 10:53:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1339221a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 Apr 2026 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775818439; x=1776423239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+T0pbPrCFK4jJi0PBGJd5tN4NDcA3zu0rne4iUcOJ0=;
        b=T0Q8CKmVv/SpNxwj2Z3Edv/WlsXgGhELz1+WyVDJRtCMBlvbSvmMtG0B6WXnX0hzja
         fQHz1x1SVB1MHqFJsEgFsG8FR6WmPgDeYClMptyQgB1AVrcFgfnvrRV1wtksOhSsWiTM
         0Lww59K7Xss7k6qlXUa2DKgVF0Iib9Fgk3+VEC8l3w8eL1k/dK+RMsURHWSGCz7bi/L8
         okuxYwI64l1BJOaSX49vC51ihxf0kb3qVEErqTNhAWHAJZhQCuNp3e4p9kQmdtpIsg9M
         9BeZAYfuru5q901YqHOaKZrbaxkzpN1h8SGKV1tzHBNnZtmisPlhD2KS1bqIQES7KD+m
         xuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775818439; x=1776423239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+T0pbPrCFK4jJi0PBGJd5tN4NDcA3zu0rne4iUcOJ0=;
        b=nr6Kvw87pbVABz1EX5MITXYYZf2lq+kKnsaUdwoe0kQp9h+CsUJ4lbCuKkI17bwOnM
         /FWyP/DuP2+0YEXQjT85hhwhLNjaesytCJHckJH1ko7Dqw7ZbrFyIAVBZqGp3h0wHT+x
         Z2Y40miiApXrHt0UXOF8EakvGzq6/wKbrLxgcuP9lkL1s6Oj7F/5F9+sdcK5s1EWkWiv
         G28dRYSHeZB/KqYS/g/DzfiO3uWIW1IdDiNPgXowgGB6yNZbdRtoUWi7nT1oFAfVn++Z
         K3HfuEdxn46rtNgIBAcTLZ2YWwLTdjzAW9lVa3dSLRhz3k+qfzkV0hCpqOMuITXyLzWm
         v2ag==
X-Forwarded-Encrypted: i=1; AJvYcCUibtBEayVn8VwLY1herYGTa9kGbv5V7Ep2My9+iz8w3uVd9cIs+qQKPIqYy1KVboy6rKuY7bZ9HH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZK5zibnyIIgH21kfx+uzvUClyKbF1ywZ8PhFYMFA/FQx9oLL
	uU/cou56J8gAPCJ6Mk5CqUEnkeZLxxrCoOmoIPbRf7T29GPxv5TI7x91gu2VNy1da4+5Ni9u0ci
	w1vXT8mt5ijXRI2Bk8UaNhcSkI1Nq5A4wqdrp7RfsQFC7G8RiK0ijWS6opTubtqs=
X-Gm-Gg: AeBDiessNB5l2F8sAZHSMKMZuKAafewZOhLsRLQCo34EHvZm+1OgySlx6oI5qDOC9Hl
	Cb/NenlN4+kr1F1GxFfaQEiNktPFpEDr2SrcYfd26grwW6H4eGiAWToMnxxVv8S/2CxPt/MlleC
	XE50B/LpiADE1Vhqf65Wpahn3t/ck3ZI0zhAShwXOe3fkSEgsvm79Oo54aThOgMEHDhiHoD35of
	cJjmYrEfNnnInHBSW3Kcti5G0d/E6jVvprZB+M/GkbtPA6XvVrOq69j+3ZyaihFtJhZ/qyXiPRf
	Y4lF1SRQnRnJGvXDK6vUu4Jj/LWNuw0CUPcBEAorbi0xM4MvavESDdB9PyF0C1WIkofd1CrGuHN
	+KypH7eupp2/65Ta9fnkRIqfhPUYGfIApJ6MUfaez00hK+JntyOAk
X-Received: by 2002:a05:6a20:432b:b0:398:6ea8:21f7 with SMTP id adf61e73a8af0-39fe3ce5e7fmr3214214637.15.1775818439092;
        Fri, 10 Apr 2026 03:53:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:432b:b0:398:6ea8:21f7 with SMTP id adf61e73a8af0-39fe3ce5e7fmr3214178637.15.1775818438564;
        Fri, 10 Apr 2026 03:53:58 -0700 (PDT)
Received: from [10.218.44.178] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79218fc8d9sm2160706a12.12.2026.04.10.03.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 03:53:58 -0700 (PDT)
Message-ID: <cb6b19ff-811b-427e-a588-cb85c6854da8@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 16:23:51 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] arm64: dts: qcom: kodiak: Add OPP-table for ICE
 UFS and ICE eMMC nodes
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
 <20260409-enable-ice-clock-scaling-v8-4-ca1129798606@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260409-enable-ice-clock-scaling-v8-4-ca1129798606@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AFaArXpwyYXK1c4oTzxh0N2G-TPGOsnn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwMSBTYWx0ZWRfX3cjxoo/sKqFS
 m21q3IbtX3rb7TQTvXdBmmBiQEUsIhbmIGeJtSEh32i1dr+vU7F58lE9icCZMnkWV2OszRLziIn
 YSo9LWXmClfRyxChAHI9xZ0rD1DXF3XUVfm8h6tOsIitrVU5MPddvQnZlnPk7bdeveN/81vyZTY
 4SVdP8znucyATTpBVFGe0LnT3NjXqINPC9BdmO7zBCtMhuh4Pj3PdUvvJcdxDeN+hjRKRnM7TPY
 0fnKi/3brV9q0+h4mvlh+oUbcauFeO+b1MS5kfSkzEW3AnV0vROhEar77JxisQaDmouP9aJzDK8
 tkEi/XqlHvobo3612D/uwtZ8WojyAuYSgqxgZ4zV9O5aGTuEjrrz1Eq2B06QAIvYiHPjGUqSQ2V
 Jwg8Qj49Ck2K7OVvt5+LVkSnK4gk8HW/irXpH4XeUO6fkUWeWgYL1xPacX17VkjBL+AHeHXFQxp
 2m0fgrdGZTds5vETvIw==
X-Proofpoint-GUID: AFaArXpwyYXK1c4oTzxh0N2G-TPGOsnn
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=69d8d6c7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QRdWpJMrku1fmPn5X40A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100101

On 4/9/2026 5:14 PM, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS and ICE eMMC device nodes for Kodiak
> platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 42 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index c899a17026fd2a10ebc528a816629c88ee3bde5d..b0aa1970d42a3bb0b9d371e0e6cd09b8cd164dbe 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -1087,6 +1087,27 @@ sdhc_ice: crypto@7c8000 {
>  			clock-names = "core",
>  				      "iface";
>  			power-domains = <&rpmhpd SC7280_CX>;
> +
> +			operating-points-v2 = <&ice_mmc_opp_table>;
> +
> +			ice_mmc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-150000000 {
> +					opp-hz = /bits/ 64 <150000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +				};
> +
> +				opp-300000000 {
> +					opp-hz = /bits/ 64 <300000000>;
> +					required-opps = <&rpmhpd_opp_nom>;

As per hardware spec, 300MHz is supported by SVS_L1.

-- 
Regards
Kuldeep


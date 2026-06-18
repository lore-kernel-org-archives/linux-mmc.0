Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092D3F8247
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787934; cv=none; b=QyxhnRQi9Q7KUEZEyqkARI29hF0DiAYFScgZBqCIrHWqrue1cCmp8Ckg6y8151Uw537SATp0rkEiFvCUWChxvKoq4xo/4F2z+LESdJZWMwb3DqBFoelIGjJZLaCLH+LIvknFW43Mr+ZVkiNluLSZa1kDHBjpuXPaPUo+ePKIqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787934; c=relaxed/simple;
	bh=vzILV4+h0+G1LsFLbM2We1npcaJ7hdgJ1uT/BQ+/yGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORsKC5fWCs9eNkigknhS6ANE1yeELMjSK1Uu2V7vzsN4UxTeoOmjeTIWXiU0S0FSC03pEqHV0h9wwMzksBrZM5GZ60jmotgNiDSNDDA9KvRGAwqWP36XgL1+lJn1o1OIdvITrM5nkTu0aY5805GZWapVqYC0+ddKq8Qh5yY9ArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AHo7QnnR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WD7QRmDU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AHo7QnnR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WD7QRmDU"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ICuHt61867451
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hExW5q53C06OI5kfHEsByW9qflDmMT+s04jRbOB0jEw=; b=AHo7QnnR9QOcBty4
	FuD6avT34992eZifOfKBbRensUEWSFnNabdOqVHqPsJJH3Xa1d28ezcm/8I+OIJp
	dyYxbNVqdMgcwm6SjE0dBWlJOfhYo6RH33VFLRFL5p0lp0mjjQlABBepV2JWx8A+
	8QnAT0mJ6mAX3CBxEVv22oQr6lWLCJE/i+zkrHxeKiuUPkj12bCa9DkTn59Ui5dc
	eYoYOOCWMfOE5IRzN7f3Cj/rAGLmJxwAWeerRq2Af74QdyvNaxvQhQeuDpECvaQt
	EAOlR0bAyr2GUdaxqeRUSErAmzq+gsuaKBoxXum/RCdZYyYzw+IUl7wm/L6VABig
	z2GBpQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jvkdw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 13:05:32 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6eb4c605cso159963a34.1
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781787931; x=1782392731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hExW5q53C06OI5kfHEsByW9qflDmMT+s04jRbOB0jEw=;
        b=WD7QRmDUibQXzeLS1ISPqsZQFzMiNCusS/vyttnNw96B3/y3nwNfDfr4S5RZYD3tjc
         xaIjSNlqzP3DsYKDyafjbZUqjBuH8cMF8264jiRX82Lu/W1f8EAIy3HHpAexXYwCDCVK
         StpP38FZ7FyK+iAxQvG2IAYLX4OyWJ4ho3cYytauhBXkR3ZYFqKck5oi66qE78cna7hV
         V2mefpd+x1+4iK+qUlc+kYzfSSqkTi1T0D2ePeROoo1ij2Uzc+g1or2ppyW/ByRo2x9h
         FPbA+iZ7QMtPFktXpk4hho9+aV4uP0bdd1IONOQOpjB5cG2YbrkhY50yVaN6MmD/YiQF
         zLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781787931; x=1782392731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hExW5q53C06OI5kfHEsByW9qflDmMT+s04jRbOB0jEw=;
        b=NQ6ZYnJIHo9BDvH06IPSS9hc7uM6mKMOQbQ8tgj4gZoSeFyT6lm0dpWjVB+RPVIIPU
         hE2hDQTFyBcTHuG21A14HNWPcO38ZVR614itFXYk5bXH5xC45DqpqgNKgMY8gMkhvWfk
         hI92tnxvbAXNQMBxCscsfsmeDI6WFg5z72c5ED88j3TcGmx/PBvI6PSwTNGzyjYoWqx+
         lYdt+cm6F2+hLg6pGG75OtNXMKBm7fB562KJAQ82GUjR921fKH37qDu+HdiYFgRKKBtW
         k7EjNXIIEjzVG0epQrSiwgot53xh5Q+MvXmg4mEBQKx9VdwadlS5evPwygmSM1LB4qkn
         gMhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FWYnA7JHaZBkhsRiRXSkULJ85OZwd/cBXIQzc+YnUmj+GaahjZ2EUz99hUdL3gKCaLkjGalZrA2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQnnIPubEpte4WQUK0z7Sk4X/JjBLN+ss2UrmnBE3i4I80bOi
	TbdRv4CwrMeRFzMGVrCi5WOvQJw5h7TEnLP8v7Yr5xUqQskgTbT72K/0ssKomC77Px7D3DUOmSF
	7Vpx/VXx+dtSEt+xA5Tuh1Xp6jR9Qs4bYMbr+Jh7S1M86RGMhb3RsZcQnl96aBPE=
X-Gm-Gg: AfdE7ckP/zX2q3SD7RFSGNM8MISBgNlHrcov0dMvP1Guqo6PSc1umJE0nE7x/BOxlUS
	kQ/ytG6PSc3VoCHmeBzzz+vMIi9hya1lDBGxtQWWY0E5U+08y4lC62w6IWG06M8RsegQAWywnQy
	k1w+FqMRFcVM3xkJ/l7ocYKEqhK6iVPCTBaDl2zJPoGO9WVfWRAon5OYAk0XqdXTX/+iSbI6H0S
	RLZpn3ty7vv1xmGVjLfuKwP5+N4hdqHMUhXFc4Ye4fzOV2LP/llaSiduj2S7nJbP7TQ0/zKkOLH
	dKA75cA87n0cdQ7htUWDqrw793DcrIV0MxBUOVj2NLgPAnW6cQpyn+sgW4Vj1WUR6z6C4NMVHMc
	vHSdFFexpZVJMQbsFt2sCkaJ3PvTud9LV1Ng=
X-Received: by 2002:a05:6830:43a7:b0:7e6:6f9f:7445 with SMTP id 46e09a7af769-7e90c7497d2mr4390137a34.3.1781787931546;
        Thu, 18 Jun 2026 06:05:31 -0700 (PDT)
X-Received: by 2002:a05:6830:43a7:b0:7e6:6f9f:7445 with SMTP id 46e09a7af769-7e90c7497d2mr4390108a34.3.1781787931149;
        Thu, 18 Jun 2026 06:05:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b22544sm929983566b.14.2026.06.18.06.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 06:05:29 -0700 (PDT)
Message-ID: <71f41225-226e-42b2-87e4-2c8b082aeae7@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:05:27 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/6] arm64: dts: qcom: lemans: Add OPP-table for ICE
 UFS device node
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-6-1cebc8b3275b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-6-1cebc8b3275b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfXzMySuvDHBE5p
 f6JbK7u6Ae5islS7cZKlD3lXZvrWuePjfw5+D1irjgWovbA3EoxcIOx8vCjmrK+O40E2lG/BPlt
 IuWUuCLvbA0V6I/X4f1mFWDkXznVP7vzT4M37Qzwkak/GN8Nln8CEPgmmm5oGwzc41URQUZEhgm
 6Xzq01jhBuQ18jRJAYlesEpXH/KwMnVZTL1/jabRwEzs1O4mB517PWL11A8MRctBQMsMITHJBFV
 8Yr3DgLT0vmk8gEwNbOLC2K6oW2Zg4tHXfE1ZUqz2l8gY51u43nNigCbT7xkaNIQJ9K9zxZXZZ3
 skQI0ZrAVGc7xHBiWl29uvzc0/85qzdx2P/o5oC20PnfU54JX9JUOyVtTd8mQaZJzEcAnaVKg1m
 W66//Rs1zRuO0Yit195D+FK8qDTuma69+VyCyCNiDT+48PiAHhi+pbfzL/wLjsEkKgmgU1VHm1x
 +aPjfT8aXjAN/bmGvkg==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33ed1c cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=OfDFtJRAjKKuzGRYHJAA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: sSJ4neHiBtMffqAbTO71nc7VBaEIxoZS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyMSBTYWx0ZWRfX4s4CPIFtk1Lc
 ToYNsYOGU8L5OSMLr0opjK2SmrVYaZ5HgJRoQRqDLoaZPV+BUpGFKS6cMp0CUT7SWqCdwYlo8n4
 HWh8RYBVmBdAjb9QQ/zCyGnlfEEDp70=
X-Proofpoint-GUID: sSJ4neHiBtMffqAbTO71nc7VBaEIxoZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180121

On 6/8/26 11:47 PM, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS device nodes for LeMans platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 353a6e6fd3acb22ef228bee340212b8b2c300957..f100d706edde465730873702f0b0a00b44050c23 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -3109,6 +3109,32 @@ ice: crypto@1d88000 {
>  			clock-names = "core",
>  				      "iface";
>  			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			operating-points-v2 = <&ice_opp_table>;
> +
> +			ice_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-75000000 {
> +					opp-hz = /bits/ 64 <75000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +
> +				opp-150000000 {
> +					opp-hz = /bits/ 64 <150000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +
> +				opp-300000000 {
> +					opp-hz = /bits/ 64 <300000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +
> +				opp-600000000 {
> +					opp-hz = /bits/ 64 <600000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};

Analogous question for both pairs of frequencies

Konrad

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144C348860
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180424; cv=none; b=nvLH6INx9BJkKq9BH2SEsHVm95pvj8cNBHb+rGm+0QO2z5qbOwmY4UiGM0+YuDWm0Q5rM7GNBZ4ymi97JAUJC9Uhh/iPGyV38CF9fkJeySq3X3iSt70QQ35BT4tDG9G4fom2/zGNK4PicDfZJat7ZhCOMmGwwuyd/JpeOWYD380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180424; c=relaxed/simple;
	bh=LD5koep+nrii/XuykvR3Msykmd/YE6bxJye9b/iheAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQaLcMXL5iM/e4Xjde7Dkbi4aZ7Mg0H4xzX2upDUPRnVQ92eiiU900RN4OcaHmjDWG+eo+GOrc+ctUawB9hqNPTD6a6wfgr/fZcgwSm3vwbkq9cm8x0RXnHjhgokk0ITRNmC30hu7ZWy2ffBuvIgsudhnD2rMGIpRjGStjrfb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6OBpqGq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fUhNIafw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6OBpqGq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUhNIafw"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xM7W284300
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 12:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wvUdbixww6CTGMe6OrNevndOOKL7ZNzp2IY7YAuE0kI=; b=A6OBpqGqmEZMzkZL
	aNeAZ7SbvyzaXDBfI0tUe5+HWCBd68U5xPpN71bLr8J1GQxpNmHQuEzHvdYBcms+
	O0ND70Ndjsba0YqlURI6SmLFLMVvVMNBL/7o1eWkHDqHIdJBJVFBKBAKk3MmPc59
	OEZuANvEsvSK2TRiC1Sd+Gu0CQua2XoGWWavBNe3AnXHFceCu1jDobQDSNPkOpYg
	NYxUJwxmqqngkK5jIelEsIwNcM+HODQveriYrLQ1yedKC464i7wtLwD27RBNKPDN
	c16zsSUeMNttXyZzBCZK05AMvDr35iXKNrPOHrgbMWhDwMw0wYdlL3JA1kRfl1oh
	6xLl6A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tkbwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 12:20:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c857fa2706aso3426747a12.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781180421; x=1781785221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvUdbixww6CTGMe6OrNevndOOKL7ZNzp2IY7YAuE0kI=;
        b=fUhNIafw/M4Bb6p5Pr2nh+J0f/GdaYGD/uIMh9lZUw73fsiMKJpPm3g3e5I/LxylJg
         G9kC12jLmCKoEJZaJuGWaDLSmdI4z7w7y0UpuegwJ4bw0YceUH/wY6FTUVJvSwG3UpqK
         8EA5SpXdTzlFBODPncV/RrOVhmEzcguo6jFgYTbRVKzrG9Mix4b9e/YqHLT1pQ2F0Zx4
         4zIvCpXgVC4/G+70k/4d7uIDmCI98+CgyYxMf2tKGg9H0cAC4F2wa2pw93PUAttsZ2VZ
         h2o4jmylWRmKYRDPUiBfEvAa/CNJWWEZXEi31fDD7caU0OSsiH80dXje2lSq1BpfRitk
         3wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180421; x=1781785221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvUdbixww6CTGMe6OrNevndOOKL7ZNzp2IY7YAuE0kI=;
        b=BNpRdEp+rcqVISDaPgIM5ixv5YpwwxREvNU4Qct+dvPfhN/sPtXS2SbyImvUeMQ5EV
         SS2F45JMB8MLm41EeIYpC9FIV6ac9aw70PeD9+ZLAyV23C9VwBMH+np5dx+CXCp3bK0D
         9VN2pn/DVjZjqLobLcO8cwNGZiF8ArhPEgbSW1ZFN6H4CV+Y3lbzbinnzgk0RZHIAVV6
         cumwHJBtZsL1kyXEEkgxltTdMtB7e8DrcBqNCMwqdUHa4vqxSSf72gjoT9Lhm12Z2c8K
         Dk9m6z/dwzjcCB+FdAj7elBuKc5H5T6hKvo9j8/sTl3KroGmcAcSfMnbtPkyH5ZUghrQ
         aKPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LTW4Vcyb6X/Sp9P31bCvF0fGf0UBQ8rBHuxjKIXfxKZiHtWIAV6twokAmUAKJE5RgPi9vrKoVLi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUaL1+eWiw0G/785iYwEoml+O2E8aegzOfrwVMGGqHxNak7oJ
	Rbatpl8V25u3X/9784aa2nkmsS18cUUILyFhWJIdpyxOLJgNqVXlxZUhRwoVvFK92HPrc590S3g
	IpUoFvQp10ap8zGW+RuzzsQFFYJ/eYwezVdhxKJfBRV27Z+awPQuARD2tMlqc+yo=
X-Gm-Gg: Acq92OGzaa1TOkPGwY7evnpXwtcYTHvA69TJdaXjqAhEOmmPMcTTQBMSkmAdcJXJ32P
	Uo2fAMBZ61w8uGuu9N0V0VzR0zOdtYmo5pZMfHlXcfytWICCoCekSnE92APLzGLsmVt9jmk4CMO
	cCueHZ0C+Wp9RXjnEkUM5kz6qK//0legCXjJg+tLFH0jcrw1R18Q4hE0ki0h+vqEB0aJ5CS9nNG
	hwJGHG9lbWVkkg9/NZN+5CKJ7gsdlY3uJL+Xv13huAUk1hA9oZVk7z1fHnrLQdUCM0hC6s46iun
	HCey9ou/oJxkJqiaWQY2/3h7r7vyEBIZGSCoVjuxxhMSE08LD3A6jsNgwuW0zb+n1n6jmGSN+0o
	WGaxZxHyLA01969a6cwT3+Mza+v6a6B4e6P9Z7WpyaQq/G/BGm0UVAU8roQAoaWg=
X-Received: by 2002:a05:6a20:7fa1:b0:3b3:fce3:a7f8 with SMTP id adf61e73a8af0-3b5e31f33efmr3104331637.15.1781180420573;
        Thu, 11 Jun 2026 05:20:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:7fa1:b0:3b3:fce3:a7f8 with SMTP id adf61e73a8af0-3b5e31f33efmr3104280637.15.1781180420116;
        Thu, 11 Jun 2026 05:20:20 -0700 (PDT)
Received: from [10.92.167.195] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865880cc87sm1827061a12.23.2026.06.11.05.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:20:19 -0700 (PDT)
Message-ID: <7c94758c-1100-43d9-a0a4-2cb7df947cc9@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 17:50:12 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
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
        Harshal Dev <harshal.dev@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNCBTYWx0ZWRfXwKpNX/E8By6A
 oglnkBM07uGF0sMe7O4C/WwRPJbJayztHkEHz0siXK9uRALVjYnvcbCrlcQbBl5jpzZhKoQxrMS
 dtOoRxDhcKNOVE9S23Bo5oztjbHetY13m/a1gxZQexOhI/8rtonQIo4WD9Kk0X1r6w1h7otQ+C9
 d8yOilGIipHFtkyr4GYpumKCwE2wrLzUREqHU9B/uss83h1tBSKMDrfMxiPI9JJ5UMTftmyDFDv
 an4GqsGDt1Nak8T20YOgOfJiMpmlVex1orGgjL06E9PSPvhA/KB5Cq9JoCHCL1bw1oZwBYTjyT6
 LWWb19x49Ea7dIEGAYFkfGlWKZe/772A0XHrykaLR8hKwjDDV2TaqoouowkwIeUUICtdUCAm/aK
 h00CqO33rXUt0Zq4UEqhac4qpdd1IG4AbZR9X27oCqi01avQgkCE8XRrnlAxiD4/hPGupKyWl6R
 yy2Sdc+kYvxbMiWVzeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNCBTYWx0ZWRfX/I5g9hS7ZyYJ
 RdbzGGT6ylPB3hHwxxiGBsqPQKOcgkYgWy3RVReSlE99U7kH6UPqIgh5+2k/kDI2p/mqtfZkEB2
 XOZZTnYs05iWgBJYFLw8AV9+/wPnEKU=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2aa805 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QRdWpJMrku1fmPn5X40A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: cEDXsxa9jwGwR3L5MtX22GxKIWjnX5SR
X-Proofpoint-GUID: cEDXsxa9jwGwR3L5MtX22GxKIWjnX5SR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110124

On 09-06-2026 03:17, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now, supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS and ICE eMMC device nodes for Monaco
> platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 37 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> index a1b6e6211b84d0d5008231c55613a0ccd61b9450..d9298d8b7874b8669b2cded2a28a99dce6eadbda 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> @@ -2742,6 +2742,27 @@ ice: crypto@1d88000 {
>  			clock-names = "core",
>  				      "iface";
>  			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
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
> +				opp-201600000 {
> +					opp-hz = /bits/ 64 <201600000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +
> +				opp-403200000 {
> +					opp-hz = /bits/ 64 <403200000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +			};
>  		};
>  
>  		crypto: crypto@1dfa000 {
> @@ -4878,6 +4899,22 @@ sdhc_ice: crypto@87c8000 {
>  			clock-names = "core",
>  				      "iface";
>  			power-domains = <&rpmhpd RPMHPD_CX>;
> +
> +			operating-points-v2 = <&ice_mmc_opp_table>;

s/ice_mmc_opp_table/sdhc_ice_opp_table?

-- 
Regards
Kuldeep


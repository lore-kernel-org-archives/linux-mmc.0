Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6C2F5307
	for <linux-mmc@vger.kernel.org>; Fri,  5 Sep 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073971; cv=none; b=BwBGUGslyN1xA4P2/1BJ8jSczCzwWwaeVuxm0RvhnHlzaHjKaXARc3gtbdwPsfSLiRRehF58fo3/P0ufitAMBgcSDv2PEEe+D2UrVb1KGaRCLWUbsiSI2GBP+0VR55tcYJ628yAJAz2t530WBdddAn89H+/CdX8Y/bvVNUymd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073971; c=relaxed/simple;
	bh=ldlxiteVjgDeP8xEo3N2AmqNAbePsfuqyTzaH+6MAcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+a/+FYfh/84svQkiXOZ4l8nxMQBf17L39k8es5YoUD9tUn2UVNIepr5PYxLy9HPzlsje33LvnyeOxTn2PWku7f9xP6vaqOyrlXlI5GIVhPFGkc/p8o68XJ3yzk9CHhj0m75GH/TjaXkCK9XRRLM9w6CS42mno16XvnBgKHxWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+az5kPI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+az5kPI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857Ll78008288
	for <linux-mmc@vger.kernel.org>; Fri, 5 Sep 2025 12:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dIUWCEcqZtXBeXsUMytwaz17zqmex3UoROOIhHg+zWE=; b=g+az5kPI9X9pasaF
	y1g7Irqn9G/L3wLDcrG63AV1iuDyN+JhWgRrtSfkhZiT2mlDD0PTQ6TQxbFi7DKD
	n5xCwc6vd5QRrdgaX3bcYJzUc0+lNd98YxzUQKkHDzTSYxvJflEAeTE7WBMRb/nq
	FOwMtQTPsxCBQCohxjSlWQa7R4qSbJdRRpu+Y+IYBt1+KhQvu8vLD5T5XN0r2ckJ
	QfirlxHrePqRSDKVfzhFh04+XPymQE9jpDyOKg6T2NpbCKDkRv1jPmURDb7AdW9z
	YsPl/d8Ltuhv/xVl6XPf5886DHagCrHUsam//vdc7g5sGkhoPE3mYgWnOhsBzMZU
	XF6tsg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmju0ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 12:06:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8707254e0so65635385a.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2025 05:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073967; x=1757678767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIUWCEcqZtXBeXsUMytwaz17zqmex3UoROOIhHg+zWE=;
        b=lpA1tJIkoEydrydPPd/1hKzf1ZiCVk1CI0cYc7cGP7/ybFTM3GfcKGPed4cwjEhASL
         N0u0vh2FJTg62aOK7jaFzxHYZffHYqXDZ9oq4UitCj+n50SQj2jRVhXJ7AHQuNNYa5An
         IGYV6N4F6xtTAEF1CxakOPCc3PA9KJPuFwegNr5tH1AmtXzcpF9ohEJbFXOmnP7yfbnR
         HVgKrUNu76OJaz5NiruXYYg4+W/W33ldThKMkca19Z25D+cAi9efCZS3bTXMXZyoXpOU
         c9vzggF15uAoXvcH4+AYe/lwmLERSfMxEpiRgiPRgr59Y235rF04GXCh/yVvavrYzc0i
         oJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRFzbmYFg5gAPDwZ33AusmPdmoONGYFIDOsngwX2v5gqSad662lpUegE0j2S3sEfx81/Cqj36VSGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJsMCJhJyJU5qFmaF03COZrgnvxRe5b/9RvGPxiY5biA80mbv
	wDW4MkFNehZhkjloWs2zS5XuvFQVjCqc60roxcQ6UzW+/oPtxbkW2EzQ18j/wIgslxosdntIM3N
	RbSmh7hcbW2pXFDzP08sv/VI7f711cUeGqNxFctXitFA4I/zzjo875i+fAB+TYkw=
X-Gm-Gg: ASbGncu7wDJi2qCU1yEZ7TIid9/ibBu4ilczt1hDn3NDK+mHMqgdzp/4GViw0cZCFhw
	FDGNfx18aq/GbHodgoPi9bej12IFWmVbWSdCyWiBU/HOIStO1eNhM1myaT0CuBNMZFUpBVhxFpN
	tC1NJNwPXAYBfSc91dR8dHtr4rzIuokZqiMCGynF02rYgDHX2oWx+vMdu+csyV8ssVNrOMFmJw3
	I1yhOpMHfhk4nzlf336nRbUSAjWwq79vsqp1YQYcpMbkZbRcaWdGAjFJghThKIkfb2WxJJK0OiT
	aFWSBtW4FOj37BbTtlraVek0GLSSLxCn7I8l4OKVIbwB132NqHN48JkKQRimg7Ozlrx88pSFAac
	7m20yH5Ta/ZS2zmEgkFKFgA==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr59876901cf.2.1757073967373;
        Fri, 05 Sep 2025 05:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbClop9hg8atD+aWFohh2CZ/t3jFlq5ci05mjat29SqiFLYOqxeot/a8+aYFeKlmRNuQXfyQ==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr59874841cf.2.1757073966067;
        Fri, 05 Sep 2025 05:06:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b045e576edbsm785026566b.75.2025.09.05.05.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:06:05 -0700 (PDT)
Message-ID: <b7d1985f-3c3f-4776-9990-42a343661c51@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-4-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-4-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68bad230 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=TqwOrElcE3fYHNaCTFUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: lDGlWjkY-_tcdPg4IjwSMMP8ipOdAeg7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX2P0A0nVNhlWc
 YMuX+VchQ6M51mqVL7gicv4fiozVTqqIp98kyinNdZ63Rwc8zC+l6+2I7sVvQ9PHBEH1lTDwMuI
 E/CsDDYikpwYHdtHU+pSHvtC53jE193KomAm26INGcAosBfh+Mjiarko0TzRYYB2L9PMj9N6E84
 JHAgTe2fHTp0KnIS8jgJ7wA+4UClW4Au65M0kCO9Ce0FvHbWT/iCdDmZhviRqsNUWefNfED9axy
 GX7ot6K6Gk0C95h5KOqC+IAQ53BUwXNF8fi8W0JRI6jTt3iK0yoa2IUiwNUgxDRlOYfMUUIbVAN
 mQoqfhhNUTHo+BnbbzoCQT7uzleBbazUVIlibwMlc6bPf7GNJm7Ny+OrrbHGFjIMTOIpgRn5fbr
 rBFR8bhL
X-Proofpoint-ORIG-GUID: lDGlWjkY-_tcdPg4IjwSMMP8ipOdAeg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> 
> Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> GPIO lines for extended I/O functionality.
> 
> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

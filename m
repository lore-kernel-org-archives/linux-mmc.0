Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF2F47DFB7
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jul 2026 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994115; cv=none; b=QqogvgrhsdaeHkQRBljHtlpWr6mMbyaKzPAxsfF6NAkWiSYLB0GN+LHtaA2DLD/hj42QyjmjWAZfHqqa9XCCBK0Ho7edL3mTa0vw0RA3GXpcUwhHainsDX5i451jyJd8s9+BmF1FBTEz62WI7NZCe9ZfRhaJaqL1o4JHkdkIDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994115; c=relaxed/simple;
	bh=OjyS0thUu5O7Qg9fVyTOKr75ltIXN5gXWbAhELiCNh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEdfHlEK5gKuUhSZ5BJViRd3qMKxXe4bYqsfC9k6JdGCynIwGk4m7f5Ao8B2KS8MDv/CvD899ADifgVz8pZnra+sCRAFblkieN7fj250th9TAhLyvSs3odayj9G0GzAn1sECh0OCDncPPRAhkxtUpZ7uofy21Ly/N2ECuSXcO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jXgYrgV8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HD7kdRaC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXgYrgV8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HD7kdRaC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662BoC72360227
	for <linux-mmc@vger.kernel.org>; Thu, 2 Jul 2026 12:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iIuHmaYRX4lbic50IFffPPjJu1t85Ernr4S5yAwhhcI=; b=jXgYrgV8PCunms7N
	2UvgMBDe8JBr6M8RmEi6tfecR+BX8U3AywLpvZTMeb9iwHIaEVzQezxGQXBDECGt
	CQAjmvXa4gdF3Dj5xVbspW2mFLqppFbnNi/1j4RRm/9mMa+/LHJKoGZqNxfPzI5A
	IuAOgtp5iKoYnXg/6W2PtlF/APNoUEA705AnpWf5TZP3gaxYgxQBxlYUrq3ih1no
	eCloZGpByV0Hjd8OwL0pdJrNPTUkVACejMKDdzMhyMTgr2mRxOY+2ZMJTNzWWJoF
	eNYtuddpPAlxdTbOjuX3rfcwJ5WrMyleCJyV1ee6NoVwX5ZPHvgHqlqOsk1PZINB
	0T2dEw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc029e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 12:08:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5a63e1f2so29928885a.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jul 2026 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994110; x=1783598910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIuHmaYRX4lbic50IFffPPjJu1t85Ernr4S5yAwhhcI=;
        b=HD7kdRaCZLtnBtBmYRYQIXt6zmke3+KOLxlGrFkPYc0fScyGBMWGAVlCZ8Qo87iv9Z
         AiRWSFRC2gHOcHjntMX6e6SUf5iJEAY7ILpwdOw055ssyPqW50abrq2pN0hRAv/kN9QH
         usCbyr82/rrrMUviyFhhlXlgOpgpVeZdPYT6+JP7YplHUiJap/0AHrpEsPdWlg7dMTHY
         FPtsnAnmsJ4qVnefwfZFuylOhD05a5rz4uqu9DxymBM5A/SPO7JYW10mjaxUhDm15g4s
         R6ZljtcspSyyzLDODmkAMfaGUfDqVnNKrHxiT202IDHNDDVsDYVK5q6Tb8Wh73p36WBL
         fphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994110; x=1783598910;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iIuHmaYRX4lbic50IFffPPjJu1t85Ernr4S5yAwhhcI=;
        b=f+BrZvVtyIwOHLLVhm3ko6f+YOHJgvMayOtRx8dAgD0nvBGV5gu9Ha9XvWOZJa2GoE
         cHfsGC1HW+gamkPjezTcVKD2dee3y2CD7bcoDFvnq8IzR5q3nhZm3Ve4Za3YoGkTG2lh
         QDoPxb7sKPhf/dFiFSsooh9jD1+uzqpzq78PISi9GpZYcG8euJut6UcfPk+VFH4d9prq
         ucR7GtySovofAfZsgfc8EHJtVs3cLdjryB02BYn+Js8l+4vLwqvv/yoddbaNPH1nqWhu
         yPtkGWh5iakY2uwWpCsK3KBkrAcgNvSGVB/fZCaAtTc/v65Pgs2u30Ju/eAVOkrX8fcX
         hEPg==
X-Forwarded-Encrypted: i=1; AFNElJ8IwE5hH4JqgcJGG9jw3Nlp+EV4crF6A4Jdb8Dt6dDFQGN4aWVsYiAZp12x8vQJzmost8QZ18J0bKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVK4AtO3LcD4lH6C37S/TaDE9VbZzO+MOAJ11tv1wH4zdgFWxW
	XHk547/AT2su+rB6onRJuYEIB0VAtqtuCf75EZiuJ9NhPEb5DoZom05sIHamkmlNkKw/RpqAH/e
	ryr+VnEyU55CvNjDnSbT66J8eo2ODnh1RidXTJ6x5kkiEOs/ltpF+7BES6OOjPFE=
X-Gm-Gg: AfdE7cls6fmXFFcVdW69k6bgkvI3gnqL7gNjayrdHziwXE17V7mjAFyAdpn7ZkrPjLd
	GZfHEL3qOMRA2wLacqWNouF+Qo/CV3gluqZnSa2kV3mqba6YAo642dZyJIIpBrh04huOYy5Kcv3
	v4GskdjJ4SCWjtbO52k5O5KqWKG2jgwhpiXMOL8zLA7n9tkmHh53JW22Xn2Kz1JLqkDiJfjQvzy
	uoflYqvdK/w0/+RW6lQmuh2Fk+J8P7Z1HEfgaaowku2Fxd55+XZrdXjTE+KN9tCllP11Iuf7K3E
	VyBtf3q3GxIPWs/QMCeyIeqAJWNUNnbsEvv5vzyC+QAQjCjk4CTGFTk1EuT01x5S2+QN4AWLyyj
	WN9LDbNA4/66ev5FrDj+ccCdlP8NPuNwdJN8=
X-Received: by 2002:ac8:7d83:0:b0:50b:2875:5782 with SMTP id d75a77b69052e-51c26b03d36mr54171321cf.6.1782994110485;
        Thu, 02 Jul 2026 05:08:30 -0700 (PDT)
X-Received: by 2002:ac8:7d83:0:b0:50b:2875:5782 with SMTP id d75a77b69052e-51c26b03d36mr54170781cf.6.1782994109918;
        Thu, 02 Jul 2026 05:08:29 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62f5c52sm120457966b.58.2026.07.02.05.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 05:08:29 -0700 (PDT)
Message-ID: <b655782c-7250-4311-9822-f3565fea752f@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:08:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] arm64: dts: qcom: Add SD Card support for Shikra
 SoC
To: Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
References: <20260702073354.3641966-1-monish.chunara@oss.qualcomm.com>
 <20260702073354.3641966-2-monish.chunara@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702073354.3641966-2-monish.chunara@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: elkKXn7DybmzckLnlB8hsWJyCAJ1W2w0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyNyBTYWx0ZWRfXyAd2RchEJZZb
 0GrQ7FqOyYwc8OHY//o6z+Sy/nSmAwBvn7tnpEYw2qSAStOuoncQsNFmCWCtK3XYJQZm7ge8T9k
 6BxoWLdc+GWxik3NEBd6pwJtSxjugz6qG3A3YMwxcENbENzN/x8P/lD1zIliUJ7x4664tDYRsx9
 PUzZ4GOcY58LVUjNs8SIJgBzf4zHq94ePaXP2v+Hmb4OmdwEo8noJNy+GKhImCZA8Tq5ICOcM+v
 KKJt3ZIvuGNmQIz1uS3Szqpsnwj0I2hnRAIgXl1WPj1dNCLDkHFblfZzF4LxVIw3g4SyM/JyYsL
 gJJdm5dbdF7HPD6gFo/K7NYQEpM22u2cS//qQeTsQZ+FTcvHrNGkeLJ8Q37lqh05QVZA1Crtr81
 vMs7ec2dxwZ3C+OqAOC8v/6OIWqkOQ/a9+Z7f++U/hZyfgCnBb1hT59XLoREVQ4eGxCrmkd3BE9
 H6hml+osqe/BNSoMQ+Q==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a4654bf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=jlLNuUvImV_oxURiXAgA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: elkKXn7DybmzckLnlB8hsWJyCAJ1W2w0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyNyBTYWx0ZWRfXym7IcbALcokp
 gj79SssIw4+JFoPEUZvKgusiuf/jrvL168oU/XXulbS9SKidfENxuo+gqatJnajYCBfFcBupGQ9
 /6YSO61ut3Tsj08zeAjplghJraevXOE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020127

On 7/2/26 9:33 AM, Monish Chunara wrote:
> Add support for SD card on Shikra SoC and enable the required pinctrl
> configurations.
> 
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3E2DF717
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284741; cv=none; b=kWVmP7hUFtnrzGE27lm9us5ZQRyVDQbLqTnxiIOM0b61p/Iu6uM6UTwZnJRjXgrwFAIlyHTNod9qLUlJDkB41kqLO/j047NLnnkv3kP6vq+BXeRlkGjn1dnsT1uJyBIKgNpydx1Tbl+Agl5N9pRULoDG2aQVbw9DECXDwyYIqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284741; c=relaxed/simple;
	bh=CfhSriWS4WwEYC+i+yk6Zxhywexzlao9E2hEBJT4Q/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WICxGGlqY40uTP1WALxU9wOfAIoKtAxkarwfP7XJiZ+NKFrTL0hhnU2m1/qMc1UPGZvFn4prbBqgfFvs9H805nCV0D7tQcvo0KMJEWzAivyG41cTmkBXniV8GA6ax3qD6Pa43H8BR8FOWX7KqfT4R8RUsTPAcHlNjjbVJQ5Zs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KdoQJ+0L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T5y2Ny3Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KdoQJ+0L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T5y2Ny3Q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CGVdW44112795
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9DFmNAH1IgOZkO6kAlv1u8mYMZxyL6dC6r7w1W5gOGE=; b=KdoQJ+0LAD/hkmca
	YXRDdQiNUDl63NJ7PQBKot7sA7ZbEPRID+2tkW8YtsRh7nBZ5zM4lCx374w2OcgS
	zxEnJxw4Ac6tlIfCFBJwOfZnoga32RNiB6MNJe5FQmUaXvKLCb8Z3YcRX9mPn9so
	kb4kO1ByrCy6n/H+EmcNarUdZfGOO6gSOo9fitPKpK3/lTXe7rqYKOemkzyVBxBo
	AZ4HQR/vinUxPU4LF8+uet7X5FsEdLq6wG8OfXQ9VCiK9zp5VCcH2e9EKTep/ylv
	CYhp8/UeBeO0VFKiuoWLMgHUiWM66F53+PXwgd+wIKxtLYyy44sqWc2+V6u49V3P
	+V26ww==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gbtwf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 17:18:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8422ca754d8so989043b3a.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781284738; x=1781889538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DFmNAH1IgOZkO6kAlv1u8mYMZxyL6dC6r7w1W5gOGE=;
        b=T5y2Ny3Q6p/ev5wCKFCX8bfo+Gtxz7TBmnG/aLqP8gjmhhVoWwpqyJjVFeqxLyF0zC
         5bKv0Q9evgaW/KUPMmHZ49y4fjMH7z9OJS2KLe4afJHN5+VmDf59XtPrdC7hKxAvZcCY
         qqCBnLMHg9JV1hn+YxJrK8/5VSH2SmzavfXT7wxeXIy2BiXDrAVbLmt7AKepAlPYbjJO
         FSpec367rSh+wtgLbTSOoMSubuaI0uddwkEtpt7UCwcseBldtQMd49IHNGYLcir3QJWE
         6PzgVs33bbM5VWGbjlHJmNPabWyX59SHJI/dDTh8GOl0sKSAiROHY2dAzhQ/IMMoGhYQ
         2luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284738; x=1781889538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DFmNAH1IgOZkO6kAlv1u8mYMZxyL6dC6r7w1W5gOGE=;
        b=XGgouR81VBSMLr+Y2coEyGAxK8j+xWTWSysouH6mk8VrXqegid0Joso5Kf26pKBhN+
         pNdFitQgl5n5jJBjOWf80j2K0mB+DeMXwAs5Hq5Qa7SlpaLTFJAFgL5hpNcuYMxUV/Ny
         w7rH2DRshIUlcuGqu7IrrgLMmiLzpIyJqEr7NPIzLG/2dKvTRVXcg0G4RRJNPn9rLWRR
         DWZg9u1GOFwitnrq6cT758eXqGKwsRuc2qcyxB5pXrPUt87HF/2NE/wxiDK2kdZ5orA4
         zDCiKyNasDlsAwrPduh09JCAvL6XVmk1Z4NyUtOFgTfxu9ehRRZS7RGCWjzDuyaE1kxF
         Kj6A==
X-Forwarded-Encrypted: i=1; AFNElJ+5QIZ5gh8H8EhjEgqYv6/7SArW/EwydSksUHJO7eFWzeN79UcyBctgGJHUreduJkf9ziGWj/k/cJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx600gj9XZKNaZFuLt6T2P5gRx83ul2JsBfGGtuKtG9fTwMHoHN
	LczWxCh+2A1vPcRmcK1rliUhOF8W8v6UfKYzrXaUC5M8TLbiKgaac/DgkEeDgjczekuE/r4B03P
	3g2wDeiZ69GTmivYR6gOyGEpFuld9Gy3gApHZfo7zZADbTgCmjloBKdVLnbBbXYY=
X-Gm-Gg: Acq92OFNd5zSfKBnXehqq2pQLfoLwl2pCjv8srSLWS/P9etZ/rkxVQmx5skNZ2Eqq4z
	PNdAxaWSp5mgd8B6AGBLoCQKnluYAsxHmAqe2SguAAgsmT72F5pxhYWDzKUCfP7emByGduKOVQS
	yAMLOJB3Eu6oKrblg+tJWChKhg+Fyi4s3FxhIvoqZtS0pCQaEaD4CafOd2fqJ0zQdQcEiU+iufK
	u5WtlAzXyAkJBi1GgvvPgRYm36DBs1guzVD21rN1PuWQ+NCoqRxm4028NuZcFmy0y+su8/5RRsd
	9A78BCIzQlqScVCI+zhmZ/gWhyHUHJPEAHebVDRFHRCwKRV1DzLLpjEuILM4SLyqjYqCuhjEcpm
	uNlUkdN9S13Y7Rzsy5sNoJETKESlyXSBUOH6/nogcV9jHT3eUUKs=
X-Received: by 2002:a05:6a00:1947:b0:83f:2568:d466 with SMTP id d2e1a72fcca58-8434d0ada54mr3972674b3a.31.1781284738482;
        Fri, 12 Jun 2026 10:18:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:1947:b0:83f:2568:d466 with SMTP id d2e1a72fcca58-8434d0ada54mr3972653b3a.31.1781284738042;
        Fri, 12 Jun 2026 10:18:58 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.232.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0112edsm2538142b3a.45.2026.06.12.10.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 10:18:57 -0700 (PDT)
Message-ID: <6cd2c9e0-9e3b-466d-b9ef-586bf6c779a7@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 22:48:49 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] dt-bindings: arm: qcom: Document Shikra and its
 EVK boards
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com
References: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
 <20260611-shikra-dt-v5-1-103ed26a8529@oss.qualcomm.com>
 <20260611181841.GA3163205-robh@kernel.org>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260611181841.GA3163205-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2MSBTYWx0ZWRfX2oay3SGB+oIm
 GgkHDgb4dkGpyQj+sIDxBHj7WSG3jhuETT5nVbHzkon6SSyre00pFCGbIEYycfv6vKEr7wrmkuy
 Wz/iBNOEBONZ+skBzjZYxncTFbR6IAs=
X-Proofpoint-GUID: nlsmS6xmQpBu-Vd0Xq_Cftv3G3gDRTIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2MSBTYWx0ZWRfX/f9tVQJn9Z65
 jXQYPAAEsKX7VSzPKvYRyClCPtz1nVt7bQBEiOyOXTvsDKVawVndNALhKjxyVh179SQ6UqmRDk8
 8mS9/patOvBoL2Yx8I4nZm1k0j7ZQg1D1TRKYSYiiYmzFl7FVuXOhbzmOqdjHr693eYZm1ewFgl
 6rlamq9frNPutQFLSWJmwJywNZdHvSL9S9TeVk0++TLeZMbPX2TbhicQXO36DsNnbQPMP/+awoo
 7AD8ok/0xCraFqbh1KKczuNVywXGZ6o7Un7OtzaZcK9f3xj8vE3XltQpzLLhvbxoMNAkR2YXojG
 b76Rfp7mUbXagOs9qR573BHDZ9FXTVtsOI9bb2bOiw5oUgfj1devNr9XFH0OhSgMWT7nhG0Yueo
 EinHTrArp2A9894o51kgm/VlQLptG4uPk9NqTwkuVdV1S36VMRmARuTK5p6eIJ/nNElOlZqtOmq
 49e6dmZkpnzn08SbyAw==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c3f83 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=g0pf6In4uVe9puqoFIUS9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=wogpLHfNZo3oYugl4g0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: nlsmS6xmQpBu-Vd0Xq_Cftv3G3gDRTIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120161

On 6/11/2026 11:48 PM, Rob Herring wrote:
> On Thu, Jun 11, 2026 at 03:40:08PM +0530, Komal Bajaj wrote:
>> Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
>> form factor. The SoM integrates the Shikra SoC, PMICs, and essential
>> passives, and is designed to be mounted on carrier boards.
>>
>> Three eSoM variant are introduced:
>>    - CQM: retail variant with integrated modem (PM4125 and PM8005 PMIC)
>>    - CQS: retail variant without modem (PM4125 and PM8005 PMIC)
>>    - IQS: industrial-grade variant without modem (PM8150 PMIC)
>>
>> Each SoM variant pairs with a common EVK carrier board provides debug
>> UART, USB, and other peripheral interfaces.
>>
>> Add compatible strings for the CQ2390M, CQ2390S, IQ2390S SoM variant and
>> its corresponding EVK boards.
>>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> Missing Krzysztof's reviewed-by.

Missed that. Will add his reviewed-by in next revision.

Thanks
Komal



Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C133554C
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715984; cv=none; b=MEw5CdXozvTk+lRHJFMSP3QXIZDFSEUDR6V3CtN6r9pfvqOGsIcMqjZIt4vYEvDZKMIKf/jZPCsmATsthofhMH2xi57VupEfCTlXB3ciW8i+u/Ws52RUCv5iYjhrShdZoUfZjDCUWJjgsfYRNZpCOH+FXk+hsiHhDlB10BW33ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715984; c=relaxed/simple;
	bh=lYXkrcgF/gfCqHIjWikYj3wuxE8pK3C+vUdP+nhK84M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqiLSI+q/7JE0qU4XmAVyo1IJa8cU/8ZEFLZk9m4xqCoFSfIaXCqiecVe1MBbE8Y3+tskYdtxURFwpCQ/Tnq2KqgiDIa2ASXCd8rv66b/63yVt8MBHhcGaLqvqhik3hjfoqCMW7AjRI+/1mIz6xqqvocKbv/4dWm0x5wzM1uOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9iG4J1W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L3k+0wWE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9iG4J1W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L3k+0wWE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A3iNFC1940314
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rLgXJquVUyBesXKA8dBPnaFYAdLbpSuCrTyxZs6wRLQ=; b=G9iG4J1W38x8r1bK
	yNGjcc5L8LSO9QweqAc875s9Kl/lrfPteKjrfaz0Z4iEQRw2Fqqide/Xw0T0Nq3V
	OeJ1GQX9drN9ZmvV/frtuq88//xXMqzD/RAEum592u+iCgAMqWHKCHvbnrIO90eX
	hd6oiwQPLfSCbI2zpvobZPqFHb3bokzC5b++ZxwcziC4LRqHbUo9YZw+MHLCIw/b
	EtVpgkQ/kyPMUFGfmpCIV5YbMwF79MFXyJ9aLPSDxUpLv4WLh43ewasvPdjajc3x
	Z8fYYyiSczCSma7I5pNsdnaRI6RNbruB4JStXmq3SG9WSFm2e33iu5x7ot7kE8HD
	RuVshw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7w1js15q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:33:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c710279d57so189207585a.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 01:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770715980; x=1771320780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLgXJquVUyBesXKA8dBPnaFYAdLbpSuCrTyxZs6wRLQ=;
        b=L3k+0wWERRF01hka+ZTH5p3Cx5Op8220v8WNSc6XxhMKnBYUNGgD3/b4d0x1M0kSLb
         72UEdyhHs8BEIV9o2j0SbdnFrQ6d2FDAF7aHA0AakPWAxS0/eVyMm04Ad/x6FR2LeNoS
         DNSimueaKdrzWbepIylklDHyxlN7VFuuBqluPOQ2ld0EZE0UwQaOsl1WrphohwLH8cAy
         HJ3Tj/U1prlw3Z6zhot1Bk20dmhIf2grGNpRASsr1fRwU395d3EN4/5coTdNRRAcUmBY
         DIrXGckYWY3ms6A7W0hy0x8vsWQLlkoai55c6xVQDXrPRRXXQ2+CqsaIwg1WTsNN7vrD
         uu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770715980; x=1771320780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLgXJquVUyBesXKA8dBPnaFYAdLbpSuCrTyxZs6wRLQ=;
        b=KGWl4s1LVa/Jk+59cZQ/KkO3J4gx8fPTd7Af3ggmnmPixeHDvonYB6b/Rx72aSJ5Db
         g4Ov+AEY6GUspCgIf+Z21dDh34QtQWdUH5ENDzVcFvhE6jB19RChcor1oKU+HEr33sns
         /3BkTdR1cfqZ5UeftB8UpDYvbqS+rskJhO0/rCfVQT/d5VplLCIqEwraHbmxJlHKAl4v
         QMq8upnWhCPvmepdzqoqNfsvIJnfCHj86lqluNvEmXtEgyUF0+syy8xUiCY3ucuEzj/c
         YjsL4c6+HAQi25X4JqlZOKvTXN8Ybos5bf0pDe5QfjlVk8He21pQegHarbXw0r5LarSN
         zKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsBL2j9AKZaBTcqoeIkQkR58fo0AVKkTvQF28/dM8eyN4X9N44xFzoUv9YKueSsIzURnI3cq25+K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMoEEMVaz16FrW8tBpcsBF2dO+BZAMq4m78s6z+KxQNQFT2o/
	ZT5jhi2ZnlDFkGyazajvKTWcG19YSXnczHrIMh9UWPDWvA4U5GCydyEtAed4/+GUAJ1BDL8WOvM
	aTJOdPUv3dws8/4NVopi8BlTPfowi+lwi5rw5IB/HJt2dmwBaf1Z5iYDbK6Wn0aE=
X-Gm-Gg: AZuq6aKWNDHnIsOvvCdnh5S6lgTwqHOm4Lh/SYFnwD5yenODPuTHaOlswaazVPJjnT7
	kUcvaA5W+qNTeJ4pRSHP9BGBTdzbloJ4EwJaM2tRHpxbKZ0TxgB9CPIkJv/6ihFwt4xUwkJyoXJ
	O8B7/7Hx54v773qttqvV4zDfHpo8R+4Yndd0JnVvYIgZDh4JDLSeF86w4tBDWUKvQMHDzZl//Xc
	bNgvkZu0e9nrflO1MxZbcotueJrt0cW07ABIO9jjupBPXQOd6Q4dat+7XKCdBWBPUTbz3BUn/QX
	4OdCBZqjvU0lmIS27nOKdZ8QQiN2XH3op2yR1k5jDvZkRXT1achKnfVlsQ43/biJJoYrvh0Yem3
	h1at54MYb7qlkmn1pYUCHLG3h3r5y46n82+DZKuOjZ5Z+bwel/KLC6600Qi9XNU6PKQSz44vtdC
	fhPuw=
X-Received: by 2002:a05:620a:258e:b0:8c9:eae0:d1df with SMTP id af79cd13be357-8cb1ff5ebc8mr100762685a.6.1770715980359;
        Tue, 10 Feb 2026 01:33:00 -0800 (PST)
X-Received: by 2002:a05:620a:258e:b0:8c9:eae0:d1df with SMTP id af79cd13be357-8cb1ff5ebc8mr100760085a.6.1770715979873;
        Tue, 10 Feb 2026 01:32:59 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edae32664sm489037866b.58.2026.02.10.01.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:32:58 -0800 (PST)
Message-ID: <068a7b3a-22a6-4e83-acef-85353af53390@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:32:55 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] scsi: ufs: ufs-qcom: Remove NULL check from
 devm_of_qcom_ice_get()
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
 <20260210-qcom-ice-fix-v2-4-9c1ab5d6502c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260210-qcom-ice-fix-v2-4-9c1ab5d6502c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hmrAn7isT8LMMC0aOPLn_0qE72KTVdSe
X-Proofpoint-ORIG-GUID: hmrAn7isT8LMMC0aOPLn_0qE72KTVdSe
X-Authority-Analysis: v=2.4 cv=YrIChoYX c=1 sm=1 tr=0 ts=698afb4d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=AC2hTCgHVLFjDka4hzMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA3OSBTYWx0ZWRfX3KrAv/qRwUv6
 VGtJe6wkQJEGN27BjxP2F+GAx235fsNB3MoaLxj0cClumhvFXUG9RLq0KDnvS2l5hj7OnQH1Nac
 XRwUIctmG9zu9FC4CyKfpqvrWc+xd0XiP87oWsbuefbFqzC5TOeqzv628c5FDXf9emP2TI6etxi
 ZF+mv1k/FsS2PEMG1TyEQj6slWY6wLQVn3oyI4HmaBIeUTCw9KFsN0IxT94cdZmyAogteoZDJfo
 ZK3pS77cBWzrweDQAWm72t5h1uISY6ZH9atSAz5qIjP79T1xhSapz3j8ptRMLZKORZjbOJxPn7T
 964ryTmqcfpxWYf0DGucpPrOyvynVeS3tW02VJeL54K1xVd6o47888QXBZIeS1V8iRUMTg/0o50
 gaZA8TvXgGeSpm2BKIZp8gZDDGyyec+2F8BYTRtG3Zz7PwLiSO82AVfIGPXp7F8Fck3vtF5kjWD
 MrnuFS+QEomErkiQxIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100079

On 2/10/26 7:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Now since the devm_of_qcom_ice_get() API never returns NULL, remove the
> NULL check and also simplify the error handling.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

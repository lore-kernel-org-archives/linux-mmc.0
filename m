Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77283D1ABC
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889910; cv=none; b=TrWnS99FJtBieFoeheJPlUdEjuXyS5dEcbDzYohmslI2Jd58WdrhPZ6kpl3ViB67EE3gpdNc9pqU5MsBulZSIwJ8MHegxkI3HNgxgAzD1LWNGFiG29dnW/qSY28o8QrxLL6nD2Qo5maNOcdNVLZgcjOzLj6K2ED1wc91bV3MCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889910; c=relaxed/simple;
	bh=r0aT+QTWj1B7a2o03LnJE8w5zsP80m9ExwvT1Og5Mnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed++Hb/yV21MI037zzEoM+0r9tTYJ72CV3FwHuiah9+OuKBGY2RVq2f/XoqT3WLygDm78pTKmgU86KUzLmGE27maCLNKsC5TfdTiPFgosewpADeSdnWvQ2g7mUQhSqYoJOw9yMTAmrXnPI0kt0Fq0S9Q/Nf//QxA4bDtGpIOk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XrGw6F0/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EAw2SYaA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XrGw6F0/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EAw2SYaA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mQxh871123
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 13:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NquEXa+wXS0JZmWbAUizRlERWzjLifHKVTda41vYocQ=; b=XrGw6F0/2xToLL1h
	h3AZWF6ktGDptzqrljIuR1E6Q5QFZAhdyn3fyBVhlUA3vVUz+PQniHIR5ZrnYr0/
	Ns0T5uJAzrcpdtaWOBqMlsWyT1TDgme1cVjI8yqucZ2msNOpqnXAxzcBYv6HQuRC
	AKN0DkMxoxez4Pn0d+PUr/Ym3Vue5u7LYxKNmVAzLxL3/wr3xt0zt3P52HDf84ac
	9GQLSDXdk7zpmr4qrPhqNtWUYgU8hAOG/ga6BH5f82+/XgO6wOwi2fSTqKuFSUgd
	FqLxKbwwBVQfg9+1MXN7ItiDZZFUltQYtysCq24EnpY80WEr842h7tpV4Wvuq80N
	29JHPw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eduru9gb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 13:51:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba5f794825so93414245ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779889907; x=1780494707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NquEXa+wXS0JZmWbAUizRlERWzjLifHKVTda41vYocQ=;
        b=EAw2SYaACTTJ12iy7fnemSQwvwB1zyzDbK1BAef5r+43OAI5RsBJKHUpMZenIaNiqH
         KSJed6VMukM0mWLQ6T/ISe5NRJ4Wfzxd4SLQJpt6BgVFxw081k/bNto6K5YJVw3yPtRm
         tcMUi7/IPgNsuSxNsIM+Svve5opU16rzvuzdWfuyDty5JHZPKutBcM4dn5yNHxcyIVNJ
         Z9a04Nb4smUg9UkrHKkDW6pC5iTD/k5gH6KSc2oAYOBA8jwEy3az2RSjrO23rquMu1+i
         KulGPmH8NnhU66v2eHlhfty0ba7F5rfTZZVWvOJWbz31764MvK+bWO5dgoqvn3cy/xDf
         ArMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889907; x=1780494707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NquEXa+wXS0JZmWbAUizRlERWzjLifHKVTda41vYocQ=;
        b=rVqTB+ZCjvq+JoeiTIZujMOxx9imzfDemFYtQcXG1v0Pp6uua33HtBy+ijxJppoXSz
         riniu9PcZZD7yf7mZi4Vg4gI/LxPrQZU94Uw5UrLcQyWe79kaY3BrBBBy1l1STTT79BB
         NyK7APTbyoGPU0klDTxugtZ6+mCJlc2FEwIiwLykMVyaUN1oghQZv2NK0AMD12x0Gq/X
         sho9GG7h1KMhyMaIRpPVggk7VAvk9Gqaly4lkyuC4c1hlvNXsgaxzPOXE6h4ctTrN8RQ
         uwUv3DKV4QRmNbsHOAhyRyrEkJENOEUxtFRs6SEPHwgjFshS+FTaBrblizy8QAItKq33
         d/mw==
X-Forwarded-Encrypted: i=1; AFNElJ+zKOFI/ynwWARpZ5vEGaqo062RYOiiB1U8LNHLoVOEp+3SIdNJd2a6KFXY7OWuDLCFOky215PgrPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+f/eWtZcij5CksIbRhwfXwU4umNcgfLppmzaakqKlOCO4srUQ
	V4rgEewvNwyHzSkVfDjAB8uwMtGvHrEMknO/oeFf1s9Xn24EGEQJmQ5a4NgOvPTeoByGAbDYTTF
	7c/WS3hxGi8MAfsa6pG/RZ4GTml+iF5Md/l9QMWtQsVg/1qVwtWD36tM3fdAmi4A=
X-Gm-Gg: Acq92OHC4nL1EkdanesvyMmjSQIsDjxng19oZX0CX8OcBCppNVK44Lg9hkSkJL9BPZk
	YPLbEqCcITrg96elNLQLzUsMM3LnBfTJh5ZzvOLC5bSfYHPuw4DaEQ5+a97xjsdBBSs77AwoNqU
	o3AUiDyb6FE4SaLaAOvh3KbNTgqTHIm1BBHlda981LcpPiLrj9KiVh+i8L6xaOIEwFIR7AZB2rJ
	JoCHRKjbTV/Njmrsds305JtX12kemidCxamX5lVIG+HMSuWjHtYm2UDeaZxwsPDdoLyNRHwlezy
	Str8z/o8RYJqxshzRppaD5KPX5mmBeZEZ4VXuX6F9Fgi+Qk1s9oe8IAJ3OViDBXHUptOBFNT7IZ
	qZgUEA1MFyvIo0NsJi0IG8UTzpPts2aR1m/9agq64pgas0bBQtzGjwU7ikaE=
X-Received: by 2002:a17:903:354b:b0:2bc:db91:f5a7 with SMTP id d9443c01a7336-2beb0735023mr265126485ad.11.1779889906585;
        Wed, 27 May 2026 06:51:46 -0700 (PDT)
X-Received: by 2002:a17:903:354b:b0:2bc:db91:f5a7 with SMTP id d9443c01a7336-2beb0735023mr265125955ad.11.1779889906099;
        Wed, 27 May 2026 06:51:46 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm205407535ad.36.2026.05.27.06.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:51:45 -0700 (PDT)
Message-ID: <68027ef8-6182-479e-ade4-9c19b048b337@oss.qualcomm.com>
Date: Wed, 27 May 2026 19:21:37 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] arm64: dts: qcom: Add initial device tree support
 for Shikra
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
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
References: <20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com>
 <ad5e2d91-6166-4fb6-a9da-1464b161da24@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <ad5e2d91-6166-4fb6-a9da-1464b161da24@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VY3H+lp9 c=1 sm=1 tr=0 ts=6a16f6f3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ov8QOwxTnn4yD7v_06kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: QTXMl9D0K0yY7Ne3FTdnAFO2-cKnj3eX
X-Proofpoint-GUID: QTXMl9D0K0yY7Ne3FTdnAFO2-cKnj3eX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzNiBTYWx0ZWRfX839ptArD8yby
 DOU7et443+W/g/uZ+fbXPwkn8po980SiuKmzOG+uBXP90FKOBmxbTq7qNESetuhF0/eKu/quHXo
 UrJ+8b84aWOmCiw3afXze8y8vQlhXD06xHsAI89z8hhMzFXSaVl5P15Z2gnwGhHub5/0GC7ldJc
 5dz7pBKKt0bnU29WL5v3BDb54udK+bA8jhsihTIeXRcOtKjzqKl5K7Cdw+6j1AOECl7HndSmBu1
 QbZePkwfgzNr+lEL5LdReugTDVlIj5egzOCDjmkaOX0uTD7hCNcfO/J8oxDcgacTsebh2cr3DBT
 x0R33qYm2bn/3pymm67gaudDXQSFLTqI0YkMo+lOp91vAFUQeOyRwGEfILrXRxEK3z0gI8gH/OU
 Zc4ga5A6ZL6ZJJo73EaZvz23T88gnkt2eg60bJ+fqirwYQoIzH2sOwgsAQohj5CCS1EFl0PART3
 CuWKzsb11KNj5jUtegw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270136

On 5/25/2026 6:44 PM, Konrad Dybcio wrote:
> On 5/22/26 8:02 PM, Komal Bajaj wrote:
>> Add initial device tree support for the Qualcomm Shikra SoC.
>> Shikra ships in a SoM form factor; this series covers the CQ2390M,
>> CQ2390S and IQ2390S SoM variants and their EVK boards.
>> The series adds:
>> - dt-bindings for the Shikra SoC, CQ2390M/CQ2390S/IQ2390S EVK boards
>> - SoC base DTSI
>> - CQ2390M SoM DTSI with PM4125 and PM8005 PMIC regulator definitions
>> - IQ2390S SoM DTSI with PM8150 PMIC regulator definitions
>> - EVK DTS files enabling UART and eMMC on the carrier board
>>
>> Note: USB support is intentionally dropped from this series. It will be
>> sent separately once the USB driver changes for Shikra are concluded.
>>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>>
>> ---
>> Changes in v3:
>> - Drop USB nodes from this series; will be sent separately pending
>>    conclusion of USB driver changes for Shikra
>> - Fix CPU3 reg address (0x300 -> 0x10000)
> This part seems to not have gone through (have you verified it at runtime,
> e.g. via reading the MPIDR_EL1 register?

Thanks for pointing out this, I missed to update the cover letter, the 
value is still unchanged.
(Core3  bootup failed with reg address 0x10000) [1].

>
>> and memory base (0xa0000000 -> 0x80000000) (sashiko-bot)> - Fix power-domain macro: QCM2290_VDDCX -> RPMPD_VDDCX for sdhc (sashiko-bot)
>> - Fix MPM interrupt number for ss_phy_irq (8 -> 9) (sashiko-bot)
> Hm? I don't see a 8 or a 9 in either this or previous revisions

This is a miss from my side while updating the cover.  It's interrupt 
controller's interrupt vector  instead of MPM interrupt vector[1].
Will review and fix all the cover contents in next revision.

[1]: 
https://lore.kernel.org/all/af80ccf3-b26b-48f7-ba94-0830c0730a94@oss.qualcomm.com/

Thanks
Komal
